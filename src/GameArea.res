open Kaplay
open GameContext

type t

include AreaComp({
  type t = t
})

let make = (): t => {
  k->Kaplay.add([
    addArea(
      k,
      ~options={
        shape: k->mathRect(
          Constants.tileSizeVector,
          Constants.gameSizeF - 2. * Constants.tileSize,
          Constants.gameSizeF - 2. * Constants.tileSize,
        ),
      },
    ),
  ])
}
