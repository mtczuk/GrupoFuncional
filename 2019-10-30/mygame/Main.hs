module Main where

import Graphics.Gloss
import Graphics.Gloss.Interface.IO.Game

data GameEl = GameEl { getX      :: Float
                     , getY      :: Float
                     , getVX     :: Float
                     , getVY     :: Float
                     , isVisible :: Bool }

type Ship   = GameEl
type Bullet = GameEl
type World  = (Ship, Bullet)

push :: Float -> Float -> GameEl -> GameEl
push px py (GameEl x y vx vy visible) = GameEl x y (vx + px) (vy + py) visible

applyVel :: GameEl -> GameEl
applyVel (GameEl x y vx vy visible) = GameEl (x + vx) (y + vy) vx vy visible

pushShip :: Float -> Float -> World -> World
pushShip px py (ship, bullet) = (push px py ship, bullet)

initialState = (GameEl 0 0 0 0 True, GameEl 0 0 0 0 False)

windowDisplay :: Display
windowDisplay = InWindow "Window" (200, 200) (10, 10)

drawingFunc :: World -> Picture
drawingFunc (ship, bullet) = translate (getX ship) (getY ship) $ Circle 80

inputHandler :: Event -> World -> World
inputHandler (EventKey (SpecialKey KeyUp)    Down _ _) w = pushShip   0     10  w
inputHandler (EventKey (SpecialKey KeyDown)  Down _ _) w = pushShip   0   (-10) w
inputHandler (EventKey (SpecialKey KeyRight) Down _ _) w = pushShip   10    0   w
inputHandler (EventKey (SpecialKey KeyLeft)  Down _ _) w = pushShip (-10)   0   w
inputHandler _ w = w

updateFunc :: Float -> World -> World
updateFunc _ (ship, bullet) = (applyVel ship, bullet)

main :: IO ()
main = play
  FullScreen
  white
  20
  initialState
  drawingFunc
  inputHandler
  updateFunc
  
