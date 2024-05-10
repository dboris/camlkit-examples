#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include <caml/mlvalues.h>
#include <caml/callback.h>
#include <caml/alloc.h>

// Call this function in C's main to initialize the OCaml runtime
void camllib_init(char ** argv) {
  caml_startup(argv);
}
