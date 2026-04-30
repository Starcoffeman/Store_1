package org.example.service;

import org.example.model.Brand;
import org.example.repository.BrandRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BrandService {

    @Autowired
    private BrandRepository brandRepository;

    public List<Brand> findAll() {
        return brandRepository.findAll();
    }

    public Brand findById(Integer id) {
        return brandRepository.findById(id).orElseThrow(() -> new RuntimeException("Бренд не найден"));
    }

    public Brand findByName(String name) {
        return brandRepository.findByName(name);
    }

    public boolean existsByName(String name) {
        return brandRepository.existsByName(name);
    }

    public void save(Brand brand) {
        brandRepository.save(brand);
    }

    public void update(Integer id, Brand brand) {
        Brand existingBrand = findById(id);
        existingBrand.setName(brand.getName());
        brandRepository.save(existingBrand);
    }

    public void delete(Integer id) {
        brandRepository.deleteById(id);
    }
}