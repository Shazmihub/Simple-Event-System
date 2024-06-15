<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html lang="en">
<head>

	<!-- Access the bootstrap Css like this, 
		Spring boot will handle the resource mapping automcatically -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.3/jquery.min.js" integrity="sha512-STof4xm1wgkfm7heWqFJVn58Hm3EtS31XFaagaa8VMReCXAkQnJZ+jEy8PCC/iT18dFy95WcExNHFTqLyp72eQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.10.2/umd/popper.min.js" integrity="sha512-nnzkI2u2Dy6HMnzMIkh7CPd1KX445z38XIu4jG1jGw7x5tSL3VBjE44dY4ihMU1ijAQV930SPM12cCFrB18sVw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  
  <script>
  function ValidateEmail(mail) {
	    if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(mail)) {
	      return (true)
	    }
	    return (false)
	  }	
    $(document).ready(function () {


      $("#logout").click(function () {
        $(".userName").attr("style", "display:none;");
        $(".loginButton").attr("style", "display:block;");

        localStorage.removeItem("userId", "");
		localStorage.removeItem("firstName", "");
		localStorage.removeItem("lastName", "");
		localStorage.removeItem("token", "");
		localStorage.removeItem("email", "");
		localStorage.removeItem("role", "");

        window.location.replace("login");
      });
      
      $.ajax({
		    type:"GET",
		    url:"http://localhost:8080/api/user/profile/"+localStorage.getItem("userId"),
		    contentType: 'application/json',
		    success: function(result){
		    	console.log(result);
		    	$("#loader").attr("style", "display:none");
		    	$("#firstName").val(result.firstName);
		    	$("#lastName").val(result.lastName);
		    	$("#password").val(result.password);
		    	$("#email").val(result.email);
		    	$("#roles").val(result.role);
		    },error: function(err){
		    	console.log(err);
		    	$("#loader").attr("style", "display:none");
		    	$("#errorAlert").children('.modal-dialog').children('.modal-content').children('span').html("<p style='font-size:20px;color:red'>"+err.responseJSON.message+"</p>");
				$("#errorAlert").modal("show");
			}
		}); 

      $("#updateProfileSubmit").click(function () {
    	  var data = {}
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
		    $("#loader").attr("style", "display:block;position: absolute;left: -103px;top: 20%;width: 40%;height: 40%;z-index: 9999;");
			$.ajax({
			    type:"PUT",
			    data: JSON.stringify(data),
			    url:"http://localhost:8080/api/user/profile/update/"+localStorage.getItem("userId"),
			    contentType: 'application/json',
			    success: function(result){
			    	console.log(result);
			    	localStorage.setItem("userId", result.id);
			       	localStorage.setItem("firstName", result.firstName);
			       	localStorage.setItem("lastName", result.lastName);
			       	localStorage.setItem("role", result.role);
			       	localStorage.setItem("email", result.email);
			    	$("#loader").attr("style", "display:none");
			    	if (localStorage.getItem("userId") !== "" && localStorage.getItem("userId") !== null
			    	        && localStorage.getItem("userId") !== undefined) {
			    	        $('#usernameValue').text(localStorage.getItem("firstName")+" "+localStorage.getItem("lastName"));
			    	        $(".userName").attr("style", "display:block;");
			    	        
			    	        if (localStorage.getItem("role") === "user") {
			    	        	 $(".isAdmin").attr("style", "display:none;");
			    	            $(".isUser").attr("style", "display:block;");
			    	          }
			    	          if (localStorage.getItem("role") === "admin") {
			    	            $(".isAdmin").attr("style", "display:block;");
			    	            $(".isUser").attr("style", "display:none;");
			    	          }
			    	}
			    	$("#viewProfileModal").modal("hide");
			    },error: function(err){
			    	console.log(err);
			    	$("#loader").attr("style", "display:none");
			    	$("#errorAlert").children('.modal-dialog').children('.modal-content').children('span').html("<p style='font-size:20px;color:red'>"+err.responseJSON.message+"</p>");
					$("#errorAlert").modal("show");
				}
			}); 
        
      });

      if (localStorage.getItem("userId") !== "" && localStorage.getItem("userId") !== null
        && localStorage.getItem("userId") !== undefined) {
        $('#usernameValue').text(localStorage.getItem("firstName")+" "+localStorage.getItem("lastName"));
        $(".userName").attr("style", "display:block;");
        $(".loginButton").attr("style", "display:none;");

        if (localStorage.getItem("role") === "user") {
          $(".isUser").attr("style", "display:block;");
        }
        if (localStorage.getItem("role") === "admin") {
          $(".isAdmin").attr("style", "display:block;");
        }


      } else {
        $(".userName").attr("style", "display:none;");
        $(".loginButton").attr("style", "display:block;");
      }
    });
  </script>

</head>

<body>

<!-- <nav class="navbar navbar-inverse">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="#">LANCE</a>
			</div>
			<div id="navbar" class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li class="active"><a href="#">Home</a></li>
					<li><a href="#about">About</a></li>
					
					<li><a href="#" id="logoutUser">Logout</a></li>
				</ul>
			</div>
		</div>
	</nav> -->


  <nav class="navbar navbar-expand-lg" style="background-color: #262673;padding-top: 0px;padding-bottom: 0px;">
   
     <a class="navbar-brand" href="#" style="font-family:auto ;font-weight: 700 !important ;color:white">
      <img src="img/logo.png" width="50" height="50" alt="">
     &nbsp;Donativa Volunteer System</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
      aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div style="flex: 5;"></div>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <!-- <li class="nav-item active">
          <a class="nav-link" href="/home.html" style="color:white">HOME <span class="sr-only">(current)</span></a>
        </li> -->
        <li class="nav-item isAdmin active" style="display:none">
          <a class="nav-link" href="events" style="color:white">EVENTS</a>
        </li>
        <li class="nav-item isAdmin" style="display:none">
          <a class="nav-link" href="requests" style="color:white">REQUESTS</a>
        </li>

		<li class="nav-item isAdmin" style="display:none">
          <a class="nav-link" href="reports" style="color:white">REPORTS</a>
        </li>
       
        <li class="nav-item isUser active" style="display:none">
          <a class="nav-link" href="events" style="color:white">EVENTS</a>
        </li>
        <li class="nav-item isUser" style="display:none">
          <a class="nav-link" href="myrequests" style="color:white">MY REQUESTS</a>
        </li>
      </ul>
      <ul class="navbar-nav">
        <div class="userName" style="display:none">
          <div class="d-flex flex-row">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <li class="nav-item dropdown">

              <a style="color:white !important" class="nav-link dropdown-toggle" data-toggle="dropdown" href="#"
                role="button"><i class="fa fa-user-o fa-1x" aria-hidden="true"></i>&nbsp;&nbsp;<span
                  id="usernameValue"></span></a>
              <div class="dropdown-menu dropdown-menu-right">


                <a class="dropdown-item" data-toggle="modal" data-target="#viewProfileModal"><i
                    class="fa fa-plus-circle fa-fw"></i>&nbsp;My Profile</a>
                 <div class="dropdown-divider"></div> 
               
                <a class="dropdown-item" id="logout"><i class="fa fa-sign-out fa-fw"></i>Logout</a>
              </div>
            </li>
          </div>
        </div>

        <div class="loginButton" style="display:none">
          <div class="d-flex flex-row">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <li class="nav-item d-flex flex-row">

              <a class="btn btn-outline-success my-2 my-sm-0" href="login">SIGN IN</a>
            </li>
          </div>
        </div>
      </ul>
    </div>
  </nav>
</body>


<div class="modal" id="viewProfileModal" tabindex="-1" role="dialog" aria-labelledby="viewProfileModal"
  aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="accountModalLabel">VIEW PROFILE</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
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
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-king"></i></span>
                                         <select class="form-control" id="roles">
										   	<option selected disabled value="1">Select roles</option>
										     <option value="user">USER</option>
										     <option value="admin">ADMIN</option>
										   </select>
                                    </div>
                                </div>

      </div>
      <div class="modal-footer">

        <button type="button" id="updateProfileSubmit" class="btn btn-primary">Update</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<div class="modal" id="errorAlert" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content" style="text-align: center;padding:10px; background-color: bisque;">
      <i class="fa fa-times-circle  fa-5x" aria-hidden="true" style="color: red;"></i><br>
      <span id="errorMsg"></span><br>
      <button type="button" class="btn btn-success" data-dismiss="modal">Okay</button>
    </div>
  </div>
</div>
<div class="modal" id="successAlert" role="dialog" aria-labelledby="successAlertLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content" style="text-align: center; align-items:center; padding:10px; background-color: bisque;">
      <img src="../img/claps.png" width="100" height="100" alt=""></img><br>
      <span id="successMsg"></span><br><br>
      <button type="button" class="btn btn-success" data-dismiss="modal">Okay</button>
    </div>
  </div>
</div>

<script type="text/javascript" th:src="@{/webjars/jquery/3.2.1/jquery.min.js/}"></script>
<script type="text/javascript" th:src="@{/webjars/bootstrap/3.3.7/js/bootstrap.min.js}"></script>

</html>