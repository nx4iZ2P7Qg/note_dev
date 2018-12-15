package designpattern.abstractfactory;

/**
 * 
 * @author DF
 *
 */
public class FactoryProducer {
    public static AbstractFactory getFactory(String choice) {
        String shape = "SHAPE";
        String color = "COLOR";
        if (choice.equalsIgnoreCase(shape)) {
            return new ShapeFactory();
        }
        if (choice.equalsIgnoreCase(color)) {
            return new ColorFactory();
        }
        return null;
    }
}
