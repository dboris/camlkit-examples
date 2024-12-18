open Foundation
open Runtime

let class_name = "MainAppController"

let ivars = []

let init self = self

let method_signature_for_selector = function
  | "incrementClicked:" -> Objc_type.(encode_method ~args: [id] void)
  | _ -> Objc_type.(encode_value unknown)
;;

let handle_invocation inv _ =
  match string_of_selector (NSInvocation.selector_ inv) with
  | "incrementClicked:" ->
    Model.increment ();
    Main_window.update_label ()
  | _ -> raise Not_found
;;
