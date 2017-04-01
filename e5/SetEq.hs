module SetEq where
import Set

remove :: Eq a => a -> [a] -> [a]
remove x (y:ys) = if x == y then ys else y:remove x ys

contain :: Eq a => a -> [a] -> Bool
contain x = foldr (\ y -> (||) (x == y)) False

instance Eq a => Eq (Set a) where
  (Set []) == (Set []) = True
  (Set (x:xs)) == (Set ys) = contain x ys && (Set xs == Set (remove x ys))
  Set a == Set b = False