<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Composition</title>
<!-- microsoft CDN -->
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#comp').addClass('active');
	
	// 문자 체크
	$('#composition').on('keyup', function(){
		langCheck($("#composition").val()); 
	});
	
	// 서브밋
	$('#check').on('click', function(){
		var composition = $('#composition').val();
		if(composition.length == 0){
			alert("please write composition.");
			return;
		}
		
		$('#compositionCheck').submit();
	});
	
	// 텍스트 음성 제공(TTS)
	$('#ttsBtn').on('click',function(e) {
		e.preventDefault();
		var composition = $('#composition').val();
		composition = encodeURIComponent(composition);
		
		var url = 'http://api.voicerss.org/?key=3100d4db68664b858bb58864ea49e91e&hl=en-gb&src='+ composition;
		$('audio').attr('src', url).get(0).play();
	});
	
	// STT 페이지 새창
	$('#stt').on('click', function(){
		window.open("./goSpeakingText", "Speaking to Text", "width=700, height=500, location=no, toolbar=no, menubar=no, scrollbars=no, resizable=no");
	});
});

// 문자 체크
function langCheck(value){
	var str = lastLan(value);
	var chk = false;
	
	if(str == " " || str == "" || str == "'" || str == "," || str == "." || str == "-" || str == "\n"){
		chk = true;
	}else if(isNaN(str)){
		chk = isAlphabet(str);
	}else{
		chk = isNumber(str);
	}
	
	if(!chk){
		alert('형식에 맞는 문자 및 숫자만 입력가능합니다.');
	}
}

// 마지막 글자 추출
function lastLan(val){
	var length = val.length;
	var str = val.substr(length-1,length);
	return str;
}

// 문자가 영어인지 판별
function isAlphabet(ch) {
  var numUnicode = ch.charCodeAt(0); // number of the decimal Unicode
  if ( 65 <= numUnicode && numUnicode <= 90 ) return true;	// 대문자
  if ( 97 <= numUnicode && numUnicode <= 122 ) return true;	// 소문자
  return false;
}

// 문자가 숫자인지 판별
function isNumber(ch) {
	var numUnicode = ch.charCodeAt(0);                                                                                    
	if ( 48 <= numUnicode && numUnicode <= 57 ) return true;            
	return false;
}

// STT 자식창의 값 가져오기
function setSttData(sendData){
	document.getElementById('composition').value = sendData;
}

</script>
<style type="text/css">
.tts{
margin-bottom: 20px;
}
.container{
margin-top: 20px;
}
input[type="checkbox"]{
height: 20px;
width: 20px;
}
table{
width: 1300px;
}

</style>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
<div class="container" align="center">
	<h2>Composition</h2>
	<hr>
	<form id="compositionCheck" action="goConfirmed" method="post">
		<textarea id="composition" rows="20" cols="100" name="composition"></textarea><br/>

		<div id="checkList" style="width:30%;">
				<br>
			<div class="col-md-4"><input class="confirm" type="checkbox" name="confirm" value="grammer"><br>Grammer</div>
			<div class="col-md-4"><input class="confirm" type="checkbox" name="confirm" value="emotion"><br>Emotion</div>
			<div class="col-md-4"><input class="confirm" type="checkbox" name="confirm" value="repetition"><br>Repetition</div>
		</div>
		<br><br>
		<hr>
		<div id="btn" class="raw">
			<button id="stt" type="button">Speech to Text</button>
			<button id="check" type="button">Check</button>
		</div>
	</form>
	<br/>
	<!-- 텍스트 음성 제공 버튼(TTS Button) -->
	<div id="tts" class="raw tts">
		Text to Speech 
		<button id="ttsBtn"><img alt="speaker" src="./resources/images/icons/speaker.png" style="width:20px;height:20px;"></button>
		<audio src="" class="audio" hidden></audio>
	</div>
</div>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>