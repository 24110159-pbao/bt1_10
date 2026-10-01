package com.webst5.controller;

import com.webst5.entity.CartItem_24110159;
import com.webst5.entity.Order_24110159;
import com.webst5.entity.User_24110159;
import com.webst5.service.CartService_24110159;
import com.webst5.service.OrderService_24110159;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutController_24110159 extends HttpServlet {
    private final CartService_24110159 cartService = new CartService_24110159();
    private final OrderService_24110159 orderService = new OrderService_24110159();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User_24110159 user = requireUser(req, resp);
        if (user == null) return;

        String orderId = req.getParameter("orderId");
        if (orderId != null && !orderId.isBlank()) {
            Order_24110159 order = orderService.findForUser(orderId, user.getUserId());
            if (order == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            req.setAttribute("order", order);
            req.getRequestDispatcher("/WEB-INF/views/order-success.jsp").forward(req, resp);
            return;
        }
        renderCheckout(req, resp, user, null);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        User_24110159 user = requireUser(req, resp);
        if (user == null) return;

        try {
            Order_24110159 order = orderService.placeCodOrder(
                    user.getUserId(),
                    req.getParameter("receiverName"),
                    req.getParameter("receiverPhone"),
                    req.getParameter("shippingAddress"));
            resp.sendRedirect(req.getContextPath() + "/checkout?orderId=" + order.getOrderId());
        } catch (IllegalArgumentException e) {
            renderCheckout(req, resp, user, e.getMessage());
        }
    }

    private void renderCheckout(HttpServletRequest req, HttpServletResponse resp,
                                User_24110159 user, String error)
            throws ServletException, IOException {
        List<CartItem_24110159> items = cartService.getItems(user.getUserId());
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
        req.setAttribute("receiverName", req.getParameter("receiverName") == null
                ? user.getFullname() : req.getParameter("receiverName"));
        req.setAttribute("receiverPhone", req.getParameter("receiverPhone") == null
                ? user.getPhone() : req.getParameter("receiverPhone"));
        req.setAttribute("shippingAddress", req.getParameter("shippingAddress"));
        req.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(req, resp);
    }

    private User_24110159 requireUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Object value = req.getSession(false) == null ? null : req.getSession(false).getAttribute("user");
        if (value instanceof User_24110159 user) return user;
        resp.sendRedirect(req.getContextPath() + "/login");
        return null;
    }
}