open Foundation
open AppKit
open Runtime

let label =
  NSTextField.self |> NSTextFieldClass.labelWithString (new_string "")

let update_label () =
  let count = Model.get_count () |> string_of_int  in
  label |> NSControl.setStringValue (new_string count)
;;

let create app_ctrl =
  let w = 400. and h = 300. in
  let win =
    alloc NSWindow.self
    |> NSWindow.initWithContentRect
      (CGRect.make ~x: 0. ~y: 0. ~width: w ~height: h)
      ~styleMask: (Bitmask.of_list [
        _NSWindowStyleMaskTitled;
        _NSWindowStyleMaskClosable;
        _NSWindowStyleMaskResizable
        ])
      ~backing: _NSBackingStoreBuffered
      ~defer: false
  in
  let btn =
    NSButton.self
    |> NSButtonClass.buttonWithTitle (new_string "Increment")
      ~target: app_ctrl ~action: (selector "incrementClicked:")
  in
  btn |> NSView.setFrame
    (CGRect.make ~x: 50. ~y: (h -. 40.) ~width: 100. ~height: 30.);

  update_label ();

  label |> NSView.setFrame
    (CGRect.make ~x: 20. ~y: (h -. 45.) ~width: 50. ~height: 30.);

  win |> NSWindow.contentView |> NSView.addSubview label;
  win |> NSWindow.contentView |> NSView.addSubview btn;
  win
;;