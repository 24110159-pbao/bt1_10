package com.webst5.controller;

import com.webst5.entity.User_24110159;
import com.webst5.service.OrderService_24110159;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/orders")
public class OrderHistoryController_24110159 extends HttpServlet {
    private final OrderService_24110159 orderService = new OrderService_24110159();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Object value = req.getSession(false) == null
                ? null : req.getSession(false).getAttribute("user");
        if (!(value instanceof User_24110159 user)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.setAttribute("orders", orderService.findAllForUser(user.getUserId()));
        req.getRequestDispatcher("/WEB-INF/views/orders.jsp").forward(req, resp);
    }
}