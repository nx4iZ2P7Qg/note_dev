import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;

/**
 * 反射demo
 * @author DF
 */
public class ConstructorMethodField {
    /**
     * key_Constructor_Method_Field
     * @param args
     */
    public static void main(String[] args) {
        try {
            Class clazz = Class.forName("java.lang.String");
            Class superClass = clazz.getSuperclass();
            clazz.getModifiers();
            Constructor[] constructors = clazz.getDeclaredConstructors();
            constructors[0].getName();
            constructors[0].getModifiers();
            Class[] paramTypes1 = constructors[0].getParameterTypes();
            paramTypes1[0].getName();

            Method[] methods = clazz.getDeclaredMethods();
            methods[0].getName();
            methods[0].getReturnType();
            methods[0].getModifiers();
            Class[] paramTypes2 = methods[0].getParameterTypes();
            paramTypes2[0].getName();

            Field[] fields = clazz.getDeclaredFields();
            Class type = fields[0].getType();
            fields[0].getName();
            fields[0].getModifiers();
            type.getName();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
