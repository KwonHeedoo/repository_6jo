<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<!-- header -->
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- side menu -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">

<link href="./resources/admin/css/stylesheet.css" rel="stylesheet"> 
<meta charset="UTF-8">

<script type="text/javascript">
window.onload=function(){if(window.jQuery){$(document).ready(function(){$(".sidebarNavigation .navbar-collapse").hide().clone().appendTo("body").removeAttr("class").addClass("sideMenu").show();$("body").append("<div class='overlay'></div>");$(".navbar-toggle, .navbar-toggler").on("click",function(){$(".sideMenu").addClass($(".sidebarNavigation").attr("data-sidebarClass"));$(".sideMenu, .overlay").toggleClass("open");$(".overlay").on("click",function(){$(this).removeClass("open");$(".sideMenu").removeClass("open")})});$("body").on("click",".sideMenu.open .nav-item",function(){if(!$(this).hasClass("dropdown")){$(".sideMenu, .overlay").toggleClass("open")}});$(window).resize(function(){if($(".navbar-toggler").is(":hidden")){$(".sideMenu, .overlay").hide()}else{$(".sideMenu, .overlay").show()}})})}else{console.log("sidebarNavigation Requires jQuery")}};

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

// 쪽지 리스트 출력
function outputMsg(resp){
	var map = resp;
	var result = '';
	
	result += '<a class="nav-link dropdown-toggle alarm" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="position:relative;">';
	result += '<i class="fa fa-comments fa-lg">';
	if(map.msgCount != 0){
		result += '<span class="nav-counter">' + map.msgCount + '</span>';
	}
	result += '</i>';
	result += '</a>';
	result += '<div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdown01">';
	
	if(map.messageList.length){
		$.each(map.messageList, function(index, item){
			result += '<div class="dropdown-item" id="msg' + item.messageNum + '" style="width:280px;">';
			result += '<div style="float:left; width:50%;"><b>' + item.userid + '</b></div>';
			result += '<div style="float:right; width:50%;">' + item.regdate + '</div><br/>';
			result += '<div class="msg">' + item.message + '</div>';
			result += '</div>';
			result += '<div class="divider"></div>';
		});
		result += '<a class="dropdown-item" href="./goMessageList" style="width:280px;"><b>Read All Message ></b></a>';
	}else{
		result += '<a class="dropdown-item" href="./goMessageList" style="width:280px;"><b>Read All Message ></b></a>';
	}
	result += '</div>';
	
	$('#msgItem').html(result);
	if(map.messageList.length){
		$.each(map.messageList, function(index, item){
			$('#msg' + item.messageNum).on('click', function(){
				read(item.messageNum, item.userid, item.nickname, item.message);
			});
		});
	}
	
}

// 쪽지 읽기
function read(messageNum, userid, nickname, message){
	var form = document.createElement('form');
	form.setAttribute('method', 'post');
	form.setAttribute('action', 'goReceiveMsgBox');
	form.setAttribute('target', 'ReceiveMsgBox');
	
	input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'messageNum';
	input.value = messageNum;
	form.appendChild(input);

	input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'userid';
	input.value = userid;
	form.appendChild(input);
	
	input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'nickname';
	input.value = nickname;
	form.appendChild(input);

	input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'message';
	input.value = message;
	form.appendChild(input);
	
	document.body.appendChild(form);
	
	window.open('', 'ReceiveMsgBox', 'width=400, height=500, location=no, toolbar=no, menubar=no, scrollbars=no, resizable=no');
	
	form.submit();
	
	document.body.removeChild(form);
	
	// msgList() 재실행
	msgList();
}
</script>

<style>
nav {height:50px;}
</style>

<title>Insert title here</title>
</head>
<body>

<!-- header -->
<nav class="navbar navbar-expand-md navbar-dark bg-dark sidebarNavigation" data-sidebarClass="navbar-dark bg-dark">
        <div class="container-fluid">
        <a class="navbar-brand" href="./goUserPage">English Supporter</a>
        <button class="navbar-toggler leftNavbarToggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault"
            aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarsExampleDefault">
        <input id="msgList" type="hidden" value="${messageList}">
            <ul class="nav navbar-nav nav-flex-icons ml-auto" style="padding-left:88%;">
            	<li class="nav-item dropdown" id="msgItem" style="padding-right:8px;"></li>
                <%-- <li class="nav-item dropdown" style="padding-right:8px;">
                    <a class="nav-link dropdown-toggle alarm" id="dropdown01" data-toggle="dropdown" aria-haspopup="true"
                        aria-expanded="false" style="position:relative;"><i class="fa fa-comments fa-lg"><c:if test="${msgCount != 0}"><span class="nav-counter">${msgCount}</span></c:if></i></a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdown01">
                    <c:if test="${not empty messageList}">
	                    <c:forEach var="message" items="${messageList}">
	                    	<input id="message${message.messageNum}" type="hidden" value="${message.message}">
	                    	<div class="dropdown-item" id="msg${message.messageNum}" style="width:280px;">
	                    		<div style="float:left; width:50%;"><b>${message.userid}</b></div>
	                    		<div style="float:right; width:50%;">${message.regdate}</div><br/>
	                    		<div class="msg">${message.message}</div>
	                    	</div>
	                    	<script type="text/javascript">
	                    		var messageNum = '${message.messageNum}';
								$('#msg'+messageNum).on('click',function(){
									var nickname = '${message.nickname}';
									var message = $('#message' + messageNum).val();
									read(messageNum, nickname, message);
								});
							</script>
	                    	<div class="divider"></div>
	                    </c:forEach>
	                    	<a class="dropdown-item" href="./goMessageList" style="width:280px;"><nobr><b>Read All Message ></b></nobr></a>
                    </c:if>
                    <c:if test="${empty messageList}">
                    	<a class="dropdown-item" href="./goMessageList" style="width:280px;"><nobr><b>Read All Message ></b></nobr></a>
                    </c:if>
                    </div>
                </li> --%>
                
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="https://example.com" id="dropdown01" data-toggle="dropdown" aria-haspopup="true"
                        aria-expanded="false"><i class="fa fa-user-circle-o fa-lg" ></i></a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdown01">
                        <a class="dropdown-item" href="#"><i class="fa fa-id-badge"></i>&nbsp Admins Management</a>
                        <a class="dropdown-item" href="./logout"><i class="fa fa-sign-out"></i> Logout</a>
                    </div>
                </li>
            </ul>
           <!--  <form class="form-inline my-2 my-lg-0">
                <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
            </form> -->
        </div>
    </div>
    </nav>

<!-- side menu -->
<div class="nav-side-menu">
    <div class="brand">Brand Logo</div>
    <i class="fa fa-bars fa-2x toggle-btn" data-toggle="collapse" data-target="#menu-content"></i>
  
        <div class="menu-list">
  
            <ul id="menu-content" class="menu-content collapse out">
                <li id="dashboard">
                  <a href="./goDashboard">
                  <i class="fa fa-dashboard fa-lg"></i> Dashboard
                  </a>
                </li>

                <li  data-toggle="collapse" data-target="#products" class="collapsed">
                  <a href="#"><i class="fa fa-book fa-lg"></i> Learning Services<span class="arrow"></span></a>
                </li>
	                <ul class="sub-menu collapse" id="products">
	                    <li><a href="#">Word Training</a></li>
	                    <li><a href="#">Mock Interview</a></li>
	                </ul>

                 <li id="reportManager">
                  <a href="./goReportManager">
                  <i class="fa fa-ban fa-lg"></i> Report Management
                  </a>
                  </li>

                 <li id="userManager">
                  <a href="./goUserManager">
                  <i class="fa fa-users fa-lg"></i> Users Management
                  </a>
                </li>
            </ul>
     </div>
</div>
</body>
</html>