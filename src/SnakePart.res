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

include AreaComp({
  type t = t
})

let make = (~x, ~y, tag): t => {
  k->Kaplay.add([
    addPos(k, x, y),
    addRect(k, Constants.tileSize, Constants.tileSize),
    addColor(k, tag == Constants.SnakeHead ? Constants.red500 : Constants.red600),
    addArea(k),
    Kaplay.tag((tag :> string)),
  ])
}
