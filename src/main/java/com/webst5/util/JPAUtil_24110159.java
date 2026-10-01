package com.webst5.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAUtil_24110159 {
    private static final EntityManagerFactory FACTORY =
            Persistence.createEntityManagerFactory("webst5PU");

    public static EntityManager getEntityManager() {
        return FACTORY.createEntityManager();
    }

    public static void close() {
        if (FACTORY.isOpen()) FACTORY.close();
    }
}
