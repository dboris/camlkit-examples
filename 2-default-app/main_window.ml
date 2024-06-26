open Foundation
open Appkit
open Appkit_globals
open Runtime

let label =
  NSTextField._class_ |> NSTextField.C.labelWithString (new_string "")
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
  Define._class_ "MyController"
    ~methods:
      [ Define._method_ increment_count_method
        ~cmd: increment_sel ~args: Objc_t.[id] ~return: Objc_t.void
      ]
;;

let create _app =
  let w = 400. and h = 300. in
  let win =
    alloc NSWindow._class_
    |> NSWindow.initWithContentRect
      (CGRect.make ~x: 0. ~y: 0. ~width: w ~height: h)
      ~styleMask: (combine_options [
        _NSWindowStyleMaskTitled; _NSWindowStyleMaskClosable
      ])
      ~backing: _NSBackingStoreBuffered
      ~defer: false
  and controller = _new_ controller_class
  in
  let btn =
    NSButton._class_
    |> NSButton.C.buttonWithTitle (new_string "Increment")
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