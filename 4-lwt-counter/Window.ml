open AppKit

let label1 = ref nil
let label2 = ref nil

let create ?(width=300.) ?(height=200.) title =
  let app = NSApplication.self |> NSApplicationClass.sharedApplication in
  let win =
    NSWindow.self |> alloc |> NSWindow.initWithContentRect
      (CGRect.make ~x:0. ~y:0. ~width ~height)
      ~styleMask:Bitmask.(_NSWindowStyleMaskTitled + _NSWindowStyleMaskClosable)
      ~backing:_NSBackingStoreBuffered
      ~defer:false
  and quit_btn =
    NSButton.self |> NSButtonClass.buttonWithTitle (new_string "Quit")
      ~target:app ~action:(selector "terminate:")
  and sv = NSStackView.self |> alloc |> init in
  label1 := NSTextField.self |> NSTextFieldClass.labelWithString
    (new_string "Native count: 0") |> retain;
  label2 := NSTextField.self |> NSTextFieldClass.labelWithString
    (new_string "LWT count: 0") |> retain;
  sv |> NSStackView.setOrientation _NSUserInterfaceLayoutOrientationVertical;
  sv |> NSStackView.setSpacing 30.;
  sv |> NSStackView.setEdgeInsets
    (NSEdgeInsets.init ~top:20. ~bottom:20. ~left:20. ~right:20.) ;
  sv |> NSStackView.addArrangedSubview !label1;
  sv |> NSStackView.addArrangedSubview !label2;
  sv |> NSStackView.addArrangedSubview quit_btn;
  win |> NSWindow.setTitle (new_string title);
  win |> NSWindow.setContentView sv;
  win