package com.donativa.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.donativa.entity.Request;
import com.donativa.request.RequestAdminDto;
import com.donativa.request.RequestDto;
import com.donativa.service.RequestService;

@RestController
@CrossOrigin
@RequestMapping("/api/requests")
public class RequestController {
	
	@Autowired
    private RequestService requestService;

    @PostMapping
    public ResponseEntity<?> joinEvent(@Valid @RequestBody RequestDto reqRequest) {
        Request request = requestService.joinEvent(reqRequest);
        return new ResponseEntity<>(request, HttpStatus.CREATED);
    }
    
    @PostMapping("/admin")
    public ResponseEntity<?> actionRequestByAdmin(@Valid @RequestBody RequestAdminDto reqRequest) {
        Request request = requestService.actionRequestByAdmin(reqRequest);
        return new ResponseEntity<>(request, HttpStatus.CREATED);
    }
    
    @GetMapping("/{userId}")
    public ResponseEntity<?> getAllRequestForUser(@PathVariable long userId) {
        List<Request> request = requestService.getAllRequestForUser(userId);
        return new ResponseEntity<>(request, HttpStatus.CREATED);
    }
}
