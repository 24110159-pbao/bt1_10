package com.webst5.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "Seller")
public class Seller_24110159 {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer sellerId;

    private String sellername;
    private String images;
    private Integer status;

    public Integer getSellerId() { return sellerId; }
    public void setSellerId(Integer sellerId) { this.sellerId = sellerId; }
    public String getSellername() { return sellername; }
    public void setSellername(String sellername) { this.sellername = sellername; }
    public String getImages() { return images; }
    public void setImages(String images) { this.images = images; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
}
