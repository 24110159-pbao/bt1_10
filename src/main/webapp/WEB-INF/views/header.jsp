<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WEBST5 - 24110159</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #f5f7fb;
            color: #334155;
        }

        header {
            background: #ffffff;
            border-bottom: 1px solid #e5e7eb;
            box-shadow: 0 3px 15px rgba(15, 23, 42, 0.06);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .top {
            max-width: 1200px;
            min-height: 70px;
            margin: 0 auto;
            padding: 0 20px;

            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 25px;
        }

        .top h2 {
            margin: 0;
            color: #4f46e5;
            font-size: 21px;
            font-weight: 800;
            white-space: nowrap;
        }

        nav {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        nav a {
            padding: 9px 12px;
            border-radius: 8px;
            color: #475569;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        nav a:hover {
            color: #4f46e5;
            background: #eef2ff;
        }

        nav span {
            padding: 8px 10px;
            color: #64748b;
            font-size: 14px;
            font-weight: 600;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 30px 20px;
            min-height: calc(100vh - 150px);
        }

        @media (max-width: 800px) {
            .top {
                min-height: auto;
                padding: 15px;
                flex-direction: column;
                align-items: stretch;
                gap: 12px;
            }

            .top h2 {
                text-align: center;
            }

            nav {
                justify-content: center;
                flex-wrap: wrap;
            }

            nav a,
            nav span {
                font-size: 13px;
            }

            .container {
                padding: 20px 12px;
            }
        }
    </style>
</head>

<body>

<header>
    <div class="top">

        <h2>WEBST5 - ECOMMERCE</h2>

        <nav>

            <a href="${pageContext.request.contextPath}/products">
                Trang chủ
            </a>

            <a href="${pageContext.request.contextPath}/products">
                Sản phẩm
            </a>

            <%
                com.webst5.entity.User_24110159 current =
                    (com.webst5.entity.User_24110159)
                    session.getAttribute("user");

                if (current == null) {
            %>

                <a href="${pageContext.request.contextPath}/login">
                    Đăng nhập
                </a>

                <a href="${pageContext.request.contextPath}/register">
                    Đăng ký
                </a>

            <%
                } else {
            %>

                <a href="${pageContext.request.contextPath}/cart">
                    Giỏ hàng
                </a>

                <a href="${pageContext.request.contextPath}/orders">
                    Hóa đơn
                </a>

                <%
                    if (current.getRole() != null &&
                        "ADMIN".equalsIgnoreCase(
                            current.getRole().getRoleName()
                        )) {
                %>

                    <a href="${pageContext.request.contextPath}/admin/categories">
                        Quản trị
                    </a>

                <%
                    }
                %>

                <span>
                    Xin chào, <%= current.getFullname() %>
                </span>

                <a href="${pageContext.request.contextPath}/logout">
                    Đăng xuất
                </a>

            <%
                }
            %>

        </nav>

    </div>
</header>

<main class="container">