package org.example;

import org.example.model.Article;
import org.example.model.Product;
import org.example.model.Review;
import org.example.service.ArticleService;
import org.example.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.security.Principal;
import java.util.List;

@Controller
public class MainController {

    @Autowired
    private ProductService productService;

    @Autowired
    private ArticleService articleService;

    @GetMapping
    public String index(Model model, Principal principal) {
        try {
            List<Product> products = productService.findAll();
            List<Article> latestArticles = articleService.getLatestArticles();

            // Принудительно инициализируем коллекции reviews
            products.forEach(product -> {
                if (product.getReviews() != null) {
                    // Вызываем size() чтобы инициализировать коллекцию
                    product.getReviews().size();
                }
                // Вычисляем средний рейтинг
                product.getAverageRating();
            });

            model.addAttribute("products", products);
            model.addAttribute("review", new Review());
            model.addAttribute("latestArticles", latestArticles);
            // Добавляем флаг авторизации для JavaScript
            model.addAttribute("isAuthenticated", principal != null);

            return "main";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Ошибка загрузки товаров: " + e.getMessage());
            return "error";
        }
    }
}