open Kaplay
open GameContext

type t

include Pos.Comp({
  type t = t
})
include Rect.Comp({
  type t = t
})
include Color.Comp({
  type t = t
})

let make = (~x, ~y, ~width, ~height) => {
  Context.add(k, [addPos(k, x, y), addRect(k, width, height), addColor(k, Constants.grey400)])
}
