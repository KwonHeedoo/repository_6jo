<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<title>ENGLISH SUPPORTER</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="resources/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
function mRoomList(){
	var form = document.createElement('form');
	form.setAttribute('method', 'get');
	form.setAttribute('action', 'goMRoomList');
	form.setAttribute('target', 'mRoom');
	
	document.body.appendChild(form);
	
	window.open('', 'mRoom', 'width=400, height=500, location=no, toolbar=no, menubar=no, scrollbars=no, resizable=no');
	
	form.submit();
	
	document.body.removeChild(form);

}
function goMatching(roomid){
	location.href = "./goMatching?roomid=" + roomid;
}
</script>
<script type="text/javascript">
function message(){
	window.open('./goSendMsgBox', 'SendMsgBox', 'width=400, height=500, location=no, toolbar=no, menubar=no, scrollbars=no, resizable=no');
}

$(function(){
	msgList();
});

// 읽지 않은 쪽지 요청
function msgList(){
	var userid = '${sessionScope.loginId}';
	
	$.ajax({
		url : 'msgList'
		, type : 'post'
		, data : {'userid' : userid}
		, success : function(resp){outputMsg(resp);}
		, error : function(){alert('Error!');}
	});
}

// 새 쪽지 유무 출력
function outputMsg(resp){
	var map = resp;
	var result = '';
	
	result += '<a href="./goMessageList" class="alarm" style="position:relative;">';
	result += '<i class="fa fa-comments fa-lg">';
	if(map.msgCount != 0){
		result += '<span class="nav-counter">New</span>';
	}
	result += '</i>';
	result += '</a>';
	
	$('#msgItem').html(result);
}
</script>
<style type="text/css">
.nav-counter {
 position:absolute;
 top: -8px;
 right: -7px;
 min-width: 8px;
 height: 15px;
 line-height: 14px;
 margin-top: 5px;
 padding: 0 6px;
 font-weight: normal;
 font-size: xx-small;
 color: white;
 text-align: center;
 text-shadow: 0 1px rgba(0, 0, 0, 0.2);
 background: #e23442;
 border: 1px solid #911f28;
 border-radius: 11px;
 background-image: -webkit-linear-gradient(top, #e8616c, #dd202f);
 background-image: -moz-linear-gradient(top, #e8616c, #dd202f);
 background-image: -o-linear-gradient(top, #e8616c, #dd202f);
 background-image: linear-gradient(to bottom, #e8616c, #dd202f);
 -webkit-box-shadow: inset 0 0 1px 1px rgba(255, 255, 255, 0.1), 0 1px rgba(0, 0, 0, 0.12);
 box-shadow: inset 0 0 1px 1px rgba(255, 255, 255, 0.1), 0 1px rgba(0, 0, 0, 0.12);
}
 
.alarm {
 display: inline-block;
 vertical-align: middle;
 border: none;
 height: 13px;
 line-height: 13px;
 padding: 0px 25.6px;
 font-weight: 300;
 font-size: 12px;
 font-family: "Helvetica Neue Light", "Helvetica Neue", "Helvetica", "Arial", "Lucida Grande", sans-serif;
 text-shadow: 0 1px 1px white;
 margin: 0;
 text-decoration: none;
 text-align: center;
}
</style>
</head>
<div class="wrapper row0">
  <div id="topbar" class="hoc clear"> 
    <div class="fl_left">
      <ul>
        <li><i class="fa fa-phone"></i> +00 (123) 456 7890</li>
        <!-- <li><i class="fa fa-envelope-o"></i> info@domain.com</li> -->
        <li><i class="fa fa-envelope-o"></i> <a onclick="message()">Ask to English Supporter</a></li>
      </ul>
    </div>
    <div class="fl_right">
      <ul>
      	<c:if test="${sessionScope.loginId != null}">
      	 <li>
      	 	<img alt="Profile" <c:if test="${sessionScope.img != null}">
      	 	src="./getProfileImg"
      	 	<%-- src="./resources/profile/${session.img}" --%>
      	 	</c:if>
      	 	<c:if test="${sessionScope.img == null}">
      	 	src="./resources/images/icons/user-avatar-placeholder.png"
      	 	</c:if>
      	 	style="width:35px; height:35px;">
      	 </li>
      	</c:if>
      	
        <c:if test="${sessionScope.loginId != null}">
         <li>${sessionScope.loginNick} 님  환영합니다.</li>
        </c:if>
        <li><a href="./"><i class="fa fa-lg fa-home"></i></a></li>
        <c:if test="${sessionScope.loginType eq 'user'}">
         <li id="msgItem"></li>
        </c:if>
       	<!-- 로그인 하지 않은 경우 --> 
       	<c:if test="${sessionScope.loginId == null}">
        <li><a href="goLoginForm">Login</a></li>
        <li><a href="goRegisterForm">Register</a></li>
        </c:if>
        <!-- 로그인 한 경우 --> 
        <c:if test="${sessionScope.loginId != null}">
		<li><a href="logout">Logout</a></li>
		<c:if test="${sessionScope.loginType == 'user'}">
		<li><a href="goMypage">My Page</a></li>
		</c:if>
		<c:if test="${sessionScope.loginType == 'admin'}">
		<li><a href="./goAdminPage">Admin Page</a></li>
		</c:if> 
		</c:if>
      </ul>
    </div>
  </div>
</div>
<div class="wrapper row1">
  <header id="header" class="hoc clear"> 
    <div id="logo" class="fl_left">
      <h1><a href="${pageContext.request.contextPath}/">ENGLISH SUPPORTER</a></h1>
    </div>
    <nav id="mainav" class="fl_right">
      <ul class="clear">
        <li id="home"><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li id="wordtra"><a href="goWordtest">Word Training</a></li>
        
        <li id="comp"><a href="./goComposition">Text Training</a></li>
        <li><a class="drop" href="#">My Resume</a>
          <ul>
            <li><a href="goMyDocs">My documents</a>
              </li>
            <li><a href="#" class="drop">write +</a>
             	<ul>
                <li><a href="goResumeForm">resume(CV)</a></li>
                <li><a href="goCoverletter">cover letter</a></li>
              	</ul>
            </li>
          </ul>
        </li>
        <li id="interview"><a class="drop" href="#">Interview</a>
          <ul>
            <li><a href="./goInterview">Mock Interview</a></li>
            <!-- <li><a href="./goBoardList?boardType=appraise">Interview Appraise</a></li> -->
            <li><a href="./goBoardList?boardType=appraise">Interview Appraise</a></li>
            <li><a href="./goBoardList?boardType=matching">1:1 Video Chat</a></li>
            <li><a href="javascript:void(0);" onclick="mRoomList();">1:1 RoomList</a></li>
          </ul>
        </li>
<!--         <li><a class="drop" href="#">MyPage</a>
          <ul>
            <li><a href="goMypage">My Info</a></li>         
            <li><a href="#">My Scheduler</a></li>
            <li><a href="#">My Chatting</a></li> -->
            
<!--             <li><a class="drop" href="#">Level 2 + Drop</a>
              <ul>
                <li><a href="#">Level 3</a></li>
                <li><a href="#">Level 3</a></li>
                <li><a href="#">Level 3</a></li>
              </ul>
            </li> -->
            <li id="nBoard"><a href="./goBoardList?boardType=notice">Notice</a></li>
          </ul>
    </nav>
  </header>
  
</div>
<script src="resources/scripts/jquery.min.js"></script>
<script src="resources/scripts/jquery.backtotop.js"></script>
<script src="resources/scripts/jquery.mobilemenu.js"></script>
<script src="resources/scripts/jquery.flexslider-min.js"></script>
</html>