package com.webst5.util;

import com.webst5.entity.*;
import com.webst5.dao.*;

public class SeedData_24110159 {

    public static void initialize() {
        UserDAO_24110159 userDAO = new UserDAO_24110159();

        if (userDAO.findByUsername("admin") != null) return;

        var roles = new UserRole_24110159();
        roles.setRoleName("ADMIN");

        var userRole = new UserRole_24110159();
        userRole.setRoleName("USER");

        var seller = new Seller_24110159();
        seller.setSellername("Seller Demo");
        seller.setStatus(1);

        var category = new Category_24110159();
        category.setCategoryName("Danh mục mẫu");
        category.setStatus(1);

        jakarta.persistence.EntityManager em = JPAUtil_24110159.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(roles);
            em.persist(userRole);
            em.persist(seller);
            em.persist(category);
            em.getTransaction().commit();
        } catch (RuntimeException e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }

        User_24110159 admin = new User_24110159();
        admin.setUsername("admin");
        admin.setEmail("admin@gmail.com");
        admin.setFullname("Administrator");
        admin.setPassword("123456");
        admin.setStatus(1);
        admin.setRole(roles);
        userDAO.save(admin);

        User_24110159 user = new User_24110159();
        user.setUsername("user");
        user.setEmail("user@gmail.com");
        user.setFullname("User Demo");
        user.setPassword("123456");
        user.setStatus(1);
        user.setRole(userRole);
        user.setSeller(seller);
        userDAO.save(user);
    }
}
