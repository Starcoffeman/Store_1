package org.example.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "reviews")
public class Review {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;  // Добавьте это поле!

    @Column(name = "rating")
    private Integer rating;

    @Column(name = "comment")
    private String comment;

    @Column(name = "review_date")
    private LocalDateTime reviewDate;

    @Transient
    public Integer getUserID() {
        return user != null ? user.getId() : null;
    }

    @Transient
    public Integer getProductID() {
        return product != null ? product.getId() : null;
    }

    @Transient
    public String getUserName() {
        return user != null ? user.getUsername() : "Пользователь";
    }
}