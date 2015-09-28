#include <iostream>
#include <fstream>
#include <set>
#include <map>
#include <vector>

#include <chdl/chdl.h>
#include <chdl/gatesimpl.h>
#include <chdl/numeric.h>
#include <chdl/loader.h>

using namespace std;
using namespace chdl;

const unsigned N(32), STAGES(4);

// #define NOPIPELINE
// #define PRINT
// #define SIMULATE

node ValidSig(node in, node stall, int n=STAGES) {
  if (n == 0)
    return in;
  else
    return Wreg(!stall, ValidSig(in, stall, n - 1));
}

int main() {
  typedef fp32 T;
  
  typedef ag<STP("stall"),     in<node>,
          ag<STP("valid_in"),  in<node>,
          ag<STP("valid_out"), out<node>,
          ag<STP("a"),         in<bvec<32> >,
          ag<STP("b"),         in<bvec<32> >,
          ag<STP("c"),         out<bvec<32> > > > > > > > interface_t;
  
  bvec<32> a, b, c;
  //T at, bt, ct;
  //Flatten(at) = a;
  //Flatten(bt) = b;
  //Flatten(ct) = c;
  c = a * b;
  
  node stall;

  #ifdef SIMULATE
  bvec<8> ctr; ctr = Reg(ctr + Lit<8>(1));
  at = IToF<8,23>(ctr[range<0, 3>()]);
  bt = IToF<8,23>(ctr[range<4, 7>()]);
  stall = Lit(0);

  TAP(a); TAP(b); TAP(c); TAP(stall);
  #else
  interface_t io;
  a = _(io, "a");
  b = _(io, "b");
  _(io, "c") = c;
  stall = _(io, "stall");
  _(io, "valid_out") = ValidSig(_(io, "valid_in"), stall);

  EXPOSE(io);
  #endif

  cout << "Built." << endl;

  // Preoptimization. Can't do dedup or the autopipelining will unintentionally 
  // ruin other parts of the circuit.
  //opt_dead_node_elimination();
  //opt_contract();
  //opt_combine_literals();
  //opt_contract();

  bvec<N> out(~~c);
  #ifdef SIMULATE
  OUTPUT(out);
  #endif

  unsigned pl(pathlen(Cat(a, b), out));
  cout << "Path length pre-optimization: " << pl << endl;

  #ifndef NOPIPELINE
  // Attempt at autopipelining.
  set<nodeid_t> s;
  map<nodeid_t, unsigned> rlayer;
  unsigned current_layer(0);
  for (unsigned i = 0; i < N; ++i) s.insert(out[i]);

  // First, find the logic "layer" of everything.
  do {
    set<nodeid_t> next;
    for (auto it = s.begin(); it != s.end(); ++it) { 
      for (unsigned i = 0; i < nodes[*it]->src.size(); ++i) {
        rlayer[*it] = current_layer;
        next.insert(nodes[*it]->src[i]);
      }
    }
    current_layer++;
    s = next;
  } while (!s.empty());

  map<unsigned, set<nodeid_t>> layer;
  for (auto it = rlayer.begin(); it != rlayer.end(); ++it)
    layer[it->second].insert(it->first);

  cout << "Found layers.\n";

  #ifdef PRINT
  for (unsigned i = 0; i < pl; ++i) {
    cout << i << ':';
    for (auto it = layer[i].begin(); it != layer[i].end(); ++it) {
      cout << ' ' << *it;
    }
    cout << endl;
  }
  #endif

  // Next, find edges that cross each layer boundary.
  map<unsigned, set<pair<node, unsigned>>> edge;
  for (unsigned i = 0; i < pl; ++i) {
    for (auto it = layer[i].begin(); it != layer[i].end(); ++it) {
      for (unsigned j = 0; j < nodes[*it]->src.size(); ++j) {
        nodeid_t s(nodes[*it]->src[j]);
        unsigned limit;
        if (rlayer.find(s) == rlayer.end()) limit = pl;
        else limit = rlayer[s];
        for (unsigned k = i; k < limit; ++k)
          edge[k].insert(make_pair(*it, j));
      }        
    }
  }

  cout << "Found layer-crossing edges." << endl;

  #ifdef PRINT
  for (unsigned i = 0; i < pl; ++i) {
    cout << i << ':';
    for (auto it = edge[i].begin(); it != edge[i].end(); ++it)
      cout << ' ' << it->first << '-' << it->second;
    cout << endl;
  }
  #endif

  // Place pipeline registers at each edge.
  unsigned regcount(0);
  for (unsigned i = pl/STAGES; i < pl; i += pl/STAGES) {
    for (auto it = edge[i].begin(); it != edge[i].end(); ++it) {
      invimpl *inv = dynamic_cast<invimpl*>(nodes[it->first]);
      nandimpl *nand = dynamic_cast<nandimpl*>(nodes[it->first]);
      unsigned in_idx(it->second);
      node n(it->first), in(nodes[it->first]->src[in_idx]);
      if (inv) {
        n = Inv(Wreg(!stall, in));
        ++regcount;
      } else if (nand) {
        if (in_idx == 0)
          n = Nand(Wreg(!stall, in), nodes[it->first]->src[1]);
        else
          n = Nand(nodes[it->first]->src[0], Wreg(!stall, in));
        ++regcount;
      } else {
        cout << "Edge through unknown type!" << endl;
        return 1;
      }
    }
  }
  cout << "Inserted " << regcount << " registers." << endl;
  #endif

  optimize();

  cout << "Path length post-optimization: " << critpath() << endl;
  ofstream cpr("autopipeline-critpath.txt");
  critpath_report(cpr);
  
  if (cycdet()) {
    cout << "Cycle detected." << endl;
    return 1;
  }

  #ifdef SIMULATE
  ofstream wavefile("autopipeline.vcd");
  run(wavefile, 1000);
  #else
  ofstream nandfile("autopipeline.nand");
  print_netlist(nandfile);
  #endif

  return 0;
}
