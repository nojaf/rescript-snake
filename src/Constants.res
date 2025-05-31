open Kaplay.Context
open GameContext

let gameSize = 500
let gameSizeF = 500.0
let tileSize = 25.
let tileSizeVector = k->vec2(tileSize, tileSize)

type tags = SnakeHead | SnakeTail | Coin

type scenes =
  | Game
  | GameOver

let initialGameSpeed = 0.50

// Wall
let grey400 = k->colorFromHex("#99a1af")
// Snake head
let red500 = k->colorFromHex("#fb2c36")
// Snake tail
let red600 = k->colorFromHex("#e7000b")
// Coin
let yellow300 = k->colorFromHex("#ffdf20")
// Text
let neutral700 = k->colorFromHex("#404040")
