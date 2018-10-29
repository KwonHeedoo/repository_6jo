<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<style type="text/css">
input{
width: 100%;
}
th{
width: 20%;
}
.btn{
    color: #FFFFFF;
    background-color: #D64E3F;
    border-color: #D64E3F;
    display: inline-block;
    padding: 8px 10px 10px;
    text-transform: uppercase;
    border: 1px solid;
    border-radius: 22px;
}
.btn:hover {
	color: #333;
    background-color: transparent;
}
.td{
text-align: center;
}
</style>
</head>
<body>
	<div class="jumbotron jumbotron-fluid">
		<div class="container">
		<h2>Input new word for my Wordlist</h2>
		<hr>
		<input type="hidden" name="userid" value="${sessionScope.userid}">
			<table>
			<tr>
			<th> WORD </th>
			<td><input type="text" name="word"><br></td>
			</tr>
			<tr>
			<th> Meaning </th>
			<td><input type="text" name="meaningK"></td>
			</tr>
			<tr>
			<td><br><input type="button" value="SUBMIT" class="btn" id="sendword"></td>
			</tr>
			</table>
			
		</div>
	</div>
			<div id="result" align="center"></div>
	
<script type="text/javascript">
function isAlphabet(ch) {
	  var numUnicode = ch.charCodeAt(0); // number of the decimal Unicode
	  if ( 65 <= numUnicode && numUnicode <= 90 ) return true;	// 대문자
	  if ( 97 <= numUnicode && numUnicode <= 122 ) return true;	// 소문자
	  return false;
}
	$(function(){
		$('#sendword').on('click',function(){
			var word = $('input[name="word"]').val();
			var mean = $('input[name="meaningK"]').val();
			var userid = $('input[name="userid"]').val();
			
			if(word==""||mean==""){
				alert('Please fill out the black');
				return;
			}
			var length = word.length;
			var str = word.substr(length-1,length);
			
			if(!isAlphabet(str)){
				alert('Please write English for word');
				return;
			}
			
			var newword ={
					'word' : word,
					'meaningK' : mean,
					'userid' : userid,
					'wordtype':"user",
					'command':"insert"
			};
		
			$.ajax({
				method: "post",
				url: "controlMyWords",
				data : newword,
				success: function(reps){
					var result = reps; /
					$('#result').text("새 단어 입력이 완료되었습니다.");
					$('input[name="word"]').val('');
					$('input[name="meaningK"]').val('');
				}
			
			});
			
		});
	});

</script>
</body>
</html>