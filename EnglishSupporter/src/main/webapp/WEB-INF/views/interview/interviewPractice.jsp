<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>

<meta charset="utf-8">
<meta name="description" content="WebRTC code samples">
<meta name="viewport"
	content="width=device-width, user-scalable=yes, initial-scale=1, maximum-scale=1">
<meta itemprop="description" content="Client-side WebRTC code samples">
<meta itemprop="image" content="../../../images/webrtc-icon-192x192.png">
<meta itemprop="name" content="WebRTC code samples">
<meta name="mobile-web-app-capable" content="yes">
<meta id="theme-color" name="theme-color" content="#ffffff">

<base target="_blank">

<title>Interviewing</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

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
<script>
		var questions;
		var count = 0;
		var max;
		
		
		$(function(){
			$("#start_part").show();
			$("#question_part").hide();
			$("#download_part").hide();
			init();
			
			$("#start").on('click',function(){
				$("#start_part").hide();
				$("#question_part").show();
				$("#download_part").hide();
			});
			$("#end").on('click',function(){
				$("#start_part").hide();
				$("#question_part").hide();
				$("#download_part").show();
			});
			$("#record").on('click',function(){
				$("#start_part").hide();
				$("#question_part").show();
				$("#download_part").hide();
				setQuestion();
			});
		});
		function init(){
			$.ajax({
				method:'post',
				url:'getQuestion',
				dateType : 'json',
				success :function(data){
					questions = data;
					max = questions.length;
					setQuestion();
				}
			});
		}
		
		function setQuestion(){
			if(count < max){
				$("#question").text(questions[count++].question);
			}
			else{
				alert("모든 문제 소비");
			}
		}
		
		
	</script>
	<style type="text/css">
.container {
	text-align: center;
}

button {
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
	<div id="container">

		<div id="start_part" style="text-align:center">
			<button id="start">Start</button>
		</div>
		<div id="question_part" style="display: none;text-align:center">
			<h1 id="question"></h1>
			<video id="gum" playsinline autoplay muted></video>
			<br>
			<button id="end">대답 완료</button>
		</div>
		<div id="download_part" style="display: none;text-align:center">
			<video id="recorded" controls autoplay loop></video>
			<br>
			<button id="play">Play</button>
			<br> <a id="download" href="#">download</a>
			<button id="record">다음 질문</button>
		</div>
	</div>
	</div>

	<!-- include adapter for srcObject shim -->

	<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
	<script src="./resources/js/webRTC/startRecord.js" async></script>
	<script src="./resources//js/lib/ga.js"></script>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>
