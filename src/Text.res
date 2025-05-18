open Kaplay
open GameContext

type t

include TextComp({
  type t = t
})

include ColorComp({
  type t = t
})

include PosComp({
  type t = t
})

include AnchorComp({
  type t = t
})

let make = (text, ~size, ~x, ~y): t => {
  k->Kaplay.add([
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
