<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>My Info Update</title>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<style type="text/css">
.raw{
height: 70%;

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
line-height: 45%;
padding-bottom: 10px;
}

.container{
height: 40%;
}


/* ~~ 로그인폼에서 긁어옴 */

</style>
<script src="resources/jquery-3.3.1.min.js"></script>
<script>
$(function(){
	init();
	$('#imgInp').val("${u.imgFilePath}");
	$("#nickname").on('keyup', function(){
		var nickname = $('#nickname').val();
		
		$.ajax({
			url : "nicknameCheck"
			,type : "post"
			,data : {"nickname" : nickname}
			,success : function(resp){
				if(resp == 1){
					$('#nicknameCheck').text("This nickname is already taken");
					$('#nicknameCheck').css("color" , "red");
				}else if(resp == 0){
					$('#nicknameCheck').text("This nickname is available");
					$('#nicknameCheck').css("color" , "blue");
				}
			}
			,error : function(resp){
				alert("통신실패");
			}
		});
	});
 	//사진 미리보기
	$("#imgInp").on('change',function(){
		readURL(this);
	});
	$("#delImg").on('click',delImg);
	// 이미지변경 유효성검사
	/* $("#imgInp").on("change", function(){
		if( $("#imgInp").val() != "" ){
			var ext = $('#imgInp').val().split('.').pop().toLowerCase();
			if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
				alert('gif, png, jpg, jpeg 파일만 업로드 할수 있습니다.');
				$("#imgInp").val("");
				init();
				return;
			}*/

function readURL(input) {
	var ext = $('#imgInp').val().split('.').pop().toLowerCase();
	if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
		alert('gif, png, jpg, jpeg 파일만 업로드 할수 있습니다.');
		$("#imgInp").val("");
		return;
	}
	if (input.files && input.files[0]){
		var reader = new FileReader();
		reader.onload = function(e) {
		$('#blah').attr('src' , e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}
function delImg()
{
	$('#blah').attr('src' , './resources/images/icons/user-avatar-placeholder.png');
	$('#imgInp').val('');
} 

function init()
{
	var result = '';
	result =  '<img id="blah" name="blah"';
	result +=  		'<c:if test="${sessionScope.img == null}">';
	result +=  			'src="./resources/images/icons/user-avatar-placeholder.png"';
	result +=  		'</c:if>';
	result +=  		'<c:if test="${sessionScope.img != null}">';
	result +=  		'src="./getProfileImg?userid=${sessionScope.loginId}"';
	result +=  			'</c:if>';
	result +=			'style="width: 200px; height: 200px;" />';

	$('#imgOPT').html(result);	
}


	});
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
						<form action="infoUpdate" method="post" enctype="multipart/form-data">
						<div class="center">
						<br>
						<h3>[ My Info Update ]</h3>
						 	<div id="imgOPT">
							</div>
							<br>	
							<input type="file" id="imgInp" name="imgInp"  accept="image/jpg image/jpeg image/png image/gif" />	
							<br><input type="button" id="delImg" value="이미지삭제" class="btn"/> 
						
							<p>ID: <input type="text" name="userid" value="${u.userid}" readonly /></p>
							<p>NAME: <input type="text" name="username" value="${u.username}" placeholder="${u.username}" /></p>
							<p>NICKNAME: <input type="text" name="nickname" id="nickname" value="${u.nickname}" placeholder="${u.nickname}" /></p>
							<span id="nicknameCheck"></span>
							<p>EMAIL: <input type="text" name="email" value="${u.email}" placeholder="${u.email}" /></p>
							<p>BIRTH DATE: <input type="date" name="birthdate" value="" /></p>
							<input type="hidden" value="${u.birthdate}" id="birthdate">
							<p>PASSWORD: <input type="password" name="userpwd" placeholder="Verify your Password" required /></p>
							<br>
							<input type="submit" value="UPDATE" class="btn" />
						</div><!-- center -->
						</form>
					</div><!-- center -->
				</div><!-- row -->
			</div><!-- side-body -->
		</div><!-- container-fluid -->
	</div><!-- raw -->
	
<c:if test="${not empty msg}">
<script>
$(function(){
	alert("${msg}");
	location.href = "${pageContext.request.contextPath}/goInfoUpdate";
});
</script>
</c:if>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
<script type="text/javascript">
$(function(){
	var date = $('#birthdate').val();
	date = date.split(' ');
	console.log(date);

	var birthdate = date[0];
	$('input[name="birthdate"]').val(birthdate);
	console.log(birthdate);
})
/*
$(function(){
	var date = $('#birthdate').val();
	date =date.split('-');
	console.log(date);

	var birthdate = date[0]+"-"+date[1]+"-"+date[2].substring(0,2);
	$('input[name="birthdate"]').val(birthdate);
	console.log(birthdate);
});
*/
</script>

</html>