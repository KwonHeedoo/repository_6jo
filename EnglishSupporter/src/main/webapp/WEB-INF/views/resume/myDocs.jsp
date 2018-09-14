<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My documentations</title>
<script src="resources/jquery-3.3.1.min.js"></script>
<script src="resources/jquery.serialize-object.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style>
html,body{
height: 100%;
}

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
    border-right : 1px solid #eee;
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
    background: #f1efef;
    border-bottom: 1px solid #FFFFFF;
}
.tab_container {
    border-top: none;
    clear: both;
    float: left;
    background: #FFFFFF;
    width: 100%;
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
	height: 60%;
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
			<th>UPDATE/DELETE</th>
		</tr>
		<!-- 게시판 내용부분 :: 데이터가 없을 경우 -->
		<c:if test="${empty clList}">
			<tr>
				<td colspan="4">There is no CoverLetter</td>
			</tr>
		</c:if>
		<!-- 게시판 내용부분 :: 데이터가 있을 경우 -->
		<c:if test="${not empty clList}">
			<c:forEach var="coverletter" items="${clList}" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td class="coverletterTitle">
					<a class="cltitle${status.count}" href="">${coverletter.title}</a>
					</td>
					<td class ="regdate${status.count}"></td>
					<td>
					<a href="#" onclick="updateCL('${coverletter.userid}','${coverletter.title}');">UPDATE</a> / <a href="#" onclick="deleteCL('${coverletter.userid}','${coverletter.title}');">DELETE</a>
					</td>
				</tr>
				<script>
						$('td.regdate${status.count}').text("${coverletter.regdate}".substring(0,16));
					var link = "./viewMyCoverletter?userid=${coverletter.userid}&title="+encodeURI('${coverletter.title}');
						$('a.cltitle${status.count}').attr('href',link);
				</script>
			</c:forEach>
		</c:if>
	</table>
	</div>     
		<div id="page" align="center">
		<a href="./goMyDocs?cpage=1">◀◀</a>&emsp; 
		<a href="./goMyDocs?cpage=${c_navi.currentPage - 1}&selectedTab=coverletter">Prev</a>&emsp;
		<c:forEach var="num" begin="${c_navi.startPageGroup}" end="${c_navi.endPageGroup}" step="1">
			<a href="./goMyDocs?cpage=${num}&selectedTab=coverletter" >
			<span <c:if test="${c_navi.currentPage == num}"> style="font-size:12pt; font-weight:bold;" </c:if>>${num}&emsp;</span></a>
		</c:forEach>
		<a href="./goMyDocs?cpage=${c_navi.currentPage + 1}&selectedTab=coverletter">Next</a>&emsp; 
		<a href="./goMyDocs?cpage=${c_navi.totalPageCount}&selectedTab=coverletter">▶▶</a>
		</div>
	
	  
</div>
        <!-- #tab2 -->
        <div id="tab2" class="tab_content">
	<div>
	<table border="1">
		<!-- 게시판 제목부분 -->
		<tr>
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
			<c:forEach var="resume" items="${resumeList}" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td class="resumeTitle"><a href="./viewMyResume?resume_no=${resume.resume_no}"
						>${resume.title}</a></td>
					<td class="deadline${status.count}">${resume.deadline}</td>
					<td class="regdate2${status.count}">${resume.regdate}</td>
					<td>
					<a href="#" onclick="updatedocs('${resume.resume_no}');">UPDATE</a> / <a href="#" onclick="deletedocs('${resume.resume_no}');">DELETE</a>
					</td>
				</tr>
				<script>
					//var regdate2 = ;
					//var deadline = ;
						$('td.regdate2${status.count}').text("${resume.regdate}".substring(0,16));
						$('td.deadline${status.count}').text("${resume.deadline}".substring(0,16));
				</script>
			</c:forEach>
		</c:if>
	</table>
	</div>  
		<div id="page" align="center">
		<a href="./goMyDocs?rpage=1">◀◀</a>&emsp; 
		<a href="./goMyDocs?rpage=${r_navi.currentPage - 1}&selectedTab=resume">Prev</a>&emsp;
		<c:forEach var="num" begin="${r_navi.startPageGroup}" end="${r_navi.endPageGroup}" step="1">
			<a href="./goMyDocs?rpage=${num}&selectedTab=resume" >
			<span <c:if test="${r_navi.currentPage == num}"> style="font-size:12pt; font-weight:bold;" </c:if>>${num}&emsp;</span></a>
		</c:forEach>
		<a href="./goMyDocs?rpage=${r_navi.currentPage + 1}&selectedTab=resume">Next</a>&emsp; 
		<a href="./goMyDocs?rpage=${r_navi.totalPageCount}&selectedTab=resume">▶▶</a>
		</div>
   <!-- tab2 -->
   </div>
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

function ajaxDelete(object) {
	$.ajax({
		method: "post",
		url: "deleteDocs",
		data : object,
		success: function(reps){
			var text="";
			text =reps;
			alert(text);
			if(text.includes("완료")){
				var type = object.type;
				console.log(type);
				location.href = "${pageContext.request.contextPath}/goMyDocs?selectedTab="+type;
				}
		},
		error: function(error){
			console.log("에러"+error);
		}
	});
}


function updateCL(userid,title) {
	var openNewWindow = window.open("about:blank"); // 새창띄우기
 	var link = "updateMyCoverletter?userid="+userid+"&title="+encodeURI(title);
	openNewWindow.location.href ="${pageContext.request.contextPath}/"+link; //수정창 주소...
}

function deleteCL(userid,title) {
	if (confirm("정말 삭제하시겠습니까??") == true){    //확인
	    // 삭제는 에이젝스로 한 후 삭제결과 받아서 alert 한 후  location.href로 페이지 재로딩
	    var object ={'userid':userid,'title':title,'type':'coverletter'};
	    ajaxDelete(object);
	    // 삭제시 넘길 것 userid, title, type= (resume, coverletter)
		//location.href="${pageContext.request.contextPath}/goMyDocs";
	}else{   //취소
	    return;
	}
}

/*이력서 수정*/
function updatedocs(resume_no) {
	//var openNewWindow = window.open("about:blank"); // 새창띄우기

	location.href ="${pageContext.request.contextPath}/goUpdateResume?resume_no="+resume_no; //수정창 주소...
}

/*이력서 삭제 확인창 띄워서 삭제확인 받고  페이지 재로딩*/
function deletedocs(resume_no) {
	if (confirm("정말 삭제하시겠습니까??") == true){    //확인
	    // 삭제는 에이젝스로 한 후 삭제결과 받아서 alert 한 후  location.href로 페이지 재로딩
	   	var object ={'resume_no':resume_no,'type':'resume'};
	    ajaxDelete(object);
	    // 삭제시 넘길 것 userid, title, type= (resume, coverletter)
		//location.href="${pageContext.request.contextPath}/goMyDocs";
	}else{   //취소
	    return;
	}
}

//this 는 선택된 탭을 가리킴...
function selectTab(tab) {
	$("ul.tabs li").removeClass("active").css("color", "#333");
    //$(this).addClass("active").css({"color": "darkred","font-weight": "bolder"});
    tab.addClass("active").css("color", "#d00202");
    $(".tab_content").hide();
    var activeTab = tab.attr("rel");
    $("#" + activeTab).fadeIn();
}

$(function () {
	$('#resume').addClass('active');
	
	// 페이지에 들어올 때 어떤 탭을 선택해서 들어올것인지 변수 확인하기 
	var selectedTab = "${selectedTab}";
	var stab;
	if(selectedTab=="coverletter"){
		stab = $("ul.tabs li[rel='tab1']");
		selectTab(stab);
	}else{
		//$("ul.tabs li[rel='tab2']").addClass("active").css("color", "#d00202");
		stab= $("ul.tabs li[rel='tab2']");
		selectTab(stab);
	}
	

    // 클릭시 적용이벤트 
    $("ul.tabs li").click(function(){
    	var tab =$(this);
    	selectTab(tab);
    });
    
   });

</script>
</html>