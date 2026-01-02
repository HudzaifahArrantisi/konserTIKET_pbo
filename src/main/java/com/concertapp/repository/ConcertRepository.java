package com.concertapp.repository;

import com.concertapp.model.Concert;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface ConcertRepository extends JpaRepository<Concert, UUID> {
}