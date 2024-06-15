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
	
	<script>
		
	$( document ).ready(function() {
		var authUserUrl = "${authUserUrl}";		    
		
		$("#registerUser").click(function(){
			var msg = "${authUserUrl}";		
			$("#passwordError").empty();
			var data = {}
			var confirmPassword = $("#confirmPassword").val();
		    data["firstName"] = $("#firstName").val();
			 data["lastName"] = $("#lastName").val();
		    data["password"] = $("#password").val();
		    data["email"] = $("#email").val();
		    data["role"] = $("#roles").val();
		    
		    if(data["firstName"]== null || data["firstName"] == undefined || data["firstName"] ==""|| data["firstName"].trim()=="" || 
		    		data["lastName"]== null || data["lastName"] == undefined || data["lastName"] ==""|| data["lastName"].trim()=="" || 
		    		data["email"]== null || data["email"] == undefined || data["email"] ==""|| data["email"].trim()=="" || 
		    		data["email"]== null || data["email"] == undefined || data["email"] ==""|| data["email"].trim()=="" || 
			    	data["role"]== null || data["role"] == undefined || data["role"] ==""|| data["role"].trim()==""){
		    	$("#errorAlert").children('.modal-dialog').children('.modal-content').children('span').html("<p style='font-size:20px;color:red'>Fields Cannot be blank!</p>");
						$("#errorAlert").modal("show");
					return false;
				}
		    
		    if(!ValidateEmail($("#email").val())){
		    	$("#emailError").html("<p style='margin-right:340px;color:red'>Please enter valid email!</p>");
		    	return false;
		    }
		    if(confirmPassword === null || confirmPassword === undefined || confirmPassword.trim() ==="" || $("#password").val()!==confirmPassword.trim()){
		    	$("#passwordError").html("<p style='margin-right:340px;color:red'>Password mismatched!</p>");
				return false;
		    }
		    $("#loader").attr("style", "display:block;position: absolute;left: -103px;top: 20%;width: 40%;height: 40%;z-index: 9999;");
			$.ajax({
			    type:"post",
			    data: JSON.stringify(data),
			    url:"http://localhost:8080/api/user/signup",
			    contentType: 'application/json',
			    success: function(result){
			    	console.log(result);
			    	$("#loader").attr("style", "display:none");
			    	$("#confirmPassword").val("");
			    	$("#firstName").val("");
			    	$("#lastName").val("");
			    	$("#password").val("");
			    	$("#email").val("");
			    	$("#roles").val("1");
			    	window.location.href = "login";
			    },error: function(err){
			    	console.log(err);
			    	$("#loader").attr("style", "display:none");
			    	$("#errorAlert").children('.modal-dialog').children('.modal-content').children('span').html("<p style='font-size:20px;color:red'>"+err.responseJSON.message+"</p>");
					$("#errorAlert").modal("show");
				}
			}); 
			
			
		});
	});
	function ValidateEmail(mail) {
	    if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(mail)) {
	      return (true)
	    }
	    return (false)
	  }	
		
		
		
		
	</script>
	<!-- 
	<spring:url value="/css/main.css" var="springCss" />
	<link href="${springCss}" rel="stylesheet" />
	 -->
	<c:url value="css/main.css" var="jstlCss" />
	<link href="${jstlCss}" rel="stylesheet" />

    <title>Registration</title>
</head>
<body>

<div class="container" style="margin-top:5px">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default" style="background-color: aliceblue;">
            <div class="container">
    		<div class="row">
             <div class="col-md-6">
             	<img src="img/register.png" style="padding:30px;width:500px; height:450px; margin-top:40px"></img>
             </div>
             <div class="col-md-6">
                <div class="panel-body">
                    <div class="text-center">
                        <!-- <h3><i class="glyphicon glyphicon-user" style="font-size:2em;"></i></h3> -->
                        <h3 class="text-center">SIGN UP</h3>
                        <div class="panel-body">

                               <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <i class="glyphicon glyphicon-user color-blue"></i>
                                        </span>
                                        <input id="firstName"
                                               class="form-control"
                                               placeholder="First name"
                                               name="firstName"
                                               th:field="*{firstName}"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <i class="glyphicon glyphicon-user color-blue"></i>
                                           
                                           
                                        </span>
                                        <input id="lastName"
                                               class="form-control"
                                               placeholder="Last name"
                                               th:field="*{lastName}"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                                        <input id="email"
                                               class="form-control"
                                               placeholder="E-mail"
                                               onblur="ValidateEmail(this.value)"/>
                                    </div>
                                    <div id="emailError" ></div>
                                </div>
                                
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <i class="glyphicon glyphicon-lock"></i>
                                        </span>
                                        <input id="password"
                                               class="form-control"
                                               placeholder="password"
                                               type="password"
                                               th:field="*{password}"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <i class="glyphicon glyphicon-lock"></i>
                                        </span>
                                        <input id="confirmPassword"
                                               class="form-control"
                                               type="password"
                                               placeholder="Confirm password"/>
                                    </div>
                                    <div id="passwordError" ></div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-king"></i></span>
                                         <select class="form-control" id="roles">
										   	<option selected disabled value="1">Select roles</option>
										     <option value="user">USER</option>
										     <option value="admin">ADMIN</option>
										   </select>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary btn-block" id="registerUser">Register</button>
                                </div>
                                
                                <div class="row">
					                <div class="col-md-12">
					                    Already registered? <a href="login">Login</a>
					                </div>
					            </div>
					            <img src="img/loading.svg" id="loader" style="display:none;"></img>
                        </div>
                    </div>
                </div>
                
            </div>
            </div></div>
        </div>
    </div>
</div>
</div>
<div class="modal" id="errorAlert" role="dialog" aria-labelledby="successAlertLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content" style="text-align: center;padding:30px">
    	
    	<p><span class="glyphicon glyphicon-remove-sign" style="color: red;font-size:50px"></span></p><br>
    	<span id="errorMsg"></span><br>
      	<button type="button" class="btn btn-success  btn-lg" data-dismiss="modal" style="width:100%">Okay</button>
    </div>
  </div>
</div>
<div class="modal" id="successAlert" role="dialog" aria-labelledby="successAlertLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content" style="text-align: center;padding:50px">
    	<p><span class="	glyphicon glyphicon-ok-circle" style="color: green;font-size:50px"></span></p><br>
    	<span id="successMsg"></span><br><br>
      	<button type="button" class="btn btn-success btn-lg" data-dismiss="modal" style="width:100%">Okay</button>
    </div>
  </div>
</div>

<script type="text/javascript" th:src="@{/webjars/jquery/3.2.1/jquery.min.js/}"></script>
<script type="text/javascript" th:src="@{/webjars/bootstrap/3.3.7/js/bootstrap.min.js}"></script>

</body>
</html>