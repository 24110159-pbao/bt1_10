<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<style>
    .cart-page { max-width: 980px; margin: 0 auto; }
    .cart-page h1 { margin: 0 0 20px; color: #1e293b; font-size: 26px; }
    .notice { margin: 0 0 16px; padding: 12px 14px; border: 1px solid #fecaca; background: #fff1f2; color: #b91c1c; }
    .cart-table { width: 100%; border-collapse: collapse; background: #fff; }
    .cart-table th, .cart-table td { padding: 13px 12px; border-bottom: 1px solid #e5e7eb; text-align: left; }
    .cart-table th { color: #475569; font-size: 13px; }
    .cart-table td { color: #334155; }
    .cart-actions { display: flex; align-items: center; gap: 8px; }
    .cart-actions input { width: 76px; padding: 8px; border: 1px solid #cbd5e1; }
    .button { display: inline-block; padding: 9px 13px; border: 0; background: #0f766e; color: #fff; text-decoration: none; cursor: pointer; font: inherit; }
    .button.secondary { background: #475569; }
    .button.remove { padding: 8px 10px; background: #b91c1c; }
    .cart-summary { display: flex; align-items: center; justify-content: space-between; gap: 16px; margin-top: 20px; }
    .cart-total { color: #1e293b; font-size: 18px; font-weight: 700; }
    .empty-cart { padding: 28px 0; color: #64748b; }
    @media (max-width: 650px) {
        .cart-table th:nth-child(2), .cart-table td:nth-child(2) { display: none; }
        .cart-table th, .cart-table td { padding: 10px 6px; font-size: 13px; }
        .cart-actions { align-items: flex-start; flex-direction: column; }
        .cart-summary { align-items: flex-start; flex-direction: column; }
    }
</style>

<section class="cart-page">
    <h1>Giỏ hàng</h1>
    <c:if test="${not empty error}">
        <p class="notice"><c:out value="${error}" /></p>
    </c:if>
    <c:choose>
        <c:when test="${empty cartItems}">
            <p class="empty-cart">Giỏ hàng đang trống.</p>
            <a class="button secondary" href="${pageContext.request.contextPath}/products">Tiếp tục mua sắm</a>
        </c:when>
        <c:otherwise>
            <div style="overflow-x:auto">
                <table class="cart-table">
                    <thead><tr><th>Sản phẩm</th><th>Đơn giá</th><th>Số lượng</th><th>Tạm tính</th></tr></thead>
                    <tbody>
                    <c:forEach var="item" items="${cartItems}">
                        <tr>
                            <td><c:out value="${item.product.productName}" /></td>
                            <td><c:out value="${item.unitPrice}" /> VNĐ</td>
                            <td>
                                <div class="cart-actions">
                                    <form action="${pageContext.request.contextPath}/cart" method="post" class="cart-actions">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="itemId" value="${item.cartItemId}">
                                        <input type="number" name="quantity" min="1" max="${item.product.stock}" value="${item.quantity}" required aria-label="Số lượng">
                                        <button class="button secondary" type="submit">Cập nhật</button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/cart" method="post">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="itemId" value="${item.cartItemId}">
                                        <button class="button remove" type="submit">Xóa</button>
                                    </form>
                                </div>
                            </td>
                            <td><c:out value="${item.unitPrice * item.quantity}" /> VNĐ</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="cart-summary">
                <span class="cart-total">Tổng cộng: <c:out value="${cartTotal}" /> VNĐ</span>
                <div>
                    <a class="button secondary" href="${pageContext.request.contextPath}/products">Tiếp tục mua</a>
                    <a class="button" href="${pageContext.request.contextPath}/checkout">Thanh toán COD</a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</section>

<%@ include file="footer.jsp" %>