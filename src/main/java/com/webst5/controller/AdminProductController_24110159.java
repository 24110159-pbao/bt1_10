package com.webst5.controller;

import com.webst5.entity.*;
import com.webst5.service.ProductService_24110159;
import com.webst5.util.FileUploadUtil_24110159;
import com.webst5.util.JPAUtil_24110159;
import com.webst5.util.ValidationUtil_24110159;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.time.LocalDate;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 10 * 1024 * 1024,
        maxRequestSize = 20 * 1024 * 1024
)
@WebServlet("/admin/products")
public class AdminProductController_24110159 extends HttpServlet {
    private final ProductService_24110159 service = new ProductService_24110159();
    private static final int SIZE = 5;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("edit".equals(action)) {
            try {
                req.setAttribute("product", service.findById(Integer.valueOf(req.getParameter("id"))));
                loadData(req);
                req.getRequestDispatcher("/WEB-INF/views/admin/product-form.jsp").forward(req, resp);
                return;
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/admin/products");
                return;
            }
        }
        if ("delete".equals(action)) {
            try {
                service.delete(Integer.valueOf(req.getParameter("id")));
            } catch (Exception ignored) {}
            resp.sendRedirect(req.getContextPath() + "/admin/products");
            return;
        }

        int page = 0;
        try {
            page = Math.max(0, Integer.parseInt(req.getParameter("page")));
        } catch (Exception ignored) {}
        req.setAttribute("products", service.findPage(page, SIZE));
        req.setAttribute("page", page);
        req.setAttribute("totalPages", (int) Math.ceil((double) service.count() / SIZE));
        req.getRequestDispatcher("/WEB-INF/views/admin/product-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        Product_24110159 p = new Product_24110159();
        String id = req.getParameter("productId");
        if (id != null && !id.isBlank()) {
            try {
                p.setProductId(Integer.valueOf(id.trim()));
            } catch (NumberFormatException ignored) {}
        }

        String rawProductName = req.getParameter("productName");
        String productName = rawProductName != null ? rawProductName.trim() : "";
        p.setProductName(productName);

        String rawProductCode = req.getParameter("productCode");
        String rawDescription = req.getParameter("description");
        String description = rawDescription != null ? rawDescription.trim() : "";
        p.setDescription(description);

        String rawPrice = req.getParameter("price");
        String rawAmount = req.getParameter("amount");
        String rawStock = req.getParameter("stock");
        String rawCategoryId = req.getParameter("categoryId");
        String rawSellerId = req.getParameter("sellerId");
        p.setImages(req.getParameter("existingImage"));

        // 1. Validate Product Name
        if (productName.isEmpty()) {
            forwardWithError(req, resp, p, "Vui lòng nhập tên sản phẩm.");
            return;
        }
        if (!ValidationUtil_24110159.isValidProductName(productName)) {
            forwardWithError(req, resp, p, "Tên sản phẩm không được vượt quá 200 ký tự.");
            return;
        }

        // 2. Validate Product Code
        Long productCode = null;
        try {
            if (rawProductCode == null || rawProductCode.trim().isEmpty()) {
                forwardWithError(req, resp, p, "Vui lòng nhập mã sản phẩm.");
                return;
            }
            productCode = Long.valueOf(rawProductCode.trim());
            if (productCode <= 0) {
                forwardWithError(req, resp, p, "Mã sản phẩm phải là số nguyên dương.");
                return;
            }
            p.setProductCode(productCode);
        } catch (NumberFormatException e) {
            forwardWithError(req, resp, p, "Mã sản phẩm không hợp lệ (phải là số nguyên).");
            return;
        }

        // 3. Validate Description
        if (!ValidationUtil_24110159.isValidDescription(description)) {
            forwardWithError(req, resp, p, "Mô tả sản phẩm không được vượt quá 500 ký tự.");
            return;
        }

        // 4. Validate Price
        Float price = null;
        try {
            if (rawPrice == null || rawPrice.trim().isEmpty()) {
                forwardWithError(req, resp, p, "Vui lòng nhập giá sản phẩm.");
                return;
            }
            price = Float.valueOf(rawPrice.trim());
            if (price < 0) {
                forwardWithError(req, resp, p, "Giá sản phẩm không được âm.");
                return;
            }
            p.setPrice(price);
        } catch (NumberFormatException e) {
            forwardWithError(req, resp, p, "Giá sản phẩm phải là số hợp lệ.");
            return;
        }

        // 5. Validate Amount
        Integer amount = null;
        try {
            if (rawAmount == null || rawAmount.trim().isEmpty()) {
                forwardWithError(req, resp, p, "Vui lòng nhập số lượng (amount).");
                return;
            }
            amount = Integer.valueOf(rawAmount.trim());
            if (amount < 0) {
                forwardWithError(req, resp, p, "Số lượng không được âm.");
                return;
            }
            p.setAmount(amount);
        } catch (NumberFormatException e) {
            forwardWithError(req, resp, p, "Số lượng phải là số nguyên không âm.");
            return;
        }

        // 6. Validate Stock
        Integer stock = null;
        try {
            if (rawStock == null || rawStock.trim().isEmpty()) {
                forwardWithError(req, resp, p, "Vui lòng nhập số lượng tồn kho (stock).");
                return;
            }
            stock = Integer.valueOf(rawStock.trim());
            if (stock < 0) {
                forwardWithError(req, resp, p, "Số lượng tồn kho không được âm.");
                return;
            }
            p.setStock(stock);
        } catch (NumberFormatException e) {
            forwardWithError(req, resp, p, "Số lượng tồn kho phải là số nguyên không âm.");
            return;
        }

        // 7. Validate Category & Seller
        Integer categoryId = null;
        Integer sellerId = null;
        try {
            if (rawCategoryId == null || rawCategoryId.trim().isEmpty()) {
                forwardWithError(req, resp, p, "Vui lòng chọn danh mục.");
                return;
            }
            categoryId = Integer.valueOf(rawCategoryId.trim());

            if (rawSellerId == null || rawSellerId.trim().isEmpty()) {
                forwardWithError(req, resp, p, "Vui lòng chọn người bán (Seller).");
                return;
            }
            sellerId = Integer.valueOf(rawSellerId.trim());
        } catch (NumberFormatException e) {
            forwardWithError(req, resp, p, "Danh mục hoặc người bán được chọn không hợp lệ.");
            return;
        }

        EntityManager em = JPAUtil_24110159.getEntityManager();
        try {
            Category_24110159 c = em.find(Category_24110159.class, categoryId);
            Seller_24110159 s = em.find(Seller_24110159.class, sellerId);
            if (c == null) {
                forwardWithError(req, resp, p, "Danh mục đã chọn không tồn tại.");
                return;
            }
            if (s == null) {
                forwardWithError(req, resp, p, "Người bán đã chọn không tồn tại.");
                return;
            }
            p.setCategory(c);
            p.setSeller(s);
        } finally {
            em.close();
        }

        // 8. Validate File Upload Image
        try {
            Part filePart = req.getPart("imagesFile");
            if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isBlank()) {
                if (!ValidationUtil_24110159.isImageExtension(filePart.getSubmittedFileName())) {
                    forwardWithError(req, resp, p, "Tệp tải lên không phải là hình ảnh hợp lệ (chấp nhận JPG, JPEG, PNG, GIF, WEBP).");
                    return;
                }
            }
        } catch (Exception e) {
            forwardWithError(req, resp, p, "Lỗi khi xử lý tệp ảnh tải lên: " + e.getMessage());
            return;
        }

        String uploadedImage = FileUploadUtil_24110159.saveImage(req, "imagesFile");
        if (uploadedImage != null && !uploadedImage.isBlank()) {
            p.setImages(uploadedImage);
        } else if (req.getParameter("existingImage") != null && !req.getParameter("existingImage").isBlank()) {
            p.setImages(req.getParameter("existingImage"));
        }

        p.setStatus(1);
        p.setWishlist(0);
        p.setCreateDate(LocalDate.now());

        if (p.getProductId() == null) {
            service.save(p);
        } else {
            service.update(p);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    private void forwardWithError(HttpServletRequest req, HttpServletResponse resp, Product_24110159 p, String errorMessage)
            throws ServletException, IOException {
        req.setAttribute("error", errorMessage);
        req.setAttribute("product", p);
        loadData(req);
        req.getRequestDispatcher("/WEB-INF/views/admin/product-form.jsp").forward(req, resp);
    }

    private void loadData(HttpServletRequest req) {
        EntityManager em = JPAUtil_24110159.getEntityManager();
        try {
            req.setAttribute("categories", em.createQuery("from Category_24110159", Category_24110159.class).getResultList());
            req.setAttribute("sellers", em.createQuery("from Seller_24110159", Seller_24110159.class).getResultList());
        } finally {
            em.close();
        }
    }
}
