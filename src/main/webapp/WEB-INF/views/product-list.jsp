<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<style>
    .products-page {
        padding: 15px 0 40px;
    }

    /* Header */
    .products-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
        margin-bottom: 28px;
        gap: 20px;
    }

    .products-header h2 {
        margin: 0 0 7px;
        color: #1e293b;
        font-size: 28px;
        font-weight: 700;
    }

    .products-header p {
        margin: 0;
        color: #64748b;
        font-size: 14px;
    }

    .product-count {
        padding: 7px 12px;
        border-radius: 999px;
        background: #eef2ff;
        color: #4f46e5;
        font-size: 12px;
        font-weight: 700;
        white-space: nowrap;
    }

    /* Product grid */
    .products-grid {
        display: grid;
        grid-template-columns: repeat(3, minmax(0, 1fr));
        gap: 22px;
    }

    /* Product card */
    .product-card {
        display: flex;
        flex-direction: column;

        overflow: hidden;

        background: #ffffff;
        border: 1px solid #e9edf5;
        border-radius: 16px;

        box-shadow: 0 5px 20px rgba(15, 23, 42, 0.06);

        transition: transform 0.2s ease,
                    box-shadow 0.2s ease,
                    border-color 0.2s ease;
    }

    .product-card:hover {
        transform: translateY(-4px);
        border-color: #d8dcf5;
        box-shadow: 0 12px 28px rgba(15, 23, 42, 0.10);
    }

    /* Image */
    .image-box {
        position: relative;

        display: flex;
        align-items: center;
        justify-content: center;

        height: 235px;
        padding: 15px;

        background: #f8fafc;
        border-bottom: 1px solid #edf0f5;
    }

    .image-box img {
        width: 100%;
        height: 100%;
        object-fit: contain;

        border-radius: 8px;

        transition: transform 0.25s ease;
    }

    .product-card:hover .image-box img {
        transform: scale(1.03);
    }

    .no-image {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;

        width: 100%;
        height: 100%;

        color: #94a3b8;
        font-size: 13px;
    }

    .no-image-icon {
        margin-bottom: 8px;
        font-size: 40px;
    }

    /* Product content */
    .product-info {
        display: flex;
        flex-direction: column;
        flex: 1;

        padding: 20px;
    }

    .product-category {
        display: inline-flex;
        align-items: center;

        width: fit-content;
        margin-bottom: 10px;
        padding: 5px 9px;

        border-radius: 6px;

        background: #f1f5f9;
        color: #475569;

        font-size: 11px;
        font-weight: 700;
    }

    .product-name {
        margin: 0 0 8px;

        min-height: 44px;

        color: #1e293b;
        font-size: 17px;
        line-height: 1.4;
        font-weight: 700;
    }

    .product-name a {
        color: inherit;
        text-decoration: none;

        transition: color 0.2s ease;
    }

    .product-name a:hover {
        color: #4f46e5;
    }

    .product-code {
        margin-bottom: 16px;

        color: #94a3b8;
        font-size: 12px;
    }

    /* Price */
    .product-price {
        margin-top: auto;
        padding-top: 14px;

        border-top: 1px solid #edf0f5;
    }

    .price-label {
        display: block;
        margin-bottom: 3px;

        color: #94a3b8;
        font-size: 11px;
        font-weight: 600;
    }

    .price {
        color: #4f46e5;
        font-size: 19px;
        font-weight: 800;
    }

    /* Bottom */
    .product-bottom {
        display: flex;
        justify-content: space-between;
        align-items: center;

        margin-top: 14px;
        gap: 10px;
    }

    .amount {
        display: inline-flex;
        align-items: center;
        gap: 5px;

        padding: 5px 9px;

        border-radius: 7px;

        background: #ecfdf5;
        color: #047857;

        font-size: 11px;
        font-weight: 700;
    }

    .detail-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;

        padding: 7px 11px;

        border-radius: 7px;

        background: #eef2ff;
        color: #4f46e5;

        text-decoration: none;

        font-size: 12px;
        font-weight: 700;

        transition: all 0.2s ease;
    }

    .detail-btn:hover {
        background: #4f46e5;
        color: #ffffff;
    }

    /* Empty */
    .empty-products {
        padding: 65px 20px;

        background: #ffffff;
        border: 1px solid #e9edf5;
        border-radius: 16px;

        text-align: center;

        box-shadow: 0 5px 20px rgba(15, 23, 42, 0.05);
    }

    .empty-icon {
        margin-bottom: 12px;
        font-size: 48px;
    }

    .empty-products h3 {
        margin: 0 0 7px;

        color: #334155;
        font-size: 20px;
    }

    .empty-products p {
        margin: 0;

        color: #94a3b8;
        font-size: 14px;
    }

    /* Pagination */
    .pagination-wrapper {
        display: flex;
        justify-content: center;

        margin-top: 30px;
    }

    .pagination {
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .pagination a {
        display: flex;
        align-items: center;
        justify-content: center;

        min-width: 38px;
        height: 38px;
        padding: 0 10px;

        border: 1px solid #e2e8f0;
        border-radius: 8px;

        background: #ffffff;
        color: #475569;

        text-decoration: none;

        font-size: 13px;
        font-weight: 600;

        transition: all 0.2s ease;
    }

    .pagination a:hover {
        border-color: #c7d2fe;
        background: #eef2ff;
        color: #4f46e5;
    }

    /* Responsive */
    @media (max-width: 1000px) {
        .products-grid {
            grid-template-columns: repeat(2, minmax(0, 1fr));
        }
    }

    @media (max-width: 650px) {
        .products-page {
            padding-top: 5px;
        }

        .products-header {
            align-items: flex-start;
            flex-direction: column;
            margin-bottom: 20px;
        }

        .products-header h2 {
            font-size: 24px;
        }

        .products-grid {
            grid-template-columns: 1fr;
            gap: 16px;
        }

        .image-box {
            height: 240px;
        }

        .product-info {
            padding: 17px;
        }
    }
</style>


<div class="products-page">

    <!-- Page header -->
    <div class="products-header">

        <div>
            <h2>Danh sách sản phẩm</h2>
            <p>
                Khám phá các sản phẩm đang có trong hệ thống
            </p>
        </div>

        <c:if test="${not empty products}">
            <span class="product-count">
                ${products.size()} sản phẩm
            </span>
        </c:if>

    </div>


    <c:choose>

        <%-- Empty --%>
        <c:when test="${empty products}">

            <div class="empty-products">

                <div class="empty-icon">
                    📦
                </div>

                <h3>Chưa có sản phẩm</h3>

                <p>
                    Hiện tại chưa có sản phẩm nào trong hệ thống.
                </p>

            </div>

        </c:when>


        <%-- Products --%>
        <c:otherwise>

            <div class="products-grid">

                <c:forEach var="p" items="${products}">

                    <div class="product-card">

                        <%-- Image --%>
                        <div class="image-box">

                            <c:choose>

                                <c:when test="${not empty p.images}">

                                    <img
                                        src="${pageContext.request.contextPath}${p.images}"
                                        alt="${p.productName}">

                                </c:when>

                                <c:otherwise>

                                    <div class="no-image">

                                        <div class="no-image-icon">
                                            🖼️
                                        </div>

                                        <span>
                                            Chưa có hình ảnh
                                        </span>

                                    </div>

                                </c:otherwise>

                            </c:choose>

                        </div>


                        <%-- Information --%>
                        <div class="product-info">

                            <%-- Category --%>
                            <span class="product-category">
                                🏷 ${p.category.categoryName}
                            </span>


                            <%-- Name --%>
                            <h3 class="product-name">

                                <a
                                    href="${pageContext.request.contextPath}/products?id=${p.productId}">

                                    ${p.productName}

                                </a>

                            </h3>


                            <%-- Code --%>
                            <div class="product-code">
                                Mã sản phẩm: ${p.productCode}
                            </div>


                            <%-- Price --%>
                            <div class="product-price">

                                <span class="price-label">
                                    Giá bán
                                </span>

                                <span class="price">
                                    ${p.price} VNĐ
                                </span>

                            </div>


                            <%-- Bottom --%>
                            <div class="product-bottom">

                                <span class="amount">
                                    📦 Còn ${p.amount}
                                </span>

                                <a
                                    class="detail-btn"
                                    href="${pageContext.request.contextPath}/products?id=${p.productId}">

                                    Xem chi tiết →

                                </a>

                            </div>

                        </div>

                    </div>

                </c:forEach>

            </div>

        </c:otherwise>

    </c:choose>



    <!-- Pagination -->
    <c:if test="${empty sellerId and totalPages > 0}">

        <div class="pagination-wrapper">

            <div class="pagination">

                <c:forEach
                    begin="0"
                    end="${totalPages - 1}"
                    var="i">

                    <a
                        href="${pageContext.request.contextPath}/products?page=${i}">

                        ${i + 1}

                    </a>

                </c:forEach>

            </div>

        </div>

    </c:if>

</div>


<%@ include file="footer.jsp" %>