package org.example.controller;

import org.example.dto.CartResponse;
import org.example.model.Order;
import org.example.model.User;
import org.example.service.CartService;
import org.example.service.OrderService;
import org.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/checkout")
public class CheckoutController {

    @Autowired
    private CartService cartService;

    @Autowired
    private UserService userService;

    @Autowired
    private OrderService orderService;

    @GetMapping
    public String checkoutPage(Model model, Principal principal) {
        if (principal == null) {
            return "redirect:/login";
        }

        User user = userService.findByUsername(principal.getName());
        CartResponse cart = cartService.getCartResponse(user);

        if (cart.getItems().isEmpty()) {
            return "redirect:/cart";
        }

        model.addAttribute("cart", cart);
        model.addAttribute("user", user);
        return "checkout";
    }

    @PostMapping("/submit")
    public String submitOrder(@RequestParam String firstName,
                              @RequestParam String lastName,
                              @RequestParam String email,
                              @RequestParam String phone,
                              @RequestParam String city,
                              @RequestParam String address,
                              @RequestParam(required = false) String apartment,
                              @RequestParam(required = false) String zipcode,
                              @RequestParam(required = false) String comment,
                              @RequestParam String deliveryMethod,
                              @RequestParam String paymentMethod,
                              Principal principal) {

        if (principal == null) {
            return "redirect:/login";
        }

        User user = userService.findByUsername(principal.getName());
        CartResponse cart = cartService.getCartResponse(user);

        if (cart.getItems().isEmpty()) {
            return "redirect:/cart";
        }

        // Создаем заказ
        Order order = new Order();
        order.setUser(user);
        order.setOrderDate(LocalDateTime.now());

        // Если оплата картой - статус PAID, иначе PENDING
        if ("CARD".equals(paymentMethod)) {
            order.setStatus("PAID");
        } else {
            order.setStatus("PENDING");
        }

        order.setTotalPrice(cart.getTotalPrice());
        order.setDeliveryMethod(getDeliveryMethodName(deliveryMethod));
        order.setPaymentMethod(getPaymentMethodName(paymentMethod));

        String fullAddress = city + ", " + address;
        if (apartment != null && !apartment.isEmpty()) {
            fullAddress += ", кв./оф. " + apartment;
        }
        if (zipcode != null && !zipcode.isEmpty()) {
            fullAddress += ", " + zipcode;
        }
        order.setAddress(fullAddress);

        // Сохраняем заказ
        Order savedOrder = orderService.createOrder(order, cart.getItems());

        // Очищаем корзину
        cartService.clearCart(user);

        return "redirect:/orders/" + savedOrder.getId() + "/success";
    }

    @PostMapping("/payment")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> processPayment(@RequestBody Map<String, String> paymentData,
                                                              Principal principal) {
        Map<String, Object> response = new HashMap<>();

        try {
            if (principal == null) {
                response.put("success", false);
                response.put("message", "Необходимо авторизоваться");
                return ResponseEntity.status(401).body(response);
            }

            User user = userService.findByUsername(principal.getName());
            CartResponse cart = cartService.getCartResponse(user);

            if (cart.getItems().isEmpty()) {
                response.put("success", false);
                response.put("message", "Корзина пуста");
                return ResponseEntity.badRequest().body(response);
            }

            // Создаем заказ со статусом PAID
            Order order = new Order();
            order.setUser(user);
            order.setOrderDate(LocalDateTime.now());
            order.setStatus("PAID");
            order.setTotalPrice(cart.getTotalPrice());
            order.setDeliveryMethod("Курьерская доставка");
            order.setPaymentMethod("Банковская карта");
            order.setAddress(user.getAddress() != null ? user.getAddress() : "Адрес не указан");

            // Сохраняем заказ
            Order savedOrder = orderService.createOrder(order, cart.getItems());

            // Очищаем корзину
            cartService.clearCart(user);

            response.put("success", true);
            response.put("orderId", savedOrder.getId());
            response.put("message", "Оплата прошла успешно");

        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "Ошибка при оплате: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

    private String getDeliveryMethodName(String method) {
        switch (method) {
            case "COURIER": return "Курьерская доставка";
            case "POST": return "Почта России";
            case "PICKUP": return "Самовывоз";
            default: return "Курьерская доставка";
        }
    }

    private String getPaymentMethodName(String method) {
        switch (method) {
            case "CARD": return "Банковская карта";
            case "CASH": return "Наличные при получении";
            case "SBP": return "СБП";
            default: return "Банковская карта";
        }
    }
}