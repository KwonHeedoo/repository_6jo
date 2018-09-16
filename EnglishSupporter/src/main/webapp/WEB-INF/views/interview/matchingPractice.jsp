<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://rtcmulticonnection.herokuapp.com/dist/RTCMultiConnection.min.js"></script>
<script src="https://rtcmulticonnection.herokuapp.com/socket.io/socket.io.js"></script>
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
   var connection = new RTCMultiConnection();
   var localVideoContainer;
   var remoteVideoContainer;
   var predefinedRoomId = '${roomid}';
   console.log(predefinedRoomId);
   
   $(function(){
	   localVideoContainer = document.getElementById("local-videos-container");
	   remoteVideoContainer = document.getElementById("remote-videos-container");
	   connection.openOrJoin( predefinedRoomId );
	});
   // this line is VERY_important
   connection.socketURL = 'https://rtcmulticonnection.herokuapp.com:443/';
   //connection.socketURL = 'ws://localhost:8085/video/pong-ws/';
   
   // if you want audio+video conferencing
   connection.session = {
       audio: true,
       video: true
   };
   
   connection.sdpConstraints.mandatory = {
      OfferToReceiveAudio : true,   
      OfferToReceiveVideo : true   
   };
   connection.onstream = function(event){
	   var video = event.mediaElement;
	      console.log(event.type);
	      
	      if(event.type === 'local'){
	         console.log("local");
	         localVideoContainer.appendChild(video);
	         $('div#local-videos-container>video').attr('controls',false);
	      }
	      if(event.type === 'remote'){
	         console.log("remote");
	         remoteVideoContainer.appendChild(video);
	         $('div#remote-videos-container>video').attr('controls',false);
	      }
   }
   
   



$(function() {
	$('#qlist').click(function() {
		var link = '${pageContext.request.contextPath}'+'/viewQuestions'
		window.open(link, "Qlist", "width=800, height=700, resizable=yes");  
	});
});
   
   
</script>
<style type="text/css">
.screen{
width: 670px;
height: 510px;
border: groove;
padding: 10px;
border-radius: 5px;
margin: 0 auto;
}

span{
width: 660px;
height: 60px;
color: black;
border: 2px solid gray;
border-radius: 10px;
font-size: 20pt;
padding: 5px;
}

.container{
margin-top: 30px;
margin-bottom: 30px;
width: 90%;
text-align: center;
}
.name{
background-color: gray;
color: white;
}

</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%@ include file="/WEB-INF/views/header.jsp"%>
<div class="container">
	<div class="raw">
		<div class="col-md-12">
		<h3 class="name">[INTERVIEW PRACTICE WITH VIDEO CHATTING]</h3>
		<br>
		</div>
		<div class="col-md-6">
		<span class="border rounded">${sessionScope.loginId}</span>
		<br><br>
		<div id = "local-videos-container" class="screen"></div>
		</div>
		<div class="col-md-6">
		<span class="border rounded">${partnerid}연결될 사람의 아이디</span>
		<br><br>
		<div id = "remote-videos-container" class="screen"></div>
		</div>
	</div>
	<br><br>
	<div class="col-md-12" align="center">
	<br>
		<button class="btn btn-defalt" id="qlist">모의면접 질문 LIST</button>
	</div>
</div>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
   </body>
</html>