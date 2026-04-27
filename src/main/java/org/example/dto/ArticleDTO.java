package org.example.dto;

import lombok.Data;

@Data
public class ArticleDTO {
    private Integer id;
    private String title;
    private String slug;
    private String content;
    private String excerpt;
    private String imageUrl;
    private String articleType;
    private String articleTypeName;
    private String authorName;
    private String formattedDate;
    private Integer views;
    private Integer likes;
    private Integer dislikes;
    private String userReaction;
}