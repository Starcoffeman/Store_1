package org.example.controller;

import org.example.dto.CartResponse;
import org.example.model.User;
import org.example.service.CartService;
import org.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    @Autowired
    private UserService userService;

    @GetMapping
    public String cartPage(Model model, Principal principal) {
        if (principal == null) {
            return "redirect:/login";
        }

        User user = userService.findByUsername(principal.getName());
        CartResponse cart = cartService.getCartResponse(user);

        model.addAttribute("cart", cart);
        model.addAttribute("cartCount", cart.getTotalCount());
        model.addAttribute("cartTotal", cart.getTotalPrice());

        return "cart/cart";
    }

    // Исправленный метод - принимает JSON
    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addToCart(
            @RequestBody Map<String, Object> requestBody,
            Principal principal) {

        Map<String, Object> response = new HashMap<>();

        if (principal == null) {
            response.put("success", false);
            response.put("message", "Необходимо авторизоваться");
            response.put("redirect", "/login");
            return ResponseEntity.ok(response);
        }

        try {
            Integer productId = null;
            Integer quantity = 1;

            // Извлекаем productId из тела запроса
            if (requestBody.containsKey("productId")) {
                Object idObj = requestBody.get("productId");
                if (idObj instanceof Integer) {
                    productId = (Integer) idObj;
                } else if (idObj instanceof String) {
                    productId = Integer.parseInt((String) idObj);
                }
            }

            if (requestBody.containsKey("quantity")) {
                Object qtyObj = requestBody.get("quantity");
                if (qtyObj instanceof Integer) {
                    quantity = (Integer) qtyObj;
                } else if (qtyObj instanceof String) {
                    quantity = Integer.parseInt((String) qtyObj);
                }
            }

            if (productId == null) {
                response.put("success", false);
                response.put("message", "Не указан ID товара");
                return ResponseEntity.badRequest().body(response);
            }

            User user = userService.findByUsername(principal.getName());
            cartService.addToCart(user, productId, quantity);
            int cartCount = cartService.getCartCount(user);

            response.put("success", true);
            response.put("message", "Товар добавлен в корзину");
            response.put("cartCount", cartCount);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Ошибка при добавлении товара: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

    // Альтернативный метод - принимает параметры формы (если нужно)
    @PostMapping("/add-form")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addToCartForm(
            @RequestParam Integer productId,
            @RequestParam(defaultValue = "1") Integer quantity,
            Principal principal) {

        Map<String, Object> response = new HashMap<>();

        if (principal == null) {
            response.put("success", false);
            response.put("message", "Необходимо авторизоваться");
            response.put("redirect", "/login");
            return ResponseEntity.ok(response);
        }

        try {
            User user = userService.findByUsername(principal.getName());
            cartService.addToCart(user, productId, quantity);
            int cartCount = cartService.getCartCount(user);

            response.put("success", true);
            response.put("message", "Товар добавлен в корзину");
            response.put("cartCount", cartCount);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Ошибка при добавлении товара: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/remove/{productId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> removeFromCart(@PathVariable Integer productId, Principal principal) {
        Map<String, Object> response = new HashMap<>();

        if (principal == null) {
            response.put("success", false);
            response.put("message", "Необходимо авторизоваться");
            return ResponseEntity.ok(response);
        }

        try {
            User user = userService.findByUsername(principal.getName());
            cartService.removeFromCart(user, productId);
            int cartCount = cartService.getCartCount(user);

            response.put("success", true);
            response.put("message", "Товар удалён из корзины");
            response.put("cartCount", cartCount);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Ошибка при удалении товара: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

    @PostMapping("/update")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateQuantity(
            @RequestBody Map<String, Object> requestBody,
            Principal principal) {

        Map<String, Object> response = new HashMap<>();

        if (principal == null) {
            response.put("success", false);
            response.put("message", "Необходимо авторизоваться");
            return ResponseEntity.ok(response);
        }

        try {
            Integer productId = null;
            Integer quantity = 1;

            if (requestBody.containsKey("productId")) {
                Object idObj = requestBody.get("productId");
                if (idObj instanceof Integer) {
                    productId = (Integer) idObj;
                } else if (idObj instanceof String) {
                    productId = Integer.parseInt((String) idObj);
                }
            }

            if (requestBody.containsKey("quantity")) {
                Object qtyObj = requestBody.get("quantity");
                if (qtyObj instanceof Integer) {
                    quantity = (Integer) qtyObj;
                } else if (qtyObj instanceof String) {
                    quantity = Integer.parseInt((String) qtyObj);
                }
            }

            if (productId == null) {
                response.put("success", false);
                response.put("message", "Не указан ID товара");
                return ResponseEntity.badRequest().body(response);
            }

            User user = userService.findByUsername(principal.getName());
            cartService.updateQuantity(user, productId, quantity);
            CartResponse cart = cartService.getCartResponse(user);

            response.put("success", true);
            response.put("cartCount", cart.getTotalCount());
            response.put("totalPrice", cart.getTotalPrice());
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Ошибка при обновлении количества: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/clear")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> clearCart(Principal principal) {
        Map<String, Object> response = new HashMap<>();

        if (principal == null) {
            response.put("success", false);
            response.put("message", "Необходимо авторизоваться");
            return ResponseEntity.ok(response);
        }

        try {
            User user = userService.findByUsername(principal.getName());
            cartService.clearCart(user);

            response.put("success", true);
            response.put("message", "Корзина очищена");
            response.put("cartCount", 0);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Ошибка при очистке корзины: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

    @GetMapping("/count")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getCartCount(Principal principal) {
        Map<String, Object> response = new HashMap<>();

        if (principal == null) {
            response.put("count", 0);
            return ResponseEntity.ok(response);
        }

        User user = userService.findByUsername(principal.getName());
        int count = cartService.getCartCount(user);

        response.put("count", count);
        return ResponseEntity.ok(response);
    }
}