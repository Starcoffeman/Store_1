package org.example.repository;

import org.example.model.ArticleReaction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import java.util.Optional;

@Repository
public interface ArticleReactionRepository extends JpaRepository<ArticleReaction, Integer> {

    Optional<ArticleReaction> findByArticleIdAndUserId(Integer articleId, Integer userId);

    @Modifying
    @Transactional
    @Query("DELETE FROM ArticleReaction r WHERE r.article.id = :articleId AND r.user.id = :userId")
    void deleteByArticleIdAndUserId(@Param("articleId") Integer articleId, @Param("userId") Integer userId);

    long countByArticleIdAndReactionType(Integer articleId, String reactionType);
}