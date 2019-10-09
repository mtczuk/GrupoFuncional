import Data.List
import Control.Concurrent (threadDelay)
import Foreign.Marshal.Utils (toBool)
import Data.Char (digitToInt)

data Orientation = Left' | Up' | Right' | Down'
  deriving (Eq, Enum, Show)

data Ant n = Ant (n, n) Orientation [[n]] deriving (Show)

testAnt = Ant (25, 25) Right' (replicate 30 $ replicate 30 0)

indReplace :: (Integral n) => a -> n -> [a] -> [a]
indReplace x n xs = genericTake n xs ++ [x] ++ genericDrop (n + 1) xs

matrixReplace :: (Integral n) => a -> n -> n -> [[a]] -> [[a]]
matrixReplace x i j xs = indReplace newLine i xs
  where newLine = indReplace x j (xs !! fromIntegral i)

turnRight :: Orientation -> Orientation
turnRight a = if a == Down' then Left' else succ a

turnLeft :: Orientation -> Orientation
turnLeft a = if a == Left' then Down' else pred a

move :: (Integral n) => n -> n -> (n, n) -> Orientation -> (n, n)
move maxY maxX (y, x) d
  |d == Left'  = (y, (x - 1) `mod` maxX)
  |d == Up'    = ((y - 1) `mod` maxY, x)
  |d == Right' = (y, (x + 1) `mod` maxX)
  |d == Down'  = ((y + 1) `mod` maxY, x)

nextState :: (Integral n) => [Bool] -> Ant n -> Ant n
nextState law (Ant (y, x) d m) = Ant (move maxY maxX (y, x) nd) nd nm
  where nd =
          if law !! fromIntegral (m !! fromIntegral y !! fromIntegral x)
          then turnRight d
          else turnLeft d
        nc = (m !! fromIntegral y !! fromIntegral x + 1) `mod` (genericLength law)
        nm = matrixReplace nc y x m
        maxY = genericLength m
        maxX = genericLength (m !! 0)

antToString :: (Show a, Integral a) => Ant a -> String
antToString (Ant _ _ m) = unlines $ map (foldl (++) []) $ map (map myShow) m
  where 
    myShow 0 = " " 
    myShow x = show x

antLoop law ant = do
  putStr $ antToString ant
  let newAnt = nextState law ant
  threadDelay 20000
  putStrLn "-----------------------"
  antLoop law newAnt

main = do
  putStr "Number of rows: "
  strRows <- getLine
  putStr "Number of columns: "
  strCols <- getLine
  putStr "Law: "
  strLaw <- getLine
  let rows = read strRows :: Int
      cols = read strCols :: Int
      law  = map (toBool . digitToInt) strLaw
      ant  = Ant (rows `div` 2, cols `div` 2) Right' (replicate rows $ replicate cols 0)
  antLoop law ant
