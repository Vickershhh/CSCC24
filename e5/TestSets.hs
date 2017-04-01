module TestSets where

import Test.HUnit

import Set
import SetShow
import SetEq
import POrd
import SetPOrd

{- Starter -- Test Set functionality -}

testEq = TestList [testEq1]
testEq1 = TestCase $ assertEqual
          "{1,2,3} == {2,3,1} is " True
          (s == s')

testShow = TestList [testShow2]
testShow2 = TestCase $ assertEqual
            "show {1,2,3} is" "{1,2,3}"
            (show s)

testOrd = TestList [testOrd1]
testOrd1 = TestCase $ assertEqual
           "{1, 2, 3} `lt` {2, 3, 1, 4} is " True
           (s `lt` t)

tests = TestList [testEq,testShow,testOrd
                 ]

main = runTestTT tests
