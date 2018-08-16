<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src='voicerss-tts.min.js'></script>
<script type="text/javascript">
$(function(){
	$('a.say').on('click',function(e){
		e.preventDefault();
		var text = $('input[name="text"]').val();
		text= encodeURIComponent(text);
		
		
		$('audio').attr('src',url).get(0).play();
		var apikey = "3100d4db68664b858bb58864ea49e91e";
		
	});
	
});

</script>

</head>
<body>

<div>
	<input type="text" name="text">
	<a href="#" class="say">sayit</a>
</div>
<audio src="" class="audio" hidden>




</body>
</html>