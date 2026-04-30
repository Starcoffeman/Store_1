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
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.List;

@Controller
public class MainController {

    @Autowired
    private ProductService productService;

    @Autowired
    private ArticleService articleService;

    @GetMapping
    public String index(Model model,
                        @RequestParam(defaultValue = "1") int topPage,
                        @RequestParam(defaultValue = "1") int bestPage,
                        Principal principal) {
        try {
            List<Product> products = productService.findAll();
            List<Article> latestArticles = articleService.getLatestArticles();

            int itemsPerPage = 8;
            int totalTopPages = (int) Math.ceil(products.size() / (double) itemsPerPage);
            int totalBestPages = (int) Math.ceil(products.size() / (double) itemsPerPage);

            // Вычисляем средний рейтинг
            products.forEach(product -> {
                if (product.getReviews() != null) {
                    product.getReviews().size();
                }
                product.getAverageRating();
            });

            model.addAttribute("products", products);
            model.addAttribute("currentTopPage", topPage);
            model.addAttribute("currentBestPage", bestPage);
            model.addAttribute("totalTopPages", totalTopPages);
            model.addAttribute("totalBestPages", totalBestPages);
            model.addAttribute("itemsPerPage", itemsPerPage);
            model.addAttribute("latestArticles", latestArticles);
            model.addAttribute("isAuthenticated", principal != null);

            return "main";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Ошибка загрузки товаров: " + e.getMessage());
            return "error";
        }
    }
}