package designpattern.builder.packing.impl;

import designpattern.builder.packing.Packing;

public class Bottle implements Packing {
    @Override
    public String pack() {
        return "Bottle";
    }
}
