package com.webst5.controller;

import com.webst5.entity.CartItem_24110159;
import com.webst5.entity.User_24110159;
import com.webst5.service.CartService_24110159;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/cart")
public class CartController_24110159 extends HttpServlet {
    private final CartService_24110159 service = new CartService_24110159();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User_24110159 user = requireUser(req, resp);
        if (user == null) return;
        render(req, resp, user.getUserId(), null);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        User_24110159 user = requireUser(req, resp);
        if (user == null) return;

        try {
            String action = req.getParameter("action");
            if ("add".equals(action)) {
                service.add(user.getUserId(), parsePositive(req.getParameter("productId")),
                        parsePositive(req.getParameter("quantity")));
            } else if ("update".equals(action)) {
                service.updateQuantity(user.getUserId(), req.getParameter("itemId"),
                        parsePositive(req.getParameter("quantity")));
            } else if ("remove".equals(action)) {
                service.remove(user.getUserId(), req.getParameter("itemId"));
            } else {
                throw new IllegalArgumentException("Thao tác giỏ hàng không hợp lệ.");
            }
            resp.sendRedirect(req.getContextPath() + "/cart");
        } catch (IllegalArgumentException e) {
            render(req, resp, user.getUserId(), e.getMessage());
        }
    }

    private void render(HttpServletRequest req, HttpServletResponse resp, Integer userId, String error)
            throws ServletException, IOException {
        List<CartItem_24110159> items = service.getItems(userId);
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem_24110159 item : items) {
            if (item.getUnitPrice() != null && item.getQuantity() != null) {
                total = total.add(new BigDecimal(Float.toString(item.getUnitPrice()))
                        .multiply(BigDecimal.valueOf(item.getQuantity())));
            }
        }
        req.setAttribute("cartItems", items);
        req.setAttribute("cartTotal", total);
        req.setAttribute("error", error);
        req.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(req, resp);
    }

    private User_24110159 requireUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Object value = req.getSession(false) == null ? null : req.getSession(false).getAttribute("user");
        if (value instanceof User_24110159 user) return user;
        resp.sendRedirect(req.getContextPath() + "/login");
        return null;
    }

    private int parsePositive(String value) {
        try {
            int parsed = Integer.parseInt(value);
            if (parsed > 0) return parsed;
        } catch (NumberFormatException ignored) {
        }
        throw new IllegalArgumentException("Số lượng hoặc mã sản phẩm không hợp lệ.");
    }
}