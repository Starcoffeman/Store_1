package org.example.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartItemDto {
    private Integer id;
    private Integer productId;
    private String productName;
    private String productImage;
    private double price;
    private Integer quantity;
    private double subtotal;
}