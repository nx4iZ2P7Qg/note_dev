package designpattern.factoryimproved;

import designpattern.factoryimproved.factory.KeyboardFactory;
import designpattern.factoryimproved.factory.MouseFactory;
import designpattern.factoryimproved.factory.ScreenFactory;
import designpattern.factoryimproved.product.Product;

/**
 * @author DF
 */
public class FactoryImprovedDemo {
    public static void main(String[] args) {
        Product keyboardProduct = new KeyboardFactory().create();
        Product mouseproduct = new MouseFactory().create();
        Product screen = new ScreenFactory().create();
    }
}
