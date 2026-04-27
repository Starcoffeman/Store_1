package org.example.service;

import org.example.dto.CartItemDto;
import org.example.model.Order;
import org.example.model.OrderItem;
import org.example.model.Product;
import org.example.model.User;
import org.example.repository.OrderItemRepository;
import org.example.repository.OrderRepository;
import org.example.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
@Transactional
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderItemRepository orderItemRepository;

    @Autowired
    private ProductRepository productRepository;

    // ==================== СУЩЕСТВУЮЩИЕ МЕТОДЫ ====================

    public List<Order> findAll() {
        return orderRepository.findAll();
    }

    public Order findById(Integer id) {
        return orderRepository.findById(id).orElseThrow(() -> new RuntimeException("Заказ не найден"));
    }

    @Transactional
    public void save(Order order) {
        orderRepository.save(order);
    }


    public void update(Integer id, Order order) {
        Order existingOrder = findById(id);
        existingOrder.setOrderDate(order.getOrderDate());
        existingOrder.setStatus(order.getStatus());
        existingOrder.setTotalPrice(order.getTotalPrice());
        existingOrder.setUser(order.getUser());  // Изменено с setUserID на setUser
        orderRepository.save(existingOrder);
    }

    public List<Order> getByUserId(Integer id) {
        return orderRepository.findByUserId(id);  // Изменено с findByUserID на findByUserId
    }

    public void delete(Integer id) {
        orderRepository.deleteById(id);
    }

    public List<Product> findAllProductById(Integer id) {
        return orderRepository.findAllProductById(id);
    }

    // ==================== НОВЫЕ МЕТОДЫ ДЛЯ ОФОРМЛЕНИЯ ЗАКАЗА ====================

    public List<Order> findByUser(User user) {
        return orderRepository.findByUser(user);
    }

    @Transactional
    public Order createOrder(Order order, List<CartItemDto> cartItems) {
        // Сохраняем заказ
        order.setOrderDate(LocalDateTime.now());
        Order savedOrder = orderRepository.save(order);

        // Сохраняем товары в заказе
        if (cartItems != null && !cartItems.isEmpty()) {
            for (CartItemDto item : cartItems) {
                Product product = productRepository.findById(item.getProductId())
                        .orElseThrow(() -> new RuntimeException("Товар не найден: " + item.getProductId()));

                OrderItem orderItem = new OrderItem();
                orderItem.setOrder(savedOrder);
                orderItem.setProduct(product);
                orderItem.setQuantity(item.getQuantity());
                orderItem.setPrice(item.getPrice());

                orderItemRepository.save(orderItem);
            }
        }

        return savedOrder;
    }

    @Transactional
    public Order updateStatus(Integer orderId, String status) {
        Order order = findById(orderId);
        order.setStatus(status);
        return orderRepository.save(order);
    }

    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }
}