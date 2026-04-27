package org.example.mapper;

import org.example.dto.ProductDTO;
import org.example.model.Product;
import org.example.model.Review;

import java.util.List;
import java.util.stream.Collectors;

public class ProductMapper {

    public static ProductDTO convertToDTO(Product product) {
        ProductDTO dto = new ProductDTO();
        dto.setId(product.getId());
        dto.setName(product.getName());
        dto.setPrice(product.getPrice());
        dto.setOldPrice(product.getOldPrice());
        dto.setFileurl(product.getFileurl());
        dto.setCategoryId(product.getCategory() != null ? product.getCategory().getId() : null);
        dto.setCategoryName(product.getCategory() != null ? product.getCategory().getName() : "Электроника");
        dto.setBrand(product.getBrand() != null ? product.getBrand().getName() : "Другое");
        dto.setStock(product.getStockQuantity());

        // Вычисляем рейтинг
        double avgRating = product.getReviews().stream()
                .mapToInt(Review::getRating)
                .average()
                .orElse(0.0);
        dto.setAverageRating(avgRating);

        // Преобразуем отзывы без циклических ссылок
        List<ProductDTO.ReviewDTO> reviewDTOs = product.getReviews().stream()
                .map(review -> {
                    ProductDTO.ReviewDTO reviewDTO = new ProductDTO.ReviewDTO();
                    reviewDTO.setId(review.getId());
                    reviewDTO.setRating(review.getRating());
                    reviewDTO.setComment(review.getComment());
                    reviewDTO.setUserId(review.getUser().getId());
                    reviewDTO.setUserName(review.getUser().getName() + " " + review.getUser().getSurname());
                    return reviewDTO;
                })
                .collect(Collectors.toList());
        dto.setReviews(reviewDTOs);

        // Вычисляем бейдж
        if (product.getOldPrice() != null && product.getOldPrice() > product.getPrice()) {
            int discount = (int) ((product.getOldPrice() - product.getPrice()) / product.getOldPrice() * 100);
            dto.setBadge("-" + discount + "%");
        } else if (avgRating >= 4.5) {
            dto.setBadge("Хит");
        } else {
            dto.setBadge("Топ");
        }

        return dto;
    }
}
