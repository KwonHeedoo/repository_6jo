<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>MY PAGE</title>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<style type="text/css">
.userimg{
background-color: gray;
}
.userinfo_low{
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/header.jsp"%>
	<%@ include file="/WEB-INF/views/mypage/mypage_sidebar.jsp"%>

		<div class="container-fluid">
			<div class="side-body">
				<div class="row">
					<div>
					<div class="userimg">
					<img alt="Profile" <c:if test="${sessionScope.img != null}">
      	 		src="./getProfileImg"
      	 		</c:if>
      	 		<c:if test="${sessionScope.img == null}">
      	 		src="./resources/images/icons/user-avatar-placeholder.png"
      	 		</c:if>
      	 		style="width:300px; height:300px;">
					</div>
					<div class="userinfo_low">
				 	registration date : ${info.regdate} <br>
				 	Last Login date : ${info.lastdate} <br>
				 	Number of attendance : ${info.attendNum} <br>
				 	Number of writing : ${info.writeCount} <br>
					</div>
					</div><!-- center -->
				</div><!-- row -->
			</div><!-- side-body -->
		</div><!-- container-fluid -->
	<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>

</html>