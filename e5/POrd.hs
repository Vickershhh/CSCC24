module POrd where
import Set
class POrd a where
  lt, lte, gt, gte, inc  :: a -> a -> Bool
  pcompare :: a -> a -> POrdering