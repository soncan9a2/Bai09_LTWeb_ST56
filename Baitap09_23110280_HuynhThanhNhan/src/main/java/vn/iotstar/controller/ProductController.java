package vn.iotstar.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.MutationMapping;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.stereotype.Controller;
import vn.iotstar.entity.Product;
import vn.iotstar.entity.User;
import vn.iotstar.entity.Category;
import vn.iotstar.service.ProductService;
import vn.iotstar.service.UserService;
import vn.iotstar.service.CategoryService;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Controller
public class ProductController {
    
    @Autowired
    private ProductService productService;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private CategoryService categoryService;
    
    @QueryMapping
    public List<Product> allProducts() {
        return productService.findAll();
    }
    
    @QueryMapping
    public List<Product> productsByPriceAsc() {
        return productService.findAllOrderByPriceAsc();
    }
    
    @QueryMapping
    public List<Product> productsByCategory(@Argument Long categoryId) {
        return productService.findByCategoryId(categoryId);
    }
    
    @QueryMapping
    public List<Product> productsByCategoryOrderByPrice(@Argument Long categoryId) {
        return productService.findByCategoryIdOrderByPriceAsc(categoryId);
    }
    
    @QueryMapping
    public Product productById(@Argument Long id) {
        return productService.findById(id).orElse(null);
    }
    
    @MutationMapping
    public Product createProduct(@Argument ProductInput input) {
        Product product = new Product();
        product.setTitle(input.getTitle());
        product.setQuantity(input.getQuantity());
        product.setDescription(input.getDescription());
        product.setPrice(BigDecimal.valueOf(input.getPrice()));
        
        if (input.getUserId() != null) {
            Optional<User> user = userService.findById(input.getUserId());
            user.ifPresent(product::setUser);
        }
        
        if (input.getCategoryId() != null) {
            Optional<Category> category = categoryService.findById(input.getCategoryId());
            category.ifPresent(product::setCategory);
        }
        
        return productService.save(product);
    }
    
    @MutationMapping
    public Product updateProduct(@Argument Long id, @Argument ProductInput input) {
        Optional<Product> existingProduct = productService.findById(id);
        if (existingProduct.isPresent()) {
            Product product = existingProduct.get();
            product.setTitle(input.getTitle());
            product.setQuantity(input.getQuantity());
            product.setDescription(input.getDescription());
            product.setPrice(BigDecimal.valueOf(input.getPrice()));
            
            if (input.getUserId() != null) {
                Optional<User> user = userService.findById(input.getUserId());
                user.ifPresent(product::setUser);
            }
            
            if (input.getCategoryId() != null) {
                Optional<Category> category = categoryService.findById(input.getCategoryId());
                category.ifPresent(product::setCategory);
            }
            
            return productService.save(product);
        }
        return null;
    }
    
    @MutationMapping
    public Boolean deleteProduct(@Argument Long id) {
        if (productService.existsById(id)) {
            productService.deleteById(id);
            return true;
        }
        return false;
    }
    
    public static class ProductInput {
        private String title;
        private Integer quantity;
        private String description;
        private Double price;
        private Long userId;
        private Long categoryId;
        public String getTitle() { return title; }
        public void setTitle(String title) { this.title = title; }
        
        public Integer getQuantity() { return quantity; }
        public void setQuantity(Integer quantity) { this.quantity = quantity; }
        
        public String getDescription() { return description; }
        public void setDescription(String description) { this.description = description; }
        
        public Double getPrice() { return price; }
        public void setPrice(Double price) { this.price = price; }
        
        public Long getUserId() { return userId; }
        public void setUserId(Long userId) { this.userId = userId; }
        
        public Long getCategoryId() { return categoryId; }
        public void setCategoryId(Long categoryId) { this.categoryId = categoryId; }
    }
}
