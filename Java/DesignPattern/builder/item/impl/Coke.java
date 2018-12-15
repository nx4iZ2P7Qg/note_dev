package designpattern.builder.item.impl;

import designpattern.builder.item.AbstractColdDrink;

/**
 * @author DF
 */
public class Coke extends AbstractColdDrink {
    @Override
    public String name() {
        return "Coke";
    }

    @Override
    public float price() {
        return 30.0f;
    }
}
