package org.example.controller;

import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.example.dto.ProductDTO;
import org.example.mapper.ProductMapper;
import org.example.model.Category;
import org.example.model.Product;
import org.example.model.User;
import org.example.service.CategoryService;
import org.example.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Slf4j
@Controller
@RequestMapping("/category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ProductService productService;

    @GetMapping
    public String index(Model model) {
        List<Category> categories = categoryService.findAll();
        model.addAttribute("categories", categories);
        return "category/categories";
    }

    @GetMapping("/search")
    public String searchProducts(
            @RequestParam(value = "query", required = false, defaultValue = "") String searchQuery,
            Model model) {

        List<Product> allProducts = productService.findAll();
        List<Product> searchResults;

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            String query = searchQuery.trim().toLowerCase();
            searchResults = allProducts.stream()
                    .filter(product ->
                            product.getName().toLowerCase().contains(query) ||
                                    (product.getBrand() != null && product.getBrand().getName().toLowerCase().contains(query)) ||
                                    (product.getCategory() != null && product.getCategory().getName().toLowerCase().contains(query)) ||
                                    (product.getDescription() != null && product.getDescription().toLowerCase().contains(query))
                    )
                    .collect(Collectors.toList());
        } else {
            searchResults = allProducts;
        }

        // Конвертируем в DTO для единообразия
        List<ProductDTO> productDTOs = searchResults.stream()
                .map(ProductMapper::convertToDTO)
                .collect(Collectors.toList());

        model.addAttribute("products", productDTOs);
        model.addAttribute("searchQuery", searchQuery);
        model.addAttribute("resultsCount", searchResults.size());

        return "/search";
    }

    @GetMapping("/add")
    public String addUserForm(Model model) {
        model.addAttribute("category", new Category());
        return "category/add";
    }

    @PostMapping("/add")
    public String addUser(@Valid Category category, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            return "category/add";
        }
        categoryService.save(category);
        return "redirect:/category";
    }

    @GetMapping("/edit/{id}")
    public String editUserForm(@PathVariable int id, Model model) {
        Category category = categoryService.findById(id);
        model.addAttribute("category", category);
        return "category/edit";
    }

    @PostMapping("/edit/{id}")
    public String editUser(@PathVariable int id, @Valid Category category, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            return "category/edit";
        }
        categoryService.update(id, category);
        return "redirect:/category";
    }

    @GetMapping("/delete/{id}")
    public String deleteUser(@PathVariable int id) {
        categoryService.delete(id);
        return "redirect:/category";
    }

    // ========== ИСПРАВЛЕННЫЕ МЕТОДЫ ДЛЯ КАТЕГОРИЙ ==========

    @GetMapping("/notebooks")
    public String categoryNotebooks(Model model) {
        List<Product> products = productService.findAllByCategoryName("Ноутбуки");
        List<ProductDTO> productDTOs = products.stream()
                .map(ProductMapper::convertToDTO)
                .collect(Collectors.toList());

        // Собираем уникальные бренды для фильтрации
        Set<String> brandsSet = new HashSet<>();
        for (Product product : products) {
            if (product.getBrand() != null && product.getBrand().getName() != null && !product.getBrand().getName().isEmpty()) {
                brandsSet.add(product.getBrand().getName());
            }
        }

        model.addAttribute("products", productDTOs);
        model.addAttribute("brands", brandsSet);
        model.addAttribute("currentCategory", "Ноутбуки");
        return "category/notebooks";
    }

    @GetMapping("/smartphones")
    public String categorySmartphones(Model model) {
        List<Product> products = productService.findAllByCategoryName("Смартфоны");
        List<ProductDTO> productDTOs = products.stream()
                .map(ProductMapper::convertToDTO)
                .collect(Collectors.toList());

        Set<String> brandsSet = new HashSet<>();
        for (Product product : products) {
            if (product.getBrand() != null && product.getBrand().getName() != null && !product.getBrand().getName().isEmpty()) {
                brandsSet.add(product.getBrand().getName());
            }
        }

        model.addAttribute("products", productDTOs);
        model.addAttribute("brands", brandsSet);
        model.addAttribute("currentCategory", "Смартфоны");
        return "category/smartphones";
    }

    @GetMapping("/tv")
    public String categoryTv(Model model) {
        List<Product> products = productService.findAllByCategoryName("Телевизоры");
        List<ProductDTO> productDTOs = products.stream()
                .map(ProductMapper::convertToDTO)
                .collect(Collectors.toList());

        Set<String> brandsSet = new HashSet<>();
        for (Product product : products) {
            if (product.getBrand() != null && product.getBrand().getName() != null && !product.getBrand().getName().isEmpty()) {
                brandsSet.add(product.getBrand().getName());
            }
        }

        model.addAttribute("products", productDTOs);
        model.addAttribute("brands", brandsSet);
        model.addAttribute("currentCategory", "Телевизоры");
        return "category/tv";
    }

    @GetMapping("/audio")
    public String categoryAudio(Model model) {
        List<Product> products = productService.findAllByCategoryName("Аудиотехника");
        List<ProductDTO> productDTOs = products.stream()
                .map(ProductMapper::convertToDTO)
                .collect(Collectors.toList());

        Set<String> brandsSet = new HashSet<>();
        for (Product product : products) {
            if (product.getBrand() != null && product.getBrand().getName() != null && !product.getBrand().getName().isEmpty()) {
                brandsSet.add(product.getBrand().getName());
            }
        }

        model.addAttribute("products", productDTOs);
        model.addAttribute("brands", brandsSet);
        model.addAttribute("currentCategory", "Аудиотехника");
        return "category/audio";
    }

    @GetMapping("/gaming")
    public String categoryGaming(Model model) {
        List<Product> products = productService.findAllByCategoryName("Игровые товары");
        List<ProductDTO> productDTOs = products.stream()
                .map(ProductMapper::convertToDTO)
                .collect(Collectors.toList());

        Set<String> brandsSet = new HashSet<>();
        for (Product product : products) {
            if (product.getBrand() != null && product.getBrand().getName() != null && !product.getBrand().getName().isEmpty()) {
                brandsSet.add(product.getBrand().getName());
            }
        }

        model.addAttribute("products", productDTOs);
        model.addAttribute("brands", brandsSet);
        model.addAttribute("currentCategory", "Игровые товары");
        return "category/gaming";
    }

    @GetMapping("/accessories")
    public String categoryAccessories(Model model) {
        List<Product> products = productService.findAllByCategoryName("Аксессуары");
        List<ProductDTO> productDTOs = products.stream()
                .map(ProductMapper::convertToDTO)
                .collect(Collectors.toList());

        Set<String> brandsSet = new HashSet<>();
        for (Product product : products) {
            if (product.getBrand() != null && product.getBrand().getName() != null && !product.getBrand().getName().isEmpty()) {
                brandsSet.add(product.getBrand().getName());
            }
        }

        model.addAttribute("products", productDTOs);
        model.addAttribute("brands", brandsSet);
        model.addAttribute("currentCategory", "Аксессуары");
        return "category/accessories";
    }
}