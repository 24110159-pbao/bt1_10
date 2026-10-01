package com.webst5.dao;

import com.webst5.entity.User_24110159;
import com.webst5.util.JPAUtil_24110159;
import jakarta.persistence.EntityManager;
import java.util.List;

public class UserDAO_24110159 {
    public User_24110159 findByUsername(String username) {
        EntityManager em = JPAUtil_24110159.getEntityManager();
        try {
            List<User_24110159> list = em.createQuery(
                "select u from User_24110159 u where u.username = :username",
                User_24110159.class).setParameter("username", username).getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally { em.close(); }
    }

    public User_24110159 findByEmail(String email) {
        EntityManager em = JPAUtil_24110159.getEntityManager();
        try {
            List<User_24110159> list = em.createQuery(
                "select u from User_24110159 u where u.email = :email",
                User_24110159.class).setParameter("email", email).getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally { em.close(); }
    }

    public User_24110159 findById(Integer id) {
        EntityManager em = JPAUtil_24110159.getEntityManager();
        try { return em.find(User_24110159.class, id); }
        finally { em.close(); }
    }

    public List<User_24110159> findAll() {
        EntityManager em = JPAUtil_24110159.getEntityManager();
        try { return em.createQuery("from User_24110159", User_24110159.class).getResultList(); }
        finally { em.close(); }
    }

    public User_24110159 save(User_24110159 user) {
        EntityManager em = JPAUtil_24110159.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(user);
            em.getTransaction().commit();
            return user;
        } catch (RuntimeException e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally { em.close(); }
    }

    public User_24110159 update(User_24110159 user) {
        EntityManager em = JPAUtil_24110159.getEntityManager();
        try {
            em.getTransaction().begin();
            User_24110159 result = em.merge(user);
            em.getTransaction().commit();
            return result;
        } catch (RuntimeException e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally { em.close(); }
    }
}
