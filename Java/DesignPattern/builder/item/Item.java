package designpattern.builder.item;

import designpattern.builder.packing.Packing;

/**
 * @author DF
 */
public interface Item {
    /**
     * 名字
     * 
     * @return
     */
    public String name();

    /**
     * 包装
     * 
     * @return
     */
    public Packing packing();

    /**
     * 价钱
     * 
     * @return
     */
    public float price();
}
