<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="header.jsp" %>

<style>
    .register-page {
        min-height: calc(100vh - 180px);
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 40px 20px;
    }

    .register-card {
        width: 100%;
        max-width: 480px;
        padding: 35px;
        background: #ffffff;
        border: 1px solid #e9edf5;
        border-radius: 18px;
        box-shadow: 0 10px 35px rgba(15, 23, 42, 0.09);
    }

    .register-header {
        text-align: center;
        margin-bottom: 28px;
    }

    .register-icon {
        width: 58px;
        height: 58px;
        margin: 0 auto 15px;

        display: flex;
        align-items: center;
        justify-content: center;

        border-radius: 15px;
        background: linear-gradient(135deg, #6366f1, #4f46e5);
        color: #ffffff;
        font-size: 25px;

        box-shadow: 0 7px 18px rgba(79, 70, 229, 0.25);
    }

    .register-header h2 {
        margin: 0 0 8px;
        color: #1e293b;
        font-size: 25px;
        font-weight: 700;
    }

    .register-header p {
        margin: 0;
        color: #64748b;
        font-size: 14px;
    }

    .error-message {
        padding: 11px 13px;
        margin-bottom: 20px;

        border: 1px solid #fecaca;
        border-radius: 9px;

        background: #fee2e2;
        color: #b91c1c;

        font-size: 13px;
        line-height: 1.5;
    }

    .register-form .form-group {
        margin-bottom: 17px;
    }

    .register-form label {
        display: block;
        margin-bottom: 8px;

        color: #334155;
        font-size: 14px;
        font-weight: 600;
    }

    .required {
        margin-left: 2px;
        color: #ef4444;
    }

    .register-form input {
        width: 100%;
        padding: 12px 14px;
        box-sizing: border-box;

        border: 1px solid #dbe1ea;
        border-radius: 10px;

        background: #ffffff;
        color: #1e293b;

        font-family: inherit;
        font-size: 14px;
        outline: none;

        transition: all 0.2s ease;
    }

    .register-form input::placeholder {
        color: #94a3b8;
    }

    .register-form input:focus {
        border-color: #6366f1;
        box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.12);
    }

    .register-button {
        width: 100%;
        margin-top: 8px;
        padding: 13px;

        border: none;
        border-radius: 10px;

        background: linear-gradient(135deg, #6366f1, #4f46e5);
        color: #ffffff;

        font-family: inherit;
        font-size: 14px;
        font-weight: 700;

        cursor: pointer;

        box-shadow: 0 5px 14px rgba(79, 70, 229, 0.24);
        transition: all 0.2s ease;
    }

    .register-button:hover {
        transform: translateY(-1px);
        box-shadow: 0 7px 18px rgba(79, 70, 229, 0.32);
    }

    .register-button:active {
        transform: translateY(0);
    }

    .login-link {
        margin: 20px 0 0;
        text-align: center;

        color: #64748b;
        font-size: 14px;
    }

    .login-link a {
        color: #4f46e5;
        font-weight: 600;
        text-decoration: none;
    }

    .login-link a:hover {
        text-decoration: underline;
    }

    .otp-note {
        display: flex;
        align-items: flex-start;
        gap: 8px;

        margin-top: 20px;
        padding: 12px 14px;

        border: 1px solid #e0e7ff;
        border-radius: 10px;

        background: #eef2ff;
        color: #4f46e5;

        font-size: 12px;
        line-height: 1.6;
    }

    .otp-note-icon {
        flex-shrink: 0;
    }

    @media (max-width: 500px) {
        .register-page {
            padding: 25px 10px;
        }

        .register-card {
            padding: 25px 20px;
            border-radius: 14px;
        }
    }
</style>


<div class="register-page">

    <div class="register-card">

        <!-- Header -->
        <div class="register-header">

            <div class="register-icon">
                👤
            </div>

            <h2>Đăng ký tài khoản</h2>

            <p>
                Tạo tài khoản mới để sử dụng hệ thống
            </p>

        </div>


        <!-- Error -->
        <% if (request.getAttribute("error") != null) { %>

            <div class="error-message">
                ⚠ ${error}
            </div>

        <% } %>


        <!-- Form -->
        <form method="post" class="register-form" novalidate id="registerForm">

            <div class="form-group">

                <label for="username">
                    Username
                    <span class="required">*</span>
                </label>

                <input
                    id="username"
                    name="username"
                    value="${not empty param_username ? param_username : (not empty param.username ? param.username : '')}"
                    placeholder="Nhập tên đăng nhập..."
                    autocomplete="username"
                    minlength="3"
                    maxlength="50"
                    pattern="^[a-zA-Z0-9_]{3,50}$"
                    title="Tên đăng nhập từ 3 - 50 ký tự, chỉ gồm chữ cái, số và dấu gạch dưới (_)"
                    required>

            </div>


            <div class="form-group">

                <label for="email">
                    Email
                    <span class="required">*</span>
                </label>

                <input
                    id="email"
                    type="email"
                    name="email"
                    value="${not empty param_email ? param_email : (not empty param.email ? param.email : '')}"
                    placeholder="example@email.com"
                    autocomplete="email"
                    maxlength="100"
                    pattern="^[a-zA-Z0-9_+&*-]+(?:\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,10}$"
                    title="Email hợp lệ dạng name@domain.com"
                    required>

            </div>


            <div class="form-group">

                <label for="fullname">
                    Họ tên
                    <span class="required">*</span>
                </label>

                <input
                    id="fullname"
                    name="fullname"
                    value="${not empty param_fullname ? param_fullname : (not empty param.fullname ? param.fullname : '')}"
                    placeholder="Nhập họ và tên..."
                    autocomplete="name"
                    minlength="2"
                    maxlength="50"
                    required>

            </div>


            <div class="form-group">

                <label for="phone">
                    Số điện thoại (tùy chọn)
                </label>

                <input
                    id="phone"
                    type="tel"
                    name="phone"
                    value="${not empty param_phone ? param_phone : (not empty param.phone ? param.phone : '')}"
                    placeholder="Nhập số điện thoại (VD: 0912345678)..."
                    autocomplete="tel"
                    maxlength="15"
                    pattern="^(?:\+84|0)[35789][0-9]{8}$"
                    title="Số di động Việt Nam gồm 10 chữ số (VD: 0912345678 hoặc +84912345678)">

            </div>


            <div class="form-group">

                <label for="password">
                    Mật khẩu
                    <span class="required">*</span>
                </label>

                <input
                    id="password"
                    type="password"
                    name="password"
                    placeholder="Nhập mật khẩu (tối thiểu 6 ký tự)..."
                    autocomplete="new-password"
                    minlength="6"
                    maxlength="50"
                    required>

            </div>


            <button type="submit" class="register-button">
                ✉ Gửi OTP
            </button>

        </form>

        <script>
            document.getElementById('registerForm').addEventListener('submit', function(e) {
                var username = document.getElementById('username').value.trim();
                var email = document.getElementById('email').value.trim();
                var fullname = document.getElementById('fullname').value.trim();
                var phone = document.getElementById('phone').value.trim();
                var password = document.getElementById('password').value;

                var emailRegex = /^[a-zA-Z0-9_+&*-]+(?:\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,10}$/;
                var usernameRegex = /^[a-zA-Z0-9_]{3,50}$/;
                var phoneRegex = /^(?:\+84|0)[35789][0-9]{8}$/;

                if (!usernameRegex.test(username)) {
                    alert('Tên đăng nhập phải từ 3 - 50 ký tự và chỉ chứa chữ cái, số, dấu gạch dưới (_).');
                    document.getElementById('username').focus();
                    e.preventDefault();
                    return;
                }
                if (!emailRegex.test(email) || email.length > 100) {
                    alert('Email không đúng định dạng chuẩn (ví dụ: example@gmail.com) hoặc dài quá 100 ký tự.');
                    document.getElementById('email').focus();
                    e.preventDefault();
                    return;
                }
                if (fullname.length < 2 || fullname.length > 50) {
                    alert('Họ và tên phải từ 2 đến 50 ký tự.');
                    document.getElementById('fullname').focus();
                    e.preventDefault();
                    return;
                }
                if (phone !== '' && !phoneRegex.test(phone)) {
                    alert('Số điện thoại không hợp lệ (Phải là số di động Việt Nam 10 số, ví dụ: 0912345678).');
                    document.getElementById('phone').focus();
                    e.preventDefault();
                    return;
                }
                if (password.length < 6 || password.length > 50) {
                    alert('Mật khẩu phải từ 6 đến 50 ký tự.');
                    document.getElementById('password').focus();
                    e.preventDefault();
                    return;
                }
            });
        </script>


        <!-- OTP note -->
        <div class="otp-note">

            <span class="otp-note-icon">🔐</span>

            <span>
                Sau khi gửi, hệ thống sẽ gửi mã OTP đến email
                của bạn để xác nhận đăng ký tài khoản.
            </span>

        </div>


        <!-- Login -->
        <p class="login-link">

            Đã có tài khoản?

            <a href="${pageContext.request.contextPath}/login">
                Đăng nhập
            </a>

        </p>

    </div>

</div>


<%@ include file="footer.jsp" %>