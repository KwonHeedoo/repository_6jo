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
	<div class="raw">
		<!-- uncomment code for absolute positioning tweek see top comment in css -->
		<!-- <div class="absolute-wrapper"> </div> -->
		<!-- Menu -->
		<div class="side-menu">
			<nav class="navbar navbar-default" role="navigation"> <!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<div class="brand-wrapper">
					<!-- Hamburger -->
					<button type="button" class="navbar-toggle">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>

					<!-- Brand -->
					<div class="brand-name-wrapper">
						<a class="navbar-brand" href="#"><span class="glyphicon glyphicon-user"></span> ${sessionScope.loginNick}'s My page </a>
					</div>
				</div>

			</div>

			<!-- Main Menu -->
			<div class="side-menu-container">
				<ul class="nav navbar-nav">

					<li><a href="goMyWords"><span class="glyphicon glyphicon-book"></span>
							My Words</a></li>
					<li><a href="#"><span class="glyphicon glyphicon-list-alt"></span>
							Scheduler</a></li>
					<li><a href="goInfoUpdate"><span class="glyphicon glyphicon-wrench"></span>
							Info Update</a></li>
					<li><a href="goPwdChange"><span class="glyphicon glyphicon-lock"></span>
							Password Change</a></li>
					<li><a href="goUnregister"><span class="glyphicon glyphicon-remove"></span>
							Unregister</a></li>

				</ul>
			</div>
			<!-- /.navbar-collapse --> </nav>

		</div>

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
						<th>Delete</th>
					</tr>
					<c:forEach var="w" items="${wordlist}" varStatus="status">
					<tr>
						<td><input type="hidden" value="${w.myword_no}">
						${status.count}</td>
						<td><input type="text" name="word" value="${w.word}" readonly="true"></td>
						<td><input type="text" name="mean" value="${w.meaningK}" readonly="true"></td>
						<td><input id="update" type="button" value="UPDATE"></td>
						<td><input id="delete" type="button" value="DELETE"></td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
<script type="text/javascript">
$(function() {
	
	$('input[value="UPDATE"]').on('click',function(){
		var type= $(this).val();
		
		// UPDATE 버튼 누르면 SAVE 버튼으로 바뀌고 해당 word + meaning 이 수정가능한 상태로 바뀜
		if(type=='UPDATE'){
			console.log('in update');
			$(this).val('SAVE');
			var tr = $(this).parent().parent();
			var ch = tr.children().children('input[type="text"]').attr('readonly',false);
		}
		
		// SAVE 버튼 누르면 다시 UPDATE 버튼으로 바뀌고 해당 word + meaning 이 수정가능한 상태로 바뀜
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
		
	});
	
	// DELETE 버튼 누르면 해당 단어 삭제
	$('#delete').on('click',function(){
		console.log('in delete');
		var tr = $(this).parent().parent();
		var myword_no = tr.children().children('input[type="hidden"]').val();
		console.log(myword_no);
		$.ajax({
			url : 'mywordDelete'
			, type : 'post'
			, data : {"myword_no" : myword_no}
			, success : function(resp){
				if(resp == true){
					alert("Delete Completed.");
					location.href = "${pageContext.request.contextPath}/goMyWords";
				}else if(resp == false){
					alert("Delete Failed.");
					location.href = "${pageContext.request.contextPath}/goMyWords";
				}
			}
			, error: function(resp){
				alert("Delete Error!");
			}
		});
	});
});

</script>
</html>