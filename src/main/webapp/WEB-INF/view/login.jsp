<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html lang="en">
<head>

	<!-- Access the bootstrap Css like this, 
		Spring boot will handle the resource mapping automcatically -->
	<link rel="stylesheet" type="text/css" href="webjars/bootstrap/3.3.7/css/bootstrap.min.css" />
	
	<script type="text/javascript" src="webjars/jquery/3.2.1/jquery.min.js"></script>
	<script type="text/javascript" src="webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<!-- 
	<spring:url value="css/main.css" var="springCss" />
	<link href="${springCss}" rel="stylesheet" />
	 -->
	<c:url value="css/main.css" var="jstlCss" />
	<link href="${jstlCss}" rel="stylesheet" />
	<script>
		
	$( document ).ready(function() {
		/* var accessToken = localStorage.getItem("email");
		if(accessToken !== "" || accessToken !== "null" || accessToken !== null ){
			window.location.href = "events";
		} */
			
		$("#loginUser").click(function(){
			var data = {}
		    data["email"] = $("#email").val();
		    data["password"] = $("#password").val();
		    if(data["email"]== null || data["email"] == undefined || data["email"] ==""|| data["email"].trim()=="" ||
			    	data["password"]== null || data["password"] == undefined || data["password"] ==""|| data["password"].trim()==""){
		    	$("#errorAlert").children('.modal-dialog').children('.modal-content').children('span').html("<p style='font-size:20px;color:red'>Fields Cannot be blank!</p>");
						$("#errorAlert").modal("show");
					return false;
				}
		    
			$.ajax({
			    type:"post",
			    url:"http://localhost:8080/api/user/signin",
			    contentType: 'application/json',
			    data: JSON.stringify(data),
			    success: function(result){
			    	console.log(result);
			       	localStorage.setItem("userId", result.id);
			       	localStorage.setItem("firstName", result.firstName);
			       	localStorage.setItem("lastName", result.lastName);
			       	localStorage.setItem("role", result.role);
			       	localStorage.setItem("email", result.email);
			       //	window.location.replace("/");
			       	window.location.href = "events";
			    },error: function(err){
			    	console.log(err);
			    	$("#passwordError").empty();
			    	$("#passwordError").html("<p style='margin-right:150px;color:red'>"+err.responseJSON.message+"</p>");
					localStorage.setItem("userId", "");
			       	localStorage.setItem("firstName", "");
			       	localStorage.setItem("lastName", "");
			       	localStorage.setItem("role", "");
			       	localStorage.setItem("email", "");
				}
			});
			
			
		});
	});
		
		
		
		
		
	</script>
</head>
<body>
<div class="container" style="margin-top:40px">
    <div class="row">
    <div class="col-md-2"></div>
        <div class="col-md-8">
            <div class="panel panel-default" style="background-color: aliceblue;">
            <div class="panel-body">
			    <div class="row">
			        <div class="col-md-6">
			        <img src="img/login.png" style="padding:30px; margin-top:40px; width:100%"></img>
			        </div>
			        <div class="col-md-6">
                
                    <div class="text-center">
                        <h3 class="text-center">SIGN IN</h3>
                        <div class="panel-body">
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-user color-blue"></i></span>
                                        <input id="email"
                                               name="email"
                                               autofocus="autofocus"
                                               class="form-control"
                                               placeholder="Email"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <i class="glyphicon glyphicon-lock"></i>
                                        </span>
                                        <input id="password"
                                               name="password"
                                               class="form-control"
                                               placeholder="Password"
                                               type="password"/>
                                    </div>
                                    <div id="passwordError" ></div>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary btn-block" id="loginUser">Login</button>
                                </div>
                                
                                <div class="row">
					                <div class="col-md-12">
					                    Dont have an account? <a href="registration" >Register</a>
					                </div>
					            </div>
                        </div>
                    </div>
                </div>
                </div></div>
            </div>
            
        </div>
        <div class="col-md-2"></div>
    </div>
</div>
<div class="modal" id="errorAlert" role="dialog" aria-labelledby="successAlertLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content" style="text-align: center;padding:30px">
    	
    	<p><span class="glyphicon glyphicon-remove-sign" style="color: red;font-size:50px"></span></p><br>
    	<span id="errorMsg"></span><br>
      	<button type="button" class="btn btn-success" data-dismiss="modal">Okay</button>
    </div>
  </div>
</div>

<script type="text/javascript" th:src="@{/webjars/jquery/3.2.1/jquery.min.js/}"></script>
<script type="text/javascript" th:src="@{/webjars/bootstrap/3.3.7/js/bootstrap.min.js}"></script>

</body>
</html>