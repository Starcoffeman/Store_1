package org.example.controller;

import org.example.model.Product;
import org.example.model.User;
import org.example.service.ProductService;
import org.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/favorites")
public class FavoritesController {

    @Autowired
    private UserService userService;

    @Autowired
    private ProductService productService;

    // Страница избранного
    @GetMapping
    @Transactional(readOnly = true)
    public String favoritesPage(Model model, Principal principal) {
        if (principal == null) {
            return "redirect:/login";
        }

        User user = userService.findByUsername(principal.getName());
        List<Product> favorites = new ArrayList<>();

        // Теперь коллекция favorites будет инициализирована в рамках транзакции
        if (user != null && user.getFavorites() != null && !user.getFavorites().isEmpty()) {
            List<Integer> ids = user.getFavorites();
            favorites = productService.findAllFavoriteProductByIds(ids);
        }

        model.addAttribute("favorites", favorites);
        model.addAttribute("favoritesCount", favorites.size());
        return "favorites/favorites";
    }

    @PostMapping("/add/{productId}")
    @ResponseBody
    public String addToFavorites(@PathVariable int productId, Principal principal) {
        if (principal == null) {
            return "unauthorized";
        }

        User user = userService.findByUsername(principal.getName());
        List<Integer> favorites = user.getFavorites();

        if (favorites == null) {
            favorites = new ArrayList<>();
        }

        if (!favorites.contains(productId)) {
            favorites.add(productId);
            user.setFavorites(favorites);
            userService.save(user);
            return "added";
        }

        return "exists";
    }

    @DeleteMapping("/remove/{productId}")
    @ResponseBody
    public String removeFromFavorites(@PathVariable int productId, Principal principal) {
        if (principal == null) {
            return "unauthorized";
        }

        User user = userService.findByUsername(principal.getName());
        List<Integer> favorites = user.getFavorites();

        if (favorites != null && favorites.contains(productId)) {
            favorites.remove(Integer.valueOf(productId));
            user.setFavorites(favorites);
            userService.save(user);
            return "removed";
        }

        return "not_found";
    }

    // Удаление из избранного (GET, для кнопки на странице)
    @GetMapping("/remove/{productId}")
    public String removeFavorite(@PathVariable int productId, Principal principal) {
        if (principal != null) {
            User user = userService.findByUsername(principal.getName());
            List<Integer> favorites = user.getFavorites();

            if (favorites != null && favorites.contains(productId)) {
                favorites.remove(Integer.valueOf(productId));
                user.setFavorites(favorites);
                userService.save(user);
            }
        }

        return "redirect:/favorites";
    }

    @PostMapping("/clear")
    public String clearFavorites(Principal principal) {
        if (principal != null) {
            User user = userService.findByUsername(principal.getName());
            user.setFavorites(new ArrayList<>());
            userService.save(user);
        }

        return "redirect:/favorites";
    }

    @GetMapping("/count")
    @ResponseBody
    public int getFavoritesCount(Principal principal) {
        if (principal == null) {
            return 0;
        }
        User user = userService.findByUsername(principal.getName());
        if (user != null && user.getFavorites() != null) {
            return user.getFavorites().size();
        }
        return 0;
    }

    @GetMapping("/ids")
    @ResponseBody
    public List<Integer> getFavoritesIds(Principal principal) {
        if (principal == null) {
            return new ArrayList<>();
        }
        User user = userService.findByUsername(principal.getName());
        if (user != null && user.getFavorites() != null) {
            return user.getFavorites();
        }
        return new ArrayList<>();
    }
}