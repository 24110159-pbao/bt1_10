package com.webst5.dao;

import com.webst5.entity.Category_24110159;
import com.webst5.util.JPAUtil_24110159;
import jakarta.persistence.EntityManager;
import java.util.List;

public class CategoryDAO_24110159 {
    public List<Category_24110159> findPage(int page, int size) {
        EntityManager em = JPAUtil_24110159.getEntityManager();
        try {
            return em.createQuery("from Category_24110159 order by categoryId desc", Category_24110159.class)
                    .setFirstResult(page * size).setMaxResults(size).getResultList();
        } finally { em.close(); }
    }
    public long count() {
        EntityManager em = JPAUtil_24110159.getEntityManager();
        try { return em.createQuery("select count(c) from Category_24110159 c", Long.class).getSingleResult(); }
        finally { em.close(); }
    }
    public Category_24110159 findById(Integer id) {
        EntityManager em = JPAUtil_24110159.getEntityManager();
        try { return em.find(Category_24110159.class, id); } finally { em.close(); }
    }
    public void save(Category_24110159 category) {
        EntityManager em = JPAUtil_24110159.getEntityManager();
        try { em.getTransaction().begin(); em.persist(category); em.getTransaction().commit(); }
        catch (RuntimeException e) { if (em.getTransaction().isActive()) em.getTransaction().rollback(); throw e; }
        finally { em.close(); }
    }
    public void update(Category_24110159 category) {
        EntityManager em = JPAUtil_24110159.getEntityManager();
        try { em.getTransaction().begin(); em.merge(category); em.getTransaction().commit(); }
        catch (RuntimeException e) { if (em.getTransaction().isActive()) em.getTransaction().rollback(); throw e; }
        finally { em.close(); }
    }
    public void delete(Integer id) {
        EntityManager em = JPAUtil_24110159.getEntityManager();
        try {
            em.getTransaction().begin();
            Category_24110159 c = em.find(Category_24110159.class, id);
            if (c != null) em.remove(c);
            em.getTransaction().commit();
        } catch (RuntimeException e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally { em.close(); }
    }
}
