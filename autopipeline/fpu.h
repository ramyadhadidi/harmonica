#ifndef __FPU_H
#define __FPU_H

#include <chdl/cassign.h>

#include <cmath>
#include <iostream>

namespace chdl {

template <unsigned E, unsigned M> struct floatnum {
  floatnum() {}
  floatnum(bvec<E+M+1> x):
    s(x[E+M]), e(x[range<M, E+M-1>()]), m(x[range<0, M-1>()]) {}

  floatnum(node s, bvec<E> e, bvec<M> m): s(s), e(e), m(m) {}

  operator bvec<E+M+1>() { return Cat(s, Cat(e, m)); }

  bvec<M+1> get_m() { return Cat(e != Lit<E>(0), m); }
  bvec<E>   get_e() { return e; }
  node      get_s() { return s; }

  bvec<E> e;
  bvec<M> m;
  node    s;
};

template <unsigned E, unsigned M> floatnum<E, M> FloatnumLit(double d) {
  using std::log2;

  if (d == 0.0) return floatnum<E, M>(Lit(0), Lit<E>(0), Lit<M>(0));

  const unsigned BIAS((1<<(E-1))-1);

  double da(fabs(d));
  int e(floor(log2(da)));
  unsigned long m(da*pow(2, M-e) - (1ul<<M));

  std::cout << "da = " << da << std::endl
            << "e = " << e << std::endl
            << "m = " << std::hex << m << std::dec << std::endl;

  return floatnum<E, M>(Lit(d < 0), Lit<E>(e + BIAS), Lit<M>(m));
}

template <unsigned N> bvec<N> Fneg(bvec<N> x) {
  return Cat(!x[N-1], x[range<0, N-2>()]);
}

template <unsigned E, unsigned M> floatnum<E, M> Fneg(floatnum<E, M> x) {
  return floatnum<E, M>(Fneg(bvec<E+M+1>(x)));
}

template <unsigned E, unsigned M, unsigned N>
  floatnum<E, M> Itof(bvec<N> x)
{
  const unsigned SZ(E + M + 1), BIAS((1<<(E-1))-1);
  node sign(x[N-1]);

  bvec<N> pos_x(Mux(sign, x, -x));
  bvec<E> e = Zext<E>(Log2(pos_x));
  bvec<LOG2(SZ)> shamt(Lit<LOG2(SZ)>(M + 1)
                        - Zext<LOG2(SZ)>(e)
                          - Lit<LOG2(SZ)>(1));
  bvec<M> m = Zext<M>(Zext<SZ>(pos_x) << Zext<CLOG2(SZ)>(shamt));

  floatnum<E, M> f(sign,
                   Mux(x == Lit<N>(0), e + Lit<E>(BIAS), Lit<E>(0)),
                   m);

  return f;
}

template <unsigned E, unsigned M, unsigned N>
  bvec<N> Ftoi(floatnum<E,M> x)
{
  const unsigned SZ(E + M + 1), BIAS((1<<(E-1))-1);

  bvec<LOG2(N)> shamt(Zext<LOG2(N)>(Lit<E>(M + BIAS) - x.get_e()));
  bvec<N> shm(Zext<N>(x.get_m()) >> shamt),
          val(Mux(x.get_s(), shm, -shm));

  node subnorm(x.get_e() == Lit<E>(0));

  return Mux(subnorm, val, Lit<N>(0));
}

template <unsigned E, unsigned M>
  floatnum<E,M> Fadd(floatnum<E,M> af, floatnum<E,M> bf)
{
  bvec<E+M+1> a(af), b(bf);

  // Swap operands if b is bigger.
  node bbigger(bf.get_e() > af.get_e() ||
               af.get_e() == bf.get_e() && bf.get_m() > af.get_m());

  floatnum<E, M> a0, b0;
  Cassign(bvec<E+M+1>(a0)).IF(bbigger, b).ELSE(a);
  Cassign(bvec<E+M+1>(b0)).IF(bbigger, a).ELSE(b);

  node sub(a0.get_s() != b0.get_s());

  bvec<2*M+2> ma(Zext<2*M+2>(a0.get_m())), mb(Zext<2*M+2>(b0.get_m()));
  bvec<2*M+2> msh(mb >> Zext<CLOG2(2*M+2)>(a0.get_e() - b0.get_e()));

  bvec<2*M+2> msum(Adder(Zext<2*M+2>(ma), Mux(sub, msh, ~msh), sub));

  bvec<E> shsum(Zext<E>(Log2(Zext<1<<CLOG2(2*M+2)>(msum))));

  node sign(a0.get_s()), subnorm(shsum + a0.get_e() < Lit<E>(M));

  bvec<E> e;
  Cassign(e).
    IF(subnorm, Lit<E>(0)).
    ELSE(a0.get_e() + shsum - Lit<E>(M));

  bvec<M> m;
  Cassign(m).
    IF(subnorm, Zext<M>(shsum)).
    IF(shsum < Lit<E>(M),
           Zext<M>(msum << Zext<CLOG2(2*M+2)>(Lit<E>(M) - shsum))).
    ELSE(Zext<M>(msum >> Zext<CLOG2(2*M+2)>(shsum - Lit<E>(M))));
  
  return floatnum<E, M>(sign, e, m);
}

template <unsigned E, unsigned M>
  floatnum<E,M> Fadd(bvec<E+M+1> a, bvec<E+M+1> b)
{
  floatnum<E, M> af(a), bf(b);
  return Fadd(af, bf);
}

template <unsigned E, unsigned M>
  floatnum<E,M> Fmul(floatnum<E,M> a, floatnum<E,M> b)
{
  const unsigned BIAS((1<<(E-1))-1);

  bvec<2*M + 2> p(Cat(Lit<M+1>(0), a.get_m()) * Cat(Lit<M+1>(0), b.get_m()));

  // Three possibilities:
  //   - p[2*M+1] is set and the product must be shifted right and the exponent
  //     incremented.
  //   - p[2*M+1] is clear, but p[2*M] is set and the product is fine the way it
  //     is.
  //   - p[2*M+1] and p[2*M] are clear and the product is subnormal.
  node shifted(p[2*M+1]), sign(a.get_s() != b.get_s());
  bvec<M> m(Mux(shifted, p[range<M, 2*M-1>()], p[range<M+1, 2*M>()]));
  bvec<E> sh(Cat(Lit<E-1>(0), shifted)),
          e(Mux(!(p[2*M+1] || p[2*M]),
                a.get_e() + b.get_e() - Lit<E>(BIAS) + sh,
                Lit<E>(0)));

  return floatnum<E, M>(sign, e, m);
}

}

#endif
