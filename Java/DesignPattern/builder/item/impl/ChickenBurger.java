package designpattern.builder.item.impl;

import designpattern.builder.item.AbstractBurger;

/**
 * @author DF
 */
public class ChickenBurger extends AbstractBurger {
    @Override
    public String name() {
        return "Chicken Burger";
    }

    @Override
    public float price() {
        return 50.5f;
    }
}
