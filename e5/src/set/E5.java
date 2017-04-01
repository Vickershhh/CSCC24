package set;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.stream.Collectors;

public class E5 {

  /**
   * Demos use of required classes of E5.
   * @param args ignored
   */
  public static void main(String[] args) {
    
    final PSet<MyInt> emptyset = new PSet<>(new ArrayList<MyInt>());

    final PSet<MyInt> singleton = new PSet<>(
        Arrays.stream(new Integer[]{42}).map(MyInt::new).collect(Collectors.toList()));

    final PSet<MyInt> three = new PSet<>(
        Arrays.stream(new Integer[]{1,2,3}).map(MyInt::new).collect(Collectors.toList()));
    

    final PSet<MyInt> four = new PSet<>(
        Arrays.stream(new Integer[]{1,2,3,4}).map(MyInt::new).collect(Collectors.toList()));

    System.out.println("{} < {42}? " + emptyset.lt(singleton));
    System.out.println("{42} <= {1,2,3}? " + singleton.lte(three));
    System.out.println("{1,2,3,4} >= {1,2,3}? " + four.gte(three));
    System.out.println("{1,2,3} ? {1,2,3,4}? " + three.pcompare(four));
    System.out.println("{1,2,3} ? {42}? " + three.pcompare(singleton));

    /* OUTPUT:
{} < {42}? true
{42} <= {1,2,3}? false
{1,2,3,4} >= {1,2,3}? true
{1,2,3} ? {1,2,3,4}? PLT
{1,2,3} ? {42}? PIN
     */
  }


  static class MyInt implements Eq<MyInt>, Show {
    private Integer myInt;

    public MyInt(Integer myInt) {
      this.myInt = myInt;
    }

    public Integer getInt() {
      return myInt;
    }

    @Override
    public boolean eq(MyInt other) {
      return myInt.equals(other.getInt());
    }

    @Override
    public String show() {
      return String.valueOf(myInt);
    }
  }
}