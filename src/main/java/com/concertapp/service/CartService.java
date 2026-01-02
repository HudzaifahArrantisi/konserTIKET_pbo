package com.concertapp.service;

import com.concertapp.model.Cart;
import com.concertapp.model.CartItem;
import com.concertapp.model.TicketCategory;
import com.concertapp.model.User;
import com.concertapp.repository.CartItemRepository;
import com.concertapp.repository.CartRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;
import java.util.UUID;

@Service
public class CartService {
    
    @Autowired
    private CartRepository cartRepository;
    
    @Autowired
    private CartItemRepository cartItemRepository;
    
    @Autowired
    private ConcertService concertService;
    
    public Cart getCartByUser(User user) {
        return cartRepository.findByUser(user)
                .orElseGet(() -> createCartForUser(user));
    }
    
    private Cart createCartForUser(User user) {
        Cart cart = new Cart();
        cart.setUser(user);
        return cartRepository.save(cart);
    }
    
    public Cart saveCart(Cart cart) {
        return cartRepository.save(cart);
    }
    
    @Transactional
    public void addItemToCart(User user, String ticketCategoryId, int quantity) {
        Cart cart = getCartByUser(user);
        UUID categoryId = UUID.fromString(ticketCategoryId);
        TicketCategory ticketCategory = concertService.getTicketCategoryById(categoryId);
        
        if (ticketCategory == null) {
            throw new RuntimeException("Ticket category not found");
        }
        
        // Check if item already exists in cart
        Optional<CartItem> existingItem = cartItemRepository.findByCartAndTicketCategory(cart, ticketCategory);
        
        if (existingItem.isPresent()) {
            // Update quantity
            CartItem item = existingItem.get();
            item.setQuantity(item.getQuantity() + quantity);
            cartItemRepository.save(item);
        } else {
            // Add new item
            CartItem newItem = new CartItem();
            newItem.setCart(cart);
            newItem.setTicketCategory(ticketCategory);
            newItem.setQuantity(quantity);
            cartItemRepository.save(newItem);
        }
        
        // Update cart total
        cartRepository.save(cart);
    }
    
    @Transactional
    public void removeItemFromCart(User user, String cartItemId) {
        Cart cart = getCartByUser(user);
        UUID itemId = UUID.fromString(cartItemId);
        cartItemRepository.deleteById(itemId);
        cartRepository.save(cart);
    }
    
    @Transactional
    public void updateCartItemQuantity(User user, String cartItemId, int quantity) {
        if (quantity <= 0) {
            removeItemFromCart(user, cartItemId);
            return;
        }
        
        UUID itemId = UUID.fromString(cartItemId);
        cartItemRepository.findById(itemId).ifPresent(item -> {
            item.setQuantity(quantity);
            cartItemRepository.save(item);
            Cart cart = getCartByUser(user);
            cartRepository.save(cart);
        });
    }
    
    @Transactional
    public void clearCart(User user) {
        Cart cart = getCartByUser(user);
        cartItemRepository.deleteByCart(cart);
        cart.getItems().clear();
        cart.setTotalAmount(java.math.BigDecimal.ZERO);
        cartRepository.save(cart);
    }
}