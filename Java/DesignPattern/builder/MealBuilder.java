package designpattern.builder;

import designpattern.builder.item.impl.ChickenBurger;
import designpattern.builder.item.impl.Coke;
import designpattern.builder.item.impl.Pepsi;
import designpattern.builder.item.impl.VegBurger;

/**
 * @author DF
 */
public class MealBuilder {
    public Meal prepareVegMeal() {
        Meal meal = new Meal();
        meal.addItem(new VegBurger());
        meal.addItem(new Coke());
        return meal;
    }

    public Meal prepareNonVegMeal() {
        Meal meal = new Meal();
        meal.addItem(new ChickenBurger());
        meal.addItem(new Pepsi());
        return meal;
    }
}
