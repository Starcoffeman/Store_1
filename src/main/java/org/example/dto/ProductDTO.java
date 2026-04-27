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

    @Data
    public static class ReviewDTO {
        private Integer id;
        private Integer rating;
        private String comment;
        private Integer userId; // только ID пользователя, не весь объект
        private String userName;
    }
}