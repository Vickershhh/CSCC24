module SetShow where
import Set
import Data.List

instance (Show a ) => Show (Set a) where
	show (Set []) = "{}"
	show (Set a) = "{" ++ concat (intersperse "," (map show a)) ++ "}"