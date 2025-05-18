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

include ZComp({
  type t = t
})

let make = (snakeHead, snakeTail) => {
  let randomPos = () => {
    let max = Constants.gameSizeF - Constants.tileSize
    let randomX = k->randf(Constants.tileSize, max)
    let valueX = randomX - randomX % Constants.tileSize
    let randomY = k->randf(Constants.tileSize, max)
    let valueY = randomY - randomY % Constants.tileSize
    let pos = k->vec2(valueX, valueY)
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
  ->Kaplay.add([
    addRect(k, Constants.tileSize, Constants.tileSize),
    addColor(k, Constants.yellow300),
    addPosFromVec2(k, coinPos()),
    addArea(k),
    tag((Constants.Coin :> string)),
  ])
  ->ignore
}
