open Kaplay.Context
open Kaplay.Types
open GameContext

type gameState = {
  mutable lastUpdate: float,
  mutable speed: float,
  mutable currentDirection: Kaplay.Vec2.t,
  directionQueue: Queue.t<Kaplay.Vec2.t>,
  mutable score: int,
}

let resetGameState = () => {
  {
    lastUpdate: 0.0,
    speed: Constants.initialGameSpeed,
    currentDirection: k->vec2Right,
    directionQueue: Queue.make(3),
    score: 0,
  }
}

let directionMap = Map.fromArray([
  (Up, k->vec2Up),
  (Down, k->vec2Down),
  (Left, k->vec2Left),
  (Right, k->vec2Right),
])

let areOppositeVectors = (v1: Kaplay.Vec2.t, v2: Kaplay.Vec2.t) => {
  v1.x == -v2.x && v1.y == -v2.y
}

let gameOver = score => {
  k->go((Constants.GameOver :> string), ~data=score)
}

let game = () => {
  let gameState = resetGameState()

  let _topWall = Wall.make(~x=0.0, ~y=0.0, ~width=Constants.gameSizeF, ~height=Constants.tileSize)
  let _bottomWall = Wall.make(
    ~x=0.0,
    ~y=Constants.gameSizeF - Constants.tileSize,
    ~width=Constants.gameSizeF,
    ~height=Constants.tileSize,
  )

  let _leftWall = Wall.make(~x=0.0, ~y=0.0, ~width=Constants.tileSize, ~height=Constants.gameSizeF)
  let _rightWall = Wall.make(
    ~x=Constants.gameSizeF - Constants.tileSize,
    ~y=0.0,
    ~width=Constants.tileSize,
    ~height=Constants.gameSizeF,
  )

  let gameArea = GameArea.make()

  let snakeHead = SnakePart.make(
    ~x=9. *. Constants.tileSize,
    ~y=9. *. Constants.tileSize,
    Constants.SnakeHead,
  )

  let snakeTail = {
    let headPos = snakeHead->SnakePart.getPos
    Array.fromInitializer(~length=2, idx => {
      SnakePart.make(
        ~x=headPos.x + Int.toFloat(idx - 1) * Constants.tileSize,
        ~y=headPos.y,
        Constants.SnakeTail,
      )
    })
  }

  let scoreText = Text.make(
    `Score: ${gameState.score->Int.toString}`,
    ~size=Constants.tileSize,
    ~x=Constants.gameSizeF / 2.,
    ~y=Constants.gameSizeF + Constants.tileSize,
  )

  k
  ->onUpdate(() => {
    let deltaTime = k->dt
    gameState.lastUpdate = gameState.lastUpdate + deltaTime
    if gameState.lastUpdate >= gameState.speed {
      switch gameState.directionQueue->Queue.dequeue {
      | Some(direction) if !areOppositeVectors(gameState.currentDirection, direction) =>
        gameState.currentDirection = direction
      | _ => ()
      }

      let nextMove = gameState.currentDirection->Kaplay.Vec2.scale(Constants.tileSizeVector)
      let currentPos = snakeHead->SnakePart.getPos
      let nextPos = currentPos->Kaplay.Vec2.add(nextMove)
      if gameArea->GameArea.hasPoint(nextPos) {
        snakeHead->SnakePart.setPos(nextPos)

        // Move the tail
        Array.reduce(snakeTail, currentPos, (acc, tailPart) => {
          let nextTailPos = tailPart->SnakePart.getPos
          tailPart->SnakePart.setPos(acc)
          nextTailPos
        })->ignore
      } else {
        gameOver(gameState.score)
      }

      switch k->getGameObjects((Constants.Coin :> string)) {
      | [coin] if Coin.hasPoint(coin, nextPos) => {
          coin->Coin.destroy
          gameState.score = gameState.score + 1
          Coin.make(snakeHead, snakeTail)
          scoreText->Text.setText(`Score: ${gameState.score->Int.toString}`)
          snakeTail->Array.push(
            SnakePart.make(~x=currentPos.x, ~y=currentPos.y, Constants.SnakeTail),
          )

          // Game speed should never go below 0.2
          gameState.speed = Math.max(0.2, gameState.speed - 0.05)
        }
      | _ => ()
      }

      // Snake head touch the tail?
      if (
        snakeTail->Array.some(tailPart => {
          tailPart->SnakePart.hasPoint(nextPos)
        })
      ) {
        gameOver(gameState.score)
      }

      gameState.lastUpdate = 0.0
    }
  })
  ->ignore

  k
  ->onKeyRelease(key => {
    let nextDirection = switch Queue.peek(gameState.directionQueue) {
    | None => gameState.currentDirection
    | Some(direction) => direction
    }

    switch Map.get(directionMap, key) {
    | Some(direction) if !areOppositeVectors(nextDirection, direction) =>
      gameState.directionQueue->Queue.enqueue(direction)
    | _ => ()
    }
  })
  ->ignore

  Coin.make(snakeHead, snakeTail)
}

let gameOver = score => {
  let _gameOverText = Text.make("Game Over", ~size=30., ~x=(k->center).x, ~y=(k->center).y)
  let _scoreText = Text.make(
    `Score ${score->Int.toString}`,
    ~size=20.,
    ~x=(k->center).x,
    ~y=(k->center).y + 50.,
  )
  let _playAgainText = Text.make(
    "(Click to play again)",
    ~size=16.,
    ~x=(k->center).x,
    ~y=(k->center).y + 90.,
  )

  k
  ->onClick(() => {
    k->go((Constants.Game :> string))
  })
  ->ignore
}

k->scene((Constants.Game :> string), game)
k->scene((Constants.GameOver :> string), gameOver)
k->go((Constants.Game :> string))
