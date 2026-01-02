package com.concertapp.service;

import com.concertapp.model.Cart;
import com.concertapp.model.User;
import com.concertapp.repository.UserRepository;
import com.concertapp.util.PasswordUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;
import java.util.UUID;

@Service
public class UserService {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private CartService cartService;
    
    @Autowired
    private PasswordUtil passwordUtil;
    
    public User register(User user) {
        // Check if email already exists
        if (userRepository.existsByEmail(user.getEmail())) {
            throw new RuntimeException("Email already registered");
        }
        
        // Hash password
        user.setPassword(passwordUtil.encode(user.getPassword()));
        
        // Save user
        User savedUser = userRepository.save(user);
        
        // Create cart for user
        Cart cart = new Cart();
        cart.setUser(savedUser);
        cartService.saveCart(cart);
        
        savedUser.setCart(cart);
        return userRepository.save(savedUser);
    }
    
    public Optional<User> login(String email, String password) {
        Optional<User> userOpt = userRepository.findByEmail(email);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            if (passwordUtil.matches(password, user.getPassword())) {
                return Optional.of(user);
            }
        }
        return Optional.empty();
    }
    
    @Transactional
    public void deleteUser(UUID userId) {
        userRepository.deleteById(userId);
    }
    
    public Optional<User> findById(UUID userId) {
        return userRepository.findById(userId);
    }
    
    public User updateUser(User user) {
        return userRepository.save(user);
    }
}