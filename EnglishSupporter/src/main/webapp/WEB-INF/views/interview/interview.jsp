<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>

    <meta charset="utf-8">
    <meta name="description" content="WebRTC code samples">
    <meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1, maximum-scale=1">
    <meta itemprop="description" content="Client-side WebRTC code samples">
    <meta itemprop="image" content="../../../images/webrtc-icon-192x192.png">
    <meta itemprop="name" content="WebRTC code samples">
    <meta name="mobile-web-app-capable" content="yes">
    <meta id="theme-color" name="theme-color" content="#ffffff">

    <base target="_blank">

    <title>Interviewing</title>
    <link rel="stylesheet" href="./resources/css/webRTC.css">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<script type="text/javascript" src = "./resources/jquery-3.3.1.min.js"></script>
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
	
</head>

<body>

	<div id="container">
	
		<div id = "start_part">
			<button id = "start">Start</button>
		</div>
		<div id = "question_part"  style="display:none">
			<h1 id = "question"></h1>
			<video id="gum" playsinline autoplay muted></video><br>
			<button id="end" >대답 완료</button>
		</div>
	    <div id="download_part"  style="display:none">
	    	 <video id="recorded" playsinline loop controls></video><br>
	    	<button id="play" >Play</button><br>
	    	<a id="download" href="#">download</a>
	    	<button id="record" >다음 질문</button>
	    </div>
	</div>

<!-- include adapter for srcObject shim -->

<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
<script src="./resources/js/webRTC/startRecord.js" async></script>
<script src="./resources//js/lib/ga.js"></script>

</body>
</html>
