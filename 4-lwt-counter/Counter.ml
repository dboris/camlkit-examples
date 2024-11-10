open AppKit
open Printf
open Lwt.Syntax

module CountProp = struct
  let name = "count" and t = Objc_type.int
  let prop = Property.define name t
  let get = Property.get name t and set v = Property.set name v t
end

let self =
  Class.define "Counter"
    ~properties:[ CountProp.prop ]
    ~superclass:NSResponder.self
    ~methods:[
      NSApplicationDelegate.applicationDidFinishLaunching' (fun self _cmd _notif ->
        let timer =
          NSTimer.self |> NSTimerClass.scheduledTimerWithTimeInterval2 1.0
            ~target:self ~selector_:(selector "updateNativeCounter")
            ~userInfo:nil ~repeats:true
        and win = Window.create "Native+LWT Counter" in
        let rec lwt_counter interval count =
          let* () = Lwt_unix.sleep interval in
          self |> NSObject.performSelectorOnMainThread
            (selector "updateLwtCounter:")
            ~withObject:(new_string (sprintf "LWT count: %i" count))
            ~waitUntilDone:false;
          lwt_counter interval (count + 1)
        in
        win |> NSWindow.center;
        win |> NSWindow.makeKeyAndOrderFront nil;
        NSRunLoop.self |> NSRunLoopClass.currentRunLoop
        |> NSRunLoop.addTimer timer ~forMode:_NSDefaultRunLoopMode;
        self |> CountProp.set 0;
        Thread.create (fun () ->
          Lwt_main.run (lwt_counter 1.0 1)) ()
          |> ignore);

      Method.define ~cmd:(selector "updateNativeCounter")
        ~args:Objc_type.noargs ~return:Objc_type.void
        (fun self _cmd ->
          let count = self |> CountProp.get in
          let str = sprintf "Native count: %i" count in
          !Window.label1 |> NSControl.setStringValue (new_string str);
          self |> CountProp.set (count + 1));

      Method.define ~cmd:(selector "updateLwtCounter:")
        ~args:Objc_type.[id] ~return:Objc_type.void
        (fun _self _cmd count_str ->
          !Window.label2 |> NSControl.setStringValue count_str)
    ]