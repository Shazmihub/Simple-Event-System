package com.donativa.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.donativa.entity.Request;

@Repository
public interface RequestRepository extends JpaRepository<Request, Long> {

	List<Request> findAllByStatus(String string);

	List<Request> findAllByRequestedByIdOrderByRequestedDateDesc(long userId);
	
	Request findByRequestedByIdAndEventId(long userId, long eventId);
	
}
