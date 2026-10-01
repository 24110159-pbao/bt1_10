package com.webst5.controller;

import com.webst5.service.UserService_24110159;
import com.webst5.util.MailUtil_24110159;
import com.webst5.util.OTPUtil_24110159;
import com.webst5.util.ValidationUtil_24110159;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/register")
public class RegisterController_24110159 extends HttpServlet {
    private final UserService_24110159 service = new UserService_24110159();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String rawUsername = req.getParameter("username");
        String rawEmail = req.getParameter("email");
        String rawFullname = req.getParameter("fullname");
        String rawPhone = req.getParameter("phone");
        String password = req.getParameter("password");

        String username = rawUsername != null ? rawUsername.trim() : "";
        String email = rawEmail != null ? rawEmail.trim() : "";
        String fullname = rawFullname != null ? rawFullname.trim() : "";
        String phone = rawPhone != null ? rawPhone.trim() : "";

        // Giữ lại dữ liệu đã nhập trên form khi có lỗi
        req.setAttribute("param_username", username);
        req.setAttribute("param_email", email);
        req.setAttribute("param_fullname", fullname);
        req.setAttribute("param_phone", phone);

        // 1. Kiểm tra Username
        if (username.isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập tên đăng nhập.");
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
            return;
        }
        if (!ValidationUtil_24110159.isValidUsername(username)) {
            req.setAttribute("error", "Tên đăng nhập không hợp lệ: phải từ 3 - 50 ký tự, chỉ gồm chữ cái, số và dấu gạch dưới (_).");
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
            return;
        }
        if (service.usernameExists(username)) {
            req.setAttribute("error", "Tên đăng nhập đã tồn tại trong hệ thống.");
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
            return;
        }

        // 2. Kiểm tra Email
        if (email.isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập địa chỉ email.");
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
            return;
        }
        if (!ValidationUtil_24110159.isValidEmail(email)) {
            req.setAttribute("error", "Địa chỉ email không đúng định dạng (Ví dụ: user@example.com) hoặc vượt quá 100 ký tự.");
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
            return;
        }
        if (service.emailExists(email)) {
            req.setAttribute("error", "Email đã tồn tại trong hệ thống.");
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
            return;
        }

        // 3. Kiểm tra Họ và tên
        if (fullname.isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập họ và tên.");
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
            return;
        }
        if (!ValidationUtil_24110159.isValidFullname(fullname)) {
            req.setAttribute("error", "Họ và tên phải từ 2 - 50 ký tự và không chứa ký tự đặc biệt nguy hiểm.");
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
            return;
        }

        // 4. Kiểm tra Số điện thoại (nếu có nhập)
        if (!phone.isEmpty() && !ValidationUtil_24110159.isValidPhone(phone)) {
            req.setAttribute("error", "Số điện thoại không đúng định dạng di động Việt Nam (Ví dụ: 0912345678 hoặc +84912345678).");
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
            return;
        }

        // 5. Kiểm tra Mật khẩu
        if (password == null || password.isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập mật khẩu.");
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
            return;
        }
        if (!ValidationUtil_24110159.isValidPassword(password)) {
            req.setAttribute("error", "Mật khẩu phải có độ dài từ 6 đến 50 ký tự.");
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
            return;
        }

        // 6. Tạo OTP và gửi email
        String otp = OTPUtil_24110159.generate();
        try {
            MailUtil_24110159.sendOTP(email, otp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Không thể gửi mã OTP đến email (" + email + "). Vui lòng kiểm tra lại địa chỉ email hoặc kết nối mạng.");
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession();
        session.setAttribute("register_username", username);
        session.setAttribute("register_email", email);
        session.setAttribute("register_fullname", fullname);
        session.setAttribute("register_password", password);
        session.setAttribute("register_phone", phone.isEmpty() ? null : phone);
        session.setAttribute("register_otp", otp);
        session.setAttribute("register_otp_time", System.currentTimeMillis());

        resp.sendRedirect(req.getContextPath() + "/verify-otp");
    }
}
