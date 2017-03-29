module SetPOrd where
import Set
import POrd
import SetEq


instance (Eq a) => POrd (Set a) where
	pcompare (Set x) (Set y)
		| x == y = PEQ
		| all (`elem` t) s = PLT
		| all (`elem` s) t = PGT
		| otherwise = PIN