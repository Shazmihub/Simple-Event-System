package com.donativa.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.donativa.entity.Event;
import com.donativa.request.EventRequest;
import com.donativa.service.EventService;

@RestController
@CrossOrigin
@RequestMapping("/api/events")
public class EventController {
	
	@Autowired
    private EventService eventService;

    @PostMapping
    public ResponseEntity<?> saveEvents(@Valid @RequestBody EventRequest eventRequest) {
        Event saveEvent = eventService.saveEvent(eventRequest);
        return new ResponseEntity<>(saveEvent, HttpStatus.CREATED);
    }
    
    @GetMapping("/{eventId}")
    public ResponseEntity<?> getEventsById(@PathVariable long eventId) {
        Event saveEvent = eventService.getEventsById(eventId);
        return ResponseEntity.status(HttpStatus.OK).body(saveEvent);
    }
    
    @GetMapping("/allevents")
    public ResponseEntity<?> getAllEvents(@RequestParam(name = "search", defaultValue = "", required = false) String name) {
        List<Event> events = eventService.getAllEvents(name);
        return ResponseEntity.status(HttpStatus.OK).body(events);
    }
    
    @DeleteMapping("/{eventId}/{userId}")
    public ResponseEntity<?> deleteEventsById(@PathVariable("eventId") long eventId, @PathVariable("userId") long userId) {
        eventService.deleteEventsById(eventId, userId);
        return ResponseEntity.status(HttpStatus.OK).body("Event deleted successfully");
    }
    
    @PutMapping("/{eventId}")
    public ResponseEntity<?> updateEvents(@PathVariable long eventId, @Valid  @RequestBody EventRequest eventRequest) {
        Event saveEvent = eventService.updateEvents(eventId, eventRequest);
        return new ResponseEntity<>(saveEvent, HttpStatus.OK);
    }
}
