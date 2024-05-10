open Uikit
open Foundation
open Runtime

(* This example illustrates a "Hello world" app built as a library.
   The only requirement for the Xcode project is to call `caml_startup` in
   `main`. There are no stubs.
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
    label |> UILabel.setText (new_string "Hello from OCaml!");
    label |> UILabel.setTextColor (UIColor.C.blackColor UIColor._class_);
    label |> UILabel.setTextAlignment Uikit_._UITextAlignmentCenter;
    label |> UIView.setFrame main_screen_bounds;
    win |> UIWindow.contentView |> UIView.addSubview label

  let methods =
    [ Define._method_ show_hello
      ~cmd: (selector "sceneActivated")
      ~args: Objc_t.[id]
      ~return: Objc_t.void

    ; Define._method_
      ~cmd: (selector "appLaunched")
      ~args: Objc_t.[id; id]
      ~return: Objc_t.void
      (fun _self _cmd _app _opts -> Printf.eprintf "App Launched...\n%!")
    ]

  let _class_ = Define._class_ "AppController" ~methods
end

let main () =
  let ctrl = _new_ App_controller._class_
  and nc =
    NSNotificationCenter._class_ |> NSNotificationCenter.C.defaultCenter
  in
  nc |> NSNotificationCenter.addObserver ctrl
    ~selector_: (selector "sceneActivated")
    ~name: Uikit_._UISceneDidActivateNotification
    ~object_: nil;
  nc |> NSNotificationCenter.addObserver ctrl
    ~selector_: (selector "appLaunched")
    ~name: Uikit_._UIApplicationDidFinishLaunchingNotification
    ~object_: nil

let () = main ()