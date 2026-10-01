package com.webst5.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "Product")
public class Product_24110159 {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer productId;

    private String productName;
    private Long productCode;

    @ManyToOne
    @JoinColumn(name = "categoryId")
    private Category_24110159 category;

    private String description;
    private Float price;
    private Integer amount;
    private Integer stock;
    private String images;
    private Integer wishlist;
    private Integer status;
    private LocalDate createDate;

    @ManyToOne
    @JoinColumn(name = "sellerId")
    private Seller_24110159 seller;

    public Integer getProductId() { return productId; }
    public void setProductId(Integer productId) { this.productId = productId; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public Long getProductCode() { return productCode; }
    public void setProductCode(Long productCode) { this.productCode = productCode; }
    public Category_24110159 getCategory() { return category; }
    public void setCategory(Category_24110159 category) { this.category = category; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Float getPrice() { return price; }
    public void setPrice(Float price) { this.price = price; }
    public Integer getAmount() { return amount; }
    public void setAmount(Integer amount) { this.amount = amount; }
    public Integer getStock() { return stock; }
    public void setStock(Integer stock) { this.stock = stock; }
    public String getImages() { return images; }
    public void setImages(String images) { this.images = images; }
    public Integer getWishlist() { return wishlist; }
    public void setWishlist(Integer wishlist) { this.wishlist = wishlist; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public LocalDate getCreateDate() { return createDate; }
    public void setCreateDate(LocalDate createDate) { this.createDate = createDate; }
    public Seller_24110159 getSeller() { return seller; }
    public void setSeller(Seller_24110159 seller) { this.seller = seller; }
}
