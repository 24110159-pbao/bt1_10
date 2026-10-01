package com.webst5.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "Users")
public class User_24110159 {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer userId;

    private String username;
    private String email;
    private String fullname;
    private String password;
    private String images;
    private String phone;
    private Integer status;
    private String code;

    @ManyToOne
    @JoinColumn(name = "roleId")
    private UserRole_24110159 role;

    @ManyToOne
    @JoinColumn(name = "sellerId")
    private Seller_24110159 seller;

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getImages() { return images; }
    public void setImages(String images) { this.images = images; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }
    public UserRole_24110159 getRole() { return role; }
    public void setRole(UserRole_24110159 role) { this.role = role; }
    public Seller_24110159 getSeller() { return seller; }
    public void setSeller(Seller_24110159 seller) { this.seller = seller; }
}
