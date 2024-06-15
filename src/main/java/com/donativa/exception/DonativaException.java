package com.donativa.exception;

public class DonativaException extends RuntimeException{
	private static final long serialVersionUID = 1L;

	public DonativaException(String errorMessage) {  
    	super(errorMessage);  
    } 
	
}
