package designpattern.builder.item;

import designpattern.builder.packing.impl.Bottle;
import designpattern.builder.packing.Packing;

/**
 * @author DF
 */
public abstract class AbstractColdDrink implements Item {
    @Override
    public Packing packing() {
        return new Bottle();
    }

    /**
     * 价钱
     * 
     * @return
     */
    @Override
    public abstract float price();
}
