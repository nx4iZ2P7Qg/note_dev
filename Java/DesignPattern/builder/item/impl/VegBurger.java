package designpattern.builder.item.impl;

import designpattern.builder.item.AbstractBurger;

/**
 * @author DF
 */
public class VegBurger extends AbstractBurger {
    @Override
    public String name() {
        return "Veg Burger";
    }

    @Override
    public float price() {
        return 25.0f;
    }
}
