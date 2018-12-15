package designpattern.abstractfactory;

/**
 * 
 * @author DF
 *
 */
public class Blue implements Color {
    @Override
    public void fill() {
        System.out.println("Inside Blue::fill() method.");
    }
}
