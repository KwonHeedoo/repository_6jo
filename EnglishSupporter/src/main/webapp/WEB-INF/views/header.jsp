<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ENGLISH SUPPORTER</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="resources/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
        <li><a href="${pageContext.request.contextPath}/"><i class="fa fa-lg fa-home"></i></a></li>
        <li><a href="#">Login</a></li>
        <li><a href="#">Register</a></li>
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
            <li><a href="#">My documents</a>
              </li>
            <li><a href="#" class="drop">write documents +</a>
             	<ul>
                <li><a href="goResumeForm">resume(CV)</a></li>
                <li><a href="#">cover letter</a></li>
              	</ul>
            </li>
          </ul>
        </li>
        <li><a class="drop" href="#">Interview</a>
          <ul>
            <li><a href="#">Mock Interview</a></li>
            <li><a href="#">Interview Appraise</a></li>
            <li><a href="./goMatchingBoard">1:1 Video Chat</a></li>
          </ul>
        </li>
        <li><a class="drop" href="#">MyPage</a>
          <ul>
            <li><a href="#">My Info</a></li>  <!-- 내정보 수정 여유있음 만들도록 하자...-->           
            <li><a href="#">My Scheduler</a></li>
            <li><a href="#">My Chatting</a></li>
            
<!--             <li><a class="drop" href="#">Level 2 + Drop</a>
              <ul>
                <li><a href="#">Level 3</a></li>
                <li><a href="#">Level 3</a></li>
                <li><a href="#">Level 3</a></li>
              </ul>
            </li> -->
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