open Foundation
open Uikit
open Uikit_globals
open Runtime

(* This example illustrates a "Hello world" app built as a library.
   It is intended to be linked with the app created in Xcode from the
   default app template.
*)

module App_controller = struct
  let show_hello _self _cmd notif =
    let win =
      notif
      |> NSNotification.object_
      |> UIWindowScene.windows
      |> NSArray.firstObject
    and label = _new_ UILabel._class_
    and main_screen_bounds =
      UIScreen._class_
      |> UIScreen.C.mainScreen
      |> UIScreen.bounds
    in
    label |> UILabel.setText (new_string "Hello from OCaml");
    label |> UILabel.setTextColor (UIColor.C.blackColor UIColor._class_);
    label |> UILabel.setTextAlignment _UITextAlignmentCenter;
    label |> UIView.setFrame main_screen_bounds;
    win |> UIWindow.contentView |> UIView.addSubview label

  let methods =
    [ Define._method_ show_hello
      ~cmd: (selector "sceneActivated")
      ~args: Objc_t.[id]
      ~return: Objc_t.void
    ]

  let _class_ = Define._class_ "AppController" ~methods
end

let main () =
  Callback.register "camllib_applicationDidFinishLaunching" (fun () ->
    let ctrl = _new_ App_controller._class_
    and nc =
      NSNotificationCenter._class_ |> NSNotificationCenter.C.defaultCenter
    in
    nc |> NSNotificationCenter.addObserver ctrl
      ~selector_: (selector "sceneActivated")
      ~name: (new_string "UISceneDidActivateNotification")
      ~object_: nil)

let () = main ()