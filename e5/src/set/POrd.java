package set;

public abstract class POrd<T> implements Eq<T> {
  public abstract POrdering pcompare(T other);
  
  public boolean lt(T other) {
    return this.pcompare(other) == POrdering.PLT;
  }
  
  public boolean gt(T other) {
    return this.pcompare(other) == POrdering.PGT;
  }
  
  public boolean lte(T other) {
    return (this.pcompare(other) == POrdering.PLT) || (this.pcompare(other) == POrdering.PEQ);
  }
  
  public boolean gte(T other) {
    return (this.pcompare(other) == POrdering.PGT) || (this.pcompare(other) == POrdering.PEQ);
  }
  
  public boolean inc(T other) {
    return this.pcompare(other) == POrdering.PIN;
  }
}
