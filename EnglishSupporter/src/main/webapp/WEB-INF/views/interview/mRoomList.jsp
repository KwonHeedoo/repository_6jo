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


</style>
</head>
<body>
	<div align="center"><h3>Room List</h3></div>
 <table class="todo-list">

  </table>
</body>
<script type="text/javascript">
function callPfunction(roomid){
	window.opener.goMatching(roomid);
}

$(function() {
	// 문제목록 가져오기 
	$.ajax({
		method:'post',
		url:'getMRoomList',
		dateType : 'json',
		success :function(data){
			var text="";
			text += '<table>';
			
			for (var i = 0; i < data.length; i++) {
				 text += "<tr>";
				 text += '<td><a href="javascript:void(0);" onclick="callPfunction('+ data[i].roomnum + ' );">' + data[i].roomnum +'</a></td>';
				 text += '<td> Appointed Time : '+ data[i].appointedTime + '</td>'
				 text += "</tr>";
			}
			text += '</table>';
			$('table.todo-list').append(text);
		},
		error:function(resp){
			console.log('에러'+resp);
		}
	});
});


</script>
</html>