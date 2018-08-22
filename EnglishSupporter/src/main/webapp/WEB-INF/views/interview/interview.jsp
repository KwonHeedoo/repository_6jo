<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="./resources/css/webRTC.css">
<script type="text/javascript" src = "./resources/jquery-3.3.1.min.js"></script>
<script>
var questions;
var count = 0;
var max = 0;
var pageFlag = false;
var tag;

$(function(){
	init();
	
	
	$("#nextQuestion").on("click",function(){
		if(pageFlag==flase){
			pageFlag = true;
			$("#question").html(tag)
		}
		else{
			if(count < max){
				$("#question").text(questions[count++].question);
			}
		}
	});
	
	$("#startInterview").on("click",function(){
		setQuestionTag();
		
	});
	
});

function init(){
	$.ajax({
		method:'post',
		url:'getQuestion',
		dateType : 'json',
		success :function(data){
			questions = data;
			$("#question").text(questions[count++].question);
			max = questions.length;
		}
	});
	
	
}

function setQuestionTag(){
	tag = "";
	tag += '<h1><p id="question"></p></h1>';
	tag += '<button id = "nextQuestion">NEXT QUESTION</button><br><br>';
	tag += '<video id="gum" playsinline autoplay muted></video>';
	tag += '<div>';
	tag += '<button id="record" disabled>Start Recording</button>';
	tag += '</div>';
	tag += '<script ';
	tag += 'src="https://webrtc.github.io/adapter/adapter-latest.js"><';
	tag += '/script>';
	tag += '<script ';
	tag += 'src="./resources/js/webRTCs.js"><';
	tag += '/script>';
	tag += '<script ';
	tag += 'src="./resources//js/lib/ga.js"><';
	tag += '/script>';
	$("body").html(tag);
	
}
function setDownloadTag(){
	tag = "";
	tag = '<video id="recorded" playsinline loop controls></video>';
	tag = '<button id="play" disabled>Play</button>';
	tag = '<a href="getdata?datanum=">download</a>';
	tag += '<script ';
	tag += 'src="./resources/js/webRTCs2.js"><';
	tag += '/script>';
}

</script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Interview</title>
</head>

<body>

<button id = "startInterview">시작하기</button>
<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
<script src="./resources/js/webRTCs.js" async></script>
<script src="./resources//js/lib/ga.js"></script>
<!-- 임시용 -->
<!-- 	<h1><p id="question"></p></h1>
	<input type="button" id = "nextQuestion" value = "NEXT QUESTION"><br><br>
	<video id="gum" playsinline autoplay muted></video>
	<video id="recorded" playsinline loop controls></video>
	
	    <div>
	        <button id="record" disabled>Start Recording</button>
	        <button id="play" disabled>Play</button>
	        <button id="download" disabled>Download</button>
	    </div> -->
</body>
</html>