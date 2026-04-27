package org.example.service;

import org.example.model.Review;
import org.example.repository.ReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class ReviewService {

    @Autowired
    private ReviewRepository reviewRepository;

    public List<Review> findAll() {
        return reviewRepository.findAll();
    }

    public Review findById(Integer id) {
        return reviewRepository.findById(id).orElseThrow(() -> new RuntimeException("Отзыв не найден"));
    }

    @Transactional
    public void save(Review review) {
        reviewRepository.save(review);
    }

    @Transactional
    public void update(Integer id, Review review) {
        Review existingReview = findById(id);
        existingReview.setRating(review.getRating());
        existingReview.setComment(review.getComment());
        existingReview.setUser(review.getUser());
        existingReview.setProduct(review.getProduct());
        existingReview.setReviewDate(java.time.LocalDateTime.now());
        reviewRepository.save(existingReview);
    }

    @Transactional
    public void delete(Integer id) {
        reviewRepository.deleteById(id);
    }

    public List<Review> getByUserId(Integer userId) {
        return reviewRepository.findByUserId(userId);
    }

    public List<Review> findByProductId(Integer productId) {
        return reviewRepository.findByProductId(productId);
    }
}