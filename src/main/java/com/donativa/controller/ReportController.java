package com.donativa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.donativa.repository.ReportRepository;

@RestController
@CrossOrigin
@RequestMapping("/api/reports")
public class ReportController {
	
	@Autowired
    private ReportRepository reportRepo;
	
	@GetMapping
    public ResponseEntity<?> getAllReports() {
        return new ResponseEntity<>(reportRepo.findAllByOrderByDateDesc(), HttpStatus.OK);
    }

}
