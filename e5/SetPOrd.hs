module SetPOrd where
import POrd
import SetEq
import Set
instance Eq a => POrd (Set a) where
  lte (Set (x:xs)) (Set ys) =  contain x ys && lte (Set xs) (Set (remove x ys))
  lte (Set []) (Set ys) = True

  lt (Set x) (Set y) = lte (Set x) (Set y) && Set x /= Set y

  gte (Set x) (Set y) = lte (Set y) (Set x)

  gt (Set x) (Set y) = gte (Set x) (Set y) && Set x /= Set y

  inc (Set x) (Set y) = Set x /= Set y && not (lt (Set x) (Set y)) && not (gt (Set x) (Set y))

  pcompare (Set x) (Set y)
    | lt (Set x) (Set y) = PLT
    | Set x == Set y = PEQ
    | gt (Set x) (Set y) = PGT
    | otherwise = PIN
