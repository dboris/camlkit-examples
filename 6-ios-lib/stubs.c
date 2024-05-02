#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include <caml/mlvalues.h>
#include <caml/callback.h>
#include <caml/alloc.h>

static value val_of_ptr(void * p) {
  return caml_copy_nativeint((intnat) p);
}

// Call this function in C's main to initialize the OCaml runtime
void camllib_init(char ** argv) {
  caml_startup(argv);
}

// Call this function in your AppDelegate
void camllib_applicationDidFinishLaunching(void) {
  static const value * closure = NULL;
  if (closure == NULL) closure =
    caml_named_value("camllib_applicationDidFinishLaunching");
  caml_callback(*closure, Val_unit);
}
