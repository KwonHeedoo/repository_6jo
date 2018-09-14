<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Resume</title>
<script src="resources/jquery-3.3.1.min.js"></script>
<link href="resources/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style type="text/css">
  .navbar {
      margin-bottom: 0;
      border-radius: 0;
   }
  .name{
  padding-top:10px;
  font-size:20pt;
  height: 50px;
  text-align: center;
  }
  .textcenter{
  text-align: center;
  }
  th.this{
  background-color: #616161;
  }

</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/header.jsp"%>


<div class="jumbotron">
  <div class="container">
  <span ><h3>[My RESUME : ${resume.title}]</h3></span>
  <span>[registration date : ${resume.regdate}]</span>
  <hr>
	<table border="1">
		<!-- 게시판 제목부분 -->
		<tr>	
			<th colspan="6" class="name this">${resume.username}</th>
		</tr>
		<tr>
		<td class="textcenter">
		Address : ${resume.address}<br>
		Phone : ${resume.phone}<br>
		E-mail :${resume.email}
		</td>
		</tr>
		<!-- 게시판 내용부분 :: 데이터가 없을 경우 -->
		<c:if test="${empty resume}">
			<tr>
				<td colspan="6">There is no Resume</td>
			</tr>
		</c:if>
		<!-- 게시판 내용부분 :: 데이터가 있을 경우 -->
		<c:if test="${not empty resume.education}">
			<tr><th colspan="6" class="this">Education</th>
			<c:forEach var="edu" items="${resume.education}" varStatus="status">
				<tr>
				<td colspan="6">
					[${edu.school_name}]
					<ul>
					<li>${edu.enter_date} -- ${edu.graduate_date}</li>
					<li>${edu.degree_level} / ${edu.major}</li>
					</ul>
				</td>
				</tr>
			</c:forEach>
		</c:if>

		<c:if test="${not empty resume.experience}">
			<tr><th colspan="6" class="this">Experience</th></tr>
			<c:forEach var="exp" items="${resume.experience}" varStatus="status">
				<tr>
				<td colspan="6">
					[${exp.company_name}]
					<ul>
					<li>${exp.start_date} -- ${exp.end_date}</li>
					<li>${exp.job_description}</li>
					</ul>
				</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${not empty resume.additional_info}">
			<tr><th colspan="6" class="this">additional Information</th>
			<c:forEach var="info" items="${resume.additional_info}" varStatus="status">
				<tr>
				<td colspan="6">
					[${info.info_title}]
					<ul>
					<li>${info.info_date}</li>
					<li>${info.detail} / ${info.remarks}</li>
					</ul>
				</td>
				</tr>
			</c:forEach>
		</c:if>

	</table>
	<div align="center">
	<input type="button" value="Back" onclick="docs()" class="btn">   
	</div>
	</div>    
</div>

	<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
<script type="text/javascript">
function docs() {
	location.href = "./goMyDocs?selectedTab=resume";
};
</script>
</html>

