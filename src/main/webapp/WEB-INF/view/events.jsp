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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
	<script type="text/javascript" src="webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<c:url value="css/main.css" var="jstlCss" />
	<!-- <script src="/js/script.js"></script> -->
	<link href="${jstlCss}" rel="stylesheet" />
	<script>
	var authUserUrl = "${authUserUrl}";		
		$( document ).ready(function() {
			getAllEvents("");
			$(function () {
                $("#header").load("header");
            });
			var accessToken = localStorage.getItem("email");
			if(accessToken === "" || accessToken === null){
				window.location.href = "login";
			}
						
			if (localStorage.getItem("role") === "admin") {
                $("#addEventButtonDiv").empty();
                $("#addEventButtonDiv").append(" <button class='btn btn-primary' data-toggle='modal' data-target='#addEventModel' >ADD EVENTS</button>");
            }
			
			$('#searchEvent').keyup(function () {
                console.log($('#searchEvent').val());
                getAllEvents($('#searchEvent').val());
            });
			
			$("#joinEventSubmit").click(function () {
                var data = {}
                data["eventId"] = $("#viewEventId").val();
                data["userId"] = localStorage.getItem("userId");
               
                $.ajax({
                    type: "post",
                    data: JSON.stringify(data),
                    url: "http://localhost:8080/api/requests",
                    contentType: 'application/json',
                    success: function (result) {
                        $("#viewEventModel").modal("hide");
                        $("#successAlert").children('.modal-dialog').children('.modal-content').children('span').html("<p style='font-size:20px;color:green'>Join request sent successfully</p>");
                        $("#successAlert").appendTo("body").modal('show');
                        getAllEvents("");

                    }, error: function (err) {
                        //jQuery.noConflict();
                        $("#errorAlert").children('.modal-dialog').children('.modal-content').children('span').html("<p style='font-size:20px;color:red'>" + err.responseJSON.message + "</p>");
                        $("#errorAlert").appendTo("body").modal('show');


                    }
                });
            });
			
			
			$("#addEventSubmit").click(function () {
                var data = {}
                data["name"] = $("#eventName").val();
                data["description"] = $("#description").val();
                data["startDate"] = moment($("#eventStartDate").val()).toDate();
                data["endDate"] = moment($("#eventEndDate").val()).toDate();
                data["adminId"] = localStorage.getItem("userId");


                if (data["name"] == null || data["name"] == undefined || data["name"] == "" || data["name"].trim() == "" ||
                    data["description"] == null || data["description"] == undefined || data["description"] == "" || data["description"].trim() == ""
                    || data["startDate"] == null || data["startDate"] == undefined || data["startDate"] == "" 
                    || data["endDate"] == null || data["endDate"] == undefined || data["endDate"] == "") {
                    //jQuery.noConflict();
                    $("#errorAlert").children('.modal-dialog').children('.modal-content').children('span').html("<p style='font-size:20px;color:red'>Fields Cannot be blank!</p>");
                    $("#errorAlert").appendTo("body").modal('show');
                    return false;
                }
                $.ajax({
                    type: "post",
                    data: JSON.stringify(data),
                    url: "http://localhost:8080/api/events",
                    contentType: 'application/json',
                    success: function (result) {
                        $("#eventName").val("");
                        $("#description").val("");
                        $("#eventStartDate").val("");
                        $("#eventEndDate").val("");
                        //jQuery.noConflict();
                        $("#addEventModel").modal("hide");
                        $("#successAlert").children('.modal-dialog').children('.modal-content').children('span').html("<p style='font-size:20px;color:green'>Event added successfully</p>");
                        $("#successAlert").appendTo("body").modal('show');
                        getAllEvents("");

                    }, error: function (err) {
                        //jQuery.noConflict();
                        $("#errorAlert").children('.modal-dialog').children('.modal-content').children('span').html("<p style='font-size:20px;color:red'>" + err.responseJSON.message + "</p>");
                        $("#errorAlert").appendTo("body").modal('show');


                    }
                });
            });
			
			
			$("#updateEventSubmit").click(function () {
                var data = {}
                data["name"] = $("#editeventName").val();
                data["description"] = $("#editdescription").val();
                data["startDate"] = moment($("#editeventStartDate").val()).toDate();
                data["endDate"] = moment($("#editeventEndDate").val()).toDate();
                data["adminId"] = localStorage.getItem("userId");


                if (data["name"] == null || data["name"] == undefined || data["name"] == "" || data["name"].trim() == "" ||
                        data["description"] == null || data["description"] == undefined || data["description"] == "" || data["description"].trim() == ""
                        || data["startDate"] == null || data["startDate"] == undefined || data["startDate"] == "" 
                        || data["endDate"] == null || data["endDate"] == undefined || data["endDate"] == "") {
                       // jQuery.noConflict();
                        $("#errorAlert").children('.modal-dialog').children('.modal-content').children('span').html("<p style='font-size:20px;color:red'>Fields Cannot be blank!</p>");
                        $("#errorAlert").appendTo("body").modal('show');
                        return false;
                    }
                $.ajax({
                    type: "put",
                    data: JSON.stringify(data),
                    url: "http://localhost:8080/api/events/" + $("#editEventId").val(),
                    contentType: 'application/json',
                    success: function (result) {
                    	 $("#eventName").val("");
                         $("#description").val("");
                         $("#eventStartDate").val("");
                         $("#eventEndDate").val("");
                        // jQuery.noConflict();
                         $("#editEventModel").modal("hide");
                        $("#successAlert").children('.modal-dialog').children('.modal-content').children('span').html("<p style='font-size:20px;color:green'>Event updated successfully</p>");
                        $("#successAlert").appendTo("body").modal('show');
                        getAllEvents("");

                    }, error: function (err) {
                        //jQuery.noConflict();
                        $("#errorAlert").children('.modal-dialog').children('.modal-content').children('span').html("<p style='font-size:20px;color:red'>" + err.responseJSON.message + "</p>");
                        $("#errorAlert").appendTo("body").modal('show');


                    }
                });
            });
			
		});
		
		function editEvent(id) {
            $.ajax({
                type: "GET",
                url: "http://localhost:8080/api/events/" + id,
                contentType: 'application/json',
                success: function (result) {
                    $("#editeventName").val(result.name);
                    $("#editdescription").val(result.description);
                    $("#editeventStartDate").val(result.startDate);
                    $("#editeventEndDate").val(result.endDate);
                    $("#editEventId").val(result.id);

                    //jQuery.noConflict();
                    $("#editEventModel").modal("show");
                }, error: function (err) {
                    $("#errorAlert").children('.modal-dialog').children('.modal-content').children('span').html("<p style='font-size:20px;color:red'>" + err.responseJSON.message + "</p>");
                    $("#errorAlert").modal("show");

                }
            });
        }
		
		function joinEvent(id) {
            $.ajax({
                type: "GET",
                url: "http://localhost:8080/api/events/" + id,
                contentType: 'application/json',
                success: function (result) {
                	$("#vieweventName").empty();
                	$("#viewdescription").empty();
                	$("#vieweventStartDate").empty();
                	$("#vieweventEndDate").empty();
                    $("#vieweventName").append("<p>"+result.name+"</p>");
                    $("#viewdescription").append("<p>"+result.description+"</p>");
                    $("#vieweventStartDate").append("<p>"+result.startDate+"</p>");
                    $("#vieweventEndDate").append("<p>"+result.endDate+"</p>");
                    $("#viewEventId").val(result.id);

                    //jQuery.noConflict();
                    $("#viewEventModel").modal("show");
                }, error: function (err) {
                    $("#errorAlert").children('.modal-dialog').children('.modal-content').children('span').html("<p style='font-size:20px;color:red'>" + err.responseJSON.message + "</p>");
                    $("#errorAlert").modal("show");

                }
            });
        }
		
		function deleteEvent(id) {
            $.ajax({
                type: "DELETE",
                url: "http://localhost:8080/api/events/" + id + "/" + localStorage.getItem("userId"),
                contentType: 'application/json',
                success: function (result) {
                	getAllEvents("");
                }, error: function (err) {
                    $("#errorAlert").children('.modal-dialog').children('.modal-content').children('span').html("<p style='font-size:20px;color:red'>" + err.responseJSON.message + "</p>");
                    $("#errorAlert").modal("show");
                }
            });
        }
		
		function getAllEvents(names) {
            $.ajax({
                type: "GET",
                url: "http://localhost:8080/api/events/allevents?search=" + names,
                contentType: 'application/json',
                success: function (result) {
                    var datas = "<div class='container' style='flex-flow: row wrap;display: flex;'>";
                    $.each(result, function (index, item) {
                        datas = datas + "<div class='card' style='width: 13rem;margin-right:5px;'>" +
                            "<div style='height: 170px;background-color:cornsilk;padding: 10px; overflow:hidden;'><h4>" + item.name + "</h4>" +
                            "<small>" + item.description + "</small></div>" +
                            "<div class='card-body' style='background-color:#262673'>";

                        if (localStorage.getItem("role") === "admin") {
                            datas = datas +
                                "<button class='btn btn-outline-warning my-2 my-sm-0'  onclick='editEvent(" + item.id + ");' ><i class='fa fa-edit'></i>&nbsp;Edit</button>" +
                                "<button class='btn btn-outline-danger my-2 my-sm-0' onclick='deleteEvent(" + item.id + ");' style='float:right;'><i class='fa fa-remove'></i>&nbsp;Delete</button>";
                        } else {
                            datas = datas +
                                "<div class='d-flex justify-content-center'><button class='btn btn-outline-warning my-2 my-sm-0'  onclick='joinEvent(" + item.id + ");' ><i class='fa fa-file'></i>&nbsp;JOIN THIS EVENT</button></div>";

                        }



                        datas = datas + "</div></div>";
                    });
                    datas = datas + "</div>";
                    $("#allEvents").empty();
                    $("#allEvents").append(datas);

                }, error: function (err) {
                    $("#errorAlert").children('.modal-dialog').children('.modal-content').children('span').html("<p style='font-size:20px;color:red'>" + err.responseJSON.message + "</p>");
                    $("#errorAlert").modal("show");

                }
            });
        }
		
		</script>
</head>
<body>
	
	<div id="header"></div>
<br></br>
	<div class="container">
	
	 <div class="row">
            <div class="col-md-10">
            <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search Events" id="searchEvent">
                    <div class="input-group-text">
                        <button class="btn btn-default" type="submit">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </div>
            </div>
            <div class="col-md-2">
                <div id="addEventButtonDiv"></div>
            </div>
		

	</div>
	</div>
	
	<br></br>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div id="allEvents"></div>
            </div>
        </div><br></br>
    </div>
	</body>
	<div class="modal" id="addEventModel" tabindex="-1" role="dialog" aria-labelledby="accountModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="accountModalLabel">Add Event</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="exampleInputEmail2">Add Event Name</label>
                    <input type="text" class="form-control" id="eventName">
                </div>

                <div class="form-group">
                    <label for="exampleInputEmail2">Description</label>
                    <textarea rows="3" type="text" class="form-control" id="description"></textarea>
                </div>

                <div class="form-group">
                    <label for="exampleInputEmail2">Start Date</label>
                    <input type="datetime-local" class="form-control" id="eventStartDate" >
                </div>

                <div class="form-group">
                    <label for="exampleInputEmail2">End Date</label>
                    <input type="datetime-local" class="form-control" id="eventEndDate">
                </div>

            </div>
            <div class="modal-footer">

                <button type="button" id="addEventSubmit" class="btn btn-primary">Add</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


<div class="modal" id="editEventModel" tabindex="-1" role="dialog" aria-labelledby="accountModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="accountModalLabel">Edit Event</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <input type="text" hidden class="form-control" id="editEventId">
                </div>
                <div class="form-group">
                    <label for="exampleInputEmail2">Edit Event Name</label>
                    <input type="text" class="form-control" id="editeventName" placeholder="Edit Event Name">
                </div>

                <div class="form-group">
                    <label for="exampleInputEmail2">Edit Description</label>
                     <textarea rows="3" type="text" class="form-control" id="editdescription"></textarea>
                </div>

                 <div class="form-group">
                    <label for="exampleInputEmail2">Start Date</label>
                    <input type="datetime-local" class="form-control" id="editeventStartDate" >
                </div>

                <div class="form-group">
                    <label for="exampleInputEmail2">End Date</label>
                    <input type="datetime-local" class="form-control" id="editeventEndDate">
                </div>

            </div>
            <div class="modal-footer">

                <button type="button" id="updateEventSubmit" class="btn btn-primary">Update</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>



<div class="modal" id="viewEventModel" tabindex="-1" role="dialog" aria-labelledby="accountModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="accountModalLabel">View Event</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <input type="text" hidden class="form-control" id="viewEventId">
                </div>
                <div class="form-group">
                    <label for="exampleInputEmail2">Event Name</label>
                    <div class="card" style="padding:10px" id="vieweventName"></div>
                </div>

                <div class="form-group">
                    <label for="exampleInputEmail2">Description</label>
                     <div class="card" style="padding:10px" id="viewdescription"></div>
                </div>

                 <div class="form-group">
                    <label for="exampleInputEmail2">Start Date</label>
                   <div class="card" style="padding:10px" id="vieweventStartDate" ></div>
                </div>

                <div class="form-group">
                    <label for="exampleInputEmail2">End Date</label>
                    <div class="card" style="padding:10px" id="vieweventEndDate"></div>
                </div>

            </div>
            <div class="modal-footer">

                <button type="button" id="joinEventSubmit" class="btn btn-primary">JOIN THIS EVENT</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>





	
	<script type="text/javascript" src="webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>


</html>