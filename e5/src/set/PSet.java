package set;

import java.util.Collection;

public class PSet<E extends Show & Eq<E>> extends POrd<PSet<E>> {
  private Collection<E> elements;
  
  public PSet(Collection<E> elts) {
    this.elements = elts;
  }
  
  @Override
  public boolean eq(PSet<E> other) {
    return (this.elements.stream().filter(x -> this.elements.stream().filter(y -> y.eq(x)).count()
        != other.elements.stream().filter(y -> y.eq(x)).count()).count() == 0) 
        && (other.elements.stream().filter(x -> this.elements.stream().filter(y -> y .eq(x)).count()
            != other.elements.stream().filter(y -> y.eq(x)).count()).count() == 0);
  }
  
  @Override
  public POrdering pcompare(PSet<E> other) {
    if (this.eq(other)) {
      return POrdering.PEQ;
    } else if (this.elements.stream().filter(
        x -> this.elements.stream().filter(
            y -> y .eq(x)).count() 
        > other.elements.stream().filter(
            y -> y.eq(x)).count()).count() == 0) {
      return POrdering.PLT;
    } else if (other.elements.stream().filter(
        x -> this.elements.stream().filter(
            y -> y.eq(x)).count() 
        < other.elements.stream().filter(
            y -> y.eq(x)).count()).count() == 0) {
      return POrdering.PGT;
    } else {
      return POrdering.PIN;
    }
  }


}
