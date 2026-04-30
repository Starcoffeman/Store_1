package org.example.controller;

import org.example.dto.ProductDTO;
import org.example.mapper.ProductMapper;
import org.example.model.Category;
import org.example.model.Product;
import org.example.service.CategoryService;
import org.example.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;
import java.util.stream.Collectors;

@Controller
public class SaleController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    @GetMapping("/sale")
    public String salePage(Model model) {
        List<Product> allProducts = productService.findAll();

        // Фильтруем товары со скидкой
        List<Product> saleProducts = allProducts.stream()
                .filter(product -> product.getOldPrice() != null && product.getOldPrice() > product.getPrice())
                .collect(Collectors.toList());

        // Конвертируем в DTO с помощью маппера (скидка уже будет вычислена)
        List<ProductDTO> productDTOs = saleProducts.stream()
                .map(ProductMapper::convertToDTO)
                .collect(Collectors.toList());

        // Получаем все категории для фильтра
        List<Category> categories = categoryService.findAll();

        // Максимальная скидка (теперь берём из DTO)
        int maxDiscount = productDTOs.stream()
                .mapToInt(dto -> dto.getDiscountPercent() != null ? dto.getDiscountPercent() : 0)
                .max()
                .orElse(0);

        model.addAttribute("products", productDTOs);
        model.addAttribute("productsCount", productDTOs.size());
        model.addAttribute("maxDiscount", maxDiscount);
        model.addAttribute("categories", categories);

        return "sale";
    }
}