package designpattern.factoryimproved.factory;

import designpattern.factoryimproved.product.KeyboardProduct;
import designpattern.factoryimproved.product.Product;

public class KeyboardFactory implements Factory {
    @Override
    public Product create() {
        return new KeyboardProduct();
    }
}
