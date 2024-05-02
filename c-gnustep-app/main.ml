open Appkit
open Runtime


module Delegate = AppDelegate.Create (App_delegate)

let main () =
  let _ = new_object "NSAutoreleasePool"
  and app = NSApplication._class_ |> NSApplication.Class.sharedApplication
  and argc = Array.length Sys.argv
  and argv =
    Sys.argv
    |> Array.to_list
    |> Objc.(CArray.of_list string)
    |> Objc.CArray.start
  in
  app |> NSApplication.setDelegate (_new_ Delegate._class_);
  app |> NSApplication.activateIgnoringOtherApps true;

  Appkit_global.main ~argc ~argv |> exit
;;

let () = main ()