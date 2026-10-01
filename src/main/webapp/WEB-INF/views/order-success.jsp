<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<section style="max-width:680px;margin:0 auto;padding:20px 0">
    <h1 style="margin:0 0 12px;color:#166534">Đặt hàng thành công</h1>
    <p>Mã đơn hàng: <strong><c:out value="${order.orderId}" /></strong></p>
    <p>Người nhận: <c:out value="${order.receiverName}" /></p>
    <p>Số điện thoại: <c:out value="${order.receiverPhone}" /></p>
    <p>Địa chỉ: <c:out value="${order.shippingAddress}" /></p>
    <p>Thanh toán: COD, thu tiền khi giao hàng.</p>
    <p>Trạng thái: <c:out value="${order.status}" /> · Thanh toán <c:out value="${order.paymentStatus}" /></p>
    <p><strong>Tổng tiền: <c:out value="${order.totalAmount}" /> VNĐ</strong></p>
    <a href="${pageContext.request.contextPath}/products">Tiếp tục mua sắm</a>
</section>

<%@ include file="footer.jsp" %>