package com.concertapp.model;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "concerts")
public class Concert {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;
    
    @Column(nullable = false)
    private String name;
    
    private String location;
    private LocalDate startDate;
    private LocalDate endDate;
    private String description;
    
    @OneToMany(mappedBy = "concert", cascade = CascadeType.ALL)
    private List<TicketCategory> ticketCategories = new ArrayList<>();
    
    public Concert() {}
    
    // Getters and Setters
    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    
    public LocalDate getStartDate() { return startDate; }
    public void setStartDate(LocalDate startDate) { this.startDate = startDate; }
    
    public LocalDate getEndDate() { return endDate; }
    public void setEndDate(LocalDate endDate) { this.endDate = endDate; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public List<TicketCategory> getTicketCategories() { return ticketCategories; }
    public void setTicketCategories(List<TicketCategory> ticketCategories) { 
        this.ticketCategories = ticketCategories; 
    }
}