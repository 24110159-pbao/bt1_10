<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<style>
    .checkout-page { max-width: 900px; margin: 0 auto; }
    .checkout-page h1 { margin: 0 0 20px; color: #1e293b; font-size: 26px; }
    .checkout-grid { display: grid; grid-template-columns: minmax(0, 1.2fr) minmax(260px, .8fr); gap: 32px; }
    .checkout-page h2 { margin: 0 0 15px; color: #334155; font-size: 18px; }
    .checkout-field { margin-bottom: 15px; }
    .checkout-field label { display: block; margin-bottom: 6px; color: #475569; font-weight: 600; }
    .checkout-field input, .checkout-field textarea { box-sizing: border-box; width: 100%; padding: 10px 11px; border: 1px solid #cbd5e1; font: inherit; }
    .checkout-field textarea { min-height: 90px; resize: vertical; }
    .checkout-lines { padding: 0; margin: 0; list-style: none; }
    .checkout-lines li { display: flex; justify-content: space-between; gap: 12px; padding: 9px 0; border-bottom: 1px solid #e5e7eb; }
    .checkout-total { margin-top: 14px; color: #1e293b; font-weight: 700; }
    .notice { margin: 0 0 16px; padding: 12px 14px; border: 1px solid #fecaca; background: #fff1f2; color: #b91c1c; }
    .button { display: inline-block; padding: 10px 14px; border: 0; background: #0f766e; color: #fff; text-decoration: none; cursor: pointer; font: inherit; }
    .empty-checkout { padding: 20px 0; color: #64748b; }
    @media (max-width: 700px) { .checkout-grid { grid-template-columns: 1fr; gap: 25px; } }
</style>

<section class="checkout-page">
    <h1>Thanh toán đơn hàng</h1>
    <c:if test="${not empty error}">
        <p class="notice"><c:out value="${error}" /></p>
    </c:if>
    <c:choose>
        <c:when test="${empty cartItems}">
            <p class="empty-checkout">Giỏ hàng đang trống, chưa thể đặt hàng.</p>
            <a class="button" href="${pageContext.request.contextPath}/products">Xem sản phẩm</a>
        </c:when>
        <c:otherwise>
            <div class="checkout-grid">
                <form action="${pageContext.request.contextPath}/checkout" method="post">
                    <h2>Thông tin nhận hàng</h2>
                    <div class="checkout-field">
                        <label for="receiverName">Người nhận</label>
                        <input id="receiverName" name="receiverName" maxlength="100" value="<c:out value='${receiverName}'/>" required>
                    </div>
                    <div class="checkout-field">
                        <label for="receiverPhone">Số điện thoại</label>
                        <input id="receiverPhone" name="receiverPhone" maxlength="20" value="<c:out value='${receiverPhone}'/>" required>
                    </div>
                    <div class="checkout-field">
                        <label for="shippingAddress">Địa chỉ nhận hàng</label>
                        <textarea id="shippingAddress" name="shippingAddress" maxlength="500" required><c:out value="${shippingAddress}" /></textarea>
                    </div>
                    <div class="checkout-field">
                        <label>Phương thức thanh toán</label>
                        <input value="Thanh toán khi nhận hàng (COD)" readonly>
                    </div>
                    <button class="button" type="submit">Đặt hàng COD</button>
                </form>
                <aside>
                    <h2>Đơn hàng</h2>
                    <ul class="checkout-lines">
                        <c:forEach var="item" items="${cartItems}">
                            <li>
                                <span><c:out value="${item.product.productName}" /> × ${item.quantity}</span>
                                <span><c:out value="${item.unitPrice * item.quantity}" /> VNĐ</span>
                            </li>
                        </c:forEach>
                    </ul>
                    <p class="checkout-total">Tổng cộng: <c:out value="${cartTotal}" /> VNĐ</p>
                </aside>
            </div>
        </c:otherwise>
    </c:choose>
</section>

<%@ include file="footer.jsp" %>