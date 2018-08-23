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
</head>
<body id="top">
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
        <li><a href="#"><i class="fa fa-lg fa-home"></i></a></li>
       	<!-- 로그인 하지 않은 경우 --> 
       	<c:if test="${sessionScope.loginId == null}">
        <li><a href="./goLoginForm">Login</a></li>
        </c:if>
        <!-- 로그인 한 경우 --> 
        <c:if test="${sessionScope.loginId != null}">
         ${sessionScope.loginId}
		<li><a href="./logout">Logout</a></li>
		</c:if>
        <li><a href="#">Register</a></li>
      </ul>
    </div>
  </div>
</div>
<div class="wrapper row1">
  <header id="header" class="hoc clear"> 
    <div id="logo" class="fl_left">
      <h1><a href="#">ENGLISH SUPPORTER</a></h1>
    </div>
    <nav id="mainav" class="fl_right">
      <ul class="clear">
        <li class="active"><a href="index.html">Home</a></li>
        <li><a href="#">Link Text</a></li>
        <li><a href="#">Link Text</a></li>
        
        <li><a class="drop" href="#">Pages</a>
          <ul>
            <li><a href="#">Gallery</a></li>
            <li><a href="#">Full Width</a></li>
            <li><a href="#">Sidebar Left</a></li>
            <li><a href="#">Sidebar Right</a></li>
            <li><a href="#">Basic Grid</a></li>
          </ul>
        </li>
        <li><a class="drop" href="#">Dropdown</a>
          <ul>
            <li><a href="#">Level 2</a></li>
            <li><a class="drop" href="#">Level 2 + Drop</a>
              <ul>
                <li><a href="#">Level 3</a></li>
                <li><a href="#">Level 3</a></li>
                <li><a href="#">Level 3</a></li>
              </ul>
            </li>
            <li><a href="#">Level 2</a></li>
          </ul>
        </li>
      </ul>
    </nav>
  </header>
  
 
  
</div>
<script src="resources/scripts/jquery.min.js"></script>
<script src="resources/scripts/jquery.backtotop.js"></script>
<script src="resources/scripts/jquery.mobilemenu.js"></script>
<script src="resources/scripts/jquery.flexslider-min.js"></script>
</body>
</html>