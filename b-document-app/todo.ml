open Runtime

let define_class () =
  let task = "task" and due = "due" and priority = "priority" in
  let ivars =
    [ Ivar.define task Objc_t.id
    ; Ivar.define due Objc_t.id
    ; Ivar.define priority Objc_t.int
    ]
  and methods =
    Property._object_ task Objc_t.id () @
    Property._object_ due Objc_t.id () @
    Property.value priority Objc_t.int
  in
    Class.define "Todo" ~ivars ~methods
;;
