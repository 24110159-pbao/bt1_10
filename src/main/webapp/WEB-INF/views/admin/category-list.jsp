<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../header.jsp" %>

<style>
    .category-page {
        min-height: calc(100vh - 120px);
        padding: 40px 20px;
        background: #f5f7fb;
    }

    .category-container {
        max-width: 1200px;
        margin: 0 auto;
    }

    .category-card {
        background: #fff;
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

    /* Button */
    .btn-add {
        display: inline-flex;
        align-items: center;
        gap: 7px;
        padding: 11px 17px;
        border-radius: 10px;
        background: linear-gradient(135deg, #6366f1, #4f46e5);
        color: #fff;
        text-decoration: none;
        font-size: 14px;
        font-weight: 600;
        box-shadow: 0 5px 14px rgba(79, 70, 229, 0.22);
        transition: all 0.2s ease;
        white-space: nowrap;
    }

    .btn-add:hover {
        color: #fff;
        transform: translateY(-1px);
        box-shadow: 0 7px 18px rgba(79, 70, 229, 0.3);
    }

    /* Table */
    .table-wrapper {
        width: 100%;
        overflow-x: auto;
    }

    .category-table {
        width: 100%;
        border-collapse: collapse;
        min-width: 750px;
    }

    .category-table th {
        padding: 15px 20px;
        background: #f8fafc;
        color: #475569;
        font-size: 13px;
        font-weight: 700;
        text-align: left;
        border-bottom: 1px solid #e2e8f0;
        white-space: nowrap;
    }

    .category-table td {
        padding: 15px 20px;
        color: #334155;
        font-size: 14px;
        border-bottom: 1px solid #edf0f5;
        vertical-align: middle;
    }

    .category-table tbody tr {
        transition: background 0.15s ease;
    }

    .category-table tbody tr:hover {
        background: #fafbff;
    }

    .category-table tbody tr:last-child td {
        border-bottom: none;
    }

    /* ID */
    .category-id {
        color: #64748b;
        font-weight: 600;
    }

    /* Category name */
    .category-name {
        color: #1e293b;
        font-weight: 600;
    }

    /* Image */
    .category-image {
        width: 70px;
        height: 52px;
        object-fit: cover;
        border-radius: 8px;
        border: 1px solid #e2e8f0;
        background: #f8fafc;
    }

    .no-image {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 70px;
        height: 52px;
        border-radius: 8px;
        background: #f1f5f9;
        color: #94a3b8;
        font-size: 12px;
        border: 1px dashed #cbd5e1;
    }

    /* Status */
    .status {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 5px 10px;
        border-radius: 999px;
        font-size: 12px;
        font-weight: 600;
    }

    .status::before {
        content: "";
        width: 6px;
        height: 6px;
        border-radius: 50%;
        background: currentColor;
    }

    .status-active {
        color: #15803d;
        background: #dcfce7;
    }

    .status-inactive {
        color: #b91c1c;
        background: #fee2e2;
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
        text-align: center;
        padding: 45px 20px !important;
        color: #94a3b8 !important;
    }

    .empty-icon {
        display: block;
        font-size: 32px;
        margin-bottom: 8px;
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
        background: #fff;
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

    /* Bottom navigation */
    .bottom-navigation {
        margin-top: 20px;
        text-align: center;
    }

    .product-link {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        color: #4f46e5;
        text-decoration: none;
        font-size: 14px;
        font-weight: 600;
        transition: color 0.2s ease;
    }

    .product-link:hover {
        color: #3730a3;
        text-decoration: underline;
    }

    /* Mobile */
    @media (max-width: 700px) {
        .category-page {
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

        .category-table th,
        .category-table td {
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

<div class="category-page">
    <div class="category-container">

        <div class="category-card">

            <!-- Header -->
            <div class="page-header">
                <div class="page-title">
                    <h2>Quản lý Category</h2>
                    <p>Quản lý danh mục sản phẩm trong hệ thống</p>
                </div>

                <a class="btn-add"
                   href="${pageContext.request.contextPath}/admin/categories?action=edit&id=0">
                    <span>＋</span>
                    Thêm Category
                </a>
            </div>

            <!-- Table -->
            <div class="table-wrapper">
                <table class="category-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên Category</th>
                        <th>Hình ảnh</th>
                        <th>Status</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:choose>

                        <c:when test="${not empty categories}">
                            <c:forEach var="c" items="${categories}">
                                <tr>

                                    <td>
                                        <span class="category-id">
                                            #${c.categoryId}
                                        </span>
                                    </td>

                                    <td>
                                        <span class="category-name">
                                            ${c.categoryName}
                                        </span>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty c.images}">
                                                <img
                                                    class="category-image"
                                                    src="${pageContext.request.contextPath}${c.images}"
                                                    alt="${c.categoryName}">
                                            </c:when>

                                            <c:otherwise>
                                                <span class="no-image">
                                                    No image
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${c.status == 1 || c.status == true || c.status == 'ACTIVE'}">
                                                <span class="status status-active">
                                                    Active
                                                </span>
                                            </c:when>

                                            <c:otherwise>
                                                <span class="status status-inactive">
                                                    Inactive
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <div class="actions">

                                            <a class="action-btn edit-btn"
                                               href="${pageContext.request.contextPath}/admin/categories?action=edit&id=${c.categoryId}">
                                                ✏ Sửa
                                            </a>

                                            <a class="action-btn delete-btn"
                                               href="${pageContext.request.contextPath}/admin/categories?action=delete&id=${c.categoryId}"
                                               onclick="return confirm('Bạn có chắc muốn xóa Category này không?')">
                                                🗑 Xóa
                                            </a>

                                        </div>
                                    </td>

                                </tr>
                            </c:forEach>
                        </c:when>

                        <c:otherwise>
                            <tr>
                                <td colspan="5" class="empty-row">
                                    <span class="empty-icon">📂</span>
                                    Chưa có Category nào.
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

                        <c:forEach begin="0"
                                   end="${totalPages - 1}"
                                   var="i">

                            <a href="${pageContext.request.contextPath}/admin/categories?page=${i}"
                               class="${i == currentPage ? 'active' : ''}">
                                ${i + 1}
                            </a>

                        </c:forEach>

                    </div>
                </div>
            </c:if>

        </div>

        <!-- Product navigation -->
        <div class="bottom-navigation">
            <a class="product-link"
               href="${pageContext.request.contextPath}/admin/products">
                📦 Quản lý Product →
            </a>
        </div>

    </div>
</div>

<%@ include file="../footer.jsp" %>