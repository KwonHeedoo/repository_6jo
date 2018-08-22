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
</head>
<body>
	<div class="jumbotron jumbotron-fluid">
		<div class="container">
		<h2>Input New Word for My Wordlist</h2>
			<input type="hidden" name="userid" value="${sessionScope.userid}">
			<label>WORD</label>
			<input type="text" name="word">
			<br>
			<label>meaning</label>	
			<input type="text" name="meaningK">
			
			
			<input type="button" value="SUBMIT" class="btn" id="sendword">
			<div id="result">
				
			</div>
		</div>
	</div>
	
<script type="text/javascript">
	$(function(){
		$('#sendword').on('click',function(){
			var word =$('input[name="word"]');
			var mean =$('input[name="meaningK"]');
			var userid = $('input[name="userid"]').val();
			var newword ={
					'word' : word.val(),
					'meaningK' : mean.val(),
					'userid' : userid,
					'wordtype':"user",
					'command':"insert"
			};
		
			$.ajax({
				method: "post",
				url: "controlMyWords",
				data : newword,
				success: function(reps){
					var result = reps; // 성공....?
					$('#result').text("새 단어 입력이 완료되었습니다.");
					word.val('');
					mean.val('');
				}
			
			});
			
		});
	});

</script>
</body>
</html>