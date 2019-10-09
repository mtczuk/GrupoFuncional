import Data.Array

data Heap a = Heap { compare   :: (a -> a -> Bool)
                   , size      :: Int
                   , heapArray :: (Array Int a) }

instance (Show a) => Show (Heap a) where
  show (Heap _ size arr) = show' 1 0
    where 
      show' i ind
        | i > size  = ""
        | otherwise = 
          (show' (left i) (ind + 4)) ++
          (replicate ind ' ') ++ 
          (show $ arr ! i) ++ "\n" ++
          (show' (right i) (ind + 4))
      
left :: Int -> Int
left n = n * 2

right :: Int -> Int
right n = n * 2 + 1

parent :: Int -> Int
parent n = n `div` 2

heap :: (a -> a -> Bool) -> a -> Int -> (Heap a)
heap comp defaultVal maxSize = Heap comp 0 arr
  where
    arr = array (1, maxSize) [(i, defaultVal) | i <- [1..maxSize]]

insert :: Heap a -> a -> Maybe (Heap a)
insert (Heap comp size arr) x 
  | size == length arr = Nothing
  | otherwise          = Just $ up (size + 1) h
  where
    h      = Heap comp (size + 1) newArr
    newArr = arr // [(size + 1, x)]

pop :: Show a => Heap a -> (Maybe a, Heap a)
pop h@(Heap comp size arr)
  | size == 0 = (Nothing, h)
  | otherwise = (Just root, newHeap)
  where
    root    = arr ! 1
    newHeap = down 1 $ Heap comp (size - 1) newArr
    newArr  = arr // [(1, arr ! size)]

down :: Show a => Int -> (Heap a) -> (Heap a)
down i h@(Heap comp size arr)
  | i > size        = h
  | shouldMoveLeft  = down li $ Heap comp size arrLeft
  | shouldMoveRight = down ri $ Heap comp size arrRight
  | otherwise       = h
  where
    shouldMoveLeft  = comp l this && (comp l r || ri > size) && li <= size
    shouldMoveRight = comp r this && not (comp l r) && ri <= size
    arrLeft  = arr // [(i, l), (li, this)]
    arrRight = arr // [(i, r), (ri, this)]
    li   = left i
    ri   = right i
    l    = arr ! li
    r    = arr ! ri
    this = arr ! i

up :: Int -> (Heap a) -> (Heap a)
up i h@(Heap comp size arr)
  | notRoot && shouldMoveUp = up pi $ Heap comp size arrMoveUp
  | otherwise               = h
  where
    pi           = parent i
    notRoot      = i > 1
    shouldMoveUp = comp this p
    this         = arr ! i
    p            = arr ! pi
    arrMoveUp    = arr // [(i, p), (pi, this)]

heapLoop :: (Heap Int) -> IO ()
heapLoop h = do
  a <- getLine
  putStrLn "--------------------------"
  if a !! 0 == '+' then do
    v <- getLine
    let maybeh = insert h (read v)
    let newh = case maybeh of Just a  -> a
                              Nothing -> h
    print newh
    heapLoop newh
  else do
    let (_, newh) = pop h
    print newh
    heapLoop newh
  putStrLn "--------------------------"

main = do
  heapLoop $ heap (>) 0 100
