<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="header.jsp" %>

<style>
    .otp-page {
        min-height: calc(100vh - 180px);
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 40px 20px;
    }

    .otp-card {
        width: 100%;
        max-width: 430px;
        padding: 35px;

        background: #ffffff;
        border: 1px solid #e9edf5;
        border-radius: 18px;

        box-shadow: 0 10px 35px rgba(15, 23, 42, 0.09);
    }

    .otp-header {
        text-align: center;
        margin-bottom: 28px;
    }

    .otp-icon {
        width: 60px;
        height: 60px;
        margin: 0 auto 15px;

        display: flex;
        align-items: center;
        justify-content: center;

        border-radius: 16px;

        background: linear-gradient(135deg, #6366f1, #4f46e5);
        color: #ffffff;

        font-size: 27px;

        box-shadow: 0 7px 18px rgba(79, 70, 229, 0.25);
    }

    .otp-header h2 {
        margin: 0 0 8px;

        color: #1e293b;
        font-size: 25px;
        font-weight: 700;
    }

    .otp-header p {
        margin: 0;

        color: #64748b;
        font-size: 14px;
        line-height: 1.6;
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

    .otp-form label {
        display: block;

        margin-bottom: 10px;

        color: #334155;
        font-size: 14px;
        font-weight: 600;

        text-align: center;
    }

    .otp-input {
        width: 100%;
        height: 58px;
        padding: 10px 15px;

        box-sizing: border-box;

        border: 1px solid #dbe1ea;
        border-radius: 11px;

        background: #f8fafc;
        color: #1e293b;

        font-family: Arial, Helvetica, sans-serif;
        font-size: 25px;
        font-weight: 700;

        letter-spacing: 9px;
        text-align: center;

        outline: none;

        transition: all 0.2s ease;
    }

    .otp-input:focus {
        border-color: #6366f1;
        background: #ffffff;

        box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.12);
    }

    .otp-input::placeholder {
        color: #cbd5e1;
        letter-spacing: 7px;
    }

    .otp-button {
        width: 100%;

        margin-top: 20px;
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

    .otp-button:hover {
        transform: translateY(-1px);

        box-shadow: 0 7px 18px rgba(79, 70, 229, 0.32);
    }

    .otp-button:active {
        transform: translateY(0);
    }

    .otp-note {
        margin-top: 20px;
        padding: 13px 15px;

        border: 1px solid #e0e7ff;
        border-radius: 10px;

        background: #eef2ff;
        color: #4f46e5;

        font-size: 12px;
        line-height: 1.6;

        text-align: center;
    }

    .otp-help {
        margin: 20px 0 0;

        color: #64748b;
        font-size: 13px;

        text-align: center;
    }

    .otp-help a {
        color: #4f46e5;
        font-weight: 600;
        text-decoration: none;
    }

    .otp-help a:hover {
        text-decoration: underline;
    }

    @media (max-width: 500px) {
        .otp-page {
            padding: 25px 10px;
        }

        .otp-card {
            padding: 25px 20px;
            border-radius: 14px;
        }

        .otp-input {
            height: 54px;
            font-size: 22px;
            letter-spacing: 7px;
        }
    }
</style>


<div class="otp-page">

    <div class="otp-card">

        <!-- Header -->
        <div class="otp-header">

            <div class="otp-icon">
                🔐
            </div>

            <h2>Xác nhận OTP</h2>

            <p>
                Mã OTP đã được gửi đến email của bạn.
                <br>
                Vui lòng nhập mã để hoàn tất đăng ký.
            </p>

        </div>


        <!-- Error -->
        <% if (request.getAttribute("error") != null) { %>

            <div class="error-message">
                ⚠ ${error}
            </div>

        <% } %>


        <!-- OTP form -->
        <form method="post" class="otp-form">

            <label for="otp">
                Nhập mã OTP 6 số
            </label>

            <input
                id="otp"
                class="otp-input"
                type="text"
                name="otp"
                maxlength="6"
                minlength="6"
                pattern="[0-9]{6}"
                inputmode="numeric"
                autocomplete="one-time-code"
                placeholder="••••••"
                required>

            <button type="submit" class="otp-button">
                ✓ Xác nhận OTP
            </button>

        </form>


        <!-- Note -->
        <div class="otp-note">
            💡 Kiểm tra cả thư mục <b>Spam</b> nếu bạn chưa thấy email OTP.
        </div>


        <p class="otp-help">
            Nhập sai mã?
            <a href="${pageContext.request.contextPath}/register">
                Đăng ký lại
            </a>
        </p>

    </div>

</div>


<%@ include file="footer.jsp" %>