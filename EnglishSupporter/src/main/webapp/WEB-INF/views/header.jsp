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
</head>
<div class="wrapper row0">
  <div id="topbar" class="hoc clear"> 
    <div class="fl_left">
      <ul>
        <li><i class="fa fa-phone"></i> +00 (123) 456 7890</li>
        <li><i class="fa fa-envelope-o"></i> info@domain.com</li>
      </ul>
    </div>
    <div class="fl_right">
      <ul>
        <c:if test="${sessionScope.loginId != null}">
         <li>${sessionScope.loginNick} 님  환영합니다.</li>
        </c:if>
        <li><a href="./"><i class="fa fa-lg fa-home"></i></a></li>
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
		<li><a href="./goDashboard">Admin Page</a></li>
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
        
        <li><a href="./goComposition">Text Training</a></li>
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
        <li><a class="drop" href="#">Interview</a>
          <ul>
            <li><a href="./goInterview">Mock Interview</a></li>
            <!-- <li><a href="./goBoardList?boardType=appraise">Interview Appraise</a></li> -->
            <li><a href="./goBoardList?boardType=appraise">Interview Appraise</a></li>
            <li><a href="./goBoardList?boardType=matching">1:1 Video Chat</a></li>
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
            <li><a href="./goBoardList?boardType=notice">Notice</a></li>
          </ul>
    </nav>
  </header>
  
</div>
<script src="resources/scripts/jquery.min.js"></script>
<script src="resources/scripts/jquery.backtotop.js"></script>
<script src="resources/scripts/jquery.mobilemenu.js"></script>
<script src="resources/scripts/jquery.flexslider-min.js"></script>
</html>