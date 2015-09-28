/*
 * Floating point data filter for GTKWave. 32-bit floating point numbers go in
 * as hex and come out nicely rendered. Makes it easier to validate the
 * pipelined functional units we are generating.
 */

#include <stdio.h>

int main() {
  while (!feof(stdin)) {
    char s[80];
    fgets(s, 80, stdin);
    if (feof(stdin)) break;
    fprintf(stderr, "Got %s", s);
    unsigned x;
    sscanf(s, "%x", &x);
    float *f = (void*)&x;
    fprintf(stdout, "%f\n", *f);
    fflush(stdout);
    fprintf(stderr, "Processed %f\n", *f);
  }

  return 0;
}
