package designpattern.abstractfactory;

/**
 * 
 * @author DF
 *
 */
public abstract class AbstractFactory {
    /**
     * 获取颜色
     * 
     * @param color
     * @return
     */
    abstract Color getColor(String color);

    /**
     * 获取形状
     * 
     * @param shape
     * @return
     */
    abstract Shape getShape(String shape);
}
