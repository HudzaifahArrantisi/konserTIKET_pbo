package com.concertapp.controller;

import com.concertapp.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class HomeController {
    
    @GetMapping("/")
    public String home(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        
        // Sample data for tickets
        List<Map<String, Object>> tickets = Arrays.asList(
            createTicket("DAY 1", "IDR 350K", 
                Arrays.asList("Basic Access", "General Area", "Food & Drinks (additional cost)")),
            createTicket("DAY 2", "IDR 750K", 
                Arrays.asList("VIP Area", "Premium View", "Special Merch", "Complimentary Drinks")),
            createTicket("DAY 3", "IDR 1.5M", 
                Arrays.asList("Backstage Access", "Meet & Greet", "VIP Lounge", "All Merch", "Premium Catering"))
        );
        
        model.addAttribute("user", user);
        model.addAttribute("tickets", tickets);
        
        // Tentukan view yang akan ditampilkan berdasarkan login status
        if (user != null) {
            return "index2"; // Halaman untuk user yang sudah login
        } else {
            return "index";  // Halaman untuk guest/tamu
        }
    }
    
    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        List<Map<String, Object>> tickets = Arrays.asList(
            createTicket("DAY 1", "IDR 350K", 
                Arrays.asList("Basic Access", "General Area", "Food & Drinks (additional cost)")),
            createTicket("DAY 2", "IDR 750K", 
                Arrays.asList("VIP Area", "Premium View", "Special Merch", "Complimentary Drinks")),
            createTicket("DAY 3", "IDR 1.5M", 
                Arrays.asList("Backstage Access", "Meet & Greet", "VIP Lounge", "All Merch", "Premium Catering"))
        );
        
        model.addAttribute("user", user);
        model.addAttribute("tickets", tickets);
        
        return "index2";
    }
    
    private Map<String, Object> createTicket(String label, String price, List<String> features) {
        Map<String, Object> ticket = new HashMap<>();
        ticket.put("label", label);
        ticket.put("price", price);
        ticket.put("features", features);
        return ticket;
    }
}