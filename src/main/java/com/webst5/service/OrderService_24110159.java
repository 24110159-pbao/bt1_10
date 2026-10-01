package com.webst5.service;

import com.webst5.entity.CartItem_24110159;
import com.webst5.entity.Cart_24110159;
import com.webst5.entity.OrderItem_24110159;
import com.webst5.entity.Order_24110159;
import com.webst5.entity.Product_24110159;
import com.webst5.entity.User_24110159;
import com.webst5.util.JPAUtil_24110159;
import jakarta.persistence.EntityManager;
import jakarta.persistence.LockModeType;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

public class OrderService_24110159 {
    public Order_24110159 placeCodOrder(
            Integer userId, String receiverName, String receiverPhone, String shippingAddress) {
        String name = receiverName == null ? "" : receiverName.trim();
        String phone = receiverPhone == null ? "" : receiverPhone.trim();
        String address = shippingAddress == null ? "" : shippingAddress.trim();
        if (name.isEmpty() || phone.isEmpty() || address.isEmpty()) {
            throw new IllegalArgumentException("Vui lòng nhập đầy đủ thông tin nhận hàng.");
        }
        if (name.length() > 100 || phone.length() > 20 || address.length() > 500) {
            throw new IllegalArgumentException("Thông tin nhận hàng vượt quá độ dài cho phép.");
        }

        EntityManager em = JPAUtil_24110159.getEntityManager();
        try {
            em.getTransaction().begin();
            List<Cart_24110159> carts = em.createQuery(
                    "select c from Cart_24110159 c where c.user.userId = :userId and c.status = 0",
                    Cart_24110159.class)
                    .setParameter("userId", userId)
                    .setMaxResults(1)
                    .setLockMode(LockModeType.PESSIMISTIC_WRITE)
                    .getResultList();
            if (carts.isEmpty()) throw new IllegalArgumentException("Giỏ hàng đang trống.");
            Cart_24110159 cart = carts.get(0);

            List<CartItem_24110159> items = em.createQuery(
                    "select i from CartItem_24110159 i join fetch i.product " +
                            "where i.cart.cartId = :cartId",
                    CartItem_24110159.class)
                    .setParameter("cartId", cart.getCartId())
                    .getResultList();
            if (items.isEmpty()) throw new IllegalArgumentException("Giỏ hàng đang trống.");

            Order_24110159 order = new Order_24110159();
            order.setOrderId(UUID.randomUUID().toString());
            order.setUser(em.getReference(User_24110159.class, userId));
            order.setReceiverName(name);
            order.setReceiverPhone(phone);
            order.setShippingAddress(address);
            order.setOrderDate(LocalDateTime.now());
            order.setPaymentMethod("COD");
            order.setPaymentStatus("UNPAID");
            order.setStatus("PENDING");
            order.setTotalAmount(BigDecimal.ZERO);
            em.persist(order);

            BigDecimal total = BigDecimal.ZERO;
            for (CartItem_24110159 cartItem : items) {
                Product_24110159 product = em.find(
                        Product_24110159.class,
                        cartItem.getProduct().getProductId(),
                        LockModeType.PESSIMISTIC_WRITE);
                int quantity = cartItem.getQuantity() == null ? 0 : cartItem.getQuantity();
                int stock = product == null || product.getStock() == null ? 0 : product.getStock();
                if (product == null || quantity < 1 || quantity > stock) {
                    throw new IllegalArgumentException(
                            "Tồn kho của " + cartItem.getProduct().getProductName() +
                                    " đã thay đổi. Vui lòng kiểm tra lại giỏ hàng.");
                }

                BigDecimal unitPrice = toMoney(cartItem.getUnitPrice());
                BigDecimal lineTotal = unitPrice.multiply(BigDecimal.valueOf(quantity));
                OrderItem_24110159 orderItem = new OrderItem_24110159();
                orderItem.setOrderItemId(UUID.randomUUID().toString());
                orderItem.setOrder(order);
                orderItem.setProduct(product);
                orderItem.setProductName(product.getProductName());
                orderItem.setUnitPrice(unitPrice);
                orderItem.setQuantity(quantity);
                orderItem.setLineTotal(lineTotal);
                em.persist(orderItem);

                product.setStock(stock - quantity);
                product.setAmount(stock - quantity);
                total = total.add(lineTotal);
            }

            order.setTotalAmount(total);
            cart.setStatus(1);
            cart.setBuyDate(LocalDateTime.now());
            em.getTransaction().commit();
            return order;
        } catch (RuntimeException e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Order_24110159 findForUser(String orderId, Integer userId) {
        EntityManager em = JPAUtil_24110159.getEntityManager();
        try {
            List<Order_24110159> orders = em.createQuery(
                    "select o from Order_24110159 o where o.orderId = :orderId " +
                            "and o.user.userId = :userId",
                    Order_24110159.class)
                    .setParameter("orderId", orderId)
                    .setParameter("userId", userId)
                    .setMaxResults(1)
                    .getResultList();
            return orders.isEmpty() ? null : orders.get(0);
        } finally {
            em.close();
        }
    }

    public List<Order_24110159> findAllForUser(Integer userId) {
        EntityManager em = JPAUtil_24110159.getEntityManager();
        try {
            return em.createQuery(
                    "select distinct o from Order_24110159 o " +
                            "left join fetch o.items " +
                            "where o.user.userId = :userId order by o.orderDate desc",
                    Order_24110159.class)
                    .setParameter("userId", userId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    private BigDecimal toMoney(Float value) {
        if (value == null || value < 0) {
            throw new IllegalArgumentException("Giá sản phẩm không hợp lệ.");
        }
        return new BigDecimal(Float.toString(value)).setScale(2, RoundingMode.HALF_UP);
    }
}