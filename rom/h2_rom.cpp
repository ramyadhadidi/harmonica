#include <chdl/chdl.h>
#include <chdl/memreq.h>
#include <chdl/loader.h>

using namespace std;
using namespace chdl;

int main() {
  mem_port<8, 4, 30, 0> p;
  
  Rom<16, 8, 4, 30, 0>(p, "sample2.hex");

  Expose("imem", in_mem_port<8, 4, 30, 0>(p));

  optimize();
  
  ofstream vl("h2_rom.v");
  print_verilog("h2_rom", vl);

  ofstream nand("h2_rom.nand");
  print_netlist(nand);

  return 0;
}
