<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Composition</title>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		// 문자 체크
		$("#composition").on('keyup', function(){
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
	});
	
	// 문자 체크
	function langCheck(value){
		var str = lastLan(value);
		var chk = false;
		
		if(str == " " || str == "" || str == "," || str == "." || str == "\n"){
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
	
</script>
</head>
<body>
	Composition<br/>
	<form id="compositionCheck" action="confirm" method="post">
		<textarea id="composition" rows="20" cols="50" name="composition"></textarea><br/>
		<input class="confirm" type="checkbox" name="confirm" value="grammer">Grammer
		<input class="confirm" type="checkbox" name="confirm" value="repetition">Repetition
		<input class="confirm" type="checkbox" name="confirm" value="emotion">Emotion
		<br/>
		<button id="stt" type="button">STT</button>
		<button id="check" type="button">Check</button>
	</form>
	<br/>
	<button id="tts" type="button">TTS</button>
</body>
</html>