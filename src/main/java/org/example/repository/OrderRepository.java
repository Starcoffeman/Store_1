package org.example.repository;

import org.example.model.Order;
import org.example.model.Product;
import org.example.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Integer> {
    // Поиск заказов по ID пользователя (Integer)
    List<Order> findByUserId(Integer userId);

    // Поиск заказов по пользователю (User)
    List<Order> findByUser(User user);

    // Поиск всех товаров в заказе (если нужно)
    @Query("SELECT oi.product FROM OrderItem oi WHERE oi.order.id = :orderId")
    List<Product> findAllProductById(@Param("orderId") Integer orderId);
}
