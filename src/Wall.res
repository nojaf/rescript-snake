open Kaplay
open GameContext

type t

include PosComp({
  type t = t
})
include RectComp({
  type t = t
})
include ColorComp({
  type t = t
})

let make = (~x, ~y, ~width, ~height) => {
  Kaplay.add(k, [addPos(k, x, y), addRect(k, width, height), addColor(k, Constants.grey400)])
}
