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

include Area.Comp({
  type t = t
})

let make = (~x, ~y, tag): t => {
  k->Context.add([
    addPos(k, x, y),
    addRect(k, Constants.tileSize, Constants.tileSize),
    addColor(k, tag == Constants.SnakeHead ? Constants.red500 : Constants.red600),
    addArea(k),
    Context.tag((tag :> string)),
  ])
}
