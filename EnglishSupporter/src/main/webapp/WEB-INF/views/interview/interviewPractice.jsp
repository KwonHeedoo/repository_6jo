<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Interviewing</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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

	$(function() {
		$('#interview').addClass('active');
		
		$("#start_part").show();
		$("#question_part").hide();
		$("#download_part").hide();
		init();

		$("#start").on('click', function() {
			$("#start_part").hide();
			$("#question_part").show();
			$("#download_part").hide();
		});
		$("#end").on('click', function() { //대답완료시 
			$("#start_part").hide();
			$("#question_part").hide();
			$("#download_part").show();
			var stt = setInterval(getSTT,500);
			var appr = setInterval(getPronAppraisal,500);
			function getSTT(){
				var num = $("#datanum").attr("value");	
				console.log(num);
				$.ajax({
					method : 'post',
					url : 'getResultIData',
					data : {"dataNum" : num},
					dateType : 'json',
					success : function(data) {
						if(data.answer == null){
							console.log("answer waiting");
						}
						else if(data.answer == "no answer"){
							console.log("no answer");
							clearInterval(stt);
							console.log(questions[count]);
							$('#Q2').text("Q. "+questions[count-1].question);
							$("#answer").text("Answer : " +data.answer);
						}
						else{
							console.log("Set Answer");
							clearInterval(stt);
							console.log(questions[count]);
							$('#Q2').text("Q. "+questions[count-1].question);
							$("#answer").text("Answer : " +data.answer);
						}
						
						//data.answer;
					}
				});
			}
			//[AJAX] 발음 평가된 값  가져오기
			function getPronAppraisal(){
				var num = $("#datanum").attr("value");
				$.ajax({
					method : 'post',
					url : 'getResultIData',
					data : {"dataNum" : num},
					dateType : 'json',
					success : function(data) {
						console.log(data.confidence);
						if(data.confidence == -1){
							console.log("appr waiting");
						}
						else{
							console.log("set appr");
							clearInterval(appr);
							$("#confidence").text("Confidence : " + data.confidence);
						}
					}
				});
			}
			//getSTT();
			//getPronAppraisal();
		});
		$("#record").on('click', function() {
			//$('#recorded').attr('src','');
			$("#start_part").hide();
			$("#question_part").show();
			$("#download_part").hide();
			
			$('#Q2').text("");
			$("#answer").text("");
			$("#confidence").text("");
					
			$("#datanum").val("");
			setQuestion();
		});
	});
	function init() {
		$.ajax({
			method : 'post',
			url : 'getQuestion',
			dateType : 'json',
			success : function(data) {
				questions = data;
				max = questions.length;
				setQuestion();
			}
		});
	}

	function setQuestion() {
		if (count < max) {
			$("#question").text('Q:'+questions[count++].question);
		} else {
			alert("모든 문제 소비");
		}
	}
	//[AJAX] STT 한 택스트 가져오기
	/* if($("#datanum").val != ""){
		
	} */
	
	
	/* window.onunload = function() {
	    myfun();
	    alert('Bye.');
	} */
	
</script>
<style type="text/css">
.container{
	text-align: center;
	height: 700px;
}

.jumbotron {
	margin-top: 30px;
	height: 750px;
	text-align: center;
}
button {
	border: none;
	background: transparent;
	font-size: 30pt;
	text-align: center;
	margin-top: 50px;
	margin-bottom: 10px;
}

.stopb {
	float: right;
	position: relative;
	left: -45%;
}

.startb {
	float: left;
	position: relative;
	left: 45%;
}

button {
	margin: 0;
}

#gum{
border-radius: 5px;
}
#question_part{
margin: 5px auto;
}
#download_part{
padding-left: 30px;
padding-right: 30px;

}
.col-md-6{
height: 600px;
}
span{
width: 100%;
height: 100%;
border-radius: 10px;
font-size: 20pt;
padding: 5px;
}
.name{
background-color: gray;
color: white;
text-align: center;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/header.jsp"%>
		<div id="container">
	<div class="jumbotron jumbotron-fluid">
			<h3 class="name">[INTERVIEW PRACTICE]</h3><br>
			<div id="start_part" style="text-align: center">
				<h3>Press START button to start recording videos for interview practice!</h3>

				<button id="start" class="btn">Start</button>
			</div>
			<div id="question_part" style="display: none; text-align: center">
				<h3 id="question"></h3>
				<video id="gum" playsinline autoplay muted></video>
				<br><br>
				<button id="end" class="btn">대답 완료</button>
				
				
			</div>
			<div  id="download_part" style="text-align: center">
				<div class ="col-md-6">
				<video id="recorded" controls height="480" width="680"></video>
				<br>
				<a id="download" href="#" class="btn">영상 download</a>
				<button id="record" class="btn">다음 질문</button>
				<br>
				</div>
				<div class ="col-md-6">
				<span id = "Q2"></span><br><br>
				<span id = "answer"></span>
				</div>
				<div class ="col-md-12">
				<span id = "confidence">Confidence :<br></span>
				</div>
				
			</div>
		</div>
	</div>
	<input type ="hidden" id = "datanum">
	<!-- include adapter for srcObject shim -->

	<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
	<script src="./resources/js/webRTC/startRecord.js" async></script>
	<script src="./resources//js/lib/ga.js"></script>
	<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>
