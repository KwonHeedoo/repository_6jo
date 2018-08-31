<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- google CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>Notice Board</title>
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
		, data : {'page' : page, 'boardType' : 'notice', 'searchItem' : searchItem, 'searchText' : searchText}
		, success : output
		, error : function(){alert("Error!");}
	});
}

// 게시판 출력
function output(resp){
	var map = resp;
	var boardResult = '';
	var loginType = $('#loginType').val();
	
	boardResult += '<div id="boardTable">';
	boardResult += '<table border="1">';
	// 게시판 제목부분
	boardResult += '<tr id="boardMenu">';
	boardResult += '<th>No</th>';
	boardResult += '<th class="boardTitle">TITLE</th>';
	boardResult += '<th>NICKNAME</th>';
	boardResult += '<th>REGDATE</th>';
	boardResult += '<th>HITS</th>';
	boardResult += '</tr>';
	// 게시판 내용부분 :: 데이터가 없을 경우
	if(!map.boardList.length){
		boardResult += '<tr>';
		boardResult += '<td colspan="6">There is no Board</td>';
		boardResult += '</tr>';
	}
	// 게시판 내용부분 :: 데이터가 있을 경우
	if(map.boardList.length){
		var count = 1;
		$.each(map.boardList, function(index, item){
			boardResult += '<tr>';
			boardResult += '<td>' + (map.navi.totalRecordsCount - map.navi.startRecord - (count - 1)) + '</td>';
			boardResult += '<td class="boardTitle"><a href="./detailBoard?boardNum=' + item.boardNum + '&boardType=notice&page=' + map.navi.currentPage + '&back=false&searchItem=' + map.searchItem + '&searchText=' + map.searchText + '">' + item.title + '</a></td>';
			boardResult += '<td>' + item.userid + '</td>';
			boardResult += '<td>' + item.regdate + '</td>';
			boardResult += '<td>' + item.hitcount + '</td>';
			boardResult += '</tr>';
			count++;
		});
	}
	boardResult += '</table>';
	boardResult += '</div>';// boardTable
	// 페이징
	boardResult += '<div id="page">';
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
		boardResult += '<form id="searchBox" action="boardList" method="get">';
		boardResult += '<input type="hidden" name="boardType" value="notice">';
		boardResult += '<div class="col-md-4">';
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
		boardResult += '</div>';
		boardResult += '<div class="col-md-4">';
		boardResult += '<input id="searchTextBox" type="text" name="searchText" value="' + map.searchText + '">';
		boardResult += '</div>';
		boardResult += '<div class="col-md-4">';
		boardResult += '<input id="search" type="button" value="Search">';
		boardResult += '</div>';
		boardResult += '</form>';
	}
	boardResult += '</div>';
	if(loginType === 'admin'){
		boardResult += '<a href="./writeBoardForm?page=' + map.navi.currentPage + '&boardType=notice"><button class="btn">Write Board</button></a>';
	}
	
	//$('#selectBox option[value='+map.searchItem+']').attr('selected', 'selected');
	//$('#selectBox').val(map.searchItem);
	//$("#selectBox").val(map.searchItem).attr("selected", true); //값이 1인 option 선택
	$('#boardResult').html(boardResult);
	$('#search').click(search);
}

// 페이지 이동
function selectPage(page, searchItem, searchText){
	$.ajax({
		url  : 'boardList'
		, type : 'get'
		, data : {'page' : page, 'boardType' : 'notice', 'searchItem' : searchItem, 'searchText' : searchText}
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
		, data : {'boardType' : 'notice', 'searchItem' : searchItem, 'searchText' : searchText}
		, success : output
		, error : function(){alert("Error!");}
	});
}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
	<h1>Notice Board</h1>
	<input id="boardType" type="hidden" value="${boardType}">
	<input id="page" type="hidden" value="${page}">
	<input id="searchItem" type="hidden" value="${searchItem}">
	<input id="searchText" type="hidden" value="${searchText}">
	<input id="loginType" type="hidden" value="${sessionScope.loginType}">
	<div id="boardResult"></div>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>