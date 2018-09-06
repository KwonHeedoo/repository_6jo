<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>My Info</title>
<!-- <script src="//code.jquery.com/jquery-1.11.1.min.js"></script> -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<style type="text/css">
html,body{
height: inherit;
}

input:not([type=button]){
width: 100%;
}

input[type=checkbox] {
width: 20px;
height: 20px;
}

.datecol{
border: none;
}

.container{
    margin: 0;
    padding-left: 0;
    padding-right: 0;
    width: 100%;
}


.side-menu {
margin-top:0;
position:absolute;
float:left;
  width: 280px;
  height: 80%;
  background-color: #f8f8f8;
  border-right: 1px solid #e7e7e7;
}
.side-menu .navbar-nav li {
  display: block;
  width: 100%;
  border-bottom: 1px solid #e7e7e7;
}
.side-body {
  margin-top: 20px;
  margin-left: 300px;
}

.navbar-default .navbar-nav>li>a:hover, .navbar-default .navbar-nav>li>a:focus{
	background-color: #c7c7c7 ;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/header.jsp"%>
	<div class="container">
		<!-- uncomment code for absolute positioning tweek see top comment in css -->
		<!-- <div class="absolute-wrapper"> </div> -->
		<!-- Menu -->
		<div class="side-menu">
			<nav class="navbar navbar-default" role="navigation"> <!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<div class="brand-wrapper">
					<!-- Hamburger -->
					<button type="button" class="navbar-toggle">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>

					<!-- Brand -->
					<div class="brand-name-wrapper">
						<a class="navbar-brand" href="#"><span class="glyphicon glyphicon-user"></span> ${sessionScope.loginNick}'s My page </a>
					</div>
				</div>

			</div>

			<!-- Main Menu -->
			<div class="side-menu-container">
				<ul class="nav navbar-nav">

					<li><a href="#"><span class="glyphicon glyphicon-book"></span>
							My Words</a></li>
					<li><a href="#"><span class="glyphicon glyphicon-list-alt"></span>
							Scheduler</a></li>
					<li><a href="goInfoUpdate"><span class="glyphicon glyphicon-wrench"></span>
							Info Update</a></li>
					<li><a href="goPwdChange"><span class="glyphicon glyphicon-lock"></span>
							Password Change</a></li>
					<li><a href="goUnregister"><span class="glyphicon glyphicon-remove"></span>
							Unregister</a></li>

				</ul>
			</div>
			<!-- /.navbar-collapse --> </nav>

		</div>

		<!-- Main Content -->
		<div class="container-fluid">
			<div class="side-body">
				<%@ include file="/WEB-INF/views/mypage/mySchedule.jsp"%>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
<link href="resources/fullcalendar/fullcalendar.min.css" rel="stylesheet">
<link href="resources/fullcalendar/fullcalendar.print.min.css" rel="stylesheet" media="print">
<script src="resources/fullcalendar/lib/moment.min.js"></script>
<script src="resources/fullcalendar/lib/jquery.min.js"></script>
<script src="resources/fullcalendar/fullcalendar.min.js"></script>
<script src="resources/fullcalendar/theme-chooser.js"></script>
</html>