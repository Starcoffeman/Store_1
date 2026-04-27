package org.example.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.util.List;
import java.util.ArrayList;

@Getter
@Setter
@Entity
@Table(name = "products")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "description", length = 5000)
    private String description;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "category_id", referencedColumnName = "id")
    private Category category;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "brand_id", referencedColumnName = "id")
    private Brand brand;

    @Column(name = "price", nullable = false)
    private Double price;

    @Column(name = "old_price")
    private Double oldPrice;

    @Column(name = "file_url")
    private String fileurl;

    // Расширенные поля
    @Column(name = "processor", length = 200)
    private String processor;

    @Column(name = "ram", length = 50)
    private String ram;

    @Column(name = "storage", length = 100)
    private String storage;

    @Column(name = "display", length = 200)
    private String display;

    @Column(name = "battery", length = 100)
    private String battery;

    @Column(name = "color", length = 50)
    private String color;

    @Column(name = "weight", length = 50)
    private String weight;

    @Column(name = "warranty", length = 50)
    private String warranty;

    @Column(name = "country", length = 100)
    private String country;

    @Column(name = "additional_info", length = 2000)
    private String additionalInfo;

    @Column(name = "in_stock")
    private Boolean inStock = true;

    @Column(name = "stock_quantity")
    private Integer stockQuantity = 0;

    // Связи
    @OneToMany(mappedBy = "product", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private List<Review> reviews = new ArrayList<>();

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
//    @OrderBy("display_order ASC, is_primary DESC")
    private List<ProductImage> images = new ArrayList<>();

    // Временные поля
    @Transient
    private String badge;

    @Transient
    private Double averageRating;

    @Transient
    private Integer discountPercent;

    // Вспомогательные методы
    public String getPrimaryImage() {
        if (images != null && !images.isEmpty()) {
            for (ProductImage img : images) {
                if (img.isPrimary()) {
                    return img.getImageUrl();
                }
            }
            return images.get(0).getImageUrl();
        }
        return fileurl != null ? fileurl : "/images/images.png";
    }

    public List<String> getAllImageUrls() {
        List<String> urls = new ArrayList<>();
        if (images != null && !images.isEmpty()) {
            for (ProductImage img : images) {
                urls.add(img.getImageUrl());
            }
        }
        if (fileurl != null && !urls.contains(fileurl)) {
            urls.add(fileurl);
        }
        return urls;
    }

    public String getStockStatus() {
        if (inStock == null || !inStock || (stockQuantity != null && stockQuantity <= 0)) {
            return "Нет в наличии";
        } else if (stockQuantity != null && stockQuantity < 10) {
            return "Осталось мало (" + stockQuantity + " шт.)";
        }
        return "В наличии";
    }

    public String getStockBadgeClass() {
        if (inStock == null || !inStock || (stockQuantity != null && stockQuantity <= 0)) {
            return "out-of-stock";
        } else if (stockQuantity != null && stockQuantity < 10) {
            return "low-stock";
        }
        return "in-stock";
    }
}