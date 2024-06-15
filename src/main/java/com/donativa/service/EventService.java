package com.donativa.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.donativa.entity.Event;
import com.donativa.entity.Report;
import com.donativa.entity.Users;
import com.donativa.exception.DonativaException;
import com.donativa.repository.EventRepository;
import com.donativa.repository.ReportRepository;
import com.donativa.repository.UserRepository;
import com.donativa.request.EventRequest;

@Service
public class EventService {
	
	@Autowired
	UserRepository userRepo;
	
	@Autowired
	EventRepository eventRepo;
	
	@Autowired
	ReportRepository reportRepository;
	
	public static final String SPACE = " ";

	public Event saveEvent(EventRequest eventRequest) {
		Users admin = userRepo.findByIdAndRole(eventRequest.getAdminId(), "admin");
		if(admin == null) {
			throw new DonativaException("UserId dont have permission");
		}
		Event event = new Event();
		event.setName(eventRequest.getName());
		event.setDescription(eventRequest.getDescription());
		
		String pattern = "MM/dd/yyyy HH:mm:ss";
		DateFormat df = new SimpleDateFormat(pattern);
		
		LocalDateTime startdateTime = LocalDateTime.parse(df.format(eventRequest.getStartDate()), DateTimeFormatter.ofPattern(pattern));
		LocalDateTime enddateTime = LocalDateTime.parse(df.format(eventRequest.getEndDate()), DateTimeFormatter.ofPattern(pattern));
		
		event.setStartDate(startdateTime);
		event.setEndDate(enddateTime);
		event.setCreatedBy(admin);
		event.setCreatedDate(new Date());
		
		String msg = new StringBuilder().append(admin.getFirstName())
				.append(SPACE)
				.append(admin.getLastName())
				.append(SPACE)
				.append("created an event :")
				.append(SPACE)
				.append(event.getName())
				.toString();
		saveReport(msg);
		return eventRepo.save(event);
	}
	
	public Event updateEvents(long eventId, EventRequest eventRequest) {
		
		Optional<Event> eventOptional = eventRepo.findById(eventId);
		if(!eventOptional.isPresent()) {
			throw new DonativaException("Event not found");
		}
		
		Users admin = userRepo.findByIdAndRole(eventRequest.getAdminId(), "admin");
		if(admin == null) {
			throw new DonativaException("UserId dont have permission");
		}
		Event event = eventOptional.get();
		event.setName(eventRequest.getName());
		event.setDescription(eventRequest.getDescription());
		String pattern = "MM/dd/yyyy HH:mm:ss";
		DateFormat df = new SimpleDateFormat(pattern);
		
		LocalDateTime startdateTime = LocalDateTime.parse(df.format(eventRequest.getStartDate()), DateTimeFormatter.ofPattern(pattern));
		LocalDateTime enddateTime = LocalDateTime.parse(df.format(eventRequest.getEndDate()), DateTimeFormatter.ofPattern(pattern));
		
		event.setStartDate(startdateTime);
		event.setEndDate(enddateTime);
		event.setCreatedBy(admin);
		event.setCreatedDate(new Date());
		
		String msg = new StringBuilder().append(admin.getFirstName())
				.append(SPACE)
				.append(admin.getLastName())
				.append(SPACE)
				.append("updated an event :")
				.append(SPACE)
				.append(event.getName())
				.toString();
		saveReport(msg);
		return eventRepo.save(event);
	}

	public void deleteEventsById(long eventId, long userId) {
		Users admin = userRepo.findByIdAndRole(userId, "admin");
		if(admin == null) {
			throw new DonativaException("UserId dont have permission");
		}
		
		Optional<Event> eventOptional = eventRepo.findById(eventId);
		if(!eventOptional.isPresent()) {
			throw new DonativaException("Event not found");
		}
		
		String msg = new StringBuilder().append(admin.getFirstName())
				.append(SPACE)
				.append(admin.getLastName())
				.append(SPACE)
				.append("deleted an event :")
				.append(SPACE)
				.append(eventOptional.get().getName())
				.toString();
		saveReport(msg);
		eventRepo.deleteById(eventId);
	}

	public Event getEventsById(long eventId) {
		Optional<Event> eventOptional = eventRepo.findById(eventId);
		if(!eventOptional.isPresent()) {
			throw new DonativaException("Event not found");
		}
		return eventOptional.get();
	}

	public List<Event> getAllEvents(String name) {
		if(name.equals("")) {
			 return eventRepo.findAll();
		}
		return eventRepo.findAllByNameContainingIgnoreCaseOrderByCreatedDateDesc(name);
	}
	
	public void saveReport(String msg) {
		Report report = new Report();
		report.setMessage(msg);
		report.setDate(new Date());
		reportRepository.save(report);
	}

}
