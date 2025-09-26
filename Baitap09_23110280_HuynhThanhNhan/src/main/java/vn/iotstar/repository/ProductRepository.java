package vn.iotstar.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import vn.iotstar.entity.Product;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    
    List<Product> findByTitleContaining(String title);
    
    List<Product> findByCategoryId(Long categoryId);
    
    List<Product> findByUserId(Long userId);
    
    @Query("SELECT p FROM Product p ORDER BY p.price ASC")
    List<Product> findAllOrderByPriceAsc();
    
    @Query("SELECT p FROM Product p WHERE p.category.id = :categoryId ORDER BY p.price ASC")
    List<Product> findByCategoryIdOrderByPriceAsc(Long categoryId);
    
    @Query("SELECT p FROM Product p WHERE p.price BETWEEN :minPrice AND :maxPrice ORDER BY p.price ASC")
    List<Product> findByPriceBetweenOrderByPriceAsc(Double minPrice, Double maxPrice);
}
