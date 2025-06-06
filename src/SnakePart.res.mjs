// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Constants from "./Constants.res.mjs";
import * as Pos$Kaplay from "@nojaf/rescript-kaplay/src/Components/Pos.res.mjs";
import * as Area$Kaplay from "@nojaf/rescript-kaplay/src/Components/Area.res.mjs";
import * as GameContext from "./GameContext.res.mjs";
import * as Rect$Kaplay from "@nojaf/rescript-kaplay/src/Components/Rect.res.mjs";
import * as Color$Kaplay from "@nojaf/rescript-kaplay/src/Components/Color.res.mjs";

Pos$Kaplay.Comp({});

Rect$Kaplay.Comp({});

Color$Kaplay.Comp({});

Area$Kaplay.Comp({});

function make(x, y, tag) {
  return GameContext.k.add([
    GameContext.k.pos(x, y),
    GameContext.k.rect(Constants.tileSize, Constants.tileSize),
    GameContext.k.color(tag === "SnakeHead" ? Constants.red500 : Constants.red600),
    GameContext.k.area(),
    tag
  ]);
}

export {
  make,
}
/*  Not a pure module */
