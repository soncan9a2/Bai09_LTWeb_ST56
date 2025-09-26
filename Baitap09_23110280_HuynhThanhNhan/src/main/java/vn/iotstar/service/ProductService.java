package vn.iotstar.service;

import vn.iotstar.entity.Product;

import java.util.List;
import java.util.Optional;

public interface ProductService {
    
    List<Product> findAll();
    
    Optional<Product> findById(Long id);
    
    List<Product> findByTitleContaining(String title);
    
    List<Product> findByCategoryId(Long categoryId);
    
    List<Product> findByUserId(Long userId);
    
    List<Product> findAllOrderByPriceAsc();
    
    List<Product> findByCategoryIdOrderByPriceAsc(Long categoryId);
    
    List<Product> findByPriceBetweenOrderByPriceAsc(Double minPrice, Double maxPrice);
    
    Product save(Product product);
    
    void deleteById(Long id);
    
    void delete(Product product);
    
    boolean existsById(Long id);
}
