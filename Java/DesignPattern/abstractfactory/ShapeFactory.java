package designpattern.abstractfactory;

/**
 * 
 * @author DF
 *
 */
public class ShapeFactory extends AbstractFactory {
    @Override
    public Shape getShape(String shapeType){
        String circle = "CIRCLE";
        String rectangle = "RECTANGLE";
        String square = "SQUARE";

        if(shapeType == null){
            return null;
        }

        if(shapeType.equalsIgnoreCase(circle)){
            return new Circle();

        }else if(shapeType.equalsIgnoreCase(rectangle)){
            return new Rectangle();

        }else if(shapeType.equalsIgnoreCase(square)){
            return new Square();
        }

        return null;
    }

    @Override
    Color getColor(String color) {
        return null;
    }
}
