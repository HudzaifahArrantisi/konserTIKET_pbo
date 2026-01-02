package com.concertapp.controller;

import com.concertapp.model.Order;
import com.concertapp.model.User;
import com.concertapp.service.OrderService;
import com.concertapp.service.QRCodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/payment")
public class PaymentController {
    
    @Autowired
    private OrderService orderService;
    
    @Autowired
    private QRCodeService qrCodeService;
    
    @GetMapping("/qris/{orderId}")
    public String showQRIS(@PathVariable String orderId, Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        Order order = orderService.getOrderById(orderId);
        if (order == null || !order.getUser().getId().equals(user.getId())) {
            return "redirect:/cart";
        }
        
        model.addAttribute("order", order);
        model.addAttribute("qrCode", qrCodeService.generateQRCode(
            order.getPayment().getQrisData(), 300, 300));
        
        return "payment/qris";
    }
    
    @PostMapping("/confirm/{orderId}")
    public String confirmPayment(@PathVariable String orderId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        orderService.processPayment(orderId);
        return "redirect:/profile/orders?success=true";
    }
}