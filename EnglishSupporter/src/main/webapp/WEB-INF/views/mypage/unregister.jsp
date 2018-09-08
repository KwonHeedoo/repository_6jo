<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Unregister</title>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<style type="text/css">
.raw{
height: 55%;

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
  margin-left: 250px;
}

.navbar-default .navbar-nav>li>a:hover, .navbar-default .navbar-nav>li>a:focus{
	background-color: #c7c7c7 ;
}

/* 로그인폼에서 긁어옴 ~~ */
.center{
margin :0 auto;
text-align: center;
width: 50%;
margin-left: 20%;
}
input{
width: 100%;
height: 30px;
border:1px solid; border-radius:22px;
display:block; width:100%; padding:8px 15px;
}
.btn{
width: 45%;
height: 35px;
padding:8px 18px 10px; text-transform:uppercase; font-weight:700; cursor:pointer;
border:1px solid; border-radius:22px;
}
.container{
height: 40%;
}
/* ~~ 로그인폼에서 긁어옴 */
</style>
<script src="resources/jquery-3.3.1.min.js"></script>
<script>
$(function(){
	$('#unregister').on('click', function(){
		
		var userid = $('#userid').val();
		var userpwd = $('#userpwd').val();
		var sendData = {"userid" : userid, "userpwd" : userpwd};
		
		$.ajax({
			type: 'post'
			, url: 'pwdCheck'
			, data: JSON.stringify(sendData)
			, contentType: 'application/json;charset=UTF-8'
			, success: function(resp){
				if(resp == 1){
					unregister();
				}else if(resp == 0){
					alert("Please Check your Password.");
					location.href = "${pageContext.request.contextPath}/goUnregister";
				}
			}
			, error: function(resp){
				alert("Password Check Error!");
			}
		});
	});
});

function unregister() {
	
	var userid = $('#userid').val();
	var userpwd = $('#userpwd').val();
	var sendData = {"userid" : userid, "userpwd" : userpwd};
	
	$.ajax({
		type: 'post'
		, url: 'unregister'
		, data: JSON.stringify(sendData)
		, contentType: 'application/json;charset=UTF-8'
		, success: function(resp){
			if(resp == 1){
				alert("Unregister Completed.");
			}else if(resp == 0){
				alert("Unregister Failed.");
			}
			location.href = "${pageContext.request.contextPath}/";
		}
		, error: function(resp){
			alert("Unregister Error!");
		}
	});
}

</script>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
<%@ include file="/WEB-INF/views/mypage/mypage_sidebar.jsp"%>

		<!-- Main Content -->
		<div class="container-fluid">
			<div class="side-body">
				<div class="row">
					<div class="center">
						<form action="unregister" method="post">
						<div class="center">
						<br>
						<h3>[ Unregister ]</h3>
						<br>
							<p>ID: <input type="text" id="userid" name="userid" value="${sessionScope.loginId}" readonly /></p>
							<p>PASSWORD: <input id="userpwd" type="password" name="userpwd" placeholder="Enter your Password for Verification" required /></p>
							<span id="pwdCheck"></span>
							<br>
							<p><input id="unregister" type="button" value="UNREGISTER" class="btn" /></p>
						</div><!-- center -->
						</form>
					</div><!-- center -->
				</div><!-- row -->
			</div><!-- side-body -->
		</div><!-- container-fluid -->
	
<%@ include file="/WEB-INF/views/Footer.jsp"%>

</body>
</html>