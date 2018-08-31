<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>New Resume</title>
<script src="resources/jquery-3.3.1.min.js"></script>
<script src="resources/jquery.serialize-object.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style>

input[type='text'], input[type='date'] {
margin:0 auto;
height: 28px;
width: 100%
}
::placeholder{
 color: #dad9d9;
 font-size: 9pt;
}

.add{
width: 30px;
margin-left: 0;
}

.box{
height: 55px;
}
h5{
font-weight: bold;
}

ul.tabs {
    margin: 0;
    padding: 0;
    float: left;
    list-style: none;
    height: 32px;
    border-bottom: 1px solid #eee;
    border-left: 1px solid #eee;
    width: 100%;
    font-family:"dotum";
    font-size:12px;
}
ul.tabs li {
    float: left;
    text-align:center;
    cursor: pointer;
    width:150px;
    height: 31px;
    line-height: 31px;
    border: 1px solid #eee;
    border-left: none;
    font-weight: bold;
    background: #FFFFFF;
    overflow: hidden;
    position: relative;
}
ul.tabs li.active {
    background: #f8dbdb;
    border-bottom: 1px solid #FFFFFF;
}
.tab_container {
    border-top: none;
    clear: both;
    float: left;
    background: #FFFFFF;
}
.tab_content {
    padding: 5px;
    font-size: 12px;
    display: none;
    margin: 0 auto;
    margin-top: 20px;
    
}
.tab_container .tab_content ul {
    width:100%;
    margin:0px;
    padding:0px;
}
.tab_container .tab_content ul li {
    padding:5px;
    list-style:none
}

 #container {
	width:80%;
	height: inherit;
	margin :0 auto;    
    margin-top: 20px;
    margin-bottom: 30px;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/header.jsp"%>
<div id="container">
<h1>My documentations</h1>
    <ul class="tabs">
        <li rel="tab1">COVER LETTER</li>
        <li rel="tab2">RESUME(CV)</li>
    </ul>
    <div class="tab_container">
        <!-- #tab1 -->
        <div id="tab1" class="tab_content">
	<div>
	<table border="1">
		<!-- 게시판 제목부분 -->
		<tr id="boardMenu">
			<th>No</th>
			<th class="boardTitle">TITLE</th>
			<th>Registration Date</th>
			<th>Update/Delete</th>
		</tr>
		<!-- 게시판 내용부분 :: 데이터가 없을 경우 -->
		<c:if test="${empty clList}">
			<tr>
				<td colspan="4">There is no CoverLetter</td>
			</tr>
		</c:if>
		<!-- 게시판 내용부분 :: 데이터가 있을 경우 -->
		<c:if test="${not empty clList}">
			<c:forEach var="coverletter" items="${clList}" varStatus="i">
				<tr>
					<td>${i+1}</td>
					<td class="boardTitle">
					<a href="./viewMyCoverletter?userid=${clList.userid}&title=${clList.title}">${clList.title}</a>
					</td>
					<td>${clList.regdate}</td>
					<td>
					<a href="#" onclick="updateCdocs();">UPDATE</a> / <a href="#" onclick="deleteCdocs();">DELETE</a>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	</div>       
</div>
        <!-- #tab2 -->
        <div id="tab2" class="tab_content">
	<div>
	<table border="1">
		<!-- 게시판 제목부분 -->
		<tr id="boardMenu">
			<th>No</th>
			<th class="boardTitle">TITLE</th>
			<th>deadline</th>
			<th>Registration Date</th>
			<th>Update/Delete</th>
		</tr>
		<!-- 게시판 내용부분 :: 데이터가 없을 경우 -->
		<c:if test="${empty resumeList}">
			<tr>
				<td colspan="5">There is no Resume</td>
			</tr>
		</c:if>
		<!-- 게시판 내용부분 :: 데이터가 있을 경우 -->
		<c:if test="${not empty resumeList}">
			<c:forEach var="resume" items="${resumeList}" varStatus="i">
				<tr>
					<td>${i+1}</td>
					<td class="boardTitle"><a href="./viewMyResume?resume_no=${resume.resume_no}"
						>${resume.title}</a></td>
					<td>${resume.deadline}</td>
					<td>${resume.regdate}</td>
					<td>
					<a href="#" onclick="updateRdocs();">UPDATE</a> / <a href="#" onclick="deleteRdocs();">DELETE</a>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	</div>       
        </div>
        <!-- #tab3 -->
    </div>
    <!-- .tab_container -->
</div>
<!-- #container -->
	<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
<script type="text/javascript">
/*a 태그 # 클릭이벤트 막기*/
$(document).on('click', 'a[href="#"]', function(e){
    e.preventDefault();
});

/*커버레터 수정*/
function updateCdocs() {
	var openNewWindow = window.open("about:blank"); // 새창띄우기

	openNewWindow.location.href ="${pageContext.request.contextPath}/"; //수정창 주소...
}

/*커버레터 삭제 확인창 띄워서 삭제확인 받고  페이지 재로딩*/
function deleteCdocs() {
	if (confirm("정말 삭제하시겠습니까??") == true){    //확인
	    // 삭제는 에이젝스로 한 후 삭제결과 받아서 alert 한 후  location.href로 페이지 재로딩
	    // 삭제시 넘길 것 userid, title, type= (resume, coverletter)
		location.href="${pageContext.request.contextPath}/";
	}else{   //취소
	    return;
	}
}


$(function () {
    $(".tab_content").hide();
    $(".tab_content:first").show();

    $("ul.tabs li").click(function () {
        $("ul.tabs li").removeClass("active").css("color", "#333");
        //$(this).addClass("active").css({"color": "darkred","font-weight": "bolder"});
        $(this).addClass("active").css("color", "#d00202");
        $(".tab_content").hide()
        var activeTab = $(this).attr("rel");
        $("#" + activeTab).fadeIn()
    });
});

</script>
</html>