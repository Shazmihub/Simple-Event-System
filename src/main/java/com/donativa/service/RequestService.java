package com.donativa.service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.donativa.entity.Event;
import com.donativa.entity.Report;
import com.donativa.entity.Request;
import com.donativa.entity.Users;
import com.donativa.exception.DonativaException;
import com.donativa.repository.EventRepository;
import com.donativa.repository.ReportRepository;
import com.donativa.repository.RequestRepository;
import com.donativa.repository.UserRepository;
import com.donativa.request.RequestAdminDto;
import com.donativa.request.RequestDto;

@Service
public class RequestService {
	
	@Autowired
	UserRepository userRepo;
	
	@Autowired
	EventRepository eventRepo;
	
	@Autowired
	RequestRepository requestRepo;
	

	@Autowired
	ReportRepository reportRepository;
	
	public static final String SPACE = " ";

	public Request joinEvent(@Valid RequestDto reqRequest) {
		
		Optional<Event> eventOptional = eventRepo.findById(reqRequest.getEventId());
		if(!eventOptional.isPresent()) {
			throw new DonativaException("Event not found");
		}
		
		Users user = userRepo.findByIdAndRole(reqRequest.getUserId(), "user");
		if(user == null) {
			throw new DonativaException("UserId dont have permission");
		}
		Event event = eventOptional.get();
		
		Request request = requestRepo.findByRequestedByIdAndEventId(reqRequest.getUserId(), reqRequest.getEventId());
		if(request != null) {
			throw new DonativaException("Request already exists");
		}
		
		
		Request req = new Request();
		req.setEvent(event);
		req.setRequestedBy(user);
		req.setRequestedDate(new Date());
		req.setStatus("REQUESTED");
		
		String msg = new StringBuilder().append(user.getFirstName())
				.append(SPACE)
				.append(user.getLastName())
				.append(SPACE)
				.append("want to join the event")
				.append(SPACE)
				.append(event.getName())
				.toString();
		saveReport(msg);
		return requestRepo.save(req);
	}

	public Request actionRequestByAdmin(RequestAdminDto reqRequest) {
		
		Users user = userRepo.findByIdAndRole(reqRequest.getAdminId(), "admin");
		if(user == null) {
			throw new DonativaException("UserId dont have permission");
		}
		
		Optional<Request> requestOptional = requestRepo.findById(reqRequest.getRequestId());
		if(!requestOptional.isPresent()) {
			throw new DonativaException("Request not found");
		}
		Request request = requestOptional.get();
		request.setActionBy(user);
		request.setActionDate(new Date());
		request.setStatus(reqRequest.getStatus());
		
		String msg = new StringBuilder().append(user.getFirstName())
				.append(SPACE)
				.append(user.getLastName())
				.append(SPACE)
				.append("want to")
				.append(SPACE)
				.append(reqRequest.getStatus().toLowerCase())
				.append(SPACE)
				.append("the event request for ")
				.append(request.getEvent().getName())
				.toString();
		saveReport(msg);
		return requestRepo.save(request);
	}

	public List<Request> getAllRequestForUser(long userId) {
		Optional<Users> userOptional = userRepo.findById(userId);
		if(!userOptional.isPresent()) {
			throw new DonativaException("UserId not found");
		}
		
		Users users = userOptional.get();
		if(users.getRole().equals("admin")) {
			return requestRepo.findAllByStatus("REQUESTED");
		} else {
			return requestRepo.findAllByRequestedByIdOrderByRequestedDateDesc(userId);
		}
	}
	
	public void saveReport(String msg) {
		Report report = new Report();
		report.setMessage(msg);
		report.setDate(new Date());
		reportRepository.save(report);
	}

}
