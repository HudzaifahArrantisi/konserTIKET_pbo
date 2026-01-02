package com.concertapp.service;

import com.concertapp.model.*;
import com.concertapp.repository.OrderRepository;
import com.concertapp.repository.PaymentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
public class OrderServiceSimple {
    
    @Autowired
    private OrderRepository orderRepository;
    
    @Autowired
    private PaymentRepository paymentRepository;
    
    @Autowired
    private CartService cartService;
    
    @Transactional
    public Order createOrderFromCart(User user) {
        Cart cart = cartService.getCartByUser(user);
        
        if (cart.getItems().isEmpty()) {
            throw new RuntimeException("Cart is empty");
        }
        
        // Create order
        Order order = new Order();
        order.setUser(user);
        order.setTotalAmount(cart.getTotalAmount());
        
        // Save order
        Order savedOrder = orderRepository.save(order);
        
        // Create payment
        Payment payment = new Payment();
        payment.setOrder(savedOrder);
        payment.setAmount(savedOrder.getTotalAmount());
        payment.setQrisData(generateQRISData(savedOrder));
        
        paymentRepository.save(payment);
        
        // Clear cart
        cartService.clearCart(user);
        
        return savedOrder;
    }
    
    private String generateQRISData(Order order) {
        return "QRIS-DUMMY-DATA-" + order.getOrderNumber();
    }
    
    public List<Order> getUserOrders(User user) {
        return orderRepository.findByUser(user);
    }
    
    public List<Order> getUserPaidOrders(User user) {
        return orderRepository.findByUserAndStatus(user, "PAID");
    }
}