package designpattern.builder.item.impl;

import designpattern.builder.item.AbstractColdDrink;

/**
 * @author DF
 */
public class Pepsi extends AbstractColdDrink {
    @Override
    public String name() {
        return "Pepsi";
    }

    @Override
    public float price() {
        return 35.0f;
    }
}
