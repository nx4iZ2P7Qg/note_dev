package annotion;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@interface Todo {
    enum Priority {LOW, MEDIUM, HIGH}

    enum Status {STARTED, NOT_STARTED}

    String author() default "df";

    Priority priority() default Priority.LOW;

    Status status() default Status.NOT_STARTED;
}
