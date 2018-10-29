<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
<!-- <script src='../resources/voicerss-tts.min.js'></script> -->
<script src="./resources//js/wordPractice.js"></script>
<script src="https://cdn.webrtc-experiment.com/RecordRTC.js"></script>
<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
<style type="text/css">
.container {
	text-align: center;
}

input {
	border: none;
	background: transparent;
	font-size: 30pt;
	width: 100%;
	text-align: center;
	margin-top: 50px;
	margin-bottom: 10px;	
}
.stopb{
	float: right;
    position: relative;
    left: -45%;
}
.startb{
	float: left;
    position: relative;
    left: 45%;
}

</style>
</head>


<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
	<div class="jumbotron jumbotron-fluid">
		<div class="container">
			<div>
				
				<a href="#" id="mywordstar"><img id="checkmyword" src="" alt="star" border="0" /></a>
				<br>
				<span>[학습어휘종류선택]</span> <br>
				<span id="userworddelete"></span>
					<select id ="level" class="form-control">
					<option value="1">난이도 초급</option>
					<option value="2">난이도 중급</option>
					<option value="3">난이도 상급</option>
					<option value="0">나의단어장</option>
				</select>
			</div>

			<div class="raw">
					<div class="col-md-12">
						<input type="text" name="text" class="" value="" readonly>
					</div>
					<br>
					<div class="col-md-12">
						<span id="meaning"></span>
					</div>
					<br><br>
					<div class="col-md-12">
						<a href="#" class="say btn">say it!</a>
					</div>
							
			</div>
		<div align="center">
		<div><span class="word"></span></div>
			<ul class="pagination">
			
				<li class="page-item"><a class="page-link" href="#" id="before">Previous</a></li>
				<li class="page-item"><a class="page-link" href="#" id="next">Next</a></li>
			</ul>
		</div>
		</div>

	<div class="col-md-12" style="text-align: right">
		<a href="#" class="writeword btn">Add MyWord</a>
		</div>
	</div>	
	<div class="raw" align="center">
	<hr>
	<div class="col-md-12">
		<div class="startb"> 
	<button id="btn-start-recording" type="button"><img  src="./resources/images/icons/mic.gif" style="width:20px;height:20px;"></button>start
		</div>
		<div class="stopb"> 
	<button id="btn-stop-recording" type="button"><img  src="./resources/images/icons/mic-slash.gif" style="width:20px;height:20px;"></button>stop
		</div>
		<br>
	</div>
		<br>
		<div class="col-md-12">
		<audio controls id="playaudio"></audio>
		<br>
		</div>
	<hr>
	</div>
	
	<audio src="" class="audio" hidden></audio>
	
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>