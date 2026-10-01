package com.webst5.util;

import com.webst5.ImageServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

public class FileUploadUtil_24110159 {

    public static String saveImage(
            HttpServletRequest request,
            String fieldName)
            throws IOException, ServletException {

        Part filePart = request.getPart(fieldName);

        if (filePart == null
                || filePart.getSize() == 0
                || filePart.getSubmittedFileName() == null
                || filePart.getSubmittedFileName().isBlank()) {
            return null;
        }

        String originalFileName =
                Paths.get(filePart.getSubmittedFileName())
                        .getFileName()
                        .toString();

        String extension = "";
        int dotIndex = originalFileName.lastIndexOf('.');
        if (dotIndex > 0) {
            extension = originalFileName.substring(dotIndex).toLowerCase();
        }

        String savedFileName = UUID.randomUUID() + extension;

        // 1. Lưu vào thư mục runtime "/uploads" để webapp truy cập và hiển thị được ngay lập tức
        String runtimeUploadPath = request.getServletContext().getRealPath("/uploads");
        Path runtimeFile = null;
        if (runtimeUploadPath != null && !runtimeUploadPath.isBlank()) {
            Path runtimeDir = Paths.get(runtimeUploadPath);
            Files.createDirectories(runtimeDir);
            runtimeFile = runtimeDir.resolve(savedFileName);
            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, runtimeFile, StandardCopyOption.REPLACE_EXISTING);
            }
            System.out.println("[Runtime] Ảnh đã lưu tại: " + runtimeFile.toAbsolutePath());
        }

        // 2. Đồng thời đồng bộ vào thư mục source code "src/main/webapp/uploads"
        // Để không bị mất ảnh khi rebuild, clean compile hoặc restart server Tomcat
        try {
            Path sourceDir = ImageServlet.findSourceUploadDir(request.getServletContext());
            if (sourceDir != null) {
                Files.createDirectories(sourceDir);
                Path sourceFile = sourceDir.resolve(savedFileName);
                if (runtimeFile != null && Files.exists(runtimeFile)) {
                    Files.copy(runtimeFile, sourceFile, StandardCopyOption.REPLACE_EXISTING);
                } else {
                    try (InputStream input = filePart.getInputStream()) {
                        Files.copy(input, sourceFile, StandardCopyOption.REPLACE_EXISTING);
                    }
                }
                System.out.println("[Source] Ảnh đã đồng bộ tại: " + sourceFile.toAbsolutePath());
            }
        } catch (Exception e) {
            System.err.println("Không thể đồng bộ ảnh về thư mục source: " + e.getMessage());
        }

        return "/uploads/" + savedFileName;
    }
}
