<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<style>
    .detail-page {
        min-height: calc(100vh - 180px);
        padding: 20px 0 40px;
    }

    /* Page header */
    .detail-header {
        margin-bottom: 25px;
    }

    .detail-header h2 {
        margin: 0 0 7px;
        color: #1e293b;
        font-size: 27px;
        font-weight: 700;
    }

    .detail-header p {
        margin: 0;
        color: #64748b;
        font-size: 14px;
    }

    /* Main card */
    .product-detail-card {
        display: grid;
        grid-template-columns: 430px 1fr;
        gap: 40px;

        padding: 30px;

        background: #ffffff;
        border: 1px solid #e9edf5;
        border-radius: 18px;

        box-shadow: 0 8px 30px rgba(15, 23, 42, 0.07);
    }

    /* Image */
    .image-box {
        display: flex;
        align-items: center;
        justify-content: center;

        min-height: 390px;
        padding: 20px;

        border: 1px solid #e2e8f0;
        border-radius: 15px;

        background: #f8fafc;
    }

    .image-box img {
        display: block;

        width: 100%;
        max-width: 370px;
        height: 350px;

        object-fit: contain;

        border-radius: 10px;
    }

    .no-image {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;

        width: 100%;
        height: 350px;

        color: #94a3b8;
        font-size: 14px;
    }

    .no-image-icon {
        margin-bottom: 10px;
        font-size: 45px;
    }

    /* Product information */
    .product-info {
        display: flex;
        flex-direction: column;
    }

    .product-title {
        margin: 0 0 20px;

        color: #1e293b;
        font-size: 25px;
        line-height: 1.4;
        font-weight: 700;
    }

    .product-code {
        display: inline-flex;
        align-items: center;

        width: fit-content;
        margin-bottom: 25px;
        padding: 6px 11px;

        border-radius: 7px;
        background: #eef2ff;
        color: #4f46e5;

        font-size: 12px;
        font-weight: 700;
    }

    /* Information rows */
    .info-list {
        border-top: 1px solid #edf0f5;
    }

    .info-row {
        display: grid;
        grid-template-columns: 150px 1fr;
        gap: 15px;

        padding: 15px 0;

        border-bottom: 1px solid #edf0f5;
    }

    .info-label {
        color: #64748b;
        font-size: 14px;
        font-weight: 600;
    }

    .info-value {
        color: #334155;
        font-size: 14px;
        font-weight: 500;
    }

    .category-badge {
        display: inline-flex;
        align-items: center;

        padding: 5px 10px;

        border-radius: 7px;
        background: #f1f5f9;
        color: #475569;

        font-size: 12px;
        font-weight: 600;
    }

    .price {
        color: #4f46e5;
        font-size: 20px;
        font-weight: 700;
    }

    .amount {
        display: inline-flex;
        align-items: center;
        justify-content: center;

        min-width: 45px;
        padding: 5px 10px;

        border-radius: 7px;
        background: #ecfdf5;
        color: #047857;

        font-size: 12px;
        font-weight: 700;
    }

    /* Description */
    .description-box {
        margin-top: 22px;
        padding: 18px;

        border-radius: 11px;
        background: #f8fafc;
        border: 1px solid #e2e8f0;
    }

    .description-title {
        margin-bottom: 8px;

        color: #334155;
        font-size: 14px;
        font-weight: 700;
    }

    .description {
        margin: 0;

        color: #64748b;
        font-size: 14px;
        line-height: 1.7;

        white-space: pre-line;
    }

    /* Not found */
    .not-found {
        padding: 55px 20px;

        background: #ffffff;
        border: 1px solid #e9edf5;
        border-radius: 18px;

        box-shadow: 0 8px 30px rgba(15, 23, 42, 0.07);

        text-align: center;
    }

    .not-found-icon {
        margin-bottom: 12px;
        font-size: 45px;
    }

    .not-found h3 {
        margin: 0 0 8px;
        color: #334155;
        font-size: 20px;
    }

    .not-found p {
        margin: 0;
        color: #64748b;
        font-size: 14px;
    }

    /* Back button */
    .back-wrapper {
        margin-top: 22px;
    }

    .back-btn {
        display: inline-flex;
        align-items: center;
        gap: 7px;

        padding: 10px 15px;

        border-radius: 9px;

        background: #ffffff;
        border: 1px solid #e2e8f0;

        color: #475569;
        text-decoration: none;

        font-size: 13px;
        font-weight: 600;

        transition: all 0.2s ease;
    }

    .back-btn:hover {
        color: #4f46e5;
        background: #eef2ff;
        border-color: #c7d2fe;
    }

    /* Responsive */
    @media (max-width: 850px) {
        .product-detail-card {
            grid-template-columns: 1fr;
            gap: 25px;
            padding: 22px;
        }

        .image-box {
            min-height: 320px;
        }

        .image-box img {
            height: 280px;
        }

        .no-image {
            height: 280px;
        }
    }

    @media (max-width: 500px) {
        .detail-page {
            padding-top: 10px;
        }

        .detail-header h2 {
            font-size: 23px;
        }

        .product-detail-card {
            padding: 15px;
            border-radius: 14px;
        }

        .image-box {
            min-height: 260px;
            padding: 15px;
        }

        .image-box img {
            height: 230px;
        }

        .no-image {
            height: 230px;
        }

        .product-title {
            font-size: 21px;
        }

        .info-row {
            grid-template-columns: 1fr;
            gap: 5px;
        }
    }
</style>


<div class="detail-page">

    <div class="detail-header">
        <h2>Chi tiết sản phẩm</h2>
        <p>Thông tin chi tiết của sản phẩm trong hệ thống</p>
    </div>


    <c:choose>

        <c:when test="${not empty product}">

            <div class="product-detail-card">

                <!-- Product image -->
                <div class="image-box">

                    <c:choose>

                        <c:when test="${not empty product.images}">

                            <img
                                src="${pageContext.request.contextPath}${product.images}"
                                alt="${product.productName}">

                        </c:when>

                        <c:otherwise>

                            <div class="no-image">
                                <div class="no-image-icon">🖼️</div>
                                <span>Chưa có hình ảnh</span>
                            </div>

                        </c:otherwise>

                    </c:choose>

                </div>


                <!-- Product information -->
                <div class="product-info">

                    <h1 class="product-title">
                        ${product.productName}
                    </h1>

                    <span class="product-code">
                        Mã sản phẩm: ${product.productCode}
                    </span>


                    <div class="info-list">

                        <!-- Category -->
                        <div class="info-row">

                            <div class="info-label">
                                Danh mục
                            </div>

                            <div class="info-value">

                                <span class="category-badge">
                                    🏷 ${product.category.categoryName}
                                </span>

                            </div>

                        </div>


                        <!-- Price -->
                        <div class="info-row">

                            <div class="info-label">
                                Giá
                            </div>

                            <div class="info-value">

                                <span class="price">
                                    ${product.price} VNĐ
                                </span>

                            </div>

                        </div>


                        <!-- Stock -->
                        <div class="info-row">

                            <div class="info-label">
                                Còn hàng
                            </div>

                            <div class="info-value">

                                <span class="amount">
                                    ${product.stock}
                                </span>

                            </div>

                        </div>

                    </div>

                    <c:choose>
                        <c:when test="${product.stock > 0}">
                            <form action="${pageContext.request.contextPath}/cart" method="post" style="display:flex;align-items:center;gap:10px;margin-top:20px;flex-wrap:wrap">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productId" value="${product.productId}">
                                <label for="quantity">Số lượng</label>
                                <input id="quantity" type="number" name="quantity" min="1" max="${product.stock}" value="1" required style="width:80px;padding:9px;border:1px solid #cbd5e1">
                                <button type="submit" style="padding:10px 14px;border:0;background:#0f766e;color:#fff;cursor:pointer">Thêm vào giỏ</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <p style="margin-top:20px;color:#b91c1c">Sản phẩm hiện đã hết hàng.</p>
                        </c:otherwise>
                    </c:choose>


                    <!-- Description -->
                    <div class="description-box">

                        <div class="description-title">
                            📝 Mô tả sản phẩm
                        </div>

                        <p class="description">
                            <c:choose>

                                <c:when test="${not empty product.description}">
                                    ${product.description}
                                </c:when>

                                <c:otherwise>
                                    Chưa có mô tả cho sản phẩm này.
                                </c:otherwise>

                            </c:choose>
                        </p>

                    </div>

                </div>

            </div>


            <!-- Back -->
            <div class="back-wrapper">

                <a
                    class="back-btn"
                    href="${pageContext.request.contextPath}/products">

                    ← Quay lại danh sách sản phẩm

                </a>

            </div>

        </c:when>


        <c:otherwise>

            <div class="not-found">

                <div class="not-found-icon">
                    📦
                </div>

                <h3>Không tìm thấy sản phẩm</h3>

                <p>
                    Sản phẩm bạn đang tìm kiếm không tồn tại hoặc đã bị xóa.
                </p>

                <div class="back-wrapper">

                    <a
                        class="back-btn"
                        href="${pageContext.request.contextPath}/products">

                        ← Quay lại danh sách

                    </a>

                </div>

            </div>

        </c:otherwise>

    </c:choose>

</div>


<%@ include file="footer.jsp" %>