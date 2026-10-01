package com.webst5.controller;

import com.webst5.entity.User_24110159;
import com.webst5.entity.UserRole_24110159;
import com.webst5.util.JPAUtil_24110159;
import com.webst5.util.ValidationUtil_24110159;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/verify-otp")
public class VerifyOTPController_24110159 extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("register_otp") == null) {
            resp.sendRedirect(req.getContextPath() + "/register");
            return;
        }
        req.getRequestDispatcher("/WEB-INF/views/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("register_otp") == null) {
            resp.sendRedirect(req.getContextPath() + "/register");
            return;
        }

        String rawInput = req.getParameter("otp");
        String input = rawInput != null ? rawInput.trim() : "";
        String otp = (String) s.getAttribute("register_otp");
        Long time = (Long) s.getAttribute("register_otp_time");

        // Validate định dạng mã OTP
        if (input.isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập mã OTP gồm 6 chữ số.");
            req.getRequestDispatcher("/WEB-INF/views/verify-otp.jsp").forward(req, resp);
            return;
        }
        if (!ValidationUtil_24110159.isValidOTP(input)) {
            req.setAttribute("error", "Mã OTP phải bao gồm đúng 6 chữ số.");
            req.getRequestDispatcher("/WEB-INF/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        // Validate thời gian hiệu lực (5 phút = 300,000 ms)
        if (time == null || System.currentTimeMillis() - time > 5 * 60 * 1000L) {
            req.setAttribute("error", "Mã OTP đã hết thời hạn hiệu lực (5 phút). Vui lòng đăng ký lại.");
            req.getRequestDispatcher("/WEB-INF/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        // Validate so khớp OTP
        if (!otp.equals(input)) {
            req.setAttribute("error", "Mã OTP không chính xác. Vui lòng kiểm tra lại email.");
            req.getRequestDispatcher("/WEB-INF/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        User_24110159 user = new User_24110159();
        user.setUsername((String) s.getAttribute("register_username"));
        user.setEmail((String) s.getAttribute("register_email"));
        user.setFullname((String) s.getAttribute("register_fullname"));
        user.setPassword((String) s.getAttribute("register_password"));
        user.setPhone((String) s.getAttribute("register_phone"));
        user.setStatus(1);

        EntityManager em = JPAUtil_24110159.getEntityManager();
        try {
            em.getTransaction().begin();
            UserRole_24110159 role = em.createQuery("from UserRole_24110159 r where r.roleName='USER'", UserRole_24110159.class)
                    .getResultStream().findFirst().orElse(null);
            user.setRole(role);
            em.persist(user);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            req.setAttribute("error", "Đã xảy ra lỗi khi tạo tài khoản. Vui lòng thử lại.");
            req.getRequestDispatcher("/WEB-INF/views/verify-otp.jsp").forward(req, resp);
            return;
        } finally {
            em.close();
        }

        // Xóa thông tin đăng ký trong session
        s.removeAttribute("register_username");
        s.removeAttribute("register_email");
        s.removeAttribute("register_fullname");
        s.removeAttribute("register_password");
        s.removeAttribute("register_phone");
        s.removeAttribute("register_otp");
        s.removeAttribute("register_otp_time");

        resp.sendRedirect(req.getContextPath() + "/login?registered=1");
    }
}
