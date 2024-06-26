open Foundation
open Runtime
module T = Objc_t

let define_class () =
  let open Define in
  let items = "items" in
  let ivars = [ ivar items T.id ]

  and init self cmd =
    let self = self |> msg_super cmd ~args: T.[] ~return: T.id in
    self |> Property.set items (new_object "NSMutableArray") ~typ: Objc_t.id;
    self
  in
  let methods =
    Property._object_ items T.id () @
    [ _method_ init
      ~cmd: (selector "init") ~args: T.[] ~return: T.id

    ; _method_ (fun _ _ -> true)
      ~cmd: (selector "autosavesInPlace") ~args: T.[] ~return: T.bool

    ; _method_ (fun _ _ -> new_string "Document")
      ~cmd: (selector "windowNibName") ~args: T.[] ~return: T.id

    ; _method_ (fun _ _ _data_type _err -> nil)
      ~cmd: (selector "dataOfType:error:") ~args: T.[id; ptr id] ~return: T.id

    ; _method_ (fun _ _ _data _data_type _err -> true)
      ~cmd: (selector "readFromData:ofType:error:")
      ~args: T.[id; id; ptr id] ~return: T.bool
    ]
  in
  _class_ "Document" ~superclass: NSDocument._class_ ~methods ~ivars
