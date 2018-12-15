package designpattern.factory;

/**
 * @author DF
 */
public class ShapeFactory {
    /**
     * 得到Shape对象
     */
    public Shape getShape(String shapeType) {
        String circle = "CIRCLE";
        String rectangle = "RECTANGLE";
        String square = "SQUARE";
        if (shapeType == null) {
            return null;
        }
        if (shapeType.equalsIgnoreCase(circle)) {
            return new Circle();
        } else if (shapeType.equalsIgnoreCase(rectangle)) {
            return new Rectangle();
        } else if (shapeType.equalsIgnoreCase(square)) {
            return new Square();
        }
        return null;
    }
}
