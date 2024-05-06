open Runtime
open Appkit
open Camlkit

module Delegate = Appkit_AppDelegate.Create (App_delegate)

let main () =
  let _ = new_object "NSAutoreleasePool"
  and app = NSApplication._class_ |> NSApplication.C.sharedApplication
  and argc = Array.length Sys.argv
  and argv =
    Sys.argv
    |> Array.to_list
    |> Objc.(CArray.of_list string)
    |> Objc.CArray.start
  in
  assert (app |>
    NSApplication.setActivationPolicy Appkit_._NSApplicationActivationPolicyRegular);
  app |> NSApplication.setDelegate (_new_ Delegate._class_);
  app |> NSApplication.activateIgnoringOtherApps true;

  Appkit_._NSApplicationMain argc argv |> exit
;;

let () = main ()
