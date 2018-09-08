<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>My Info</title>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<style type="text/css">
.raw{
height: 60%;

}
.side-menu {
margin-top:0;
position:absolute;
float:left;
  width: 280px;
  height: 100%;
  background-color: #f8f8f8;
  border-right: 1px solid #e7e7e7;
}
.side-menu .navbar-nav li {
  display: block;
  width: 100%;
  border-bottom: 1px solid #e7e7e7;
}
.side-body {
  margin-top: 20px;
  margin-left: 300px;
}

.navbar-default .navbar-nav>li>a:hover, .navbar-default .navbar-nav>li>a:focus{
	background-color: #c7c7c7 ;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/header.jsp"%>
	<%@ include file="/WEB-INF/views/mypage/mypage_sidebar.jsp"%>
		<!-- Main Content -->
		<div class="container-fluid">
			<div class="side-body">
				<h2>[ My Words ]</h2>
				<table>
					<tr>
						<th>No</th>
						<th>Word</th>
						<th>Meaning</th>
						<th>Update</th>
						<th>Remove</th>
					</tr>
					<c:forEach var="w" items="${wordlist}" varStatus="status">
					<tr>
						<td><input type="hidden" value="${w.myword_no}">
						${status.count}</td>
						<td><input type="text" name="word" value="${w.word}" readonly="true"></td>
						<td><input type="text" name="mean" value="${w.meaningK}" readonly="true"></td>
						<td><input id="update" type="button" value="UPDATE"></td>
						<td><input id="remove" type="button" value="REMOVE"></td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
<script type="text/javascript">
$(function() {
	
	// UPDATE 버튼 누르면 SAVE 버튼으로 바뀌고 해당 word + meaning 이 수정가능한 상태로 바뀜
	$('input[value="UPDATE"]').on('click',function(){
		var type= $(this).val();
		console.log(type);
		if(type=='UPDATE'){
			console.log('in update');
			$(this).val('SAVE');
			var tr = $(this).parent().parent();
			var ch = tr.children().children('input[type="text"]').attr('readonly',false);
		}
		if(type=='SAVE'){
			console.log('in save');
			$(this).val('UPDATE');
			var tr = $(this).parent().parent();
			var myword_no = tr.children().children('input[type="hidden"]').val();
			var word = tr.children().children('input[name="word"]').val();
			var mean = tr.children().children('input[name="mean"]').val();
			var sendData = {"myword_no" : myword_no, "word" : word, "meaningK" : mean};
			
			$.ajax({
				url : 'mywordUpdate'
				, type : 'post'
				, data : JSON.stringify(sendData)
				, contentType : 'application/json;charset=UTF-8'
				, success : function(resp){
					if(resp == 1){
						alert("Update Completed.");
						location.href = "${pageContext.request.contextPath}/goMyWords";
					}else if(resp == 0){
						alert("Update Failed.");
						location.href = "${pageContext.request.contextPath}/goMyWords";
					}
				}
				, error: function(resp){
					alert("Update Error!");
				}
			});
		}
		
		//console.log(tr);
		//console.log(ch);
	});
	
	// SAVE 버튼 누르면 수정된 word + meaning 으로 업데이트 처리
	$('input[value="SAVE"]').on('click',function(){
		console.log('in save');
		$(this).val('UPDATE');
		var tr = $(this).parent().parent();
		var myword_no = tr.children().children('input[type="hidden"]').val();
		var word = tr.children().children('input[name="word"]').val();
		var mean = tr.children().children('input[name="mean"]').val();
		var sendData = {"myword_no" : myword_no, "word" : word, "meaningK" : mean};
		
		$.ajax({
			url : 'mywordUpdate'
			, type : 'post'
			, data : JSON.stringify(sendData)
			, contentType : 'application/json;charset=UTF-8'
			, success : function(resp){
				if(resp == 1){
					alert("Update Completed.");
					location.href = "${pageContext.request.contextPath}/goMyWords";
				}else if(resp == 0){
					alert("Update Failed.");
					location.href = "${pageContext.request.contextPath}/goMyWords";
				}
			}
			, error: function(resp){
				alert("Update Error!");
			}
		});
	});
});

</script>
</html>