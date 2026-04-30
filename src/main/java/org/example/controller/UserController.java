package org.example.controller;

import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.example.dto.PasswordResetRequest;
import org.example.model.Order;
import org.example.model.Review;
import org.example.model.User;
import org.example.service.OrderService;
import org.example.service.ReviewService;
import org.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Year;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@Controller
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping
    public String index(Model model) {
        List<User> users = userService.findAll();
        model.addAttribute("listUsers", users);
        return "user/users";
    }

    @GetMapping("/profile")
    public String profile(Model model) {
        try {
            User user = userService.getCurrentUser();

            if (user == null) {
                log.error("Пользователь не найден");
                return "redirect:/login";
            }

            log.info("Загрузка профиля: username={}, role={}",
                    user.getUsername(),
                    user.getRole() != null ? user.getRole().getName() : "null");

            List<Review> reviews = reviewService.getByUserId(user.getId());
            int ordersCount = orderService.getByUserId(user.getId()).size();
            List<Order> recentOrders = orderService.getByUserId(user.getId());

            // Преобразуем отзывы в объекты с названием товара
            List<Map<String, Object>> recentReviewsWithProducts = reviews.stream()
                    .limit(5) // Берем последние 5 отзывов
                    .map(review -> {
                        Map<String, Object> reviewMap = new HashMap<>();
                        reviewMap.put("id", review.getId());
                        reviewMap.put("rating", review.getRating());
                        reviewMap.put("comment", review.getComment());
                        reviewMap.put("reviewDate", review.getReviewDate());
                        reviewMap.put("productId", review.getProduct().getId());
                        reviewMap.put("productName", review.getProduct().getName()); // Название товара
                        return reviewMap;
                    })
                    .collect(Collectors.toList());

            model.addAttribute("recentOrders", recentOrders);
            model.addAttribute("ordersCount", ordersCount);
            model.addAttribute("registrationDate", user.getRegistrationDate());
            model.addAttribute("reviewsCount", reviews.size());
            model.addAttribute("recentReviews", recentReviewsWithProducts); // Передаем обогащенные отзывы
            model.addAttribute("user", user);

            return "user/profile";

        } catch (Exception e) {
            log.error("Ошибка при загрузке профиля: {}", e.getMessage());
            return "redirect:/login";
        }
    }

    @GetMapping("/add")
    public String addUserForm(Model model) {
        model.addAttribute("user", new User());
        return "user/addUser";
    }

    @PostMapping("/add")
    public String addUser(@Valid User user, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            return "user/addUser";
        }
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRegistrationDate(LocalDate.now());
        userService.save(user);
        return "redirect:/users";
    }

    @GetMapping("/reset-password")
    public String showResetPasswordForm(Model model) {
        model.addAttribute("resetRequest", new PasswordResetRequest());
        return "user/reset-password";
    }

    @PostMapping("/reset-password")
    public String resetPassword(@Valid PasswordResetRequest resetRequest,
                                BindingResult bindingResult,
                                RedirectAttributes redirectAttributes) {

        // Проверяем совпадение паролей
        if (!resetRequest.getNewPassword().equals(resetRequest.getConfirmPassword())) {
            redirectAttributes.addFlashAttribute("error", "Пароли не совпадают");
            return "redirect:/users/reset-password";
        }

        // Проверяем длину пароля
        if (resetRequest.getNewPassword().length() < 4) {
            redirectAttributes.addFlashAttribute("error", "Пароль должен содержать минимум 4 символа");
            return "redirect:/users/reset-password";
        }

        // Ищем пользователя по логину и email
        User user = userService.findByUsernameAndEmail(
                resetRequest.getUsername(),
                resetRequest.getEmail()
        );

        if (user == null) {
            redirectAttributes.addFlashAttribute("error",
                    "Пользователь с таким логином и email не найден");
            return "redirect:/users/reset-password";
        }

        // Обновляем пароль
        user.setPassword(passwordEncoder.encode(resetRequest.getNewPassword()));
        userService.save(user);

        redirectAttributes.addFlashAttribute("message",
                "Пароль успешно изменён! Теперь вы можете войти с новым паролем.");
        return "redirect:/login";
    }

    @GetMapping("/delete/{id}")
    public String deleteUser(@PathVariable int id) {
        userService.delete(id);
        return "redirect:/users";
    }

    @GetMapping("/edit/{id}")
    public String editUserForm(@PathVariable int id, Model model) {
        User user = userService.findById(id);
        model.addAttribute("user", user);
        return "user/editUser";
    }

    @PostMapping("/edit/{id}")
    public String editUser(@PathVariable int id, @Valid User user, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            return "user/editUser";
        }
        userService.update(id, user);
        return "redirect:/users";
    }

    @PostMapping("profile/edit/{id}")
    public String editUserInProfile(@PathVariable int id, @Valid User user, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            return "user/editUser";
        }
        userService.updateInProfile(id, user);
        return "redirect:/users/profile";
    }

}
