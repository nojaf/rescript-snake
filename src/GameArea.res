open Kaplay
open GameContext

type t

include Area.Comp({
  type t = t
})

let make = (): t => {
  k->Context.add([
    addArea(
      k,
      ~options={
        shape: k->Context.mathRect(
          Constants.tileSizeVector,
          Constants.gameSizeF - 2. * Constants.tileSize,
          Constants.gameSizeF - 2. * Constants.tileSize,
        ),
      },
    ),
  ])
}
