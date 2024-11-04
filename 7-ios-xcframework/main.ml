open Uikit

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
    and label = _new_ UILabel.self
    and main_screen_bounds =
      UIScreen.self
      |> UIScreenClass.mainScreen
      |> UIScreen.bounds
    in
    label |> UILabel.setText (new_string "Hello from OCaml!");
    label |> UILabel.setTextColor (UIColorClass.blackColor UIColor.self);
    label |> UILabel.setTextAlignment _UITextAlignmentCenter;
    label |> UIView.setFrame main_screen_bounds;
    win |> UIWindow.contentView |> UIView.addSubview label

  let methods =
    [ Method.define show_hello
      ~cmd: (selector "sceneActivated")
      ~args: Objc_type.[id]
      ~return: Objc_type.void

    ; Method.define
      ~cmd: (selector "appLaunched")
      ~args: Objc_type.[id; id]
      ~return: Objc_type.void
      (fun _self _cmd _app _opts -> Printf.eprintf "App Launched...\n%!")
    ]

  let _class_ = Class.define "AppController" ~methods
end

let main () =
  let ctrl = _new_ App_controller.self
  and nc =
    NSNotificationCenter.self |> NSNotificationCenterClass.defaultCenter
  in
  nc |> NSNotificationCenter.addObserver ctrl
    ~selector_: (selector "sceneActivated")
    ~name: _UISceneDidActivateNotification
    ~object_: nil;
  nc |> NSNotificationCenter.addObserver ctrl
    ~selector_: (selector "appLaunched")
    ~name: _UIApplicationDidFinishLaunchingNotification
    ~object_: nil

let () = main ()