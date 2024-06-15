package com.donativa.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.donativa.request.LoginRequest;
import com.donativa.request.SignupRequest;
import com.donativa.service.UserService;

@CrossOrigin
@RestController
@RequestMapping("/api/user")
public class UserController {

	@Autowired
	UserService userService;

	@PostMapping("/signin")
	public ResponseEntity<?> authenticateUser(@Valid @RequestBody LoginRequest loginRequest) {
		return ResponseEntity.ok().body(userService.authenticateUser(loginRequest));
	}

	@PostMapping("/signup")
	public ResponseEntity<?> registerUser(@Valid @RequestBody SignupRequest signUpRequest) {
		return ResponseEntity.status(HttpStatus.CREATED).body(userService.registerUser(signUpRequest));
	}
	
	@PutMapping("/profile/update/{userId}")
	public ResponseEntity<?> updateUser(@Valid @RequestBody SignupRequest signUpRequest, @PathVariable("userId") long userId) {
		return ResponseEntity.status(HttpStatus.OK).body(userService.updateUser(userId, signUpRequest));
	}
	
	@GetMapping("/profile/{userId}")
	public ResponseEntity<?> getUser(@PathVariable("userId") long userId) {
		return ResponseEntity.ok().body(userService.getUser(userId));
	}
}
