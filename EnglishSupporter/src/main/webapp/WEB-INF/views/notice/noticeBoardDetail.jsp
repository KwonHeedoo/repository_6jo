<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Notice Board</title>
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
</style>
<script>
$(function(){
	init();
});

// ajax로 전체 comment를 끌어옴
function init() {
	$('.comments').val("");
	var boardNum = $('#boardNum').val();
	
	$.ajax({
		url  : 'commentList'
		, type : 'get'
		, data : {'boardNum' : boardNum, 'boardType' : 'notice'}
		, success : output
		, error : function(){alert("Error!");}
	});
}

// 가져온 전체 comment를 html에 뿌리기
function output(resp){
	var loginId = $('#loginId').val();
	var loginType = $('#loginType').val();
	var commentList = resp;
	var commentResult = '';
	var parentGroup = 0;
	
	commentResult += '<div class="container">';
	commentResult += '<div class="row reples">';
	commentResult += '<div>';
	commentResult += '<h2 class="page-header">Comments</h2>';
	commentResult += '<div class="writeComment">';
	commentResult += '<div><input id="comment" class="comments" type="text" placeholder="댓글 내용" />';
	commentResult += '&ensp;<input id="insertComment" type="button" value="댓글 추가" /></div><br>';
	commentResult += '</div>';// writeComment
	commentResult += '<section class="comment-list">';
	$.each(commentList, function(index, item){
		if(item.parentId == null){
			parentGroup = item.groupNum;
		}
		commentResult += '<article class="row">';
		if(item.parentId == null){
			commentResult += '<div class="col-md-2 col-sm-2 hidden-xs">';
		}else{
			commentResult += '<div class="col-md-2 col-sm-2 col-md-offset-1 col-sm-offset-0 hidden-xs">';
		}
		commentResult += '<figure class="thumbnail">'; 
		commentResult += '<figcaption class="text-center">' + item.nickname + '</figcaption>'
		commentResult += '</figure>';//thumbnail
		commentResult += '<img class="img-responsive" src="./resources/images/icons/user-avatar-placeholder.png" />';
		commentResult += '</div>';//col-md-2 col-sm-2 hidden-xs | col-md-2 col-sm-2 col-md-offset-1 col-sm-offset-0 hidden-xs 
		if(item.parentId == null){
			commentResult += '<div class="col-md-10 col-sm-10">';
		}else{
			commentResult += '<div class="col-md-9 col-sm-9">';
		}
		commentResult += '<div class="panel panel-default arrow left">';
		commentResult += '<div class="panel-body">';
		commentResult += '<header class="text-left">';
		commentResult += '<div class="comment-user">';
		if(item.parentId == null && item.nickname != '*****'){
			commentResult += '<i class="fa fa-user"></i>Comment'
		}else if(item.parentId != null && item.nickname != '*****'){
			commentResult += '<i class="fa fa-user"></i>' + item.parentNick;
		}
		if(item.parentId == null && item.nickname != '*****'){
			commentResult += '<span style="float:right"><button onclick="report(\'' + item.userid + '\', \'' + item.comments + '\')" style="font-size:x-small; border:none; background-color:white; color:red;">신고</button></span>';
		}else if(item.parentId != null && item.nickname != '*****'){
			commentResult += '<span style="float:right"><button onclick="report(\'' + item.userid + '\', \'' + item.comments + '\')" style="font-size:x-small; border:none; background-color:white; color:red;">신고</button></span>';
		}
		commentResult += '</div>';//comment-user
		commentResult += '<time class="comment-date" datetime="' + item.regdate + '">';//
		commentResult += '<i class="fa fa-clock-o"></i>' + item.regdate;
		commentResult += '</time>';//comment-date
		commentResult += '</header>';//text-left
		commentResult += '<div class="comment-post">';
		commentResult += '<p class="comment-text"><input id="cmt'+ item.commentNum +'" value="' + item.comments + '" disabled="true" style="border:0px; background-color:white;" /></p>';
		commentResult += '</div>';//comment-post
		commentResult += '<p class="text-right">';
		if(loginId === item.userid){
			commentResult += '<button class="btn2 btn-sm btn-default" id="update' + item.commentNum + '" onclick="modifyComment(' + item.commentNum + ')">Modify</button>';
			commentResult += '<button class="btn2 btn-sm btn-default" onclick="deleteComment('+ item.commentNum + ', ' + item.groupNum +')">Delete</button>';
		}
		if(item.parentId == null && item.nickname != '*****'){
			commentResult += '<button class="btn2 btn-sm btn-default" onclick="reply(\'' + item.userid + '\', \'' + item.nickname + '\', ' + item.groupNum + ', ' + item.commentNum + ', this)"><i class="fa fa-reply"></i> Reply</button>';
		}else if(item.parentId != null && item.nickname != '*****'){
			commentResult += '<button class="btn2 btn-sm btn-default" onclick="reply(\'' + item.userid + '\', \'' + item.nickname + '\', ' + parentGroup + ', ' + item.commentNum + ', this)"><i class="fa fa-reply"></i> Reply</button>';
		}else{
			commentResult += '<br /><br />';
		}
		commentResult += '</p>';//text-right
		commentResult += '</div>';//panel-body
		commentResult += '</div>';//panel panel-default arrow left
		commentResult += '</div>';//col-md-10 col-sm-10 | col-md-9 col-sm-9
		commentResult += '</article>';//row
		commentResult += '<br><div id="reply' + item.commentNum + '"></div><br>';
	});
	commentResult += '</section>';//comment-list
	commentResult += '</div>';//col-md-8
	commentResult += '</div>';//row
	commentResult += '</div>';//container
	
	
	$('#commentResult').html(commentResult);
	$('#insertComment').click(insertComment);
}

// 댓글 삭제
function deleteComment(commentNum, groupNum) {
	//확인
	if (confirm("Are you Sure??") == true){
		$.ajax({
			url  : 'deleteComment'
			, type : 'get'
			, data : {'commentNum' : commentNum, 'groupNum' : groupNum, 'boardType' : 'notice'}
			, success : init
			, error : function(){alert("Error!");}
		});
	//취소
	}else{
	    return;
	}
}

// 댓글수정
function modifyComment(commentNum) {
	$('#cmt' + commentNum).attr('disabled', false);
	$('#cmt' + commentNum).css('border', '1px solid');
	$('#cmt' + commentNum).css('width', '100%');
	document.getElementById('cmt' + commentNum).focus();
	
	$('#update' + commentNum).on('click', update);
			
	function update(){
		var userid = $('#loginId').val();
		var nickname = $('loginNick').val();
		var comments = $('#cmt' + commentNum).val();
		
		$.ajax({
			url  : 'updateComment'
			, type : 'post'
			, data : {'commentNum' : commentNum, 'userid' : userid, 'nickname' : nickname
					 ,'comments' : comments, 'boardType' : 'notice'}
			, success : function(){
				init();
			}
			, error : function(){alert("Error!");}
		});
	 
	}
}

// 댓글 삽입
function insertComment() {
	var boardNum = $('#boardNum').val();
	var userid = $('#loginId').val();
	var nickname = $('#loginNick').val();
	var comments = $('.comments').val();
	
	if(comments.length == 0) {
		alert("Please Write Your Comment");
		return ;
	}
	
	$.ajax({
		url  : 'insertComment'
		, type : 'post'
		, data : {'userid' : userid, 'nickname' : nickname, 'boardNum' : boardNum
				 , 'comments' : comments, 'boardType' : 'notice'}
		, success : init
		, error : function(){alert("Error!");}
	});
}

//reply 달기
function reply(parentId, parentNick, groupNum, commentNum, btn){
	var reply = '';
	reply += '<span class="parentNick">To.' + parentNick+'</span>';
	reply += '&emsp;<input id="replybox" type="text" />&emsp;';
	reply += '<button id="sendReply">Send</button><br>';
	$('#reply' + commentNum).append(reply);
	$(this).html('Cancel');
	
	btn.onclick = function(){
		$('#reply' + commentNum).remove();
		init();
	};
	
	$('#sendReply').on('click', function(){
		var boardNum = $('#boardNum').val();
		var comments = $('#replybox').val();
		var userid = $('#loginId').val();
		var nickname = $('#loginNick').val();

		$.ajax({
			url : 'insertComment'
			, type : 'post'
			, data : {'userid' : userid
					  , 'nickname' : nickname
					  , 'boardNum' : boardNum
					  , 'comments' : comments
					  , 'parentId' : parentId
					  , 'parentNick' : parentNick
					  , 'groupNum' : groupNum
					  , 'reply' : 'reply'
					  , 'boardType' : 'notice'}
			, success : init
			, error : function(){alert("Error!");} 
		});
	});
}

//게시물 삭제 확인
function checkDel(){
	//확인
	if (confirm("Are you Sure??") == true){
		return true;
	//취소
	}else{
	    return false;
	}
}

//신고 페이지 오픈 및 데이터 값 보내기
function report(reportee, report){
	var reporter = $('#loginId').val();
	var boardNum = $('#boardNum').val();
	var page = $('#page').val();
	var searchItem = $('#searchItem').val();
	var searchText = $('#searchText').val();
	
	var form = document.createElement('form');
	form.setAttribute('method', 'post');
	form.setAttribute('action', 'goReportBox');
	form.setAttribute('target', 'ReportBox');
	
	input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'reporter';
	input.value = reporter;
	form.appendChild(input);

	input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'reportee';
	input.value = reportee;
	form.appendChild(input);
	
	input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'report';
	input.value = report;
	form.appendChild(input);
	
	input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'page';
	input.value = page;
	form.appendChild(input);
	
	input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'boardNum';
	input.value = boardNum;
	form.appendChild(input);
	
	input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'boardType';
	input.value = 'notice';
	form.appendChild(input);
	
	input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'searchItem';
	input.value = searchItem;
	form.appendChild(input);
	
	input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'searchText';
	input.value = searchText;
	form.appendChild(input);
	
	document.body.appendChild(form);
	
	window.open('', 'ReportBox', 'width=400, height=500, location=no, toolbar=no, menubar=no, scrollbars=no, resizable=no');
	
	form.submit();
	
	document.body.removeChild(form);
}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
<div class="container">
	<br>
	<h1>Notice Board</h1>
	<div>
		<input id="boardNum" type="hidden" value="${board.boardNum}">
		<input id="userid" type="hidden" value="${board.userid}">
		<input id="page" type="hidden" value="${page}">
		<input id="searchItem" type="hidden" value="${searchItem}">
		<input id="searchText" type="hidden" value="${searchText}">
		<input id="loginId" type="hidden" value="${sessionScope.loginId}">
		<input id="loginNick" type="hidden" value="${sessionScope.loginNick}">
		<input id="loginType" type="hidden" value="${sessionScope.loginType}">
		<h4>${board.title}<button onclick="report('${board.userid}', '${board.contents}')" style="font-size:x-small; border:none; background-color:white;color:red;">신고</button></h4>
		<div>
			<pre>${board.contents}</pre>
		</div>
		<div>
			<a href="./goBoardList?page=${page}&boardType=notice&searchItem=${searchItem}&searchText=${searchText}"><button class="btn">Back</button></a>
			<c:if test="${board.userid eq sessionScope.loginId}">
			<a href="./updateBoardForm?boardNum=${board.boardNum}&boardType=notice&page=${page}&searchItem=${searchItem}&searchText=${searchText}"><button class="btn">Update</button></a>
			<a href="./deleteBoard?boardNum=${board.boardNum}&boardType=notice"><button class="btn" onclick="return checkDel()">Delete</button></a>
			</c:if>
		</div>
		<div id="commentResult"></div>
	</div>
</div>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>