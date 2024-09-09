open Foundation
open AppKit
open Runtime

let label =
  NSTextField.self |> NSTextFieldClass.labelWithString (new_string "")
let increment_sel = selector "incrementClicked:"

let update_label () =
  let count = Model.get_count () |> string_of_int  in
  label |> NSControl.setStringValue (new_string count)
;;

let increment_count_method _self _cmd _sender =
  Model.increment ();
  update_label ()
;;

let controller_class =
  Class.define "MyController"
    ~methods:
      [ Method.define increment_count_method
        ~cmd: increment_sel ~args: Objc_t.[id] ~return: Objc_t.void
      ]
;;

let create _app =
  let w = 400. and h = 300. in
  let win =
    alloc NSWindow.self
    |> NSWindow.initWithContentRect
      (CGRect.make ~x: 0. ~y: 0. ~width: w ~height: h)
      ~styleMask: (Bitmask.of_list [
        _NSWindowStyleMaskTitled; _NSWindowStyleMaskClosable
      ])
      ~backing: _NSBackingStoreBuffered
      ~defer: false
  and controller = _new_ controller_class
  in
  let btn =
    NSButton.self
    |> NSButtonClass.buttonWithTitle (new_string "Increment")
      ~target: controller ~action: increment_sel
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