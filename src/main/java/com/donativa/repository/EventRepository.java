package com.donativa.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.donativa.entity.Event;

@Repository
public interface EventRepository extends JpaRepository<Event, Long> {

	List<Event> findAllByNameContainingIgnoreCaseOrderByCreatedDateDesc(@Param("name") String name);

}
