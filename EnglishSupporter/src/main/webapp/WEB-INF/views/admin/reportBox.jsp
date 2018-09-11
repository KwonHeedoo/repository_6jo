<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- google CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="resources/jquery.serialize-object.min.js"></script>
<title>Report</title>
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
	<h1>Report to Administrator</h1>
	<form id="reportCheck">
		<input id="reporter" type="hidden" value="${report.reporter}" name="reporter">
		<input id="reportee" type="hidden" value="${report.reportee}" name="reportee">
		<input id="report" type="hidden" value="${report.report}" name="report">
		<textarea id="reason" rows="20" cols="50" name="reason"></textarea>
		<input id="reportURL" type="hidden" value="${reportURL}" name="reportURL">
	</form>
	<button id="sendReport">Send</button>
	<button id="calcel" onclick="window.close()">Cancel</button>
</body>
</html>