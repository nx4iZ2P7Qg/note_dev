package annotion;

import java.lang.reflect.Method;

/**
 * https://blog.csdn.net/u014563989/article/details/60570794
 *
 * @ override的源码中没有做任何事情
 * 和其他annotation一样(Annotations in the java.lang package)都被javac处理了
 * 自定义的annotation如果要实现某逻辑，需要自己写annotation processor
 * <p>
 * J2SE5.0在java.lang.annotation中提供了四种元注解
 * @ Documented 是否包含在JavaDoc中
 * @ Retention 生命周期
 * RetentionPolicy.SOURCE  编译阶段结束后丢弃
 * RetentionPolicy.CLASS   类加载后丢弃
 * RetentionPolicy.RUNTIME 保留到运行时
 * @ Target
 * ElementType.TYPE            描述类、接口或enum声明
 * ElementType.FIELD           描述实例变量
 * ElementType.METHOD
 * ElementType.PARAMETER
 * ElementType.CONSTRUCTOR
 * ElementType.LOCAL_VARIABLE
 * ElementType.ANNOTATION_TYPE 另一个注释
 * ElementType.PACKAGE         记录java文件的package信息
 * @ Inherited 是否允许继承
 * <p>
 * servlet3.0中也有很多注解
 */

public class AnnotationDemo {

    @Todo(author = "abc", priority = Todo.Priority.HIGH, status = Todo.Status.NOT_STARTED)
    public void incompleteMethod01() {

    }

    // ide的todo示例
    // todo
    public void incompleteMethod02() {

    }

    public static void main(String[] args) {
        // 反射获取类的注解
        Class annotationDemoClass = AnnotationDemo.class;
        for (Method method : annotationDemoClass.getMethods()) {
            Todo todo = (Todo) method.getAnnotation(Todo.class);
            if (todo != null) {
                System.out.println("\n");
                System.out.println("Method name = " + method.getName());
                System.out.println("Author = " + todo.author());
                System.out.println("Priority = " + todo.author());
                System.out.println("Status = " + todo.status());
                System.out.println("\n");
            } else {
                System.out.println("todo == null, method = " + method.getName());
            }
        }
    }
}
