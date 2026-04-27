package org.example.service;

import org.example.dto.CartItemDto;
import org.example.dto.CartResponse;
import org.example.model.CartItem;
import org.example.model.Product;
import org.example.model.User;
import org.example.repository.CartRepository;
import org.example.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
public class CartService {

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private ProductRepository productRepository;

    @Transactional
    public CartItem addToCart(User user, Integer productId, Integer quantity) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Товар не найден"));

        Optional<CartItem> existingItem = cartRepository.findByUserAndProductId(user, productId);

        if (existingItem.isPresent()) {
            CartItem cartItem = existingItem.get();
            cartItem.setQuantity(cartItem.getQuantity() + quantity);
            return cartRepository.save(cartItem);
        } else {
            CartItem cartItem = new CartItem(user, product, quantity);
            return cartRepository.save(cartItem);
        }
    }

    @Transactional
    public void removeFromCart(User user, Integer productId) {
        cartRepository.deleteByUserAndProductId(user, productId);
    }

    @Transactional
    public void updateQuantity(User user, Integer productId, Integer quantity) {
        if (quantity <= 0) {
            removeFromCart(user, productId);
        } else {
            cartRepository.updateQuantity(user, productId, quantity);
        }
    }

    @Transactional
    public void clearCart(User user) {
        cartRepository.deleteAllByUser(user);
    }

    public List<CartItem> getCartItems(User user) {
        return cartRepository.findByUser(user);
    }

    public CartResponse getCartResponse(User user) {
        List<CartItem> cartItems = getCartItems(user);
        List<CartItemDto> items = new ArrayList<>();
        int totalCount = 0;
        double totalPrice = 0;

        for (CartItem item : cartItems) {
            Product product = item.getProduct();
            double subtotal = product.getPrice() * item.getQuantity();
            totalCount += item.getQuantity();
            totalPrice += subtotal;

            items.add(new CartItemDto(
                    item.getId(),
                    product.getId(),
                    product.getName(),
                    product.getFileurl(),
                    product.getPrice(),
                    item.getQuantity(),
                    subtotal
            ));
        }

        return new CartResponse(items, totalCount, totalPrice);
    }

    public int getCartCount(User user) {
        return cartRepository.findByUser(user).stream()
                .mapToInt(CartItem::getQuantity)
                .sum();
    }
}