package vn.iotstar.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.iotstar.entity.Product;
import vn.iotstar.repository.ProductRepository;
import vn.iotstar.service.ProductService;

import java.util.List;
import java.util.Optional;

@Service
public class ProductServiceImpl implements ProductService {
    
    @Autowired
    private ProductRepository productRepository;
    
    @Override
    public List<Product> findAll() {
        return productRepository.findAll();
    }
    
    @Override
    public Optional<Product> findById(Long id) {
        return productRepository.findById(id);
    }
    
    @Override
    public List<Product> findByTitleContaining(String title) {
        return productRepository.findByTitleContaining(title);
    }
    
    @Override
    public List<Product> findByCategoryId(Long categoryId) {
        return productRepository.findByCategoryId(categoryId);
    }
    
    @Override
    public List<Product> findByUserId(Long userId) {
        return productRepository.findByUserId(userId);
    }
    
    @Override
    public List<Product> findAllOrderByPriceAsc() {
        return productRepository.findAllOrderByPriceAsc();
    }
    
    @Override
    public List<Product> findByCategoryIdOrderByPriceAsc(Long categoryId) {
        return productRepository.findByCategoryIdOrderByPriceAsc(categoryId);
    }
    
    @Override
    public List<Product> findByPriceBetweenOrderByPriceAsc(Double minPrice, Double maxPrice) {
        return productRepository.findByPriceBetweenOrderByPriceAsc(minPrice, maxPrice);
    }
    
    @Override
    public Product save(Product product) {
        return productRepository.save(product);
    }
    
    @Override
    public void deleteById(Long id) {
        productRepository.deleteById(id);
    }
    
    @Override
    public void delete(Product product) {
        productRepository.delete(product);
    }
    
    @Override
    public boolean existsById(Long id) {
        return productRepository.existsById(id);
    }
}
