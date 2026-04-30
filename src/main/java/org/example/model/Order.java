package org.example.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "orders")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "order_date", nullable = false)
    private LocalDateTime orderDate;

    @Column(name = "status", nullable = false)
    private String status;

    @Column(name = "total_price", nullable = false)
    private Double totalPrice;

    @Column(name = "delivery_method", nullable = false)
    private String deliveryMethod;

    @Column(name = "payment_method", nullable = false)
    private String paymentMethod;

    @Column(name = "address", length = 500)
    private String address;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrderItem> orderItems = new ArrayList<>();

    // Вспомогательные методы
    public void addOrderItem(OrderItem item) {
        orderItems.add(item);
        item.setOrder(this);
    }

    public void removeOrderItem(OrderItem item) {
        orderItems.remove(item);
        item.setOrder(null);
    }

    @Transient
    public Integer getUserID() {
        return user != null ? user.getId() : null;
    }

    public void setUserID(Integer userId) {
        if (userId != null) {
            User u = new User();
            u.setId(userId);
            this.user = u;
        }
    }
}