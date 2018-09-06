<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Updating Notice Board</title>
<script>
function cancell(boardNum, page, searchItem, searchText) {
	location.href = "detailBoard?boardNum="+boardNum+"&&boardType=notice&page="+page+"&back=true&searchItem="+searchItem+"&searchText="+searchText;
};

function board(page) {
	location.href = "./goBoardList?page=" + page + "&boardType=notice";
};

function formCheck(){
	var title = document.getElementById("title").value;
	var contents = document.getElementById("contents").value;
	
	if(title.length == 0 || contents.length == 0){
		alert("Please Write Title or Content");
		return false;
	}
	
	return true;
};
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
	<h1>Updating Notice Board</h1>
	<div>
	<form action="updateBoard" method="post" onsubmit="return formCheck()">
		<input type="hidden" name="boardNum" value="${board.boardNum}">
		<input type="hidden" name="page" value="${page}">
		<input type="hidden" name="searchItem" value="${searchItem}">
		<input type="hidden" name="searchText" value="${searchText}">
		<div>
			<input type="hidden" name="boardType" value="notice">
			<input id="title" type="text" name="title" value="${board.title}" placeholder="TITLE" autocomplete="off">
		</div>
		<h3 id="introduce">Content</h3>
		<div>
			<textarea id="contents" rows="15" cols="60" name="contents">${board.contents}</textarea><br/>
		</div>
		<div>
			<div class="col-md-6">
				<input type="submit" value="Update">
			</div>
			<div class="col-md-6">
				<input type="button" value="Cancell" onclick="cancell(${board.boardNum}, ${page}, '${searchItem}', '${searchText}')">
			</div>
		</div>
	</form>
	</div>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>