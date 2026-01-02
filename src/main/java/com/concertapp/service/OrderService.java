package com.concertapp.service;

import com.concertapp.model.*;
import com.concertapp.repository.OrderRepository;
import com.concertapp.repository.PaymentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

@Service
public class OrderService {
    
    @Autowired
    private OrderRepository orderRepository;
    
    @Autowired
    private PaymentRepository paymentRepository;
    
    @Autowired
    private CartService cartService;
    
    @Autowired
    private QRCodeService qrCodeService;
    
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
        savedOrder.setPayment(payment);
        
        // Clear cart
        cartService.clearCart(user);
        
        return orderRepository.save(savedOrder);
    }
    
    private String generateQRISData(Order order) {
        // Simulate QRIS data generation
        return "00020101021226650014ID.CO.QRIS.WWW0118936009110023265702ID5914The Hype Machine6011JAKARTA SELATAN61051235062230313HYPE" + 
               order.getOrderNumber() + "5802ID6304ABCD";
    }
    
    @Transactional
    public Order processPayment(String orderId) {
        Order order = orderRepository.findById(UUID.fromString(orderId))
                .orElseThrow(() -> new RuntimeException("Order not found"));
        
        if (!"PENDING".equals(order.getStatus())) {
            throw new RuntimeException("Order is not pending");
        }
        
        order.setStatus("PAID");
        order.setPaidDate(LocalDateTime.now());
        
        Payment payment = order.getPayment();
        if (payment != null) {
            payment.setStatus("SUCCESS");
            payment.setPaymentDate(LocalDateTime.now());
            paymentRepository.save(payment);
        }
        
        return orderRepository.save(order);
    }
    
    public java.util.List<Order> getUserOrders(User user) {
        return orderRepository.findByUser(user);
    }
    
    public java.util.List<Order> getUserPaidOrders(User user) {
        return orderRepository.findByUserAndStatus(user, "PAID");
    }
    
    public Order getOrderById(String orderId) {
        return orderRepository.findById(UUID.fromString(orderId))
                .orElse(null);
    }
}