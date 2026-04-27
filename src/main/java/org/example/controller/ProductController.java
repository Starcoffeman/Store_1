package org.example.controller;

import jakarta.validation.Valid;
import org.example.dto.ProductDTO;
import org.example.mapper.ProductMapper;
import org.example.model.Category;
import org.example.model.Product;
import org.example.model.ProductImage;
import org.example.model.Review;
import org.example.repository.ProductImageRepository;
import org.example.service.CategoryService;
import org.example.service.ProductService;
import org.example.service.ReviewService;
import org.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/products")
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private UserService userService;

    @Autowired
    private ProductImageRepository  productImageRepository;

    @GetMapping
    public String index(Model model) {
        try {
            List<Product> products = productService.findAll();
            products.forEach(product -> {
                List<Review> reviews = reviewService.findByProductId(product.getId());
                product.setReviews(reviews);

                // Вычисляем средний рейтинг
                if (reviews != null && !reviews.isEmpty()) {
                    double avg = reviews.stream()
                            .mapToInt(Review::getRating)
                            .average()
                            .orElse(0.0);
                    product.setAverageRating(avg);
                } else {
                    product.setAverageRating(0.0);
                }
            });
            model.addAttribute("listProducts", products);
            return "product/products";
        } catch (Exception e) {
            model.addAttribute("error", "Ошибка загрузки товаров: " + e.getMessage());
            return "error";
        }
    }

    @GetMapping("/add")
    public String addProductForm(Model model) {
        try {
            List<Category> categories = categoryService.findAll();
            if (categories == null || categories.isEmpty()) {
                model.addAttribute("error", "Нет доступных категорий. Сначала создайте категорию.");
            }
            model.addAttribute("product", new Product());
            model.addAttribute("categories", categories);
            return "product/addProduct";
        } catch (Exception e) {
            model.addAttribute("error", "Ошибка загрузки формы: " + e.getMessage());
            return "error";
        }
    }

    @GetMapping("/catalog")
    public String getAll(Model model) {
        try {
            List<Product> products = productService.findAll();
            List<Category> categories = categoryService.findAll();

            List<ProductDTO> productDTOs = products.stream()
                    .map(ProductMapper :: convertToDTO)
                    .collect(Collectors.toList());

            Set<String> brandsSet = new HashSet<>();
            for (Product product : products) {
                if (product.getBrand() != null && !product.getBrand().getName().isEmpty()) {
                    brandsSet.add(product.getBrand().getName());
                }
            }

            model.addAttribute("products", productDTOs);
            model.addAttribute("categories", categories);
            model.addAttribute("brands", brandsSet);

            return "product/allProduct";
        } catch (Exception e) {
            model.addAttribute("error", "Ошибка загрузки формы: " + e.getMessage());
            return "error";
        }
    }

    @GetMapping("/catalog/notebooks")
    public String getAllNotebooks(Model model) {
        try {
            List<Product> products = productService.findAll();
            List<Category> categories = categoryService.findAll();

            Set<String> brandsSet = new HashSet<>();
            for (Product product : products) {
                if (product.getBrand() != null && !product.getBrand().getName().isEmpty()) {
                    brandsSet.add(product.getBrand().getName());
                }
            }

            model.addAttribute("products", products);
            model.addAttribute("categories", categories);
            model.addAttribute("brands", brandsSet);

            return "product/allProduct";
        } catch (Exception e) {
            model.addAttribute("error", "Ошибка загрузки формы: " + e.getMessage());
            return "error";
        }
    }

    @PostMapping("/add")
    public String addProduct(@Valid @ModelAttribute("product") Product product,
                             BindingResult bindingResult,
                             Model model,
                             RedirectAttributes redirectAttributes) {
        try {
            // Проверка на ошибки валидации
            if (bindingResult.hasErrors()) {
                List<Category> categories = categoryService.findAll();
                model.addAttribute("categories", categories);
                model.addAttribute("error", "Пожалуйста, исправьте ошибки в форме");
                return "product/addProduct";
            }

            // Проверка обязательных полей
            if (product.getName() == null || product.getName().trim().isEmpty()) {
                bindingResult.rejectValue("name", "error.product", "Название товара обязательно");
                List<Category> categories = categoryService.findAll();
                model.addAttribute("categories", categories);
                return "product/addProduct";
            }

            if (product.getCategory() == null || product.getCategory().getId() == null) {
                bindingResult.rejectValue("category", "error.product", "Выберите категорию");
                List<Category> categories = categoryService.findAll();
                model.addAttribute("categories", categories);
                return "product/addProduct";
            }

            if (product.getPrice() == null || product.getPrice() <= 0) {
                bindingResult.rejectValue("price", "error.product", "Цена должна быть больше 0");
                List<Category> categories = categoryService.findAll();
                model.addAttribute("categories", categories);
                return "product/addProduct";
            }

            // Сохраняем товар
            productService.save(product);
            redirectAttributes.addFlashAttribute("success", "Товар успешно добавлен!");
            return "redirect:/products";

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Ошибка при добавлении товара: " + e.getMessage());
            List<Category> categories = categoryService.findAll();
            model.addAttribute("categories", categories);
            return "product/addProduct";
        }
    }

    @GetMapping("/edit/{id}")
    public String editProductForm(@PathVariable Integer id, Model model) {
        try {
            Product product = productService.findById(id);
            if (product == null) {
                return "redirect:/products?error=Товар не найден";
            }
            List<Category> categories = categoryService.findAll();
            model.addAttribute("product", product);
            model.addAttribute("categories", categories);
            return "product/editProduct";
        } catch (Exception e) {
            model.addAttribute("error", "Ошибка загрузки товара: " + e.getMessage());
            return "error";
        }
    }

    @PostMapping("/edit/{id}")
    public String editProduct(@PathVariable Integer id,
                              @Valid @ModelAttribute("product") Product product,
                              BindingResult bindingResult,
                              Model model,
                              RedirectAttributes redirectAttributes) {
        try {
            if (bindingResult.hasErrors()) {
                List<Category> categories = categoryService.findAll();
                model.addAttribute("categories", categories);
                return "product/editProduct";
            }

            productService.update(id, product);
            redirectAttributes.addFlashAttribute("success", "Товар успешно обновлен!");
            return "redirect:/products";

        } catch (Exception e) {
            model.addAttribute("error", "Ошибка при обновлении товара: " + e.getMessage());
            List<Category> categories = categoryService.findAll();
            model.addAttribute("categories", categories);
            return "product/editProduct";
        }
    }

    @GetMapping("/delete/{id}")
    public String deleteProduct(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        try {
            productService.delete(id);
            redirectAttributes.addFlashAttribute("success", "Товар успешно удален!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Ошибка при удалении товара: " + e.getMessage());
        }
        return "redirect:/products";
    }

    @GetMapping("/{id}")
    public String productDetails(@PathVariable Integer id, Model model) {
        Product product = productService.findById(id);
        List<Review> reviews = reviewService.findByProductId(id);

        // Вычисляем средний рейтинг
        double averageRating = reviews.stream()
                .mapToInt(Review::getRating)
                .average()
                .orElse(0.0);
        product.setAverageRating(averageRating);

        // Вычисляем скидку
        if (product.getOldPrice() != null && product.getOldPrice() > 0) {
            int discount = (int) ((1 - product.getPrice() / product.getOldPrice()) * 100);
            product.setDiscountPercent(discount);
        }

        // Загружаем дополнительные изображения
        List<ProductImage> productImages = productImageRepository.findByProductIdOrderByDisplayOrderAscIsPrimaryDesc(id);
        product.setImages(productImages);

        // Похожие товары из той же категории
        List<Product> similarProducts = productService.findByCategoryId(product.getCategory().getId());
        similarProducts.removeIf(p -> p.getId().equals(id));
        if (similarProducts.size() > 4) {
            similarProducts = similarProducts.subList(0, 4);
        }

        // ПРОВЕРКА: находится ли товар в избранном у текущего пользователя
        boolean isFavorite = false;
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !auth.getName().equals("anonymousUser")) {
            isFavorite = userService.isProductInFavorites(auth.getName(), id);
        }

        model.addAttribute("product", product);
        model.addAttribute("reviews", reviews);
        model.addAttribute("similarProducts", similarProducts);
        model.addAttribute("isFavorite", isFavorite);


        return "product/product-details";
    }


}