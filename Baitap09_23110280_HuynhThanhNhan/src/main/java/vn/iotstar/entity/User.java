package vn.iotstar.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Set;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "users")
public class User {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false, columnDefinition = "NVARCHAR(255)")
    private String fullname;
    
    @Column(nullable = false, unique = true, columnDefinition = "NVARCHAR(255)")
    private String email;
    
    @Column(nullable = false, columnDefinition = "NVARCHAR(255)")
    private String password;
    
    @Column(length = 20, columnDefinition = "NVARCHAR(20)")
    private String phone;
    
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<Product> products;
    
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
        name = "category_user",
        joinColumns = @JoinColumn(name = "user_id"),
        inverseJoinColumns = @JoinColumn(name = "category_id")
    )
    private Set<Category> categories;
}
