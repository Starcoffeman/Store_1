package org.example.controller;

import jakarta.validation.Valid;
import org.example.model.Brand;
import org.example.service.BrandService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/brands")
public class BrandController {

    @Autowired
    private BrandService brandService;

    // Список всех брендов
    @GetMapping
    public String listBrands(Model model) {
        model.addAttribute("brands", brandService.findAll());
        return "brands/list";
    }

    // Форма добавления бренда
    @GetMapping("/add")
    public String addBrandForm(Model model) {
        model.addAttribute("brand", new Brand());
        return "brands/add";
    }

    // Обработка добавления бренда
    @PostMapping("/add")
    public String addBrand(@Valid @ModelAttribute("brand") Brand brand,
                           BindingResult bindingResult,
                           RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            return "brands/add";
        }

        if (brandService.existsByName(brand.getName())) {
            redirectAttributes.addFlashAttribute("error", "Бренд с таким названием уже существует");
            return "redirect:/brands/add";
        }

        brandService.save(brand);
        redirectAttributes.addFlashAttribute("success", "Бренд успешно добавлен");
        return "redirect:/brands";
    }

    // Форма редактирования бренда
    @GetMapping("/edit/{id}")
    public String editBrandForm(@PathVariable Integer id, Model model) {
        Brand brand = brandService.findById(id);
        model.addAttribute("brand", brand);
        return "brands/edit";
    }

    // Обработка редактирования бренда
    @PostMapping("/edit/{id}")
    public String editBrand(@PathVariable Integer id,
                            @Valid @ModelAttribute("brand") Brand brand,
                            BindingResult bindingResult,
                            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            return "brands/edit";
        }

        Brand existingBrand = brandService.findById(id);

        // Проверяем, не занято ли новое имя другим брендом
        if (!existingBrand.getName().equals(brand.getName()) && brandService.existsByName(brand.getName())) {
            redirectAttributes.addFlashAttribute("error", "Бренд с таким названием уже существует");
            return "redirect:/brands/edit/" + id;
        }

        brandService.update(id, brand);
        redirectAttributes.addFlashAttribute("success", "Бренд успешно обновлён");
        return "redirect:/brands";
    }

    // Удаление бренда
    @GetMapping("/delete/{id}")
    public String deleteBrand(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        try {
            brandService.delete(id);
            redirectAttributes.addFlashAttribute("success", "Бренд успешно удалён");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Нельзя удалить бренд, так как есть товары, привязанные к нему");
        }
        return "redirect:/brands";
    }
}