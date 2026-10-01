package com.webst5.dao;

import com.webst5.entity.Product_24110159;
import com.webst5.util.JPAUtil_24110159;
import jakarta.persistence.EntityManager;
import java.util.List;

public class ProductDAO_24110159 {
    public List<Product_24110159> findPage(int page, int size) {
        EntityManager em = JPAUtil_24110159.getEntityManager();
        try {
            return em.createQuery("from Product_24110159 order by productId desc", Product_24110159.class)
                    .setFirstResult(page * size).setMaxResults(size).getResultList();
        } finally { em.close(); }
    }
    public List<Product_24110159> findBySeller(Integer sellerId) {
        EntityManager em = JPAUtil_24110159.getEntityManager();
        try {
            return em.createQuery(
                "from Product_24110159 p where p.seller.sellerId = :sellerId order by p.productId desc",
                Product_24110159.class).setParameter("sellerId", sellerId).getResultList();
        } finally { em.close(); }
    }
    public long count() {
        EntityManager em = JPAUtil_24110159.getEntityManager();
        try { return em.createQuery("select count(p) from Product_24110159 p", Long.class).getSingleResult(); }
        finally { em.close(); }
    }
    public Product_24110159 findById(Integer id) {
        EntityManager em = JPAUtil_24110159.getEntityManager();
        try { return em.find(Product_24110159.class, id); } finally { em.close(); }
    }
    public void save(Product_24110159 p) {
        EntityManager em = JPAUtil_24110159.getEntityManager();
        try { em.getTransaction().begin(); em.persist(p); em.getTransaction().commit(); }
        catch (RuntimeException e) { if (em.getTransaction().isActive()) em.getTransaction().rollback(); throw e; }
        finally { em.close(); }
    }
    public void update(Product_24110159 p) {
        EntityManager em = JPAUtil_24110159.getEntityManager();
        try { em.getTransaction().begin(); em.merge(p); em.getTransaction().commit(); }
        catch (RuntimeException e) { if (em.getTransaction().isActive()) em.getTransaction().rollback(); throw e; }
        finally { em.close(); }
    }
    public void delete(Integer id) {
        EntityManager em = JPAUtil_24110159.getEntityManager();
        try {
            em.getTransaction().begin();
            Product_24110159 p = em.find(Product_24110159.class, id);
            if (p != null) em.remove(p);
            em.getTransaction().commit();
        } catch (RuntimeException e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally { em.close(); }
    }
}
