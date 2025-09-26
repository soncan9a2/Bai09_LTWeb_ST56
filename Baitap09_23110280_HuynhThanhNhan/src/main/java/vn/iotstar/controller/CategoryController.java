package vn.iotstar.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.MutationMapping;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.stereotype.Controller;
import vn.iotstar.entity.Category;
import vn.iotstar.service.CategoryService;

import java.util.List;
import java.util.Optional;

@Controller
public class CategoryController {
    
    @Autowired
    private CategoryService categoryService;
    
    @QueryMapping
    public List<Category> allCategories() {
        return categoryService.findAll();
    }
    
    @QueryMapping
    public Category categoryById(@Argument Long id) {
        return categoryService.findById(id).orElse(null);
    }
    
    @QueryMapping
    public List<Category> categoriesByUser(@Argument Long userId) {
        return categoryService.findByUserId(userId);
    }
    
    @MutationMapping
    public Category createCategory(@Argument CategoryInput input) {
        Category category = new Category();
        category.setName(input.getName());
        category.setImages(input.getImages());
        return categoryService.save(category);
    }
    
    @MutationMapping
    public Category updateCategory(@Argument Long id, @Argument CategoryInput input) {
        Optional<Category> existingCategory = categoryService.findById(id);
        if (existingCategory.isPresent()) {
            Category category = existingCategory.get();
            category.setName(input.getName());
            category.setImages(input.getImages());
            return categoryService.save(category);
        }
        return null;
    }
    
    @MutationMapping
    public Boolean deleteCategory(@Argument Long id) {
        if (categoryService.existsById(id)) {
            categoryService.deleteById(id);
            return true;
        }
        return false;
    }
    
    public static class CategoryInput {
        private String name;
        private String images;
        public String getName() { return name; }
        public void setName(String name) { this.name = name; }
        
        public String getImages() { return images; }
        public void setImages(String images) { this.images = images; }
    }
}
