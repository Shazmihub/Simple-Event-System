package com.donativa.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ViewController {

	@RequestMapping(value = {"/login", "/"}, method = RequestMethod.GET)
    public String showWelcomePage(Map<String, Object> model){
        return "login";
    }
	
	@RequestMapping(value = "/registration", method = RequestMethod.GET)
    public String showRegistrationPage(Map<String, Object> model){
        return "registration";
    }

	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String dashboard(Map<String, Object> model) {
		return "dashboard";
	}
	
	@RequestMapping(value = "/events", method = RequestMethod.GET)
	public String events(Map<String, Object> model) {
		return "events";
	}
	
	@RequestMapping(value = "/reports", method = RequestMethod.GET)
	public String reports(Map<String, Object> model) {
		return "reports";
	}
	
	@RequestMapping(value = "/requests", method = RequestMethod.GET)
	public String requests(Map<String, Object> model) {
		return "requests";
	}
	
	@RequestMapping(value = "/myrequests", method = RequestMethod.GET)
	public String myrequests(Map<String, Object> model) {
		return "myrequests";
	}
	
	@RequestMapping(value = "/header", method = RequestMethod.GET)
	public String header(Map<String, Object> model) {
		return "header";
	}

    

}