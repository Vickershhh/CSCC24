module POrd where

import Set

class POrd a where 
	pcompare :: a -> a -> Bool

	lt :: a -> a -> Bool
    lt x y = pcompare x y == PLT

    gt :: a -> a -> Bool
    gt x y = pcompare x y== PGT

    lte :: a -> a -> Bool
    lte x y = (pcompare x y == PLT) | (pcompare x y == PEQ)

    gte :: a -> a -> Bool
    gte x y = (pcompare x y == PGT) | (pcompare x y == PEQ)

    inc :: a -> a -> Bool
    inc x y = pcompare x y == PIN
