package com.webst5;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@WebServlet("/uploads/*")
public class ImageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String fileName = pathInfo.startsWith("/") ? pathInfo.substring(1) : pathInfo;

        // 1. Thử lấy từ thư mục runtime getRealPath("/uploads")
        Path targetFile = null;
        String realUploadPath = request.getServletContext().getRealPath("/uploads");
        if (realUploadPath != null) {
            Path runtimeFile = Paths.get(realUploadPath, fileName);
            if (Files.exists(runtimeFile)) {
                targetFile = runtimeFile;
            }
        }

        // 2. Nếu không tìm thấy ở runtime, tự động dò tìm trong thư mục source (src/main/webapp/uploads)
        if (targetFile == null) {
            Path sourceDir = findSourceUploadDir(request.getServletContext());
            if (sourceDir != null) {
                Path sourceFile = sourceDir.resolve(fileName);
                if (Files.exists(sourceFile)) {
                    targetFile = sourceFile;
                }
            }
        }

        // 3. Nếu vẫn không thấy ở cả 2 nơi thì trả về 404
        if (targetFile == null || !Files.exists(targetFile)) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String contentType = Files.probeContentType(targetFile);
        response.setContentType(contentType != null ? contentType : "application/octet-stream");
        Files.copy(targetFile, response.getOutputStream());
    }

    /**
     * Tự động dò tìm thư mục source code "src/main/webapp/uploads" một cách tương đối
     * không cần hardcode đường dẫn tuyệt đối (chạy được trên mọi máy tính).
     */
    public static Path findSourceUploadDir(ServletContext context) {
        try {
            // Thử dò từ thư mục gốc của project (user.dir)
            String userDir = System.getProperty("user.dir");
            if (userDir != null) {
                Path candidate = Paths.get(userDir, "src", "main", "webapp", "uploads");
                if (Files.exists(candidate)) {
                    return candidate;
                }
            }

            // Dò ngược từ runtime realPath
            String realPath = context.getRealPath("/");
            if (realPath != null) {
                Path curr = Paths.get(realPath);
                while (curr != null && curr.getParent() != null) {
                    Path candidate = curr.resolve("src/main/webapp/uploads");
                    if (Files.exists(candidate) || Files.exists(curr.resolve("pom.xml"))) {
                        return candidate;
                    }
                    curr = curr.getParent();
                }
            }
        } catch (Exception ignored) {}
        return null;
    }
}
