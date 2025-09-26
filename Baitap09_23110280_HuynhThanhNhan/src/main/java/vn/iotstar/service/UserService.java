package vn.iotstar.service;

import vn.iotstar.entity.User;

import java.util.List;
import java.util.Optional;

public interface UserService {
    
    List<User> findAll();
    
    Optional<User> findById(Long id);
    
    Optional<User> findByEmail(String email);
    
    List<User> findByFullnameContaining(String fullname);
    
    List<User> findByCategoryId(Long categoryId);
    
    User save(User user);
    
    void deleteById(Long id);
    
    void delete(User user);
    
    boolean existsById(Long id);
}
