package org.example.controller;

import org.example.model.Article;
import org.example.model.ArticleReaction;
import org.example.model.User;
import org.example.repository.ArticleReactionRepository;
import org.example.repository.ArticleRepository;
import org.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/articles")
public class ArticleReactionController {

    @Autowired
    private ArticleReactionRepository reactionRepository;

    @Autowired
    private ArticleRepository articleRepository;

    @Autowired
    private UserService userService;

    @PostMapping("/{id}/like")
    public ResponseEntity<Map<String, Object>> likeArticle(@PathVariable Integer id, Authentication auth) {
        return handleReaction(id, "LIKE", auth);
    }

    @PostMapping("/{id}/dislike")
    public ResponseEntity<Map<String, Object>> dislikeArticle(@PathVariable Integer id, Authentication auth) {
        return handleReaction(id, "DISLIKE", auth);
    }

    @DeleteMapping("/{id}/reaction")
    public ResponseEntity<Map<String, Object>> removeReaction(@PathVariable Integer id, Authentication auth) {
        Map<String, Object> response = new HashMap<>();

        if (auth == null || !auth.isAuthenticated() || auth.getName().equals("anonymousUser")) {
            response.put("success", false);
            response.put("message", "Необходимо авторизоваться");
            return ResponseEntity.status(401).body(response);
        }

        User user = userService.findByUsername(auth.getName());
        if (user == null) {
            response.put("success", false);
            response.put("message", "Пользователь не найден");
            return ResponseEntity.badRequest().body(response);
        }

        Article article = articleRepository.findById(id).orElse(null);
        if (article == null) {
            response.put("success", false);
            response.put("message", "Статья не найдена");
            return ResponseEntity.badRequest().body(response);
        }

        ArticleReaction existingReaction = reactionRepository
                .findByArticleIdAndUserId(id, user.getId()).orElse(null);

        if (existingReaction != null) {
            // Удаляем реакцию
            if ("LIKE".equals(existingReaction.getReactionType())) {
                article.setLikes(article.getLikes() - 1);
            } else {
                article.setDislikes(article.getDislikes() - 1);
            }
            reactionRepository.delete(existingReaction);
            articleRepository.save(article);
        }

        response.put("success", true);
        response.put("likes", article.getLikes());
        response.put("dislikes", article.getDislikes());
        response.put("userReaction", null);

        return ResponseEntity.ok(response);
    }

    private ResponseEntity<Map<String, Object>> handleReaction(Integer articleId, String reactionType, Authentication auth) {
        Map<String, Object> response = new HashMap<>();

        if (auth == null || !auth.isAuthenticated() || auth.getName().equals("anonymousUser")) {
            response.put("success", false);
            response.put("message", "Необходимо авторизоваться");
            return ResponseEntity.status(401).body(response);
        }

        User user = userService.findByUsername(auth.getName());
        if (user == null) {
            response.put("success", false);
            response.put("message", "Пользователь не найден");
            return ResponseEntity.badRequest().body(response);
        }

        Article article = articleRepository.findById(articleId).orElse(null);
        if (article == null) {
            response.put("success", false);
            response.put("message", "Статья не найдена");
            return ResponseEntity.badRequest().body(response);
        }

        ArticleReaction existingReaction = reactionRepository
                .findByArticleIdAndUserId(articleId, user.getId()).orElse(null);

        if (existingReaction != null) {
            // Если уже есть реакция, удаляем её
            if ("LIKE".equals(existingReaction.getReactionType())) {
                article.setLikes(article.getLikes() - 1);
            } else {
                article.setDislikes(article.getDislikes() - 1);
            }
            reactionRepository.delete(existingReaction);

            // Если это была такая же реакция, просто удаляем
            if (existingReaction.getReactionType().equals(reactionType)) {
                articleRepository.save(article);
                response.put("success", true);
                response.put("likes", article.getLikes());
                response.put("dislikes", article.getDislikes());
                response.put("userReaction", null);
                response.put("message", "Реакция удалена");
                return ResponseEntity.ok(response);
            }
        }

        // Добавляем новую реакцию
        ArticleReaction reaction = new ArticleReaction();
        reaction.setArticle(article);
        reaction.setUser(user);
        reaction.setReactionType(reactionType);
        reactionRepository.save(reaction);

        if ("LIKE".equals(reactionType)) {
            article.setLikes(article.getLikes() + 1);
        } else {
            article.setDislikes(article.getDislikes() + 1);
        }
        articleRepository.save(article);

        response.put("success", true);
        response.put("likes", article.getLikes());
        response.put("dislikes", article.getDislikes());
        response.put("userReaction", reactionType);
        response.put("message", reactionType.equals("LIKE") ? "Лайк добавлен" : "Дизлайк добавлен");

        return ResponseEntity.ok(response);
    }
}