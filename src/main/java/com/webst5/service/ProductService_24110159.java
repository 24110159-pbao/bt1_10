package com.webst5.service;

import com.webst5.dao.ProductDAO_24110159;
import com.webst5.dao.ProductDAO_24110159;
import com.webst5.entity.Product_24110159;
import java.util.List;

public class ProductService_24110159 {
    private final ProductDAO_24110159 dao = new ProductDAO_24110159();
    public List<Product_24110159> findPage(int page, int size) { return dao.findPage(page, size); }
    public List<Product_24110159> findBySeller(Integer sellerId) { return dao.findBySeller(sellerId); }
    public long count() { return dao.count(); }
    public Product_24110159 findById(Integer id) { return dao.findById(id); }
    public void save(Product_24110159 p) { dao.save(p); }
    public void update(Product_24110159 p) { dao.update(p); }
    public void delete(Integer id) { dao.delete(id); }
}
