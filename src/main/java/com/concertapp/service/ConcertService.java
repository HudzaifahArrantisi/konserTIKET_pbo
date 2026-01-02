package com.concertapp.service;

import com.concertapp.model.Concert;
import com.concertapp.model.TicketCategory;
import com.concertapp.repository.ConcertRepository;
import com.concertapp.repository.TicketCategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

@Service
public class ConcertService {
    
    @Autowired
    private ConcertRepository concertRepository;
    
    @Autowired
    private TicketCategoryRepository ticketCategoryRepository;
    
    public List<Concert> getAllConcerts() {
        return concertRepository.findAll();
    }
    
    public Concert getActiveConcert() {
        List<Concert> concerts = concertRepository.findAll();
        if (concerts.isEmpty()) {
            return createSampleConcert();
        }
        return concerts.get(0);
    }
    
    private Concert createSampleConcert() {
        Concert concert = new Concert();
        concert.setName("The Hype Machine Festival 2025");
        concert.setLocation("Jakarta International Stadium");
        concert.setStartDate(LocalDate.of(2025, 12, 10));
        concert.setEndDate(LocalDate.of(2025, 12, 13));
        concert.setDescription("The biggest music festival in Indonesia with 50+ international artists");
        
        Concert savedConcert = concertRepository.save(concert);
        
        // Create ticket categories
        createTicketCategories(savedConcert);
        
        return savedConcert;
    }
    
    private void createTicketCategories(Concert concert) {
        TicketCategory day1 = new TicketCategory();
        day1.setConcert(concert);
        day1.setName("Day 1");
        day1.setDescription("Basic Access - General Area");
        day1.setPrice(new BigDecimal("350000"));
        day1.setStock(5000);
        
        TicketCategory day2 = new TicketCategory();
        day2.setConcert(concert);
        day2.setName("Day 2");
        day2.setDescription("VIP Area - Premium View");
        day2.setPrice(new BigDecimal("750000"));
        day2.setStock(3000);
        
        TicketCategory day3 = new TicketCategory();
        day3.setConcert(concert);
        day3.setName("Day 3");
        day3.setDescription("Backstage Access - Meet & Greet");
        day3.setPrice(new BigDecimal("1500000"));
        day3.setStock(2000);
        
        ticketCategoryRepository.saveAll(Arrays.asList(day1, day2, day3));
    }
    
    public TicketCategory getTicketCategoryById(UUID id) {
        return ticketCategoryRepository.findById(id).orElse(null);
    }
    
    public List<TicketCategory> getTicketCategoriesByConcert(UUID concertId) {
        return ticketCategoryRepository.findByConcertId(concertId);
    }
}