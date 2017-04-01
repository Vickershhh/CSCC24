from abc import ABCMeta, abstractmethod
from enum import Enum, unique


@unique
class POrdering(Enum):
    PLT = 1
    PGT = 2
    PEQ = 3
    PIN = 4


class POrd(metaclass=ABCMeta):
    @abstractmethod
    def pcompare(self, other):
        pass

    def __lt__(self, other):
        return self.pcompare(other) == POrdering.PLT

    def __gt__(self, other):
        return self.pcompare(other) == POrdering.PGT

    def __eq__(self, other):
        return self.pcompare(other) == POrdering.PEQ

    def __le__(self, other):
        return (self.pcompare(other) == POrdering.PLT) or (
            self.pcompare(other) == POrdering.PEQ)

    def __ge__(self, other):
        return (self.pcompare(other) == POrdering.PGT) or (
            self.pcompare(other) == POrdering.PEQ)


class Infix:
    def __init__(self, function):
        self.function = function

    def __ror__(self, other):
        return Infix(lambda x, self=self, other=other: self.function(other, x))

    def __or__(self, other):
        return self.function(other)

    def __call__(self, value1, value2):
        return self.function(value1, value2)


class PSet(POrd):

    def __init__(self, elements=[]):
        self.elements = elements

    def __str__(self):
        #return "{"+self.elements.__str__()[1:-1]+"}"
        return str(set(self.elements))

    def pcompare(self, other):
        track = [[0, 0], [0, 0]]
        for x in self.elements:
            if self.elements.count(x) < other.elements.count(x):
                track[0][0] += 1
            elif self.elements.count(x) > other.elements.count(x):
                track[0][1] += 1
        for x in other.elements:
            if self.elements.count(x) < other.elements.count(x):
                track[1][0] += 1
            elif self.elements.count(x) > other.elements.count(x):
                track[1][1] += 1

        if track == [[0, 0], [0, 0]]:
            return POrdering.PEQ
        if track[0][1] == 0 and track[1][1] == 0:
            return POrdering.PLT
        if track[0][0] == 0 and track[1][0] == 0:
            return POrdering.PGT
        return POrdering.PIN

pin = Infix(lambda x, y: x.pcompare(y) == POrdering.PIN)


if __name__ == '__main__':

    emptyset = PSet()
    singleton = PSet([42])
    s = PSet([1, 2, 3])
    sr = PSet([3, 1, 2])
    t = PSet([3, 2, 1, 4])

    print(emptyset)
    print(singleton)
    print(s)
    print(sr)
    print(t)

    print(s == sr)
    print(s == t)
    print(s < t)
    print(singleton >= emptyset)
    print(singleton < t)
    print(singleton | pin | t)
    print(s < sr)
    print(s <= sr)
    print(s.pcompare(sr))
    print(s.pcompare(singleton))

    ''' OUTPUT:
{}
{42}
{1, 2, 3}
{3, 1, 2}
{3, 2, 1, 4}
True
False
True
True
False
True
False
True
POrdering.PEQ
POrdering.PIN
 '''
