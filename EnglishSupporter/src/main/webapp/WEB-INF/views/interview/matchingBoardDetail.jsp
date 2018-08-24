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
<script>
$(function(){
	init();
	$("#insertComment").on('click', insertComment);
});

//ajax로 전체 comment를 끌어옴
function init() {
	$(".userid").val("");
	$(".comments").val("");
	var boardNum = $('#boardNum').val();
	
	$.ajax({
		url  : 'commentList'
		, type : 'get'
		, data : {'boardNum' : boardNum, 'boardType' : 'matching'}
		, success : output
		, error : function(){alert("Error!");}
	});
}

function output(resp){
	var commentList = resp;
	var commentResult = '';
	
	commentResult += '<div class="container">';
	commentResult += '<div class="row">';
	commentResult += '<div class="col-md-8">';
	commentResult += '<h2 class="page-header">Comments</h2>';
	commentResult += '<section class="comment-list">';
	$.each(commentList, function(index, item){
		commentResult += '<article class="row">';
		if(item.parentCmtId == null){
			commentResult += '<div class="col-md-2 col-sm-2 hidden-xs">';
		}else{
			commentResult += '<div class="col-md-2 col-sm-2 col-md-offset-1 col-sm-offset-0 hidden-xs">';
		}
		commentResult += '<figure class="thumbnail">'; 
		commentResult += '<figcaption class="text-center">'+ item.userid + '</figcaption>'
		commentResult += '</figure>';//thumbnail
		commentResult += '<img class="img-responsive" src="./resources/images/icons/user-avatar-placeholder.png" />';
		commentResult += '</div>';//col-md-2 col-sm-2 hidden-xs | col-md-2 col-sm-2 col-md-offset-1 col-sm-offset-0 hidden-xs 
		if(item.parentCmtId == null){
			commentResult += '<div class="col-md-10 col-sm-10">';
		}else{
			commentResult += '<div class="col-md-9 col-sm-9">';
		}
		commentResult += '<div class="panel panel-default arrow left">';
		commentResult += '<div class="panel-body">';
		commentResult += '<header class="text-left">';
		commentResult += '<div class="comment-user">';
		if(item.parentCmtId == null){
			commentResult +=  '<i class="fa fa-user"></i>Comment'
		}else{
			commentResult += '<i class="fa fa-user"></i>' + item.parentCmtId;
		}
		commentResult += '</div>';//comment-user
		commentResult += '<time class="comment-date" datetime="' + item.regdate + '">';// regdate형식 16-12-2014 01:05
		commentResult += '<i class="fa fa-clock-o"></i>' + item.regdate;
		commentResult += '</time>';//comment-date
		commentResult += '</header>';//text-left
		commentResult += '<div class="comment-post">';
		commentResult += '<p class="comment-text">' + item.comments + '</p>';
		commentResult += '</div>';//comment-post
		commentResult += '<p class="text-right">';
		commentResult += '<input class="btn btn-default btn-sm modifyComment" data-rno="'+ item.commentNum + '" type="button" value="Modify" /> ';
		commentResult += '<input class="btn btn-default btn-sm deleteComment" data-dno="'+ item.commentNum + '" type="button" value="Delete" /> ';
		commentResult += '<a href="#" class="btn btn-default btn-sm"><i class="fa fa-reply"></i> Reply</a>';
		commentResult += '</p>';//text-right
		commentResult += '</div>';//panel-body
		commentResult += '</div>';//panel panel-default arrow left
		commentResult += '</div>';//col-md-10 col-sm-10 | col-md-9 col-sm-9
		commentResult += '</article>';//row
	});
	commentResult += '</section>';//comment-list
	commentResult += '</div>';//col-md-8
	commentResult += '</div>';//row
	commentResult += '</div>';//container
	
	
	$("#commentResult").html(commentResult);
	$("input:button.deleteComment").click(deleteComment);
	$("input:button.modifyComment").click(modifyComment);
}

//댓글 삭제
function deleteComment() {
	var commentNum = $(this).attr("data-dno");
	
	$.ajax({
		url  : 'deleteComment'
		, type : 'get'
		, data : {'commentNum' : commentNum, 'boardType' : 'matching'}
		, success : init
		, error : function(){alert("Error!");}
	});
}

// 댓글수정
function modifyComment() {
	var commentNum  = $(this).attr("data-rno");
	var userid    = $(this).parent().children(".text-center").text();
	var comments = $(this).parent().children(".comment-text").text();

	$('.userid').val(userid);
	$('.comments').val(comments);
	$('#insertComment').val('댓글 수정');
	$('.userid').prop('readonly', 'readonly');
	
	$('#insertComment').off('click', insertComment);

	$("#insertComment").on('click', update);
			
	function update(){
		var comments = $("#comment").val();
		
		$.ajax({
			url  : 'updateComment'
			, type : 'post'
			, data : {'commentNum' : commentNum 
					  , 'userid' : userid
					  , 'comments' : comments
					  , 'boardType' : 'matching'}
			, success : function(){
				init();
				$('.userid').prop('readonly', false);
			}
			, error : function(){alert("Error!");}
		});
	 
	}
}

// 댓글 삽입
function insertComment() {
	var userid = $(".userid").val();
	var comments = $(".comments").val();
	
	// alert("userid : "+ userid + ", comments : "+ comments);
	if(userid.length == 0 || comments.length == 0) {
		alert("아이디와 댓글을 입력하세요.");
		
		return ;
	}
	
	$.ajax({
		url  : 'insertComment'
		, type : 'post'
		, data : {"userid" : userid, "comments" : comments, 'boardType' : 'matching'}
		, success : init
		, error : function(){alert("Error!");}
	});
}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
	<h1>Matching Board</h1>
	<div>
		<h4>${board.title}</h4>
		<input id="boardNum" type="hidden" value="${board.boardNum}">
		<div>
			<pre>${board.contents}</pre>
		</div>
		<div>
			<a href="./boardList?page=${page}&boardType=matching&searchItem=${searchItem}&searchText=${searchText}"><button class="btn">Back</button></a>
			<a href="./updateBoardForm?boardNum=${board.boardNum}&boardType=matching&page=${page}&searchItem=${searchItem}&searchText=${searchText}"><button class="btn">Update</button></a>
			<a href="./deleteBoard?boardNum=${board.boardNum}&boardType=matching"><button class="btn">Delete</button></a>
		</div>
		<div>
			<input class="userid" type="text" placeholder="ID" />
			<input id="comment" class="comments" type="text" placeholder="댓글 내용" />
			<input id="insertComment" type="button" value="댓글 추가" />
		</div>
		<div id="commentResult"></div>
	</div>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>