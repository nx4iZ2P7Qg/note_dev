package designpattern.builder.item;

import designpattern.builder.packing.Packing;

public interface Item {
    public String name();
    public Packing packing();
    public float price();
}
