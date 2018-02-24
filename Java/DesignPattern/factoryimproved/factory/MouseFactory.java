package designpattern.factoryimproved.factory;

import designpattern.factoryimproved.product.MouseProduct;
import designpattern.factoryimproved.product.Product;

public class MouseFactory implements Factory {
    @Override
    public Product create() {
        return new MouseProduct();
    }
}
