package org.example.repository;

import org.example.model.CartItem;
import org.example.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
public interface CartRepository extends JpaRepository<CartItem, Integer> {

    List<CartItem> findByUser(User user);

    Optional<CartItem> findByUserAndProductId(User user, Integer productId);

    @Modifying
    @Transactional
    @Query("DELETE FROM CartItem c WHERE c.user = :user")
    void deleteAllByUser(@Param("user") User user);

    @Modifying
    @Transactional
    @Query("DELETE FROM CartItem c WHERE c.user = :user AND c.product.id = :productId")
    void deleteByUserAndProductId(@Param("user") User user, @Param("productId") Integer productId);

    @Modifying
    @Transactional
    @Query("UPDATE CartItem c SET c.quantity = :quantity WHERE c.user = :user AND c.product.id = :productId")
    void updateQuantity(@Param("user") User user, @Param("productId") Integer productId, @Param("quantity") Integer quantity);
}