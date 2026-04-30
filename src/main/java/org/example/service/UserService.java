package org.example.service;

import org.example.model.User;
import org.example.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public User findById(Integer id) {
        return userRepository.findById(id).orElseThrow(() -> new RuntimeException("Пользователь с таким не найден"));
    }

    public void save(User user) {
        userRepository.save(user);
    }

    public void update(Integer id, User user) {
        User existingUser = findById(id);
        existingUser.setUsername(user.getUsername());
        existingUser.setName(user.getName());
        existingUser.setSurname(user.getSurname());
        existingUser.setPassword(user.getPassword());
        existingUser.setEmail(user.getEmail());
        existingUser.setAddress(user.getAddress());
        userRepository.save(existingUser);
    }

    public void updateInProfile(Integer id, User user) {
        User existingUser = findById(id);
        existingUser.setUsername(user.getUsername());
        existingUser.setName(user.getName());
        existingUser.setSurname(user.getSurname());
        existingUser.setEmail(user.getEmail());
        existingUser.setAddress(user.getAddress());
        userRepository.save(existingUser);
    }

    public User getCurrentUser() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (principal instanceof UserDetails) {
            String username = ((UserDetails) principal).getUsername();
            return userRepository.findByUsername(username);
        }

        return null;
    }

    public void delete(Integer id) {
        userRepository.deleteById(Math.toIntExact(id));
    }

    @Transactional(readOnly = true)
    public User findByUsername(String username) {
        User user = userRepository.findByUsername(username);
        if (user != null && user.getFavorites() != null) {
            // Принудительная инициализация коллекции
            user.getFavorites().size();
        }
        return user;
    }

    // ВАЖНО: Добавьте @Transactional для этого метода
    @Transactional(readOnly = true)
    public boolean isProductInFavorites(String username, Integer productId) {
        User user = userRepository.findByUsername(username);
        if (user != null && user.getFavorites() != null) {
            // Инициализируем коллекцию в рамках транзакции
            user.getFavorites().size();
            return user.getFavorites().contains(productId);
        }
        return false;
    }

    public User findByUsernameAndEmail(String username, String email) {
        return userRepository.findByUsernameAndEmail(username, email);
    }
}