package designpattern.builder.item;

import designpattern.builder.packing.Packing;
import designpattern.builder.packing.impl.Wrapper;

/**
 * @author DF
 */
public abstract class AbstractBurger implements Item {
    @Override
    public Packing packing() {
        return new Wrapper();
    }

    /**
     * 价钱
     * 
     * @return
     */
    @Override
    public abstract float price();
}
