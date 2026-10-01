package com.webst5.controller;

import com.webst5.entity.Product_24110159;
import com.webst5.service.ProductService_24110159;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductController_24110159 extends HttpServlet {
    private final ProductService_24110159 service = new ProductService_24110159();
    private static final int SIZE = 5;

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id != null) {
            Product_24110159 p = service.findById(Integer.valueOf(id));
            req.setAttribute("product", p);
            req.getRequestDispatcher("/WEB-INF/views/product-detail.jsp").forward(req, resp);
            return;
        }

        String sellerId = req.getParameter("sellerId");
        if (sellerId != null) {
            List<Product_24110159> products = service.findBySeller(Integer.valueOf(sellerId));
            req.setAttribute("products", products);
            req.setAttribute("sellerId", sellerId);
            req.getRequestDispatcher("/WEB-INF/views/product-list.jsp").forward(req, resp);
            return;
        }

        int page = 0;
        try { page = Math.max(0, Integer.parseInt(req.getParameter("page"))); } catch (Exception ignored) {}
        req.setAttribute("products", service.findPage(page, SIZE));
        req.setAttribute("page", page);
        req.setAttribute("totalPages", (int) Math.ceil((double) service.count() / SIZE));
        req.getRequestDispatcher("/WEB-INF/views/product-list.jsp").forward(req, resp);
    }
}
