<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<style>
    .orders-page { max-width: 960px; margin: 0 auto; }
    .orders-page h1 { margin: 0 0 6px; color: #1e293b; font-size: 26px; }
    .orders-intro { margin: 0 0 24px; color: #64748b; }
    .order-invoice { margin-bottom: 18px; padding: 20px; background: #fff; border: 1px solid #e2e8f0; border-radius: 8px; }
    .invoice-heading { display: flex; justify-content: space-between; gap: 16px; padding-bottom: 14px; border-bottom: 1px solid #e2e8f0; }
    .invoice-heading h2 { margin: 0 0 6px; color: #334155; font-size: 16px; overflow-wrap: anywhere; }
    .invoice-meta { color: #64748b; font-size: 13px; }
    .invoice-status { text-align: right; color: #166534; font-size: 13px; font-weight: 700; }
    .invoice-status span { display: block; margin-top: 5px; color: #64748b; font-weight: 500; }
    .invoice-items { width: 100%; margin-top: 12px; border-collapse: collapse; }
    .invoice-items th, .invoice-items td { padding: 10px 6px; border-bottom: 1px solid #f1f5f9; text-align: left; font-size: 13px; }
    .invoice-items th { color: #64748b; font-weight: 600; }
    .invoice-items td:last-child, .invoice-items th:last-child { text-align: right; }
    .invoice-footer { display: flex; justify-content: space-between; gap: 14px; padding-top: 14px; color: #475569; font-size: 13px; }
    .invoice-total { color: #166534; font-size: 16px; font-weight: 700; white-space: nowrap; }
    .empty-orders { padding: 48px 20px; background: #fff; border: 1px solid #e2e8f0; border-radius: 8px; text-align: center; color: #64748b; }
    .empty-orders a { display: inline-block; margin-top: 12px; color: #166534; }
    @media (max-width: 600px) {
        .order-invoice { padding: 14px; }
        .invoice-heading, .invoice-footer { flex-direction: column; }
        .invoice-status { text-align: left; }
        .invoice-items th, .invoice-items td { padding: 8px 3px; font-size: 12px; }
    }
</style>

<section class="orders-page">
    <h1>Hóa đơn đã đặt</h1>
    <p class="orders-intro">Danh sách đơn hàng và thông tin thanh toán khi nhận hàng.</p>
    <c:choose>
        <c:when test="${empty orders}">
            <div class="empty-orders">
                <p>Bạn chưa có đơn hàng nào.</p>
                <a href="${pageContext.request.contextPath}/products">Tiếp tục mua sắm</a>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="order" items="${orders}">
                <article class="order-invoice">
                    <div class="invoice-heading">
                        <div>
                            <h2>Mã đơn: <c:out value="${order.orderId}" /></h2>
                            <div class="invoice-meta">
                                Ngày đặt: <c:out value="${order.orderDate}" />
                                · Người nhận: <c:out value="${order.receiverName}" />
                                · <c:out value="${order.receiverPhone}" />
                            </div>
                        </div>
                        <div class="invoice-status">
                            <c:out value="${order.status}" />
                            <span>COD · <c:out value="${order.paymentStatus}" /></span>
                        </div>
                    </div>
                    <table class="invoice-items">
                        <thead>
                        <tr><th>Sản phẩm</th><th>SL</th><th>Đơn giá</th><th>Thành tiền</th></tr>
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
                    <div class="invoice-footer">
                        <span>Giao đến: <c:out value="${order.shippingAddress}" /></span>
                        <span class="invoice-total">Tổng: <c:out value="${order.totalAmount}" /> VNĐ</span>
                    </div>
                </article>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</section>

<%@ include file="footer.jsp" %>