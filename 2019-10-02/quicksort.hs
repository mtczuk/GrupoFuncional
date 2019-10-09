




quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = (quicksort smaller) ++ [x] ++ (quicksort bigger)
  where smaller = [a | a <- xs, a <  x]
        bigger =  [a | a <- xs, a >= x]

twos = 2:twos

test = 1:(map (*2) test)

