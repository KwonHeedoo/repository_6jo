<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
					<li><a href="myScheduler"><span class="glyphicon glyphicon-list-alt"></span>
							Scheduler</a></li>
					<li><a href="goInfoUpdate"><span class="glyphicon glyphicon-wrench"></span>
							Info Update</a></li>
					<li><a href="goPwdChange"><span class="glyphicon glyphicon-lock"></span>
							Password Change</a></li>
					<li><a href="#"><span class="glyphicon glyphicon-remove"></span>
							Withdrawal</a></li>

				</ul>
			</div>
			<!-- /.navbar-collapse --> </nav>

		</div>

