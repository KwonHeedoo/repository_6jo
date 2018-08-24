<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>New Resume</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style>
#title {width:450px;}
#email {width:250px;}
#address {width:480px;}
#schoolname{width:280px;}
#major{width:400px;}
#pro_title{width:280px;}
#pro_desc{width:400px;}
#act_title{width:280px;}
#act_desc{width:400px;}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/header.jsp"%>
	<div class="container">
		<div class="row justify-content-end">
			<div class="col-4">
			<h2>[ New Resume ]</h2>
			<br>
			<form action="newResume" method="post">
				<input type="hidden" name="res_cov" value="resume">
				<div class="row">
					<div class="col-md-5">
					<p>TITLE: </p><input id="title" type="text" name="title" placeholder="COMPANY NAME / JOB TITLE" />
					</div>
					<div class="col-md-2">
					<p>DEADLINE: </p><input type="date" name="deadline" />
					</div>
				</div>
				<br>
				<p>HASHTAGS:</p>
					<div class="row">
						<div class="col-md-2">
							<input type="text" name="hashtag" placeholder="hashtag" />
						</div>
						<div class="col-md-2">
							<input type="button" value="+" />
						</div>
					</div>
					<br>
				
				<hr>
				
				<br>
				<div class="row">
					<div class="col-md-2">
						<p>NAME: </p><input type="text" name="username" readonly />
					</div>
					<div class="col-md-3">
						<p>EMAIL: </p><input id="email" type="text" name="email" readonly />
					</div>
					<div class="col-md-2">
						<p>PHONE NUMBER: </p><input type="text" name="phone" placeholder="PHONE NUMBER" />
					</div>
					<div class="col-md-2">
						<p>ADDRESS: </p><input id="address" type="text" name="address" placeholder="ADDRESS" />
					</div>
					<div class="col"></div>
				</div>
				<br>
				<br>
				<p>EDUCATION:</p>
				<div class="row">
					<div class="col-md-2">
						<input type="date" name="edu_date1" placeholder="START DATE" />(start date)
					</div>
					<div class="col-md-2">
						<input type="date" name="edu_date2" placeholder="END DATE" />(end date)
					</div>
					<div class="col-md-3">
						<input id="schoolname" type="text" name="edu_school" placeholder="SCHOOL NAME" />
					</div>
					<div class="col-md-4">
						<input id="major" type="text" name="edu_major" placeholder="MAJOR" />
					</div>
					<div class="col-md-1">
						<input type="button" value="+" />
					</div>
				</div>
				<br>
				<br>
				<p>SKILLS:</p>
				<div class="row">
					<div class="col-md-2">
						<input type="text" name="skill" placeholder="SKILL" />
					</div>
					<div class="col-md-2">
						<input type="button" value="+" />
					</div>
				</div>
				<br>
				<br>
				<p>PROFESSIONAL EXPERIENCES:</p>
				<div class="row">
					<div class="col-md-2">
						<input type="date" name="pro_date1" placeholder="START DATE" />(start date)
					</div>
					<div class="col-md-2">
						<input type="date" name="pro_date2" placeholder="END DATE" />(end date)
					</div>
					<div class="col-md-3">
						<input id="pro_title" type="text" name="pro_job" placeholder="JOB TITLE" />
					</div>
					<div class="col-md-4">
						<input id="pro_desc" type="text" name="pro_detail" placeholder="DESCRIPTION" />
					</div>
					<div class="col-md-1">
						<input type="button" value="+" />
					</div>
				</div>
				<br>
				<br>
				<p>ACTIVITIES:</p>
				<div class="row">
					<div class="col-md-2">
						<input type="date" name="act_date1" placeholder="START DATE" />(start date)
					</div>
					<div class="col-md-2">
						<input type="date" name="act_date2" placeholder="END DATE" />(end date)
					</div>
					<div class="col-md-3">
						<input id="act_title" type="text" name="act_title" placeholder="ACTIVITY TITLE" />
					</div>
					<div class="col-md-4">
						<input id="act_desc" type="text" name="act_detail" placeholder="DESCRIPTION" />
					</div>
					<div class="col-md-1">
						<input type="button" value="+" />
					</div>
				</div>
				<br>
				<br>
				<p>LANGUAGES:</p>
				<div class="row">
					<div class="col-md-2">
						<input type="text" name="lang" placeholder="LANGUAGE" />
					</div>
					<div class="col-md-2">
						<select id="lang_pro">
							<option value="elementary">elementary proficiency</option>
							<option value="limited working">limited working
								proficiency</option>
							<option value="professional working">professional
								working proficiency</option>
							<option value="full professional working">full
								professional working proficiency</option>
							<option value="native or bilingual">native or bilingual</option>
						</select>
					</div>
				</div>
				<br>
				<br>
				<div class="row">
					<div class="col-md-12">
						<p>ADDITIONAL INFO:</p>
						<textarea rows="6" cols="85"></textarea>
					</div>
				</div>
				<br>
				<br>
				<input type="submit" value="SAVE">
			</form>
			<div class="col-4"></div>
			</div><!-- col -->
			<div class="col align-self-end"></div>
		</div><!-- row -->
	</div>
	<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>