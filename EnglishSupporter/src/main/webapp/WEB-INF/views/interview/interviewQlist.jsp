<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>Insert title here</title>
<style type="text/css">
body {
    background: #f8f6f6;
    color: #404040;
    font-family: 'Lucida Grande', Verdana, sans-serif;
    font-size: 13px;
    font-weight: normal;
    line-height: 20px;
}
.todo-list { border-top: 1px solid #e6ebed }

.todo-list:before {
    content: '';
    width: 3px;
    z-index: 2;
    border: 1px solid #f2e3df;
    border-width: 0 1px;
    position: absolute;
    top: 0px;
    bottom: 0px;
    left: 35px;
}

.todo-list li {
    position: relative;
    padding: 7px 15px 7px 50px;
    line-height: 21px;
    font-size: 12px;
    color: #8b8f97;
    border-bottom: 1px solid #e6ebed;
}

</style>
</head>
<body>
<div class="container">
	<div align="center"><h3>Question List</h3></div>
 <ul class="todo-list">
 </ul>

</div>
</body>
<script type="text/javascript">
$(function() {
	$('#interview').addClass('active');
	
	// 문제목록 가져오기 
	$.ajax({
		method:'post',
		url:'getQuestion',
		dateType : 'json',
		success :function(data){
			var text="";
			console.log(data[0].question);
			for (var i = 0; i < data.length; i++) {
				//console.log(item[index]);
				 text += '<li class="done"><input type="checkbox"/>'+data[i].question+'</li>'; 
			}
			$('ul.todo-list').append(text);
		},
		error:function(resp){
			console.log('에러'+resp);
		}
	});
});


</script>
</html>