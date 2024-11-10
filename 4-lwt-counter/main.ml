open AppKit

let main () =
  let app = NSApplication.self |> NSApplicationClass.sharedApplication in
  let  _ = app |> NSApplication.setActivationPolicy
    _NSApplicationActivationPolicyRegular
  in
  app |> NSApplication.setDelegate (Counter.self |> alloc |> init);
  app |> NSApplication.activateIgnoringOtherApps true;
  app |> NSApplication.run

let () = main ()
