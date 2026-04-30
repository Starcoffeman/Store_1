package org.example.dto;

import lombok.Data;
import java.util.List;

@Data
public class ProductDTO {
    private Integer id;
    private String name;
    private Double price;
    private Double oldPrice;
    private Double averageRating;
    private String fileurl;
    private Integer categoryId;
    private String categoryName;
    private String brand;
    private Integer stock;
    private String badge;
    private List<ReviewDTO> reviews;
    private Integer discountPercent;  // Процент скидки

    private String processor;    // Процессор
    private String ram;          // Оперативная память
    private String storage;      // Накопитель
    private String display;      // Дисплей
    private String battery;      // Батарея
    private String color;        // Цвет
    private String weight;       // Вес
    private String warranty;     // Гарантия
    private String country;      // Страна
    private String additionalInfo; // Доп. информация



    @Data
    public static class ReviewDTO {
        private Integer id;
        private Integer rating;
        private String comment;
        private Integer userId; // только ID пользователя, не весь объект
        private String userName;
    }
}