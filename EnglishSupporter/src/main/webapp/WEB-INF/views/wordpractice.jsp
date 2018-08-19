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
				<span>[학습어휘종류선택]</span>   <button class="btn" id="btn"><img id="checkmyword" src=""></button>
				<select id ="level" class="form-control">
					<option value="1">난이도 초급</option>
					<option value="2">난이도 중급</option>
					<option value="3">난이도 상급</option>
					<option value="0">나의단어장</option>
				</select>
			</div>

			<div class="raw">
				<c:if test="${wordlist!=null}">
					<div class="col-md-12">
						<input type="text" name="text" class="" value="" readonly>
					</div>
					<div class="col-md-12">
						<p id="meaning"></p>
					</div>
					<br>
					<div class="col-md-12">
						<a href="#" class="say btn btn-lg btn-primary">sayit</a>
					</div>

				</c:if>
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

			listsize =wordlist.length;

			console.log(listsize);
			
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
			console.log(level);
			callwordlist(level);
		});
	});
	
		function initword(wordlist){			
			$('#meaning').text(wordlist[index].meaningK);
			$('input[name="text"]').val(wordlist[index].word);
			checkstar();
		}
		
		function checkstar(){
			var checked = wordlist[index].wordtype;
			console.log(checked);
			if(checked=='star'){
				$('#checkmyword').attr('src',"/resources/img/golden.png");
			}else{
				$('#checkmyword').attr('src',"/resources/img/silver.png");
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
				initword(wordlist);
			},
			
		});
	}
		
	</script>


</body>
</html>