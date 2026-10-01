package com.webst5.util;

import java.util.regex.Pattern;

public class ValidationUtil_24110159 {

    // Regex email chuẩn RFC: yêu cầu tên người dùng, ký tự @, domain có ít nhất 1 dấu chấm và phần TLD từ 2 đến 10 ký tự
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
            "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,10}$"
    );

    // Regex username: từ 3-50 ký tự, chỉ gồm chữ cái thường, hoa, số và gạch dưới
    private static final Pattern USERNAME_PATTERN = Pattern.compile(
            "^[a-zA-Z0-9_]{3,50}$"
    );

    // Regex số điện thoại Việt Nam: bắt đầu bằng 0 hoặc +84, tiếp theo là 3, 5, 7, 8, 9 và 8 chữ số tiếp theo (tổng 10 số)
    private static final Pattern PHONE_PATTERN = Pattern.compile(
            "^(?:\\+84|0)(?:3[2-9]|5[2689]|7[06-9]|8[1-9]|9[0-9])[0-9]{7}$"
    );

    // Regex OTP: đúng 6 chữ số
    private static final Pattern OTP_PATTERN = Pattern.compile(
            "^[0-9]{6}$"
    );

    /**
     * Kiểm tra tính hợp lệ của Email
     * - Không được null/rỗng
     * - Không vượt quá 100 ký tự (theo độ dài cột email VARCHAR(100) trong database)
     * - Đúng định dạng email chuẩn
     */
    public static boolean isValidEmail(String email) {
        if (email == null) {
            return false;
        }
        String trimmed = email.trim();
        if (trimmed.isEmpty() || trimmed.length() > 100) {
            return false;
        }
        return EMAIL_PATTERN.matcher(trimmed).matches();
    }

    /**
     * Kiểm tra tính hợp lệ của Số điện thoại
     * - Nếu để trống (null hoặc rỗng) thì hợp lệ (vì phone là tùy chọn trong database)
     * - Nếu có nhập thì phải đúng định dạng số di động Việt Nam và <= 20 ký tự
     */
    public static boolean isValidPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return true;
        }
        String trimmed = phone.trim();
        if (trimmed.length() > 20) {
            return false;
        }
        return PHONE_PATTERN.matcher(trimmed).matches();
    }

    /**
     * Kiểm tra tính hợp lệ của Username
     * - Không được null/rỗng
     * - Độ dài 3 đến 50 ký tự (theo VARCHAR(50) trong database)
     * - Chỉ chứa a-z, A-Z, 0-9 và dấu gạch dưới
     */
    public static boolean isValidUsername(String username) {
        if (username == null) {
            return false;
        }
        String trimmed = username.trim();
        return USERNAME_PATTERN.matcher(trimmed).matches();
    }

    /**
     * Kiểm tra tính hợp lệ của Họ tên
     * - Không được null/rỗng sau khi trim
     * - Độ dài 2 đến 50 ký tự (theo VARCHAR(50) trong database)
     * - Không chứa thẻ tag HTML (< hay >) để phòng chống XSS
     */
    public static boolean isValidFullname(String fullname) {
        if (fullname == null) {
            return false;
        }
        String trimmed = fullname.trim();
        if (trimmed.length() < 2 || trimmed.length() > 50) {
            return false;
        }
        return !trimmed.contains("<") && !trimmed.contains(">");
    }

    /**
     * Kiểm tra tính hợp lệ của Mật khẩu
     * - Không được null
     * - Độ dài tối thiểu 6 ký tự, tối đa 50 ký tự (theo VARCHAR(50) trong database)
     */
    public static boolean isValidPassword(String password) {
        if (password == null) {
            return false;
        }
        return password.length() >= 6 && password.length() <= 50;
    }

    /**
     * Kiểm tra mã OTP
     * - Phải đúng 6 chữ số
     */
    public static boolean isValidOTP(String otp) {
        if (otp == null) {
            return false;
        }
        return OTP_PATTERN.matcher(otp.trim()).matches();
    }

    /**
     * Kiểm tra Tên danh mục (CategoryName)
     * - Không null/rỗng
     * - Độ dài từ 1 đến 200 ký tự (theo VARCHAR(200) trong database)
     */
    public static boolean isValidCategoryName(String name) {
        if (name == null) {
            return false;
        }
        String trimmed = name.trim();
        return !trimmed.isEmpty() && trimmed.length() <= 200;
    }

    /**
     * Kiểm tra Tên sản phẩm (ProductName)
     * - Không null/rỗng
     * - Độ dài từ 1 đến 200 ký tự (theo VARCHAR(200) trong database)
     */
    public static boolean isValidProductName(String name) {
        if (name == null) {
            return false;
        }
        String trimmed = name.trim();
        return !trimmed.isEmpty() && trimmed.length() <= 200;
    }

    /**
     * Kiểm tra Mô tả sản phẩm (Description)
     * - Cho phép rỗng
     * - Nếu có thì không vượt quá 500 ký tự (theo VARCHAR(500) trong database)
     */
    public static boolean isValidDescription(String description) {
        if (description == null || description.trim().isEmpty()) {
            return true;
        }
        return description.trim().length() <= 500;
    }

    /**
     * Kiểm tra đuôi file hình ảnh hợp lệ
     */
    public static boolean isImageExtension(String filename) {
        if (filename == null || filename.isBlank()) {
            return false;
        }
        String lower = filename.toLowerCase();
        return lower.endsWith(".jpg") || lower.endsWith(".jpeg")
                || lower.endsWith(".png") || lower.endsWith(".gif")
                || lower.endsWith(".webp") || lower.endsWith(".bmp");
    }
}
