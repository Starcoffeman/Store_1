package org.example.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Data
@Entity
@NoArgsConstructor
@Table(name = "articles")
public class Article {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "title", nullable = false, length = 200)
    private String title;

    @Column(name = "slug", unique = true, nullable = false, length = 200)
    private String slug;

    @Column(name = "content", nullable = false, columnDefinition = "TEXT")
    private String content;

    @Column(name = "excerpt", length = 500)
    private String excerpt;

    @Column(name = "image_url", length = 500)
    private String imageUrl;

    @Column(name = "article_type")
    private String articleType = "NEWS";

    @Column(name = "status")
    private String status = "PUBLISHED";

    @Column(name = "views")
    private Integer views = 0;

    @Column(name = "likes")
    private Integer likes = 0;

    @Column(name = "dislikes")
    private Integer dislikes = 0;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "author_id")
    private User author;

    @Column(name = "published_at")
    private LocalDateTime publishedAt;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (publishedAt == null) {
            publishedAt = LocalDateTime.now();
        }
        if (slug == null || slug.isEmpty()) {
            slug = generateSlug(title);
        }
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    private String generateSlug(String title) {
        return title.toLowerCase()
                .replaceAll("[^a-zа-яё0-9\\s]", "")
                .replaceAll("\\s+", "-")
                .replaceAll("-+", "-");
    }

    public String getFormattedDate() {
        if (publishedAt == null) return "";
        return publishedAt.getDayOfMonth() + " " +
                getMonthName(publishedAt.getMonthValue()) + " " +
                publishedAt.getYear();
    }

    @Transient
    public String getArticleTypeName() {
        if (articleType == null) return "Статья";
        switch (articleType) {
            case "NEWS": return "Новость";
            case "REVIEW": return "Обзор";
            case "TIPS": return "Совет";
            case "GUIDE": return "Гайд";
            default: return "Статья";
        }
    }

    private String getMonthName(int month) {
        String[] months = {"янв", "фев", "мар", "апр", "май", "июн",
                "июл", "авг", "сен", "окт", "ноя", "дек"};
        return months[month - 1];
    }
}