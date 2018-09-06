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
		if(event.type === 'local'){
			console.log("local");
			localVideoContainer.appendChild(video);
		}
		if(event.type === 'remote'){
			console.log("remote");
			remoteVideoContainer.appendChild(video);
		}
	}
	
	var predefinedRoomId = '${roomid}';

$(function(){
	localVideoContainer = document.getElementById("local-videos-container");
	remoteVideoContainer = document.getElementById("remote-videos-container");
	connection.openOrJoin( predefinedRoomId );
})
	
	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%@ include file="/WEB-INF/views/header.jsp"%>
<div id = "local-videos-container">
</div>
<div id = "remote-videos-container">
</div>
<p> 123 </p>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
	</body>
</html>