<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html lang="en">
<head>

	<!-- Access the bootstrap Css like this, 
		Spring boot will handle the resource mapping automcatically 
	<link rel="stylesheet" type="text/css" href="webjars/bootstrap/3.3.7/css/bootstrap.min.css" />-->
	<script type="text/javascript" src="webjars/jquery/3.2.1/jquery.min.js"></script>
	<script type="text/javascript" src="webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
	<script src=
"https://cdn.rawgit.com/rainabba/jquery-table2excel/1.1.0/dist/jquery.table2excel.min.js">
</script>
	<c:url value="css/main.css" var="jstlCss" />
	<!-- <script src="/js/script.js"></script> -->
	<link href="${jstlCss}" rel="stylesheet" />
	<script>
	var authUserUrl = "${authUserUrl}";		
		$( document ).ready(function() {
			
			$(function () {
                $("#header").load("header");
            });
			var accessToken = localStorage.getItem("email");
			if(accessToken === "" || accessToken === null){
				window.location.href = "login";
			}
			getEventRequests();
			
		});
		
		
		
		
		
		
		function getEventRequests() {
            $.ajax({
                type: "GET",
                url: "http://localhost:8080/api/reports",
                contentType: 'application/json',
                success: function (result) {


                    $("#requestList").empty();
                    var receptionistData = "<table class='table table-hover'><thead><tr><th scope='col'>#</th><th scope='col'>DATE</th><th scope='col'>ACTION</th></tr></thead><tbody>";
                    var count = 1;
                    for (var i in result) {
                        receptionistData = receptionistData + "<tr><th scope='row'>" + count + "</th><td>" + moment(result[i].date).format("DD/MM/YYYY hh:mm a") + "</td><td>" + result[i].message + "</td></tr>";
                        count = count + 1;
                    }
                    if (count === 1) {
                        receptionistData = receptionistData + "<tr><td colspan='7' style='text-align:center; color:red;'>No records found</td></tr>";
                    }
                    receptionistData = receptionistData + "</tbody></table>";
                    $("#requestList").html(receptionistData);


                }, error: function (err) {
                    jQuery.noConflict();
                    $("#errorAlert").children('.modal-dialog').children('.modal-content').children('span').html("<p style='font-size:20px;color:red'>" + err.responseJSON + "</p>");
                    $("#errorAlert").modal("show");
                }
            });
        }
		
		function approveRequest(requestId) {
			
			var data = {}
            data["requestId"] = requestId;
			data["status"] = "APPROVED";
            data["adminId"] = localStorage.getItem("userId");
            $.ajax({
                type: "POST",
                data: JSON.stringify(data),
                headers: { 'Content-Type': 'application/json', 'token': '' + localStorage.getItem('token') },
                url: "http://localhost:8080/api/requests/admin",
                contentType: 'application/json',
                success: function (result) {
                	$("#successAlert").children('.modal-dialog').children('.modal-content').children('span').html("<p style='font-size:20px;color:green'>Request status updated successfully</p>");
                    $("#successAlert").appendTo("body").modal('show');
                    getEventRequests();
                }, error: function (err) {
                    jQuery.noConflict();
                    $("#errorAlert").children('.modal-dialog').children('.modal-content').children('span').html("<p style='font-size:20px;color:red'>" + err.responseJSON.message + "</p>");
                    $("#errorAlert").modal("show");
                }
            });
        }

        function declineRequest(requestId) {
        	var data = {}
            data["requestId"] = requestId;
			data["status"] = "DECLINED";
            data["adminId"] = localStorage.getItem("userId");
            $.ajax({
                type: "POST",
                data: JSON.stringify(data),
                headers: { 'Content-Type': 'application/json', 'token': '' + localStorage.getItem('token') },
                url: "http://localhost:8080/api/requests/admin",
                contentType: 'application/json',
                success: function (result) {
                	$("#successAlert").children('.modal-dialog').children('.modal-content').children('span').html("<p style='font-size:20px;color:green'>Request status updated successfully</p>");
                    $("#successAlert").appendTo("body").modal('show');
                    getEventRequests();
                }, error: function (err) {
                    jQuery.noConflict();
                    $("#errorAlert").children('.modal-dialog').children('.modal-content').children('span').html("<p style='font-size:20px;color:red'>" + err.responseJSON.message + "</p>");
                    $("#errorAlert").modal("show");
                }
            });
        }
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
	
	<div id="header"></div>

	<div class="container">
        <div class="row">

            <div class="col-md-12"> <br></br>
                <div class="card" style="padding:20px; background-color: rgb(225, 225, 238);">
                    <div class="card-body">
                        <div id="requestList"></div>
                    </div>
                </div>
            </div>

        </div><br></br>
	
	<script type="text/javascript" src="webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>

</html>