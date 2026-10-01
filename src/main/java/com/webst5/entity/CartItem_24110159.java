package com.webst5.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "CartItem")
public class CartItem_24110159 {
    @Id
    @Column(length = 50)
    private String cartItemId;

    private Integer quantity;
    private Float unitPrice;

    @ManyToOne
    @JoinColumn(name = "productId")
    private Product_24110159 product;

    @ManyToOne
    @JoinColumn(name = "cartId")
    private Cart_24110159 cart;

    public String getCartItemId() { return cartItemId; }
    public void setCartItemId(String cartItemId) { this.cartItemId = cartItemId; }
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
    public Float getUnitPrice() { return unitPrice; }
    public void setUnitPrice(Float unitPrice) { this.unitPrice = unitPrice; }
    public Product_24110159 getProduct() { return product; }
    public void setProduct(Product_24110159 product) { this.product = product; }
    public Cart_24110159 getCart() { return cart; }
    public void setCart(Cart_24110159 cart) { this.cart = cart; }
}
