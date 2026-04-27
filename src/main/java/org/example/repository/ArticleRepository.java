package org.example.repository;

import org.example.model.Article;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Repository
public interface ArticleRepository extends JpaRepository<Article, Integer> {

    // JOIN FETCH для загрузки автора вместе со статьей
    @Query("SELECT DISTINCT a FROM Article a LEFT JOIN FETCH a.author WHERE a.slug = :slug")
    Optional<Article> findBySlug(@Param("slug") String slug);

    // JOIN FETCH для страницы со статьями
    @Query("SELECT DISTINCT a FROM Article a LEFT JOIN FETCH a.author WHERE a.status = 'PUBLISHED' ORDER BY a.publishedAt DESC")
    Page<Article> findPublishedArticles(Pageable pageable);

    @Query("SELECT DISTINCT a FROM Article a LEFT JOIN FETCH a.author WHERE a.status = 'PUBLISHED' AND a.articleType = :type ORDER BY a.publishedAt DESC")
    Page<Article> findByArticleType(@Param("type") String type, Pageable pageable);

    @Query("SELECT DISTINCT a FROM Article a LEFT JOIN FETCH a.author WHERE a.status = 'PUBLISHED' AND (a.title LIKE %:keyword% OR a.content LIKE %:keyword%) ORDER BY a.publishedAt DESC")
    Page<Article> searchArticles(@Param("keyword") String keyword, Pageable pageable);

    @Query("SELECT DISTINCT a FROM Article a LEFT JOIN FETCH a.author WHERE a.status = 'PUBLISHED' ORDER BY a.publishedAt DESC")
    List<Article> findTop6ByStatusOrderByPublishedAtDesc(@Param("status") String status, Pageable pageable);

    // Перегруженный метод без Pageable
    default List<Article> findTop6ByStatusOrderByPublishedAtDesc(String status) {
        return findTop6ByStatusOrderByPublishedAtDesc(status, PageRequest.of(0, 6));
    }

    @Modifying
    @Transactional
    @Query("UPDATE Article a SET a.views = a.views + 1 WHERE a.id = :id")
    void incrementViews(@Param("id") Integer id);

    @Query("SELECT a FROM Article a WHERE a.status = 'PUBLISHED' AND a.articleType = :articleType AND a.id != :currentArticleId ORDER BY a.publishedAt DESC")
    List<Article> findSimilarArticles(@Param("currentArticleId") Integer currentArticleId, @Param("articleType") String articleType);
}