<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Matching Board</title>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link href="./resources/css/comment.css" rel="stylesheet">
<!-- google CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style type="text/css">
.btn2{
display:inline-block;
padding:6px 12px;
margin-bottom:0;
font-size:14px;
font-weight:400;
line-height:1.42857143;
text-align:center;
white-space:nowrap;
vertical-align:middle;
cursor:pointer;
-webkit-user-select:none;
-moz-user-select:none;-ms-user-select:none;user-select:none;
background-image:none;
border:1px solid transparent;
border-color: #ccc;
border-radius:4px}

#comment{
width: 90%;
}
#replybox{
width:80%; 
}

div.reples{
margin-right: 40px;
}
.parentNick{
border-style: solid; 
border-color: #e7e7e7;
border-radius: 5px;
padding: 4px;
}

input[type="text"]{
width: 100%;
}

pre{
white-space: pre-line;
}
.img-responsive {
width: 128px;
height: 128px;
}
</style>

<script>


</script>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
<div class="container">
	<br>
	<h1>Matching Board</h1>
	<div>
		<input id="boardNum" type="hidden" value="${board.boardNum}">
		<input id="userid" type="hidden" value="${board.userid}">
		<input id="boardcontents" type="hidden" value="${board.contents}">
		<input id="appointedTime" type="hidden" value="${board.appointedTime}">
		<input id="page" type="hidden" value="${page}">
		<input id="searchItem" type="hidden" value="${searchItem}">
		<input id="searchText" type="hidden" value="${searchText}">
		<input id="loginId" type="hidden" value="${sessionScope.loginId}">
		<input id="loginNick" type="hidden" value="${sessionScope.loginNick}">
		<input id="loginType" type="hidden" value="${sessionScope.loginType}">
		<h4>${board.title}<button id ="reportboard" style="font-size:x-small; border:none; background-color:white;color:red;">신고</button></h4>
		<script type="text/javascript">
			$('#reportboard').on('click',function(){
				var userid = '${board.userid}';
				var contents = $('#boardcontents').val();
				report(userid, contents);
			});
		</script>
		<h5>[Writer] ${board.nickname}</h5>
		<c:if test="${board.status != 1}">
			<h5 style="color:blue;">Appointed Time [ ${board.appointedTime} ]</h5>
		</c:if>
		<div>
			<pre>${board.contents}</pre>
		</div>
		<div align="right">
			<a href="./goBoardList?page=${page}&boardType=matching&searchItem=${searchItem}&searchText=${searchText}"><button class="btn">Back</button></a>
			<c:if test="${board.userid eq sessionScope.loginId}">
			<a href="./updateBoardForm?boardNum=${board.boardNum}&boardType=matching&page=${page}&searchItem=${searchItem}&searchText=${searchText}"><button class="btn">Update</button></a>
			</c:if>
			<c:if test="${board.userid eq sessionScope.loginId || sessionScope.loginType eq 'admin'}">
			<a href="./deleteBoard?boardNum=${board.boardNum}&boardType=matching" onclick="return checkDel()"><button class="btn">Delete</button></a>
			</c:if>
		</div>
		<div id="commentResult"></div>
	</div>
</div>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
<script src="./resources//js/Board/matchingBoardDetail.js"></script>
</body>
</html>