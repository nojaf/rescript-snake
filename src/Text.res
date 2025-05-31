open Kaplay
open GameContext

type t

include Text.Comp({
  type t = t
})

include Color.Comp({
  type t = t
})

include Pos.Comp({
  type t = t
})

include Anchor.Comp({
  type t = t
})

let make = (text, ~size, ~x, ~y): t => {
  k->Context.add([
    addText(
      k,
      text,
      ~options={
        size: size,
      },
    ),
    addPos(k, x, y),
    addAnchorCenter(k),
    addColor(k, Constants.neutral700),
  ])
}
