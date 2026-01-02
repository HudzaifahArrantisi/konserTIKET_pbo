package com.concertapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TestController {
    
    @GetMapping("/test")
    @ResponseBody
    public String test() {
        return "Application is running! Server time: " + java.time.LocalDateTime.now();
    }
    
    @GetMapping("/health")
    @ResponseBody
    public String health() {
        return "OK - Application is healthy";
    }
}