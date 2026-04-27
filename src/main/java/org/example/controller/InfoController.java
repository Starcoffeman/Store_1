package org.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class InfoController {

    @GetMapping("/delivery")
    public String deliveryPage(Model model) {
        model.addAttribute("title", "Доставка и оплата");
        model.addAttribute("page", "delivery");
        return "/info/delivery";
    }

    @GetMapping("/returns")
    public String returnsPage(Model model) {
        model.addAttribute("title", "Возврат товара");
        model.addAttribute("page", "returns");
        return "/info/returns";
    }

    @GetMapping("/warranty")
    public String warrantyPage(Model model) {
        model.addAttribute("title", "Гарантия");
        model.addAttribute("page", "warranty");
        return "/info/warranty";
    }

    @GetMapping("/faq")
    public String faqPage(Model model) {
        model.addAttribute("title", "Вопросы и ответы");
        model.addAttribute("page", "faq");
        return "/info/faq";
    }

    @GetMapping("/about")
    public String aboutPage(Model model) {
        model.addAttribute("title", "О нас");
        model.addAttribute("page", "about");
        return "/info/about";
    }

    @GetMapping("/contacts")
    public String contactsPage(Model model) {
        model.addAttribute("title", "Контакты");
        model.addAttribute("page", "contacts");
        return "/info/contacts";
    }

    @GetMapping("/vacancies")
    public String vacanciesPage(Model model) {
        model.addAttribute("title", "Вакансии");
        model.addAttribute("page", "vacancies");
        return "/info/vacancies";
    }
}