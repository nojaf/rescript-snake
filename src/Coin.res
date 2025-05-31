open Kaplay
open GameContext

type t

include GameObjRaw.Comp({
  type t = t
})

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

include Z.Comp({
  type t = t
})

let make = (snakeHead, snakeTail) => {
  let randomPos = () => {
    let max = Constants.gameSizeF - Constants.tileSize
    let randomX = k->Context.randf(Constants.tileSize, max)
    let valueX = randomX - randomX % Constants.tileSize
    let randomY = k->Context.randf(Constants.tileSize, max)
    let valueY = randomY - randomY % Constants.tileSize
    let pos = k->Context.vec2(valueX, valueY)
    pos
  }

  let isGoodPosition = (pos: Kaplay.Vec2.t) => {
    !(snakeHead->SnakePart.hasPoint(pos)) &&
    snakeTail->Array.every(tailPart => {
      !(tailPart->SnakePart.hasPoint(pos))
    })
  }

  let rec coinPos = () => {
    let pos = randomPos()
    isGoodPosition(pos) ? pos : coinPos()
  }

  k
  ->Kaplay.Context.add([
    addRect(k, Constants.tileSize, Constants.tileSize),
    addColor(k, Constants.yellow300),
    addPosFromVec2(k, coinPos()),
    addArea(k),
    Context.tag((Constants.Coin :> string)),
  ])
  ->ignore
}
