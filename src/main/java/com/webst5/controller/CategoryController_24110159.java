package com.webst5.controller;

import com.webst5.entity.Category_24110159;
import com.webst5.service.CategoryService_24110159;
import com.webst5.util.FileUploadUtil_24110159;
import com.webst5.util.ValidationUtil_24110159;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 10 * 1024 * 1024,
        maxRequestSize = 20 * 1024 * 1024
)
@WebServlet("/admin/categories")
public class CategoryController_24110159 extends HttpServlet {
    private final CategoryService_24110159 service = new CategoryService_24110159();
    private static final int SIZE = 5;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("edit".equals(action)) {
            try {
                req.setAttribute("category", service.findById(Integer.valueOf(req.getParameter("id"))));
                req.getRequestDispatcher("/WEB-INF/views/admin/category-form.jsp").forward(req, resp);
                return;
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/admin/categories");
                return;
            }
        }
        if ("delete".equals(action)) {
            try {
                service.delete(Integer.valueOf(req.getParameter("id")));
            } catch (Exception ignored) {}
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
            return;
        }

        int page = 0;
        try {
            page = Math.max(0, Integer.parseInt(req.getParameter("page")));
        } catch (Exception ignored) {}
        req.setAttribute("categories", service.findPage(page, SIZE));
        req.setAttribute("page", page);
        req.setAttribute("totalPages", (int) Math.ceil((double) service.count() / SIZE));
        req.getRequestDispatcher("/WEB-INF/views/admin/category-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String id = req.getParameter("categoryId");
        String rawCategoryName = req.getParameter("categoryName");
        String categoryName = rawCategoryName != null ? rawCategoryName.trim() : "";

        Category_24110159 c = new Category_24110159();
        if (id != null && !id.isBlank()) {
            try {
                c.setCategoryId(Integer.valueOf(id));
            } catch (NumberFormatException ignored) {}
        }
        c.setCategoryName(categoryName);
        c.setImages(req.getParameter("existingImage"));

        // Validation Tên danh mục
        if (categoryName.isEmpty()) {
            req.setAttribute("error", "Tên danh mục không được để trống.");
            req.setAttribute("category", c);
            req.getRequestDispatcher("/WEB-INF/views/admin/category-form.jsp").forward(req, resp);
            return;
        }
        if (!ValidationUtil_24110159.isValidCategoryName(categoryName)) {
            req.setAttribute("error", "Tên danh mục không được vượt quá 200 ký tự.");
            req.setAttribute("category", c);
            req.getRequestDispatcher("/WEB-INF/views/admin/category-form.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra file upload nếu có
        try {
            Part filePart = req.getPart("imagesFile");
            if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isBlank()) {
                if (!ValidationUtil_24110159.isImageExtension(filePart.getSubmittedFileName())) {
                    req.setAttribute("error", "Tệp tải lên không phải hình ảnh hợp lệ (chỉ chấp nhận JPG, JPEG, PNG, GIF, WEBP).");
                    req.setAttribute("category", c);
                    req.getRequestDispatcher("/WEB-INF/views/admin/category-form.jsp").forward(req, resp);
                    return;
                }
            }
        } catch (Exception e) {
            req.setAttribute("error", "Lỗi xử lý tệp tải lên: " + e.getMessage());
            req.setAttribute("category", c);
            req.getRequestDispatcher("/WEB-INF/views/admin/category-form.jsp").forward(req, resp);
            return;
        }

        String uploadedImage = FileUploadUtil_24110159.saveImage(req, "imagesFile");
        if (uploadedImage != null && !uploadedImage.isBlank()) {
            c.setImages(uploadedImage);
        } else if (req.getParameter("existingImage") != null && !req.getParameter("existingImage").isBlank()) {
            c.setImages(req.getParameter("existingImage"));
        }

        c.setStatus(1);

        if (c.getCategoryId() == null) {
            service.save(c);
        } else {
            service.update(c);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/categories");
    }
}
