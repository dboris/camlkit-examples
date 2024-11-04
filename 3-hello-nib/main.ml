open AppKit

(* This example demonstrates how to access view objects from a NIB file.
   The UI was laid out in Interface Builder and saved as a NIB file
   `MainWindowController.nib`.
*)

let setup_ui self _cmd =
  let app = NSApplication.self |> NSApplicationClass.sharedApplication
  and win = self |> NSWindowController.window in
  let cv = win |> NSWindow.contentView in

  (* Access subviews by tag from NIB file *)
  let label = cv |> NSView.viewWithTag 1
  and button = cv |> NSView.viewWithTag 2
  in
  label |> NSControl.setStringValue (new_string "Hello, world!");
  button |> NSControl.setTarget app;
  button |> NSControl.setAction (selector "terminate:");
  win |> NSWindow.setTitle (new_string "3-Hello-NIB")
;;

let main () =
  let wc_class =
    Class.define "MainWindowController"
      ~superclass: NSWindowController.self
      ~methods: [
        Method.define setup_ui
          ~cmd: (selector "windowDidLoad")
          ~args: Objc_type.noargs ~return: Objc_type.void
      ]
  in
  let wc =
    alloc wc_class
    |> NSWindowController.initWithWindowNibName
      (new_string "MainWindowController")
  in
  wc |> NSWindowController.showWindow nil;

  let app = NSApplication.self |> NSApplicationClass.sharedApplication in
  app
  |> NSApplication.setActivationPolicy _NSApplicationActivationPolicyRegular
  |> ignore;
  app |> NSApplication.activateIgnoringOtherApps true;

  NSApplication.run app
;;

let () = main ()
