package com.concertapp.repository;

import com.concertapp.model.Cart;
import com.concertapp.model.CartItem;
import com.concertapp.model.TicketCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface CartItemRepository extends JpaRepository<CartItem, UUID> {
    Optional<CartItem> findByCartAndTicketCategory(Cart cart, TicketCategory ticketCategory);
    void deleteByCart(Cart cart);
}