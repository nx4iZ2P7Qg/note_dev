package designpattern.builder.packing.impl;

import designpattern.builder.packing.Packing;

public class Wrapper implements Packing {
    @Override
    public String pack() {
        return "Wrapper";
    }
}
