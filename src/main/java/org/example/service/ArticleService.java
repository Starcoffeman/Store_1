package org.example.service;

import org.example.dto.ArticleDTO;
import org.example.model.Article;
import org.example.model.ArticleReaction;
import org.example.model.User;
import org.example.repository.ArticleReactionRepository;
import org.example.repository.ArticleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ArticleService {

    @Autowired
    private ArticleRepository articleRepository;

    @Autowired
    private ArticleReactionRepository reactionRepository;

    @Autowired
    private UserService userService;

    private static final int ARTICLES_PER_PAGE = 9;

    @Transactional(readOnly = true)
    public Page<Article> getAllArticles(int page) {
        Pageable pageable = PageRequest.of(page - 1, ARTICLES_PER_PAGE,
                Sort.by(Sort.Direction.DESC, "publishedAt"));
        return articleRepository.findPublishedArticles(pageable);
    }

    @Transactional(readOnly = true)
    public List<Article> getLatestArticles() {
        return articleRepository.findTop6ByStatusOrderByPublishedAtDesc("PUBLISHED");
    }

    @Transactional(readOnly = true)
    public Article getArticleBySlug(String slug) {
        return articleRepository.findBySlug(slug).orElse(null);
    }

    @Transactional
    public void incrementViews(Integer id) {
        articleRepository.incrementViews(id);
    }

    @Transactional(readOnly = true)
    public Page<Article> getArticlesByType(String type, int page) {
        Pageable pageable = PageRequest.of(page - 1, ARTICLES_PER_PAGE,
                Sort.by(Sort.Direction.DESC, "publishedAt"));
        return articleRepository.findByArticleType(type, pageable);
    }

    @Transactional(readOnly = true)
    public Page<Article> searchArticles(String keyword, int page) {
        Pageable pageable = PageRequest.of(page - 1, ARTICLES_PER_PAGE,
                Sort.by(Sort.Direction.DESC, "publishedAt"));
        return articleRepository.searchArticles(keyword, pageable);
    }

    @Transactional(readOnly = true)
    public ArticleReaction getUserReaction(Integer articleId, Integer userId) {
        return reactionRepository.findByArticleIdAndUserId(articleId, userId).orElse(null);
    }

    @Transactional(readOnly = true)
    public ArticleDTO convertToDTO(Article article, Integer currentUserId) {
        ArticleDTO dto = new ArticleDTO();
        dto.setId(article.getId());
        dto.setTitle(article.getTitle());
        dto.setSlug(article.getSlug());
        dto.setContent(article.getContent());
        dto.setExcerpt(article.getExcerpt());
        dto.setImageUrl(article.getImageUrl());
        dto.setArticleType(article.getArticleType());
        dto.setArticleTypeName(getTypeName(article.getArticleType()));

        // Безопасное получение имени автора (уже загружено в транзакции)
//        if (article.getAuthor() != null) {
//            dto.setAuthorName(article.getAuthor().getName() + " " + article.getAuthor().getSurname());
//            dto.setAuthorId(article.getAuthor().getId());
//        } else {
//            dto.setAuthorName("Админ");
//            dto.setAuthorId(null);
//        }

        dto.setFormattedDate(article.getFormattedDate());
        dto.setViews(article.getViews());
        dto.setLikes(article.getLikes());
        dto.setDislikes(article.getDislikes());

        if (currentUserId != null) {
            ArticleReaction reaction = reactionRepository
                    .findByArticleIdAndUserId(article.getId(), currentUserId).orElse(null);
            if (reaction != null) {
                dto.setUserReaction(reaction.getReactionType());
            }
        }

        return dto;
    }

    private String getTypeName(String type) {
        switch (type) {
            case "NEWS": return "Новость";
            case "REVIEW": return "Обзор";
            case "TIPS": return "Совет";
            case "GUIDE": return "Гайд";
            default: return "Статья";
        }
    }

    @Transactional(readOnly = true)
    public List<Article> getSimilarArticles(Integer currentArticleId, String articleType) {
        // Получаем статьи того же типа, исключая текущую, сортируем по дате
        return articleRepository.findSimilarArticles(currentArticleId, articleType);
    }
}