open AppKit
open Camlkit

module Delegate = Appkit_AppDelegate.Create (App_delegate)

let main () =
  let _ = _new_ NSAutoreleasePool.self
  and _ = Document.define ()
  and _ = Todo.define ()
  and app = NSApplication.self |> NSApplicationClass.sharedApplication
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
