package com.concertapp.controller;

import com.concertapp.model.User;
import com.concertapp.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/cart")
public class CartController {
    
    @Autowired
    private CartService cartService;
    
    @GetMapping
    public String viewCart(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        model.addAttribute("cart", cartService.getCartByUser(user));
        return "cart/view";
    }
    
    @PostMapping("/add")
    public String addToCart(@RequestParam String ticketCategoryId,
                           @RequestParam(defaultValue = "1") int quantity,
                           HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        cartService.addItemToCart(user, ticketCategoryId, quantity);
        return "redirect:/cart";
    }
    
    @PostMapping("/remove/{itemId}")
    public String removeFromCart(@PathVariable String itemId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        cartService.removeItemFromCart(user, itemId);
        return "redirect:/cart";
    }
    
    @PostMapping("/update")
    public String updateCart(@RequestParam String itemId,
                            @RequestParam int quantity,
                            HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        cartService.updateCartItemQuantity(user, itemId, quantity);
        return "redirect:/cart";
    }
}