module POrd where

import Set

class POrd a where
    lt, gt, lte, gte, inc :: a -> a -> Bool
    pcompare :: a -> a -> POrdering

    gt x y = pcompare x y== PGT
    lt x y = pcompare x y == PLT
    lte x y = (pcompare x y == PLT) || (pcompare x y == PEQ)
    gte x y = (pcompare x y == PGT) || (pcompare x y == PEQ)
    inc x y = pcompare x y == PIN
