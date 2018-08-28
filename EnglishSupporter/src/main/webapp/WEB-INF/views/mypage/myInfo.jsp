<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>My Info</title>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<style type="text/css">
.raw{
height: 60%;

}
.side-menu {
margin-top:0;
position:absolute;
float:left;
  width: 280px;
  height: 100%;
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
	<div class="raw">
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
						<a class="navbar-brand" href="#"><span class="glyphicon glyphicon-user"></span> ${sessionScope.u.nickname}'s My page </a>
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
					<li><a href="#"><span class="glyphicon glyphicon-lock"></span>
							Change Password</a></li>
					<li><a href="#"><span class="glyphicon glyphicon-remove"></span>
							Withdrawal</a></li>

				</ul>
			</div>
			<!-- /.navbar-collapse --> </nav>

		</div>

		<!-- Main Content -->
		<div class="container-fluid">
			<div class="side-body">
				<h1>Main Content here</h1>
				<pre> Resize the screen to view the left slide menu </pre>
				<p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed
					diam nonumy eirmod tempor invidunt ut labore et dolore magna
					aliquyam erat, sed diam voluptua. At vero eos et accusam et justo
					duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata
					sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet,
					consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt
					ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero
					eos et accusam et justo duo dolores et ea rebum. Stet clita kasd
					gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
					Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam
					nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam
					erat, sed diam voluptua. At vero eos et accusam et justo duo
					dolores et ea rebum. Stet clita kasd gubergren, no sea takimata
					sanctus est Lorem ipsum dolor sit amet.</p>



			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>