package org.example.controller;

import org.example.dto.ArticleDTO;
import org.example.model.Article;
import org.example.model.User;
import org.example.service.ArticleService;
import org.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/blog")
public class ArticleController {

    @Autowired
    private ArticleService articleService;

    @Autowired
    private UserService userService;

    @GetMapping
    public String blog(@RequestParam(defaultValue = "1") int page, Model model, Authentication authentication) {
        try {
            Page<Article> articlesPage = articleService.getAllArticles(page);

            Integer currentUserId;
            if (authentication != null && authentication.isAuthenticated() &&
                    !authentication.getName().equals("anonymousUser")) {
                User user = userService.findByUsername(authentication.getName());
                if (user != null) {
                    currentUserId = user.getId();
                } else {
                    currentUserId = null;
                }
            } else {
                currentUserId = null;
            }

            List<ArticleDTO> articleDTOs = articlesPage.getContent().stream()
                    .map(article -> {
                        ArticleDTO dto = articleService.convertToDTO(article, currentUserId);
                        if (dto.getSlug() == null || dto.getSlug().isEmpty()) {
                            dto.setSlug("article-" + dto.getId());
                        }
                        return dto;
                    })
                    .collect(Collectors.toList());

            // Получаем последние статьи для боковой панели
            List<Article> latestArticlesList = articleService.getLatestArticles();
            List<ArticleDTO> latestArticles = latestArticlesList.stream()
                    .map(article -> articleService.convertToDTO(article, currentUserId))
                    .collect(Collectors.toList());

            model.addAttribute("articles", articleDTOs);
            model.addAttribute("latestArticles", latestArticles);
            model.addAttribute("currentPage", page);
            model.addAttribute("title", "Блог");
            model.addAttribute("totalPages", articlesPage.getTotalPages());

            return "blog/blog";  // ← ИСПРАВЛЕНО: убрал /info

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Ошибка загрузки статей: " + e.getMessage());
            return "error";
        }
    }

    @GetMapping("/category/{type}")
    public String category(@PathVariable String type, @RequestParam(defaultValue = "1") int page,
                           Model model, Authentication authentication) {
        try {
            Page<Article> articlesPage = articleService.getArticlesByType(type.toUpperCase(), page);

            Integer currentUserId;
            if (authentication != null && authentication.isAuthenticated() &&
                    !authentication.getName().equals("anonymousUser")) {
                User user = userService.findByUsername(authentication.getName());
                if (user != null) {
                    currentUserId = user.getId();
                } else {
                    currentUserId = null;
                }
            } else {
                currentUserId = null;
            }

            List<ArticleDTO> articleDTOs = articlesPage.getContent().stream()
                    .map(article -> articleService.convertToDTO(article, currentUserId))
                    .collect(Collectors.toList());

            List<Article> latestArticlesList = articleService.getLatestArticles();
            List<ArticleDTO> latestArticles = latestArticlesList.stream()
                    .map(article -> articleService.convertToDTO(article, currentUserId))
                    .collect(Collectors.toList());

            model.addAttribute("articles", articleDTOs);
            model.addAttribute("latestArticles", latestArticles);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", articlesPage.getTotalPages());
            model.addAttribute("currentType", type.toLowerCase());

            return "blog/blog";  // ← ИСПРАВЛЕНО: убрал /info

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Ошибка загрузки категории: " + e.getMessage());
            return "error";
        }
    }

    @GetMapping("/search")
    public String search(@RequestParam String q, @RequestParam(defaultValue = "1") int page,
                         Model model, Authentication authentication) {
        try {
            Page<Article> articlesPage = articleService.searchArticles(q, page);

            Integer currentUserId;
            if (authentication != null && authentication.isAuthenticated() &&
                    !authentication.getName().equals("anonymousUser")) {
                User user = userService.findByUsername(authentication.getName());
                if (user != null) {
                    currentUserId = user.getId();
                } else {
                    currentUserId = null;
                }
            } else {
                currentUserId = null;
            }

            List<ArticleDTO> articleDTOs = articlesPage.getContent().stream()
                    .map(article -> articleService.convertToDTO(article, currentUserId))
                    .collect(Collectors.toList());

            List<Article> latestArticlesList = articleService.getLatestArticles();
            List<ArticleDTO> latestArticles = latestArticlesList.stream()
                    .map(article -> articleService.convertToDTO(article, currentUserId))
                    .collect(Collectors.toList());

            model.addAttribute("articles", articleDTOs);
            model.addAttribute("latestArticles", latestArticles);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", articlesPage.getTotalPages());
            model.addAttribute("searchQuery", q);

            return "blog/blog";  // ← ИСПРАВЛЕНО: убрал /info

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Ошибка поиска: " + e.getMessage());
            return "error";
        }
    }

    @GetMapping("/{slug}")
    public String articleDetail(@PathVariable String slug, Model model, Authentication authentication) {
        try {
            System.out.println("=== ПОПЫТКА ОТКРЫТЬ СТАТЬЮ ===");
            System.out.println("Slug: " + slug);

            Article article = articleService.getArticleBySlug(slug);
            System.out.println("Найдена статья: " + (article != null ? article.getTitle() : "НЕТ"));

            if (article == null) {
                System.out.println("Статья не найдена, редирект на /blog");
                return "redirect:/blog";
            }

            articleService.incrementViews(article.getId());

            Integer currentUserId;
            String userReaction = null;

            if (authentication != null && authentication.isAuthenticated() &&
                    !authentication.getName().equals("anonymousUser")) {
                User user = userService.findByUsername(authentication.getName());
                if (user != null) {
                    currentUserId = user.getId();
                    var reaction = articleService.getUserReaction(article.getId(), currentUserId);
                    if (reaction != null) {
                        userReaction = reaction.getReactionType();
                    }
                } else {
                    currentUserId = null;
                }
            } else {
                currentUserId = null;
            }

            ArticleDTO articleDTO = articleService.convertToDTO(article, currentUserId);
            if (userReaction != null) {
                articleDTO.setUserReaction(userReaction);
            }

            List<Article> similarArticles = articleService.getSimilarArticles(article.getId(), article.getArticleType());

            if (similarArticles.size() > 3) {
                similarArticles = similarArticles.subList(0, 3);
            }

            List<ArticleDTO> similarArticlesDTO = similarArticles.stream()
                    .map(a -> articleService.convertToDTO(a, currentUserId))
                    .collect(Collectors.toList());

            model.addAttribute("article", articleDTO);

            model.addAttribute("latestArticles", similarArticlesDTO);  // Изменено название атрибута

            return "blog/article-detail";

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Ошибка загрузки статьи: " + e.getMessage());
            return "error";
        }
    }
}