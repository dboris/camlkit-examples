open Foundation
open AppKit
open Runtime

let create_window app =
  let w = 300. and h = 200. in
  let win =
    alloc NSWindow.self
    |> NSWindow.initWithContentRect
      (CGRect.make ~x: 0. ~y: 0. ~width: w ~height: h)
      ~styleMask: (Bitmask.of_list [
        _NSWindowStyleMaskTitled; _NSWindowStyleMaskClosable])
      ~backing: _NSBackingStoreBuffered
      ~defer: false
  and btn =
    NSButton.self
    |> NSButtonClass.buttonWithTitle (new_string "Quit")
      ~target: app ~action: (selector "terminate:")
  and label =
    NSTextField.self
    |> NSTextFieldClass.labelWithString (new_string "Hello, world!")
  in
  label |> NSView.setFrame
    (CGRect.make ~x: 10. ~y: (h -. 40.) ~width: 150. ~height: 30.);
  btn |> NSView.setFrame
    (CGRect.make ~x: 190. ~y: 10. ~width: 100. ~height: 30.);

  win |> NSWindow.contentView |> NSView.addSubview label;
  win |> NSWindow.contentView |> NSView.addSubview btn;
  win |> NSWindow.setTitle (new_string "1-Hello");
  win
;;

let main () =
  let app = NSApplication.self |> NSApplicationClass.sharedApplication in
  let win = create_window app in
  win |> NSWindow.cascadeTopLeftFromPoint (CGPoint.init ~x: 20. ~y: 1000.)
  |> ignore;
  win |> NSWindow.makeKeyAndOrderFront nil;

  app |> NSApplication.setActivationPolicy _NSApplicationActivationPolicyRegular
  |> ignore;
  app |> NSApplication.activateIgnoringOtherApps true;

  NSApplication.run app
;;

let () = main ()
