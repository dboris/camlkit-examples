open Foundation
open Appkit
open Appkit_globals
open Camlkit
open Runtime

module Delegate = Appkit_AppDelegate.Create (App_delegate)

let main () =
  let _ = _new_ NSAutoreleasePool._class_
  and _ = Document.define_class ()
  and _ = Todo.define_class ()
  and app = NSApplication._class_ |> NSApplication.C.sharedApplication
  and argc = Array.length Sys.argv
  and argv =
    Sys.argv
    |> Array.to_list
    |> Objc.(CArray.of_list string)
    |> Objc.CArray.start
  in
  app |> NSApplication.activateIgnoringOtherApps true;
  _NSApplicationMain argc argv |> exit
;;

let () = main ()
