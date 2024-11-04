open Runtime
open Objc_type

let define () =
  Class.define "Todo"
    ~properties:
      [ Property.define "task" id
      ; Property.define "due" id
      ; Property.define "priority" int
      ]
