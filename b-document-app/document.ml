open AppKit
open Runtime
module T = Objc_t

let define_class () =
  let items = "items" in
  let ivars = [ Ivar.define items T.id ]

  and init self cmd =
    let self = self |> msg_super cmd ~args: T.[] ~return: T.id in
    self |> Property.set items (new_object "NSMutableArray") ~typ: Objc_t.id;
    self
  in
  let methods =
    Property._object_ items T.id () @
    [ Method.define init
      ~cmd: (selector "init") ~args: T.[] ~return: T.id

    ; Method.define (fun _ _ -> true)
      ~cmd: (selector "autosavesInPlace") ~args: T.[] ~return: T.bool

    ; Method.define (fun _ _ -> new_string "Document")
      ~cmd: (selector "windowNibName") ~args: T.[] ~return: T.id

    ; Method.define (fun _ _ _data_type _err -> nil)
      ~cmd: (selector "dataOfType:error:") ~args: T.[id; ptr id] ~return: T.id

    ; Method.define (fun _ _ _data _data_type _err -> true)
      ~cmd: (selector "readFromData:ofType:error:")
      ~args: T.[id; id; ptr id] ~return: T.bool
    ]
  in
  Class.define "Document" ~superclass: NSDocument.self ~methods ~ivars
