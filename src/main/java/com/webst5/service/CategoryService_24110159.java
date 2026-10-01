package com.webst5.service;

import com.webst5.dao.CategoryDAO_24110159;
import com.webst5.dao.CategoryDAO_24110159;
import com.webst5.entity.Category_24110159;
import java.util.List;

public class CategoryService_24110159 {
    private final CategoryDAO_24110159 dao = new CategoryDAO_24110159();
    public List<Category_24110159> findPage(int page, int size) { return dao.findPage(page, size); }
    public long count() { return dao.count(); }
    public Category_24110159 findById(Integer id) { return dao.findById(id); }
    public void save(Category_24110159 c) { dao.save(c); }
    public void update(Category_24110159 c) { dao.update(c); }
    public void delete(Integer id) { dao.delete(id); }
}
