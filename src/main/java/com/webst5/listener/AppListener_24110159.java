package com.webst5.listener;

import com.webst5.util.SeedData_24110159;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class AppListener_24110159 implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            SeedData_24110159.initialize();
        } catch (Exception e) {
            System.out.println("Seed data: " + e.getMessage());
        }
    }
}
