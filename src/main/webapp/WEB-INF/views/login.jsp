<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="header.jsp" %>

<style>
    .login-page {
        min-height: calc(100vh - 180px);
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 40px 20px;
    }

    .login-card {
        width: 100%;
        max-width: 430px;
        padding: 35px;
        background: #ffffff;
        border: 1px solid #e9edf5;
        border-radius: 18px;
        box-shadow: 0 10px 35px rgba(15, 23, 42, 0.09);
    }

    .login-header {
        text-align: center;
        margin-bottom: 28px;
    }

    .login-icon {
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

    .login-header h2 {
        margin: 0 0 8px;
        color: #1e293b;
        font-size: 25px;
        font-weight: 700;
    }

    .login-header p {
        margin: 0;
        color: #64748b;
        font-size: 14px;
    }

    .message {
        padding: 11px 13px;
        margin-bottom: 20px;
        border-radius: 9px;
        font-size: 13px;
        line-height: 1.5;
    }

    .success {
        color: #166534;
        background: #dcfce7;
        border: 1px solid #bbf7d0;
    }

    .error {
        color: #b91c1c;
        background: #fee2e2;
        border: 1px solid #fecaca;
    }

    .login-form .form-group {
        margin-bottom: 18px;
    }

    .login-form label {
        display: block;
        margin-bottom: 8px;
        color: #334155;
        font-size: 14px;
        font-weight: 600;
    }

    .login-form input {
        width: 100%;
        padding: 13px 14px;
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

    .login-form input::placeholder {
        color: #94a3b8;
    }

    .login-form input:focus {
        border-color: #6366f1;
        box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.12);
    }

    .login-button {
        width: 100%;
        margin-top: 5px;
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

    .login-button:hover {
        transform: translateY(-1px);
        box-shadow: 0 7px 18px rgba(79, 70, 229, 0.32);
    }

    .login-button:active {
        transform: translateY(0);
    }

    .register-link {
        margin: 20px 0 0;
        text-align: center;
        color: #64748b;
        font-size: 14px;
    }

    .register-link a {
        color: #4f46e5;
        font-weight: 600;
        text-decoration: none;
    }

    .register-link a:hover {
        text-decoration: underline;
    }

    .demo-account {
        margin-top: 22px;
        padding: 13px 15px;

        border: 1px dashed #cbd5e1;
        border-radius: 10px;

        background: #f8fafc;
        color: #64748b;

        font-size: 12px;
        line-height: 1.7;
    }

    .demo-account-title {
        margin-bottom: 5px;
        color: #475569;
        font-weight: 700;
    }

    .demo-account b {
        color: #334155;
    }

    @media (max-width: 500px) {
        .login-page {
            padding: 25px 10px;
        }

        .login-card {
            padding: 25px 20px;
            border-radius: 14px;
        }
    }
</style>

<div class="login-page">

    <div class="login-card">

        <div class="login-header">

            <div class="login-icon">
                🔐
            </div>

            <h2>Đăng nhập</h2>

            <p>
                Đăng nhập để tiếp tục sử dụng hệ thống
            </p>

        </div>


        <% if (request.getParameter("registered") != null) { %>

            <div class="message success">
                ✓ Đăng ký thành công. Hãy đăng nhập để tiếp tục.
            </div>

        <% } %>


        <% if (request.getAttribute("error") != null) { %>

            <div class="message error">
                ⚠ ${error}
            </div>

        <% } %>


        <form method="post" class="login-form">

            <div class="form-group">

                <label for="username">
                    Tên đăng nhập
                </label>

                <input
                    id="username"
                    type="text"
                    name="username"
                    value="${not empty param_username ? param_username : (not empty param.username ? param.username : '')}"
                    placeholder="Nhập tên đăng nhập..."
                    autocomplete="username"
                    required>
            </div>


            <div class="form-group">

                <label for="password">
                    Mật khẩu
                </label>

                <input
                    id="password"
                    type="password"
                    name="password"
                    placeholder="Nhập mật khẩu..."
                    autocomplete="current-password"
                    required>

            </div>


            <button type="submit" class="login-button">
                Đăng nhập
            </button>

        </form>


        <p class="register-link">
            Chưa có tài khoản?
            <a href="${pageContext.request.contextPath}/register">
                Đăng ký ngay
            </a>
        </p>


        <div class="demo-account">

            <div class="demo-account-title">
                🔑 Tài khoản mẫu
            </div>

            <div>
                Admin:
                <b>admin / 123456</b>
            </div>

            <div>
                User:
                <b>user / 123456</b>
            </div>

        </div>

    </div>

</div>

<%@ include file="footer.jsp" %>