package vn.iotstar.service;

import vn.iotstar.entity.Category;

import java.util.List;
import java.util.Optional;

public interface CategoryService {
    
    List<Category> findAll();
    
    Optional<Category> findById(Long id);
    
    Optional<Category> findByName(String name);
    
    List<Category> findByNameContaining(String name);
    
    List<Category> findByUserId(Long userId);
    
    Category save(Category category);
    
    void deleteById(Long id);
    
    void delete(Category category);
    
    boolean existsById(Long id);
}
