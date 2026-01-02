package com.concertapp.repository;

import com.concertapp.model.Concert;
import com.concertapp.model.TicketCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface TicketCategoryRepository extends JpaRepository<TicketCategory, UUID> {
    List<TicketCategory> findByConcert(Concert concert);
    List<TicketCategory> findByConcertId(UUID concertId);
}