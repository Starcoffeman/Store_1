package org.example.controller;

import jakarta.validation.Valid;
import org.example.model.Product;
import org.example.model.Review;
import org.example.model.User;
import org.example.service.ProductService;
import org.example.service.ReviewService;
import org.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/reviews")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private UserService userService;

    @Autowired
    private ProductService productService;

    @GetMapping
    public String index(Model model) {
        List<Review> reviews = reviewService.findAll();
        model.addAttribute("listReviews", reviews);
        return "review/reviews";
    }

    @GetMapping("/add")
    public String addReviewForm(Model model) {
        model.addAttribute("review", new Review());
        List<User> users = userService.findAll();
        List<Product> products = productService.findAll();
        model.addAttribute("listUsers", users);
        model.addAttribute("productList", products);
        return "review/addReview";
    }

    @GetMapping("/main")
    public String showAddReviewPage(@RequestParam("productId") Integer productId, Model model, Principal principal) {
        Review review = new Review();

        // Если пользователь авторизован, подставляем его
        if (principal != null) {
            User currentUser = userService.findByUsername(principal.getName());
            review.setUser(currentUser);
        }

        // Устанавливаем продукт
        Product product = productService.findById(productId);
        review.setProduct(product);

        model.addAttribute("review", review);
        model.addAttribute("product", product);
        return "review/addReviewMain";
    }

    @PostMapping("/main")
    public String addReviewMain(@RequestParam("rating") Integer rating,
                                @RequestParam("comment") String comment,
                                @RequestParam("product.id") Integer productId,
                                Principal principal,
                                Model model) {

        if (principal == null) {
            return "redirect:/login";
        }

        User currentUser = userService.findByUsername(principal.getName());
        Product product = productService.findById(productId);

        Review review = new Review();
        review.setRating(rating);
        review.setComment(comment);
        review.setProduct(product);
        review.setUser(currentUser);
        review.setReviewDate(LocalDateTime.now());

        reviewService.save(review);

        return "redirect:/products/" + productId;
    }

    @PostMapping("/add")
    public String addReview(@Valid Review review,
                            BindingResult bindingResult,
                            Model model) {
        if (bindingResult.hasErrors()) {
            List<User> users = userService.findAll();
            List<Product> products = productService.findAll();
            model.addAttribute("listUsers", users);
            model.addAttribute("productList", products);
            return "review/addReview";
        }

        review.setReviewDate(LocalDateTime.now());
        reviewService.save(review);
        return "redirect:/reviews";
    }

    @GetMapping("/edit/{id}")
    public String editReviewForm(@PathVariable Integer id, Model model) {
        Review review = reviewService.findById(id);
        List<User> users = userService.findAll();
        List<Product> products = productService.findAll();
        model.addAttribute("listUsers", users);
        model.addAttribute("productList", products);
        model.addAttribute("review", review);
        return "review/editReview";
    }

    @PostMapping("/edit/{id}")
    public String editReview(@PathVariable Integer id,
                             @Valid Review review,
                             BindingResult bindingResult,
                             Model model) {
        if (bindingResult.hasErrors()) {
            List<User> users = userService.findAll();
            List<Product> products = productService.findAll();
            model.addAttribute("listUsers", users);
            model.addAttribute("productList", products);
            return "review/editReview";
        }
        reviewService.update(id, review);
        return "redirect:/reviews";
    }

    @GetMapping("/delete/{id}")
    public String deleteReview(@PathVariable Integer id) {
        reviewService.delete(id);
        return "redirect:/reviews";
    }

    @GetMapping("/user/{userId}")
    public String getReviewsByUserId(@PathVariable Integer userId, Model model) {
        List<Review> reviews = reviewService.getByUserId(userId);
        User user = userService.findById(userId);
        model.addAttribute("reviews", reviews);
        model.addAttribute("user", user);
        return "review/userReviews";
    }

    @GetMapping("/product/{productId}")
    public String getReviewsByProductId(@PathVariable Integer productId, Model model) {
        List<Review> reviews = reviewService.findByProductId(productId);
        Product product = productService.findById(productId);
        model.addAttribute("reviews", reviews);
        model.addAttribute("product", product);
        return "review/productReviews";
    }
}