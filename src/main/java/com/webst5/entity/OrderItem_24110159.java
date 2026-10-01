package com.webst5.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

import java.math.BigDecimal;

@Entity
@Table(name = "OrderItems")
public class OrderItem_24110159 {
    @Id
    @Column(length = 36)
    private String orderItemId;

    @ManyToOne
    @JoinColumn(name = "orderId", nullable = false)
    private Order_24110159 order;

    @ManyToOne
    @JoinColumn(name = "productId")
    private Product_24110159 product;

    @Column(length = 200, nullable = false)
    private String productName;

    @Column(precision = 12, scale = 2, nullable = false)
    private BigDecimal unitPrice;

    @Column(nullable = false)
    private Integer quantity;

    @Column(precision = 12, scale = 2, nullable = false)
    private BigDecimal lineTotal;

    public String getOrderItemId() { return orderItemId; }
    public void setOrderItemId(String orderItemId) { this.orderItemId = orderItemId; }
    public Order_24110159 getOrder() { return order; }
    public void setOrder(Order_24110159 order) { this.order = order; }
    public Product_24110159 getProduct() { return product; }
    public void setProduct(Product_24110159 product) { this.product = product; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public BigDecimal getUnitPrice() { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice) { this.unitPrice = unitPrice; }
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
    public BigDecimal getLineTotal() { return lineTotal; }
    public void setLineTotal(BigDecimal lineTotal) { this.lineTotal = lineTotal; }
}