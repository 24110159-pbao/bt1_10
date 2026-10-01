<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../header.jsp" %>

<style>
    .product-page {
        min-height: calc(100vh - 120px);
        padding: 40px 20px;
        background: #f5f7fb;
    }

    .product-container {
        max-width: 1200px;
        margin: 0 auto;
    }

    .product-card {
        background: #ffffff;
        border: 1px solid #e9edf5;
        border-radius: 18px;
        box-shadow: 0 8px 30px rgba(15, 23, 42, 0.07);
        overflow: hidden;
    }

    /* Header */
    .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 20px;
        padding: 28px 30px;
        border-bottom: 1px solid #edf0f5;
    }

    .page-title h2 {
        margin: 0 0 6px;
        color: #1e293b;
        font-size: 26px;
        font-weight: 700;
    }

    .page-title p {
        margin: 0;
        color: #64748b;
        font-size: 14px;
    }

    /* Add button */
    .btn-add {
        display: inline-flex;
        align-items: center;
        gap: 7px;
        padding: 11px 17px;
        border-radius: 10px;
        background: linear-gradient(135deg, #6366f1, #4f46e5);
        color: #ffffff;
        text-decoration: none;
        font-size: 14px;
        font-weight: 600;
        white-space: nowrap;
        box-shadow: 0 5px 14px rgba(79, 70, 229, 0.22);
        transition: all 0.2s ease;
    }

    .btn-add:hover {
        color: #ffffff;
        transform: translateY(-1px);
        box-shadow: 0 7px 18px rgba(79, 70, 229, 0.3);
    }

    /* Table */
    .table-wrapper {
        width: 100%;
        overflow-x: auto;
    }

    .product-table {
        width: 100%;
        min-width: 850px;
        border-collapse: collapse;
    }

    .product-table th {
        padding: 15px 20px;
        background: #f8fafc;
        color: #475569;
        font-size: 13px;
        font-weight: 700;
        text-align: left;
        white-space: nowrap;
        border-bottom: 1px solid #e2e8f0;
    }

    .product-table td {
        padding: 15px 20px;
        color: #334155;
        font-size: 14px;
        vertical-align: middle;
        border-bottom: 1px solid #edf0f5;
    }

    .product-table tbody tr {
        transition: background 0.15s ease;
    }

    .product-table tbody tr:hover {
        background: #fafbff;
    }

    .product-table tbody tr:last-child td {
        border-bottom: none;
    }

    /* ID */
    .product-id {
        color: #64748b;
        font-weight: 600;
    }

    /* Product Image */
    .product-thumb {
        width: 60px;
        height: 60px;
        object-fit: cover;
        border-radius: 8px;
        border: 1px solid #e2e8f0;
        background: #f8fafc;
        display: block;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    .product-thumb:hover {
        transform: scale(1.1);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.12);
    }

    .no-image {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 60px;
        height: 60px;
        border-radius: 8px;
        background: #f1f5f9;
        color: #94a3b8;
        font-size: 11px;
        font-weight: 500;
        border: 1px dashed #cbd5e1;
        text-align: center;
    }

    /* Product name */
    .product-name {
        color: #1e293b;
        font-weight: 600;
    }

    /* Category */
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

    /* Price */
    .price {
        color: #4f46e5;
        font-weight: 700;
        white-space: nowrap;
    }

    /* Amount */
    .amount-badge {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        min-width: 45px;
        padding: 5px 9px;
        border-radius: 7px;
        background: #ecfdf5;
        color: #047857;
        font-size: 12px;
        font-weight: 700;
    }

    /* Actions */
    .actions {
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .action-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 7px 11px;
        border-radius: 7px;
        text-decoration: none;
        font-size: 13px;
        font-weight: 600;
        transition: all 0.2s ease;
    }

    .edit-btn {
        color: #4f46e5;
        background: #eef2ff;
    }

    .edit-btn:hover {
        color: #4338ca;
        background: #e0e7ff;
    }

    .delete-btn {
        color: #dc2626;
        background: #fef2f2;
    }

    .delete-btn:hover {
        color: #b91c1c;
        background: #fee2e2;
    }

    /* Empty */
    .empty-row {
        padding: 45px 20px !important;
        text-align: center;
        color: #94a3b8 !important;
    }

    .empty-icon {
        display: block;
        margin-bottom: 8px;
        font-size: 32px;
    }

    /* Pagination */
    .pagination-wrapper {
        display: flex;
        justify-content: center;
        padding: 24px 20px;
        border-top: 1px solid #edf0f5;
    }

    .pagination {
        display: flex;
        align-items: center;
        gap: 6px;
        margin: 0;
    }

    .pagination a {
        display: flex;
        align-items: center;
        justify-content: center;
        min-width: 36px;
        height: 36px;
        padding: 0 10px;
        box-sizing: border-box;
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
        color: #4f46e5;
        border-color: #c7d2fe;
        background: #eef2ff;
    }

    /* Responsive */
    @media (max-width: 700px) {
        .product-page {
            padding: 20px 12px;
        }

        .page-header {
            flex-direction: column;
            align-items: stretch;
            padding: 22px 18px;
        }

        .page-title h2 {
            font-size: 22px;
        }

        .btn-add {
            justify-content: center;
        }

        .product-table th,
        .product-table td {
            padding: 12px 14px;
        }

        .actions {
            flex-direction: column;
            align-items: stretch;
        }

        .action-btn {
            text-align: center;
        }
    }
</style>

<div class="product-page">
    <div class="product-container">

        <div class="product-card">

            <!-- Header -->
            <div class="page-header">
                <div class="page-title">
                    <h2>Quản lý Product</h2>
                    <p>Quản lý danh sách sản phẩm trong hệ thống</p>
                </div>

                <a class="btn-add"
                   href="${pageContext.request.contextPath}/admin/products?action=edit&id=0">
                    <span>＋</span>
                    Thêm Product
                </a>
            </div>


            <!-- Table -->
            <div class="table-wrapper">

                <table class="product-table">

                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Hình ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th>Danh mục</th>
                        <th>Giá</th>
                        <th>Tồn kho</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>


                    <tbody>

                    <c:choose>

                        <c:when test="${not empty products}">

                            <c:forEach var="p" items="${products}">

                                <tr>

                                    <!-- ID -->
                                    <td>
                                        <span class="product-id">
                                            #${p.productId}
                                        </span>
                                    </td>


                                    <!-- Image -->
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty p.images}">
                                                <img class="product-thumb"
                                                     src="${p.images.startsWith('http') ? p.images : (pageContext.request.contextPath).concat(p.images)}"
                                                     alt="${p.productName}">
                                            </c:when>
                                            <c:otherwise>
                                                <span class="no-image">No image</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>


                                    <!-- Product name -->
                                    <td>
                                        <span class="product-name">
                                            ${p.productName}
                                        </span>
                                    </td>


                                    <!-- Category -->
                                    <td>
                                        <span class="category-badge">
                                            🏷 ${p.category.categoryName}
                                        </span>
                                    </td>


                                    <!-- Price -->
                                    <td>
                                        <span class="price">
                                            ${p.price} VNĐ
                                        </span>
                                    </td>


                                    <!-- Inventory -->
                                    <td>
                                        <span class="amount-badge">
                                            ${p.stock != null ? p.stock : p.amount}
                                        </span>
                                    </td>


                                    <!-- Actions -->
                                    <td>

                                        <div class="actions">

                                            <a class="action-btn edit-btn"
                                               href="${pageContext.request.contextPath}/admin/products?action=edit&id=${p.productId}">
                                                ✏ Sửa
                                            </a>

                                            <a class="action-btn delete-btn"
                                               href="${pageContext.request.contextPath}/admin/products?action=delete&id=${p.productId}"
                                               onclick="return confirm('Bạn có chắc muốn xóa Product này không?')">
                                                🗑 Xóa
                                            </a>

                                        </div>

                                    </td>

                                </tr>

                            </c:forEach>

                        </c:when>


                        <c:otherwise>

                            <tr>
                                <td colspan="7" class="empty-row">
                                    <span class="empty-icon">📦</span>
                                    Chưa có Product nào.
                                </td>
                            </tr>

                        </c:otherwise>

                    </c:choose>

                    </tbody>

                </table>

            </div>


            <!-- Pagination -->
            <c:if test="${totalPages > 1}">

                <div class="pagination-wrapper">

                    <div class="pagination">

                        <c:forEach
                            begin="0"
                            end="${totalPages - 1}"
                            var="i">

                            <a href="${pageContext.request.contextPath}/admin/products?page=${i}">
                                ${i + 1}
                            </a>

                        </c:forEach>

                    </div>

                </div>

            </c:if>

        </div>

    </div>
</div>

<%@ include file="../footer.jsp" %>