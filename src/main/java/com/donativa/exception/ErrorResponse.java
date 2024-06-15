package com.donativa.exception;

import com.fasterxml.jackson.annotation.JsonProperty;

public class ErrorResponse {

	@JsonProperty("message")
	private String message = null;

	@JsonProperty("status")
	private String status = null;

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public ErrorResponse(String message, String status) {
		super();
		this.message = message;
		this.status = status;
	}

}
