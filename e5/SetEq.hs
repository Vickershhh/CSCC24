module SetEq where
import Set
import SetShow



instance Eq a => Eq (Set a) where
	Set [] == Set [] = True
	Set [] == Set a = False
	Set a == Set [] = False
	Set a == Set b = elemEqual a b && elemEqual b a where
		elemEqual [] _ = True
		elemEqual (x:xs) b = elemEqual xs b && elemEqualElem x b where
			elemEqualElem _ [] = False
			elemEqualElem x (b:bs) = x == b || elemEqualElem x bs