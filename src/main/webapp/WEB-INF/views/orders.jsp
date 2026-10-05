<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<style>
    /* ── Page layout ─────────────────────────────────── */
    .orders-page {
        max-width: 980px;
        margin: 0 auto;
    }

    .orders-page-head {
        margin-bottom: 24px;
    }

    .orders-page-head h1 {
        margin: 0 0 4px;
        font-size: 26px;
        font-weight: 800;
        color: #1e293b;
    }

    .orders-intro {
        margin: 0;
        color: #64748b;
        font-size: 14px;
    }

    /* ── Status tab bar ──────────────────────────────── */
    .status-tabs {
        display: flex;
        flex-wrap: wrap;
        gap: 6px;
        margin-bottom: 26px;
        padding: 6px;
        background: #ffffff;
        border: 1px solid #e2e8f0;
        border-radius: 14px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.04);
    }

    .status-tab {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 9px 16px;
        border-radius: 10px;
        font-size: 13px;
        font-weight: 600;
        text-decoration: none;
        color: #475569;
        transition: background 0.18s, color 0.18s, transform 0.15s;
        white-space: nowrap;
    }

    .status-tab:hover {
        background: #f1f5f9;
        color: #334155;
        transform: translateY(-1px);
    }

    .status-tab.active {
        color: #fff;
        transform: translateY(-1px);
        box-shadow: 0 3px 10px rgba(0,0,0,0.18);
    }

    .tab-all.active         { background: linear-gradient(135deg, #6366f1, #8b5cf6); }
    .tab-pending.active     { background: linear-gradient(135deg, #f59e0b, #d97706); }
    .tab-confirmed.active   { background: linear-gradient(135deg, #3b82f6, #2563eb); }
    .tab-preparing.active   { background: linear-gradient(135deg, #8b5cf6, #7c3aed); }
    .tab-shipping.active    { background: linear-gradient(135deg, #06b6d4, #0891b2); }
    .tab-delivering.active  { background: linear-gradient(135deg, #f97316, #ea580c); }
    .tab-delivered.active   { background: linear-gradient(135deg, #10b981, #059669); }
    .tab-cancelled.active   { background: linear-gradient(135deg, #ef4444, #dc2626); }
    .tab-returned.active    { background: linear-gradient(135deg, #ec4899, #db2777); }

    /* ── Order card ──────────────────────────────────── */
    .order-card {
        margin-bottom: 16px;
        background: #ffffff;
        border: 1px solid #e2e8f0;
        border-radius: 12px;
        overflow: hidden;
        transition: box-shadow 0.2s, transform 0.2s;
    }

    .order-card:hover {
        box-shadow: 0 6px 24px rgba(0,0,0,0.08);
        transform: translateY(-2px);
    }

    .order-card-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        gap: 16px;
        padding: 16px 20px;
        border-bottom: 1px solid #f1f5f9;
    }

    .order-card-title {
        font-size: 14px;
        font-weight: 700;
        color: #334155;
        margin: 0 0 4px;
    }

    .order-card-meta {
        font-size: 12px;
        color: #94a3b8;
    }

    .order-status-badge {
        display: inline-flex;
        align-items: center;
        gap: 5px;
        padding: 5px 13px;
        border-radius: 999px;
        font-size: 12px;
        font-weight: 700;
        white-space: nowrap;
        letter-spacing: 0.02em;
    }

    .badge-pending    { background: #fef3c7; color: #92400e; }
    .badge-confirmed  { background: #dbeafe; color: #1e40af; }
    .badge-preparing  { background: #ede9fe; color: #5b21b6; }
    .badge-shipping   { background: #cffafe; color: #164e63; }
    .badge-delivering { background: #ffedd5; color: #9a3412; }
    .badge-delivered  { background: #d1fae5; color: #065f46; }
    .badge-cancelled  { background: #fee2e2; color: #991b1b; }
    .badge-returned   { background: #fce7f3; color: #9d174d; }
    .badge-default    { background: #f1f5f9; color: #475569; }

    .order-items-table {
        width: 100%;
        border-collapse: collapse;
        font-size: 13px;
    }

    .order-items-table th {
        padding: 10px 20px;
        background: #f8fafc;
        color: #94a3b8;
        font-weight: 600;
        text-align: left;
        font-size: 12px;
        text-transform: uppercase;
        letter-spacing: 0.05em;
    }

    .order-items-table td {
        padding: 10px 20px;
        border-top: 1px solid #f1f5f9;
        color: #475569;
    }

    .order-items-table td:last-child,
    .order-items-table th:last-child { text-align: right; }

    .order-card-footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 12px;
        padding: 14px 20px;
        background: #f8fafc;
        font-size: 13px;
        color: #64748b;
    }

    .order-total {
        font-size: 16px;
        font-weight: 800;
        color: #059669;
    }

    .payment-tag {
        display: inline-flex;
        align-items: center;
        gap: 4px;
        padding: 3px 10px;
        background: #e0f2fe;
        color: #075985;
        border-radius: 6px;
        font-size: 12px;
        font-weight: 600;
    }

    .empty-orders {
        padding: 60px 20px;
        background: #fff;
        border: 1px solid #e2e8f0;
        border-radius: 12px;
        text-align: center;
        color: #94a3b8;
    }

    .empty-orders .empty-icon { font-size: 52px; margin-bottom: 14px; display: block; }
    .empty-orders p { margin: 0 0 16px; font-size: 16px; color: #64748b; }
    .empty-orders a {
        display: inline-block;
        padding: 10px 24px;
        background: linear-gradient(135deg, #6366f1, #8b5cf6);
        color: #fff;
        border-radius: 10px;
        font-weight: 600;
        font-size: 14px;
        text-decoration: none;
        transition: opacity 0.2s;
    }
    .empty-orders a:hover { opacity: 0.88; }

    @media (max-width: 620px) {
        .status-tabs { gap: 4px; padding: 4px; }
        .status-tab  { padding: 7px 11px; font-size: 12px; }
        .order-card-header { flex-direction: column; }
        .order-card-footer { flex-direction: column; align-items: flex-start; }
        .order-items-table th,
        .order-items-table td { padding: 8px 12px; font-size: 12px; }
    }
</style>

<section class="orders-page">

    <div class="orders-page-head">
        <h1>Lịch sử đặt hàng</h1>
        <p class="orders-intro">Theo dõi tất cả đơn hàng của bạn theo từng trạng thái.</p>
    </div>

    <nav class="status-tabs" aria-label="Lọc trạng thái đơn hàng">
        <a href="${pageContext.request.contextPath}/orders"
           class="status-tab tab-all ${empty currentStatus ? 'active' : ''}">
            🗂️ Tất cả
        </a>
        <a href="${pageContext.request.contextPath}/orders?status=PENDING"
           class="status-tab tab-pending ${'PENDING' == currentStatus ? 'active' : ''}">
            🕐 Đơn hàng mới
        </a>
        <a href="${pageContext.request.contextPath}/orders?status=CONFIRMED"
           class="status-tab tab-confirmed ${'CONFIRMED' == currentStatus ? 'active' : ''}">
            ✅ Đã xác nhận
        </a>
        <a href="${pageContext.request.contextPath}/orders?status=PREPARING"
           class="status-tab tab-preparing ${'PREPARING' == currentStatus ? 'active' : ''}">
            📦 Chuẩn bị hàng
        </a>
        <a href="${pageContext.request.contextPath}/orders?status=SHIPPING"
           class="status-tab tab-shipping ${'SHIPPING' == currentStatus ? 'active' : ''}">
            🚚 Vận chuyển
        </a>
        <a href="${pageContext.request.contextPath}/orders?status=DELIVERING"
           class="status-tab tab-delivering ${'DELIVERING' == currentStatus ? 'active' : ''}">
            🛵 Giao hàng
        </a>
        <a href="${pageContext.request.contextPath}/orders?status=DELIVERED"
           class="status-tab tab-delivered ${'DELIVERED' == currentStatus ? 'active' : ''}">
            🎉 Đã giao
        </a>
        <a href="${pageContext.request.contextPath}/orders?status=CANCELLED"
           class="status-tab tab-cancelled ${'CANCELLED' == currentStatus ? 'active' : ''}">
            ❌ Đã hủy
        </a>
        <a href="${pageContext.request.contextPath}/orders?status=RETURNED"
           class="status-tab tab-returned ${'RETURNED' == currentStatus ? 'active' : ''}">
            🔄 Hoàn hàng
        </a>
    </nav>

    <c:choose>
        <c:when test="${empty orders}">
            <div class="empty-orders">
                <span class="empty-icon">📋</span>
                <p>Không có đơn hàng nào trong mục này.</p>
                <a href="${pageContext.request.contextPath}/products">Tiếp tục mua sắm</a>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="order" items="${orders}">
                <article class="order-card">

                    <div class="order-card-header">
                        <div>
                            <p class="order-card-title">Mã đơn: <c:out value="${order.orderId}" /></p>
                            <span class="order-card-meta">
                                📅 <c:out value="${order.orderDate}" />
                                &nbsp;·&nbsp; 👤 <c:out value="${order.receiverName}" />
                                &nbsp;·&nbsp; 📞 <c:out value="${order.receiverPhone}" />
                            </span>
                        </div>

                        <c:choose>
                            <c:when test="${order.status == 'PENDING'}">
                                <span class="order-status-badge badge-pending">🕐 Đơn hàng mới</span>
                            </c:when>
                            <c:when test="${order.status == 'CONFIRMED'}">
                                <span class="order-status-badge badge-confirmed">✅ Đã xác nhận</span>
                            </c:when>
                            <c:when test="${order.status == 'PREPARING'}">
                                <span class="order-status-badge badge-preparing">📦 Chuẩn bị hàng</span>
                            </c:when>
                            <c:when test="${order.status == 'SHIPPING'}">
                                <span class="order-status-badge badge-shipping">🚚 Vận chuyển</span>
                            </c:when>
                            <c:when test="${order.status == 'DELIVERING'}">
                                <span class="order-status-badge badge-delivering">🛵 Giao hàng</span>
                            </c:when>
                            <c:when test="${order.status == 'DELIVERED'}">
                                <span class="order-status-badge badge-delivered">🎉 Đã giao</span>
                            </c:when>
                            <c:when test="${order.status == 'CANCELLED'}">
                                <span class="order-status-badge badge-cancelled">❌ Đã hủy</span>
                            </c:when>
                            <c:when test="${order.status == 'RETURNED'}">
                                <span class="order-status-badge badge-returned">🔄 Hoàn hàng</span>
                            </c:when>
                            <c:otherwise>
                                <span class="order-status-badge badge-default"><c:out value="${order.status}" /></span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <table class="order-items-table">
                        <thead>
                            <tr>
                                <th>Sản phẩm</th>
                                <th>SL</th>
                                <th>Đơn giá</th>
                                <th>Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${order.items}">
                                <tr>
                                    <td><c:out value="${item.productName}" /></td>
                                    <td><c:out value="${item.quantity}" /></td>
                                    <td><c:out value="${item.unitPrice}" /> VNĐ</td>
                                    <td><c:out value="${item.lineTotal}" /> VNĐ</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <div class="order-card-footer">
                        <span>📍 <c:out value="${order.shippingAddress}" /></span>
                        <div style="display:flex;align-items:center;gap:12px;flex-wrap:wrap">
                            <span class="payment-tag">
                                💳 COD · <c:out value="${order.paymentStatus}" />
                            </span>
                            <span class="order-total">
                                Tổng: <c:out value="${order.totalAmount}" /> VNĐ
                            </span>
                        </div>
                    </div>

                </article>
            </c:forEach>
        </c:otherwise>
    </c:choose>

</section>

<%@ include file="footer.jsp" %>