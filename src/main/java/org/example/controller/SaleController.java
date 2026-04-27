package org.example.controller;

import org.example.model.Product;
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

    @GetMapping("/sale")
    public String salePage(Model model) {
        List<Product> allProducts = productService.findAll();

        // Фильтруем товары со скидкой (где oldPrice не null и больше price)
        List<Product> saleProducts = allProducts.stream()
                .filter(product -> product.getOldPrice() != null && product.getOldPrice() > product.getPrice())
                .collect(Collectors.toList());

        // Вычисляем процент скидки для каждого товара
        saleProducts.forEach(product -> {
            if (product.getOldPrice() != null && product.getOldPrice() > 0) {
                int discountPercent = (int) ((1 - product.getPrice() / product.getOldPrice()) * 100);
                product.setDiscountPercent(discountPercent);
            }
        });

        // Подсчитываем максимальную скидку
        int maxDiscount = saleProducts.stream()
                .mapToInt(Product::getDiscountPercent)
                .max()
                .orElse(0);

        model.addAttribute("products", saleProducts);
        model.addAttribute("productsCount", saleProducts.size());
        model.addAttribute("maxDiscount", maxDiscount);

        return "sale";
    }
}