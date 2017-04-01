module Set where

data Set a = Set [a]

data POrdering = PLT | PEQ | PGT | PIN deriving (Eq, Show)

emptyset = Set []
singleton = Set [42]
s = Set [1, 2, 3]
t = Set [1, 4, 2, 3]
s' = Set [3, 1, 2]
ss = Set ["a", "b", "foo"]
ss' = Set ["a", "foo", "b"]
