<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- google CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="resources/jquery.serialize-object.min.js"></script>
<link href="resources/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<title>Report</title>
<style type="text/css">
body {
    background: #f8f6f6;
    color: #404040;
    font-family: 'Lucida Grande', Verdana, sans-serif;
    font-size: 13px;
    font-weight: normal;
    line-height: 20px;
}
</style>
<script type="text/javascript">
$(function() {
	$('#sendReport').on('click', function() {
		var reason = $('#reason').val();
		
		// 신고 이유를 작성 해야한다.
		if(reason.length == 0){
			alert('Please Write Your Reason');
			return;
		}
		
		// form의 값들 JSON화
		$.fn.serializeObject = FormSerializer.serializeObject;
		var report = $('#reportCheck').serializeObject();
		
		// 신고 접수
		$.ajax({
			url : 'report'
			, type : 'post'
			, data : JSON.stringify(report)
			, contentType : 'application/json; charset=UTF-8'
			, success : function(resp){
				if(resp == 1){
					window.close();
				}
			}
			, error : function(){alert('Error!');}
		});
	});
});
</script>
</head>
<body>
<div class="container">
	<h1>Report to Administrator</h1>
	<hr>
	<form id="reportCheck">
		<input id="reporter" type="hidden" value="${report.reporter}" name="reporter">
		<input id="reportee" type="hidden" value="${report.reportee}" name="reportee">
		<input id="report" type="hidden" value="${report.report}" name="report">
		<textarea id="reason" rows="20" cols="50" name="reason"></textarea>
		<input id="reportURL" type="hidden" value="${reportURL}" name="reportURL">
	</form>
	<br><br>
	<button id="sendReport" class="btn">Send</button>
	<button id="calcel" onclick="window.close()" class="btn">Cancel</button>
</div>
</body>
</html>