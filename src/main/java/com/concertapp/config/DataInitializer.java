package com.concertapp.config;

import com.concertapp.model.Concert;
import com.concertapp.model.TicketCategory;
import com.concertapp.repository.ConcertRepository;
import com.concertapp.repository.TicketCategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;

@Component
public class DataInitializer implements CommandLineRunner {
    
    @Autowired
    private ConcertRepository concertRepository;
    
    @Autowired
    private TicketCategoryRepository ticketCategoryRepository;
    
    @Override
    @Transactional
    public void run(String... args) {
        // Initialize sample concerts if none exist
        if (concertRepository.count() == 0) {
            createSampleConcert();
        }
    }
    
    private void createSampleConcert() {
        // Create The Hype Machine concert
        Concert hypeMachine = new Concert();
        hypeMachine.setName("The Hype Machine Festival 2025");
        hypeMachine.setLocation("Jakarta International Stadium");
        hypeMachine.setDescription("The biggest music festival in Indonesia with 50+ international artists");
        hypeMachine.setStartDate(LocalDate.of(2025, 12, 10));
        hypeMachine.setEndDate(LocalDate.of(2025, 12, 13));
        
        Concert savedConcert = concertRepository.save(hypeMachine);
        
        // Create ticket categories
        TicketCategory day1 = new TicketCategory();
        day1.setConcert(savedConcert);
        day1.setName("Day 1");
        day1.setDescription("Basic Access - General Area");
        day1.setPrice(new BigDecimal("350000"));
        day1.setStock(5000);
        
        TicketCategory day2 = new TicketCategory();
        day2.setConcert(savedConcert);
        day2.setName("Day 2");
        day2.setDescription("VIP Area - Premium View");
        day2.setPrice(new BigDecimal("750000"));
        day2.setStock(3000);
        
        TicketCategory day3 = new TicketCategory();
        day3.setConcert(savedConcert);
        day3.setName("Day 3");
        day3.setDescription("Backstage Access - Meet & Greet");
        day3.setPrice(new BigDecimal("1500000"));
        day3.setStock(2000);
        
        ticketCategoryRepository.save(day1);
        ticketCategoryRepository.save(day2);
        ticketCategoryRepository.save(day3);
    }
}