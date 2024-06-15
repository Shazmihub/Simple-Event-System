package com.donativa.request;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

public class SignupRequest {
	@NotBlank(message = "firstName cannot be blank")
	@Size(min = 2, max = 20)
	private String firstName;

	@NotBlank(message = "lastName cannot be blank")
	@Size(min = 2, max = 20)
	private String lastName;

	@NotBlank(message = "Email cannot be blank")
	@Size(max = 50)
	@Email(message = "Email is not valid")
	private String email;

	@NotBlank(message = "password cannot be blank")
	private String password;

	@NotBlank
	private String role;

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

}
