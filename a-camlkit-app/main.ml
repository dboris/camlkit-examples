open AppKit
open Camlkit

module Delegate = Appkit_AppDelegate.Create (App_delegate)

let main () =
  let app = NSApplication.self |> NSApplicationClass.sharedApplication
  and argc = Array.length Sys.argv
  and argv =
    Sys.argv
    |> Array.to_list
    |> Objc.(CArray.of_list string)
    |> Objc.CArray.start
  in
  assert (app |>
    NSApplication.setActivationPolicy _NSApplicationActivationPolicyRegular);
  app |> NSApplication.setDelegate (_new_ Delegate.self);
  app |> NSApplication.activateIgnoringOtherApps true;

  _NSApplicationMain argc argv |> exit
;;

let () = main ()
