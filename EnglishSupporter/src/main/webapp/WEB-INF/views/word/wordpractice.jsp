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
<!-- <script src='../resources/voicerss-tts.min.js'></script> -->
<script type="text/javascript">
	$(function() {
		$('a.say').on('click',function(e) {
			e.preventDefault();
			var text = $('input[name="text"]').val();
			text = encodeURIComponent(text);
			//var apikey = "3100d4db68664b858bb58864ea49e91e";
			var url = 'http://api.voicerss.org/?key=3100d4db68664b858bb58864ea49e91e&hl=en-gb&src='+ text;
		$('audio').attr('src', url).get(0).play();

		});
	});
</script>
<style type="text/css">
.container {
	text-align: center;
}

input {
	border: none;
	background: transparent;
	font-size: 30pt;
	width: 100%;
	text-align: center;
}
</style>
</head>
<body>

	<div class="jumbotron jumbotron-fluid">
		<div class="container">
			<div>
				
				<a href="#" id="mywordstar"><img id="checkmyword" src="" alt="star" border="0" /></a>
				<br>
				<span>[학습어휘종류선택]</span> <br>
				<span id="userworddelete"></span>
					<select id ="level" class="form-control">
					<option value="1">난이도 초급</option>
					<option value="2">난이도 중급</option>
					<option value="3">난이도 상급</option>
					<option value="0">나의단어장</option>
				</select>
			</div>

			<div class="raw">
					<div class="col-md-12">
						<input type="text" name="text" class="" value="" readonly>
					</div>
					<div class="col-md-12">
						<span id="meaning"></span>
					</div>
					<br>
					<div class="col-md-12">
						<a href="#" class="say btn btn-lg btn-primary">sayit</a>
					</div>
			</div>
		</div>
		<div align="center">
			<nav>
			<ul class="pagination">
				<li class="page-item"><a class="page-link" href="#" id="before">Previous</a></li>

				<li class="page-item"><a class="page-link" href="#" id="next">Next</a></li>
			</ul>
			</nav>
		</div>

		<audio src="" class="audio" hidden>
	</div>

	<script type="text/javascript">
		var index = 0;
		var listsize=0;
		var wordlist = new Array();

		$(function() {
			var level = 1;
			callwordlist(level)
			//initword(wordlist);
			//단어이동 클릭이벤트 
			$('#before').on('click', function() {
				if(index>0){
					index--;
				}
				$('#meaning').text(wordlist[index].meaningK);
				$('input[name="text"]').val(wordlist[index].word);
				checkstar();
			});
			
			$('#next').on('click', function() {
				if(index<listsize-1){
					index++;
				}
				$('#meaning').text(wordlist[index].meaningK);
				$('input[name="text"]').val(wordlist[index].word);
				checkstar();
			});
			
		//난이도별 단어 가져오기 
		$('#level').change(function(){
			
			var level = $(this).val();
			//console.log(level);
			callwordlist(level);
		});
	});
	
		function initword(wordlist){	
			//console.log(wordlist[index].meaningK);
			$('#meaning').text(wordlist[index].meaningK);
			$('input[name="text"]').val(wordlist[index].word);
			checkstar();
		}
		
		function checkstar(){
			var checked = wordlist[index].wordtype;
			console.log(checked);
			$('#userworddelete').html("");
			if(checked=='star'){
				$('#checkmyword').attr('src','/web/resources/img/golden.png');
			}else if(checked =='user'){
				$('#checkmyword').attr('src','/web/resources/img/golden.png');
				var text ='<a id="deletemyword" href="#">삭제</a>';
				$('#userworddelete').html(text);
			}else{
				$('#checkmyword').attr('src','/web/resources/img/silver.png');
				
			}
		}
		
		
	function callwordlist(level) {
		$.ajax({
			
			method: "post",
			url: "getMyWords",
			data : {'wordlevel' : level},
			success: function(reps){
				wordlist = reps;
				index=0;
				listsize =wordlist.length;
				
				console.log(wordlist);
				console.log(listsize);
				initword(wordlist);
			},
			
		});
	}
	
	$('#mywordstar').on('click',function(){
		var src = $('#checkmyword').attr('src');
		console.log(src);
		var word= $('input[name="text"]').val();
		var word = wordlist[index];
		
		if(src.includes('golden')){
			$('#checkmyword').attr('src','/web/resources/img/silver.png');
			// 나의 단어장에서 해당 단어 삭제처리하기 			
			word.command = 'delete';
		}else{
			$('#checkmyword').attr('src','/web/resources/img/golden.png');
			//나의 단어장에 해당단어 추가하기 
			word.command = 'insert';
		}
		console.log(word);
		
			$.ajax({
				method: "post",
				url: "controlMyWords",
				data : word,
				success: function(reps){
					var result = reps;
					console.log(result);
				}
			});
		
	});
		
	</script>


</body>
</html>