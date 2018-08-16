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
		$('a.say')
				.on(
						'click',
						function(e) {
							e.preventDefault();
							var text = $('input[name="text"]').val();
							text = encodeURIComponent(text);
							//var apikey = "3100d4db68664b858bb58864ea49e91e";
							var url = 'http://api.voicerss.org/?key=3100d4db68664b858bb58864ea49e91e&hl=en-gb&src='
									+ text;
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
	font-size: 25pt;
}
</style>
</head>
<body>

	<div class="jumbotron jumbotron-fluid">
		<div class="container">
			<div class="raw">
			<c:if test="${wordlist!=null}">
				<div class="col">
				<input type="text" name="text" class="" value="${wordlist[0].word}"
					readonly>
					</div>
				<div class="col">
				<p>${wordlist[0].meaningK}</p>
				</div>
				<a href="#" class="say btn btn-lg btn-primary">sayit</a>

			</c:if>
		</div>
		</div>
		<div align="center">
			<nav aria-label="Page navigation example">
			<ul class="pagination">
				<li class="page-item"><a class="page-link" href="#">Previous</a></li>
				
				<li class="page-item"><a class="page-link" href="#">Next</a></li>
			</ul>
			</nav>
		</div>

		<audio src="" class="audio" hidden>
	</div>





</body>
</html>