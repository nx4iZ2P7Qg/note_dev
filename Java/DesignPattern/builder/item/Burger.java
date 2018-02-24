package designpattern.builder.item;

import designpattern.builder.packing.Packing;
import designpattern.builder.packing.impl.Wrapper;

public abstract class Burger implements Item {
    @Override
    public Packing packing() {
        return new Wrapper();
    }

    @Override
    public abstract float price();
}
