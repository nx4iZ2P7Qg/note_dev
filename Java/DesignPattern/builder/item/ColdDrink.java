package designpattern.builder.item;

import designpattern.builder.packing.impl.Bottle;
import designpattern.builder.packing.Packing;

public abstract class ColdDrink implements Item {
    @Override
    public Packing packing() {
        return new Bottle();
    }

    @Override
    public abstract float price();
}
