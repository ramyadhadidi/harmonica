#include <chdl/chdl.h>
#include <chdl/memreq.h>
#include <chdl/loader.h>

using namespace std;
using namespace chdl;

//#define TEST

int main() {
  mem_port<8, 4, 30, 0> p;
  
  Rom<16, 8, 4, 30, 0>(p, "simple2.hex");

  Expose("imem", in_mem_port<8, 4, 30, 0>(p));

#ifdef TEST
  //TAP(p);

  optimize();

  ofstream vcd("h2_rom.vcd");
  run(vcd, 10000); 
#else
  optimize();
  
  ofstream vl("h2_rom.v");
  print_verilog("h2_rom", vl);

  ofstream nand("h2_rom.nand");
  print_netlist(nand);
#endif

  return 0;
}
