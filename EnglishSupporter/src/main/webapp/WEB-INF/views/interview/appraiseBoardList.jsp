<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- google CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style type="text/css">
select {
height: 30.98px;
margin-left: 10px;
}
.raw{
display: inline-block;
}
td, th{
text-align:center;
}
td.boardTitle{
text-align:left;
}
</style>
<title>appraise Board</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(function(){
	init();
});

function init(){
	var boardType = $('#boardType').val();
	var page = $('#page').val();
	var searchItem = $('#searchItem').val();
	var searchText = $('#searchText').val();
	
	$.ajax({
		url  : 'boardList'
		, type : 'get'
		, data : {'page' : page, 'boardType' : 'appraise', 'searchItem' : searchItem, 'searchText' : searchText}
		, success : output
		, error : function(){alert("Error!");}
	});
}

// 게시판 출력
function output(resp){
	var map = resp;
	var boardResult = '';
	var appraiseCount = 0;
	// 매칭 된 게시판 카운트
	$.each(map.boardList, function(index, item){
		if(item.appraiseId != null){
			appraiseCount++;
		}
	});
	boardResult += '<div class="container">';
	boardResult += '<div class="row justify-content-end">';
	boardResult += '<div id="boardTable">';
	boardResult += '<table border="1">';
	// 게시판 제목부분
	boardResult += '<tr id="boardMenu">';
	boardResult += '<th style="width:5%;">No</th>';
	//boardResult += '<th style="width:15%;">TIME</th>';
	boardResult += '<th class="boardTitle" style="width:45%;">TITLE</th>';
	boardResult += '<th style="width:10%;">USER</th>';
	boardResult += '<th style="width:10%;">REGDATE</th>';
	boardResult += '<th style="width:5%;">HITS</th>';
	//boardResult += '<th style="width:10%;"><button id="unmatched" onclick="constraint(' + appraiseCount + ')">appraise</button></th>'; 
	boardResult += '</tr>';
	// 게시판 내용부분 :: 데이터가 없을 경우
	if(!map.boardList.length){
		boardResult += '<tr>';
		boardResult += '<td colspan="6">There is no Board</td>';
		boardResult += '</tr>';
	}
	// 게시판 내용부분 :: 데이터가 있을 경우
	// 공지글
	if(map.noticeList.length){
		$.each(map.noticeList, function(index, item){
			boardResult += '<tr>';
			boardResult += '<td colspan="2"><span style="color:red;">[공지]</span></td>';
			boardResult += '<td class="boardTitle"><a href="./detailBoard?boardNum=' + item.boardNum + '&boardType=appraise&page=' + map.navi.currentPage + '&back=false&searchItem=' + map.searchItem + '&searchText=' + map.searchText + '">' + item.title + '</a></td>';
			boardResult += '<td>' + item.nickname + '</td>';
			boardResult += '<td>' + item.regdate + '</td>';
			boardResult += '<td>' + item.hitcount + '</td>';
			boardResult += '<td><span style="color:red;">[공지]</span></td>';
			boardResult += '</tr>';
		});
	}
	// 게시글
	if(map.boardList.length){
		var count = 1;
		$.each(map.boardList, function(index, item){
			boardResult += '<tr>';
			boardResult += '<td>' + (map.navi.totalRecordsCount - map.navi.startRecord - (count - 1)) + '</td>';
			//boardResult += '<td>' + item.appointedTime + '</td>';
			boardResult += '<td class="boardTitle"><a href="./detailBoard?boardNum=' + item.boardNum + '&boardType=appraise&page=' + map.navi.currentPage + '&back=false&searchItem=' + map.searchItem + '&searchText=' + map.searchText + '">' + item.title + '</a></td>';
			boardResult += '<td>' + item.nickname + '</td>';
			boardResult += '<td>' + item.regdate + '</td>';
			boardResult += '<td>' + item.hitcount + '</td>';
			/* boardResult += '<td>';
			if(item.appraiseId == null){
				boardResult += '<img alt="possible" src="./resources/images/icons/silver.png">';
			}else{
				boardResult += '<img alt="possible" src="./resources/images/icons/golden.png">';
			}
			boardResult += '</td>'; */
			boardResult += '</tr>';
			count++;
		});
	}
	boardResult += '</table>';
	boardResult += '</div>';// boardTable
	boardResult += '</div>';//row justify-content-end
	boardResult += '</div>';// container
	// 페이징
	boardResult += '<div id="page" align="center">';
	if(map.boardList.length){
		var i = 1;
		boardResult += '<a onclick="selectPage('+ 1 + ', \'' + map.searchItem + '\', \'' + map.searchText + '\')">◀◀</a>&emsp;'; 
		boardResult += '<a onclick="selectPage('+ (map.navi.currentPage - 1) + ', \'' + map.searchItem + '\', \'' + map.searchText + '\')">Prev</a>&emsp;';
		for(var i = map.navi.startPageGroup; i <= map.navi.endPageGroup; i++){
			boardResult += '<a onclick="selectPage('+ i + ', \'' + map.searchItem + '\', \'' + map.searchText + '\')">';
			if(map.navi.currentPage == i){
				boardResult += '<span style="font-size:12pt; font-weight:bold;">' + i + '&emsp;</span></a>';
			}else{
				boardResult += '<span>' + i + '&emsp;</span></a>';
			}
		}
		boardResult += '<a onclick="selectPage('+ (map.navi.currentPage + 1) + ', \'' + map.searchItem + '\', \'' + map.searchText + '\')">Next</a>&emsp;'; 
		boardResult += '<a onclick="selectPage('+ map.navi.totalPageCount + ', \'' + map.searchItem + '\', \'' + map.searchText + '\')">▶▶</a>';
		// 게시판 검색 기능
		boardResult += '<div class="container">';
		boardResult += '<form id="searchBox" action="boardList" method="get">';
		boardResult += '<input type="hidden" name="boardType" value="appraise">';
		boardResult += '<select id="selectItemBox" name="searchItem">';
		if(map.searchItem === 'title'){
			boardResult += '<option value="title" selected="selected">Title</option>';
			boardResult += '<option value="userid">User</option>';
			boardResult += '<option value="contents">Contents</option>';
		}else if(map.searchItem === 'userid'){
			boardResult += '<option value="title">Title</option>';
			boardResult += '<option value="userid" selected="selected">User</option>';
			boardResult += '<option value="contents">Contents</option>';
		}else{
			boardResult += '<option value="title">Title</option>';
			boardResult += '<option value="userid">User</option>';
			boardResult += '<option value="contents" selected="selected">Contents</option>';
		}
		boardResult += '</select>';
		boardResult += '<input id="searchTextBox" type="text" name="searchText" value="' + map.searchText + '">';
		boardResult += '<input id="search" type="button" value="Search">';
		boardResult += '</form>';
	}
	boardResult += '<br><a href="./writeBoardForm?page=' + map.navi.currentPage + '&boardType=appraise"><button class="btn">Write Board</button></a>';
	boardResult += '</div>';
	
	$('#boardResult').html(boardResult);
	$('#search').click(search);
}

// 페이지 이동
function selectPage(page, searchItem, searchText){
	$.ajax({
		url  : 'boardList'
		, type : 'get'
		, data : {'page' : page, 'boardType' : 'appraise', 'searchItem' : searchItem, 'searchText' : searchText}
		, success : output
		, error : function(){alert("Error!");}
	});
}

// 키워드로 게시물 찾기
function search(){
	var searchItem = $('#selectItemBox').val();
	var searchText = $('#searchTextBox').val();
	$.ajax({
		url  : 'boardList'
		, type : 'get'
		, data : {'boardType' : 'appraise', 'searchItem' : searchItem, 'searchText' : searchText}
		, success : output
		, error : function(){alert("Error!");}
	});
}

// 매칭 안된 게시글 찾기
function constraint(appraiseCount){
	// 전체 게시글
	if(appraiseCount === 0){
		$.ajax({
			url  : 'boardList'
			, type : 'get'
			, data : {'boardType' : 'appraise'}
			, success : output
			, error : function(){alert("Error!");}
		});
	// 매칭 안된 게시글
	}else{
		$.ajax({
			url  : 'boardList'
			, type : 'get'
			, data : {'boardType' : 'appraise', 'constraint' : 'unmatched'}
			, success : output
			, error : function(){alert("Error!");}
		});
	}
}
</script>
<style type="text/css">
#container {
    width: 80%;
    margin: 0 auto;
    margin-top: 20px;
    margin-bottom: 30px;
    height: 60%;
}

</style>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
<div id="container">
	<h1>appraise Board</h1>
	<input id="boardType" type="hidden" value="${boardType}">
	<input id="page" type="hidden" value="${page}">
	<input id="searchItem" type="hidden" value="${searchItem}">
	<input id="searchText" type="hidden" value="${searchText}">
	<div id="boardResult"></div>
</div>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>