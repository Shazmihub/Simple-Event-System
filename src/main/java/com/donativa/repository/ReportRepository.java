package com.donativa.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.donativa.entity.Report;


public interface ReportRepository extends JpaRepository<Report, Long> {
	List<Report> findAllByOrderByDateDesc();
}
