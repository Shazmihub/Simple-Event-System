package com.donativa.request;

import javax.validation.constraints.NotNull;

public class RequestAdminDto {
	
	@NotNull
	private long requestId;
	
	@NotNull
	private long adminId;
	
	@NotNull(message = "status cannot be blank")
	private String status;

	public long getAdminId() {
		return adminId;
	}

	public void setAdminId(long adminId) {
		this.adminId = adminId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public long getRequestId() {
		return requestId;
	}

	public void setRequestId(long requestId) {
		this.requestId = requestId;
	}
}
