module SetShow where
import Set
instance Show a => Show (Set a) where
	show (Set [])="{}"
	show (Set (x:xs)) = "{"++foldl (\x y->x++","++y)  (show x) (map show xs)++"}"
