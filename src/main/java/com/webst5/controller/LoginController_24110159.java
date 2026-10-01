package com.webst5.controller;

import com.webst5.entity.User_24110159;
import com.webst5.service.UserService_24110159;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/login")
public class LoginController_24110159 extends HttpServlet {
    private final UserService_24110159 service = new UserService_24110159();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String rawUsername = req.getParameter("username");
        String password = req.getParameter("password");

        String username = rawUsername != null ? rawUsername.trim() : "";
        req.setAttribute("param_username", username);

        if (username.isEmpty() || password == null || password.isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu.");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
            return;
        }

        User_24110159 user = service.login(username, password);

        if (user == null) {
            req.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu.");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
            return;
        }

        req.getSession().setAttribute("user", user);
        if (user.getRole() != null && "ADMIN".equalsIgnoreCase(user.getRole().getRoleName())) {
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        } else {
            resp.sendRedirect(req.getContextPath() + "/products");
        }
    }
}
