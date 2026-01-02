package com.concertapp.repository;

import com.concertapp.model.Ticket;
import com.concertapp.model.TicketCategory;
import com.concertapp.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface TicketRepository extends JpaRepository<Ticket, UUID> {
    List<Ticket> findByOrderUserId(UUID userId);
    List<Ticket> findByTicketCategory(TicketCategory ticketCategory);
}