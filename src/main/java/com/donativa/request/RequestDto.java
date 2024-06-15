package com.donativa.request;

import javax.validation.constraints.NotNull;

public class RequestDto {
	@NotNull
	private long userId;
	
	@NotNull
	private long eventId;

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public long getEventId() {
		return eventId;
	}

	public void setEventId(long eventId) {
		this.eventId = eventId;
	}
}
