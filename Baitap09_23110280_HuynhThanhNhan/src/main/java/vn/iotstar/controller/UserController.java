package vn.iotstar.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.MutationMapping;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.stereotype.Controller;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;

import java.util.List;
import java.util.Optional;

@Controller
public class UserController {
    
    @Autowired
    private UserService userService;
    
    @QueryMapping
    public List<User> allUsers() {
        return userService.findAll();
    }
    
    @QueryMapping
    public User userById(@Argument Long id) {
        return userService.findById(id).orElse(null);
    }
    
    @QueryMapping
    public List<User> usersByCategory(@Argument Long categoryId) {
        return userService.findByCategoryId(categoryId);
    }
    
    @MutationMapping
    public User createUser(@Argument UserInput input) {
        User user = new User();
        user.setFullname(input.getFullname());
        user.setEmail(input.getEmail());
        user.setPassword(input.getPassword());
        user.setPhone(input.getPhone());
        return userService.save(user);
    }
    
    @MutationMapping
    public User updateUser(@Argument Long id, @Argument UserInput input) {
        Optional<User> existingUser = userService.findById(id);
        if (existingUser.isPresent()) {
            User user = existingUser.get();
            user.setFullname(input.getFullname());
            user.setEmail(input.getEmail());
            user.setPassword(input.getPassword());
            user.setPhone(input.getPhone());
            return userService.save(user);
        }
        return null;
    }
    
    @MutationMapping
    public Boolean deleteUser(@Argument Long id) {
        if (userService.existsById(id)) {
            userService.deleteById(id);
            return true;
        }
        return false;
    }
    
    public static class UserInput {
        private String fullname;
        private String email;
        private String password;
        private String phone;
        public String getFullname() { return fullname; }
        public void setFullname(String fullname) { this.fullname = fullname; }
        
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        
        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }
        
        public String getPhone() { return phone; }
        public void setPhone(String phone) { this.phone = phone; }
    }
}
