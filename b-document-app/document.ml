open AppKit

let define () =
  let items = "items" in
  let init self cmd =
    let self =
      msg_super cmd ~self ~args: Objc_type.noargs ~return: Objc_type.id in
    self |> Property.set items (NSMutableArray.self |> _new_) Objc_type.id;
    self
  in
  let methods =
    [ NSObjectMethods.init init
    ; NSDocumentMethods.windowNibName (fun _ _ -> new_string "Document")
    ; NSDocumentMethods.dataOfType'error' (fun _ _ _dt _err -> nil)
    ; NSDocumentMethods.readFromData'ofType'error'
        (fun _ _ _data _dt _err -> true)
    ]
  in
  Class.define "Document"
    ~superclass: NSDocument.self
    ~properties: [Property.define items Objc_type.id]
    ~class_methods: [NSDocumentClassMethods.autosavesInPlace (fun _ _ -> true)]
    ~methods
