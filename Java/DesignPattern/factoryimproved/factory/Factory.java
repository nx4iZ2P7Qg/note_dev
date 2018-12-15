package designpattern.factoryimproved.factory;

import designpattern.factoryimproved.product.Product;

/**
 * @author DF
 */
public interface Factory {
    /**
     * 创建
     * 
     * @return
     */
    public Product create();
}
