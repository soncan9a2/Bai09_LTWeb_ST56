package vn.iotstar.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import vn.iotstar.entity.User;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    
    Optional<User> findByEmail(String email);
    
    List<User> findByFullnameContaining(String fullname);
    
    @Query("SELECT u FROM User u JOIN u.categories c WHERE c.id = :categoryId")
    List<User> findByCategoryId(Long categoryId);
}
