package com.donativa.service;

import java.util.Date;
import java.util.Optional;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.donativa.entity.Report;
import com.donativa.entity.Users;
import com.donativa.exception.DonativaException;
import com.donativa.repository.ReportRepository;
import com.donativa.repository.UserRepository;
import com.donativa.request.LoginRequest;
import com.donativa.request.SignupRequest;

@Service
public class UserService {
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	ReportRepository reportRepository;
	
	public static final String SPACE = " ";

	public Users authenticateUser(@Valid LoginRequest loginRequest) {
		Optional<Users> userOptional = userRepository.findByEmailAndPassword(loginRequest.getEmail(), loginRequest.getPassword());
		if(!userOptional.isPresent()) {
			throw new DonativaException("Incorrect username or password");
		}
		Users users = userOptional.get();
		
		String msg = new StringBuilder().append(users.getFirstName())
				.append(SPACE)
				.append(users.getLastName())
				.append(SPACE)
				.append("logged in successfully")
				.toString();
		saveReport(msg);
		return userOptional.get();
	}
	
	public Users registerUser(SignupRequest signUpRequest) {
		if (userRepository.existsByEmail(signUpRequest.getEmail())) {
			throw new DonativaException("Error: Email is already in use!");
		}

		// Create new user's account
		Users user = new Users(signUpRequest.getFirstName(),signUpRequest.getLastName(), 
				signUpRequest.getEmail(), signUpRequest.getPassword(),
				signUpRequest.getRole());
		String msg = new StringBuilder().append(signUpRequest.getFirstName())
				.append(SPACE)
				.append(signUpRequest.getLastName())
				.append(SPACE)
				.append("registered as")
				.append(SPACE)
				.append(signUpRequest.getRole())
				.toString();
		saveReport(msg);
		return userRepository.save(user);
	}

	public Users updateUser(long userId, @Valid SignupRequest signUpRequest) {
		Optional<Users> userOptional = userRepository.findById(userId);
		if(!userOptional.isPresent()) {
			throw new DonativaException("User not found");
		}
		Users user = userOptional.get();
		user.setEmail(signUpRequest.getEmail());
		user.setFirstName(signUpRequest.getFirstName());
		user.setLastName(signUpRequest.getLastName());
		user.setPassword(signUpRequest.getPassword());
		user.setRole(signUpRequest.getRole());

		String msg = new StringBuilder().append(signUpRequest.getFirstName())
				.append(SPACE)
				.append(signUpRequest.getLastName())
				.append(SPACE)
				.append("updated the profile information")
				.toString();
		saveReport(msg);
		return userRepository.save(user);
	}
	
	public Users getUser(long userId) {
		Optional<Users> userOptional = userRepository.findById(userId);
		if(!userOptional.isPresent()) {
			throw new DonativaException("User not found");
		}
		return userOptional.get();
	}
	
	public void saveReport(String msg) {
		Report report = new Report();
		report.setMessage(msg);
		report.setDate(new Date());
		reportRepository.save(report);
	}

}
