package com.webst5.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "Cart")
public class Cart_24110159 {
    @Id
    @Column(length = 50)
    private String cartId;

    @ManyToOne
    @JoinColumn(name = "userId")
    private User_24110159 user;

    private LocalDateTime buyDate;
    private Integer status;

    public String getCartId() { return cartId; }
    public void setCartId(String cartId) { this.cartId = cartId; }
    public User_24110159 getUser() { return user; }
    public void setUser(User_24110159 user) { this.user = user; }
    public LocalDateTime getBuyDate() { return buyDate; }
    public void setBuyDate(LocalDateTime buyDate) { this.buyDate = buyDate; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
}
