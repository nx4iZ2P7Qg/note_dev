package designpattern.abstractfactory;

/**
 * 
 * @author DF
 *
 */
public class ColorFactory extends AbstractFactory {
    @Override
    public Shape getShape(String shapeType){
        return null;
    }

    @Override
    Color getColor(String color) {
        String red = "RED";
        String green = "GREEN";
        String blue = "BLUE";

        if(color == null){
            return null;
        }

        if(color.equalsIgnoreCase(red)){
            return new Red();

        }else if(color.equalsIgnoreCase(green)){
            return new Green();

        }else if(color.equalsIgnoreCase(blue)){
            return new Blue();
        }

        return null;
    }
}
