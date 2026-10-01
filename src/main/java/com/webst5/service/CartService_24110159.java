package com.webst5.service;

import com.webst5.entity.CartItem_24110159;
import com.webst5.entity.Cart_24110159;
import com.webst5.entity.Product_24110159;
import com.webst5.util.JPAUtil_24110159;
import jakarta.persistence.EntityManager;
import jakarta.persistence.LockModeType;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

public class CartService_24110159 {
    private static final int OPEN = 0;

    public List<CartItem_24110159> getItems(Integer userId) {
        EntityManager em = JPAUtil_24110159.getEntityManager();
        try {
            Cart_24110159 cart = findOpenCart(em, userId, false);
            if (cart == null) return List.of();
            return em.createQuery(
                    "select i from CartItem_24110159 i join fetch i.product " +
                            "where i.cart.cartId = :cartId order by i.cartItemId",
                    CartItem_24110159.class)
                    .setParameter("cartId", cart.getCartId())
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public void add(Integer userId, Integer productId, int quantity) {
        if (quantity < 1) throw new IllegalArgumentException("Số lượng phải lớn hơn 0.");

        EntityManager em = JPAUtil_24110159.getEntityManager();
        try {
            em.getTransaction().begin();
            Product_24110159 product = em.find(
                    Product_24110159.class, productId, LockModeType.PESSIMISTIC_WRITE);
            validateProduct(product, quantity);

            Cart_24110159 cart = findOpenCart(em, userId, true);
            if (cart == null) {
                cart = new Cart_24110159();
                cart.setCartId(UUID.randomUUID().toString());
                cart.setUser(em.getReference(com.webst5.entity.User_24110159.class, userId));
                cart.setStatus(OPEN);
                em.persist(cart);
            }

            List<CartItem_24110159> matches = em.createQuery(
                    "select i from CartItem_24110159 i where i.cart.cartId = :cartId " +
                            "and i.product.productId = :productId",
                    CartItem_24110159.class)
                    .setParameter("cartId", cart.getCartId())
                    .setParameter("productId", productId)
                    .setMaxResults(1)
                    .getResultList();

            CartItem_24110159 item;
            int newQuantity = quantity;
            if (matches.isEmpty()) {
                item = new CartItem_24110159();
                item.setCartItemId(UUID.randomUUID().toString());
                item.setCart(cart);
                item.setProduct(product);
            } else {
                item = matches.get(0);
                newQuantity += item.getQuantity() == null ? 0 : item.getQuantity();
            }
            validateProduct(product, newQuantity);
            item.setQuantity(newQuantity);
            item.setUnitPrice(product.getPrice());
            if (matches.isEmpty()) em.persist(item);
            em.getTransaction().commit();
        } catch (RuntimeException e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void updateQuantity(Integer userId, String itemId, int quantity) {
        if (quantity < 1) throw new IllegalArgumentException("Số lượng phải lớn hơn 0.");

        EntityManager em = JPAUtil_24110159.getEntityManager();
        try {
            em.getTransaction().begin();
            CartItem_24110159 item = findOwnedItem(em, userId, itemId);
            if (item == null) throw new IllegalArgumentException("Không tìm thấy sản phẩm trong giỏ.");

            Product_24110159 product = em.find(
                    Product_24110159.class,
                    item.getProduct().getProductId(),
                    LockModeType.PESSIMISTIC_WRITE);
            validateProduct(product, quantity);
            item.setQuantity(quantity);
            item.setUnitPrice(product.getPrice());
            em.getTransaction().commit();
        } catch (RuntimeException e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void remove(Integer userId, String itemId) {
        EntityManager em = JPAUtil_24110159.getEntityManager();
        try {
            em.getTransaction().begin();
            CartItem_24110159 item = findOwnedItem(em, userId, itemId);
            if (item != null) em.remove(item);
            em.getTransaction().commit();
        } catch (RuntimeException e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    private Cart_24110159 findOpenCart(EntityManager em, Integer userId, boolean lock) {
        var query = em.createQuery(
                "select c from Cart_24110159 c where c.user.userId = :userId and c.status = :status",
                Cart_24110159.class)
                .setParameter("userId", userId)
                .setParameter("status", OPEN)
                .setMaxResults(1);
        if (lock) query.setLockMode(LockModeType.PESSIMISTIC_WRITE);
        List<Cart_24110159> carts = query.getResultList();
        return carts.isEmpty() ? null : carts.get(0);
    }

    private CartItem_24110159 findOwnedItem(EntityManager em, Integer userId, String itemId) {
        List<CartItem_24110159> items = em.createQuery(
                "select i from CartItem_24110159 i join fetch i.cart c " +
                        "join fetch i.product where i.cartItemId = :itemId " +
                        "and c.user.userId = :userId and c.status = :status",
                CartItem_24110159.class)
                .setParameter("itemId", itemId)
                .setParameter("userId", userId)
                .setParameter("status", OPEN)
                .setMaxResults(1)
                .getResultList();
        return items.isEmpty() ? null : items.get(0);
    }

    private void validateProduct(Product_24110159 product, int quantity) {
        if (product == null) throw new IllegalArgumentException("Sản phẩm không tồn tại.");
        int stock = product.getStock() == null ? 0 : product.getStock();
        if (quantity > stock) {
            throw new IllegalArgumentException("Số lượng vượt quá tồn kho hiện tại (" + stock + ").");
        }
    }
}