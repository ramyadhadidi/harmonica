#include <fstream>

#include <chdl/chdl.h>
#include <chdl/dir.h>
#include <chdl/memreq.h>
#include <chdl/loader.h>
#include <chdl/lfsr.h>

using namespace std;
using namespace chdl;

#define TEST

node RiseSync(const node &x) {
  node x0(Reg(x)), x1(Reg(x0)), x2(Reg(x1));
  return x1 && !x2;
}

template <typename T> T Sync3(const T &x) { return Reg(Reg(Reg(x))); }

typedef ag<STP("clk"), in<node>,
        ag<STP("rd"), in<node>,
        ag<STP("wr"), in<node>,
        ag<STP("addr"), in<bvec<32> >,
        ag<STP("data_in"), in<bvec<32> >,
        ag<STP("data_out"), out<bvec<32> > > > > > > > in_lil_bus;

void LilAdaptor(mem_port<32, 1, 30, 0> &p, in_lil_bus &l) {
  node clk_edge(RiseSync(_(l, "clk")));

  const unsigned long MIN_ADDR(0x88000000), MAX_ADDR(0xffffffff);
  
  bvec<32> addr(Wreg(clk_edge, Sync3(_(l, "addr")))),
           data_in(Wreg(clk_edge, Sync3(_(l, "data_in")))),
           next_data_out;

  node rd(Wreg(clk_edge, Sync3(_(l, "rd")))),
       wr(Wreg(clk_edge, Sync3(_(l, "wr"))));

  node req_valid(Reg(clk_edge) && (rd || wr) &&
                 addr >= Lit<32>(MIN_ADDR) && addr <= Lit<32>(MAX_ADDR));

  TAP(rd); TAP(wr);

  _(_(p, "req"), "valid") = req_valid;
  _(_(_(p, "req"), "contents"), "addr") = addr[range<2, 31>()];
  _(_(_(p, "req"), "contents"), "data")[0] = data_in;
  _(_(_(p, "req"), "contents"), "mask") = Lit<1>(1);
  _(_(_(p, "req"), "contents"), "wr") = wr;

  // This will work as long as the response gets back before the next clock
  // edge.
  _(_(p, "resp"), "ready") = Lit(1); //clk_edge;
  node ld_data_out(_(_(p, "resp"), "ready") && _(_(p, "resp"), "valid")),
    clear_data_out(Reg(clk_edge) && !req_valid);

  _(l, "data_out") = Reg(next_data_out);

  TAP(clear_data_out);
  TAP(ld_data_out);
  TAP(addr);
 
  Cassign(next_data_out).
    IF(ld_data_out, _(_(_(p, "resp"), "contents"), "data")[0]).
    IF(clear_data_out, Lit<32>(0)).
    ELSE(_(l, "data_out"));
}


template <unsigned SZ, unsigned B, unsigned N, unsigned A, unsigned I>
  void Rom(mem_resp<B, N, I> resp, mem_req<B, N, A, I> req,
           const char *filename)
{
  node next_full, full(Reg(next_full)), read;
  read = _(req, "valid") && _(req, "ready") && !_(_(req, "contents"), "wr");

  Cassign(next_full).
    IF(!full && read, Lit(1)).
    IF(full && _(resp, "ready"), Lit(0)).
    ELSE(full);

  _(resp, "valid") = Reg(read) || full;
  _(req, "ready") = !full || _(resp, "ready");

  bvec<SZ> addr(Zext<SZ>(_(_(req, "contents"), "addr")));
  Flatten(_(_(resp, "contents"), "data")) =
    Wreg(read, LLRom<SZ, B*N>(addr, filename));
}

template <unsigned SZ, unsigned B, unsigned N, unsigned A, unsigned I>
  void Rom(mem_port<B, N, A, I> &port, const char *filename)
{ Rom<SZ>(_(port, "resp"), _(port, "req"), filename); }

template <unsigned N> node ClkDiv() {
  const unsigned NN(CLOG2(N));
  bvec<NN> next_x, x(Reg(next_x));
  node toggle(x == Lit<NN>(N/2) || x == Lit<NN>(0));
  Cassign(next_x).
    IF(x == Lit<NN>(N - 1), Lit<NN>(0)).
    ELSE(x + Lit<NN>(1));

  node out;
  out = Wreg(toggle, !out);

  return out;
}

int main() {
  in_lil_bus lb;

  // in_mem_port<32, 1, 30, 0> port_in;
  mem_port<32, 1, 30, 0> port;

  LilAdaptor(port/*_in*/, lb);
  //Rom<8>(port, "contents.hex");
  Scratchpad<8>(port);
  
  // Connect(port, port_in);

  #ifdef TEST
  node clk;
  _(lb, "wr") = Lfsr<1, 31, 1, 0x12345678>(clk && !Reg(clk))[0];
  _(lb, "rd") = !_(lb, "wr");;
  _(lb, "addr") = Zext<32>(Lfsr<6, 63, 1, 0x1fee1full>(clk && !Reg(clk)));
  //Wreg(clk && !Reg(clk), _(lb, "addr") + Lit<32>(4), 0x7ffffff0);
  _(lb, "data_in") = Lfsr<32, 63, 3, 0x0123456789abcdefull>(
    clk && !Reg(clk) && _(lb, "wr")
  );
  clk = _(lb, "clk") = ClkDiv<123>();

  TAP(lb);
  TAP(port);

  optimize();

  ofstream vcd("lilrom.vcd");
  run(vcd, 100000);
  #else   
  EXPOSE(lb);

  optimize();

  ofstream nand("lilrom.nand");
  print_netlist(nand);

  ofstream v("lilrom.v");
  print_verilog("lilrom", v);
  #endif

  return 0;
}
