<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<style type="text/css">
.center{
margin :50px auto;
text-align: center;
width: 45%;
margin-top: 70px;
}
input{
width: 100%;
height: 30px;
border:1px solid; border-radius:22px;
display:block; width:100%; padding:8px 15px;
}
.btn{
width: 40%;
height: 35px;
padding:8px 18px 10px; text-transform:uppercase; font-weight:700; cursor:pointer;
border:1px solid; border-radius:22px;
}
.container{
height: 40%;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
<div class="container" >
	<div class="row">
		<div class="center">
			<h2>[ LOGIN ]</h2>
			<div class="center">
				<p><input type="text" id="userid" name="userid" placeholder="ID" /></p>
				<p><input type="password" id="userpwd" name="userpwd" placeholder="PASSWORD" /></p>
				<p><input type="button" id="login" class="btn" value="LOGIN"></p>
			</div>
		</div>
	</div><!-- row -->
</div>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
<script>
$(function(){
	$('#login').on('click', function(){
		var userid = $('#userid').val();
		var userpwd = $('#userpwd').val();
		var sendData = {"userid" : userid, "userpwd" : userpwd};
		
		$.ajax({
			type :'post'
			, url: 'loginCheck'
			, data : JSON.stringify(sendData)
			, contentType : 'application/json;charset=UTF-8'
			, success : function(resp){
				if(resp == 1){
					location.href = "${pageContext.request.contextPath}/";
				}else if(resp == 0){
					alert("Please Check your ID and Password.");
					location.href = "${pageContext.request.contextPath}/goLoginForm";
				}
			}
			, error: function(resp){
				alert("Login Error!");
			}
		});
		
	});
});
</script>
</html>