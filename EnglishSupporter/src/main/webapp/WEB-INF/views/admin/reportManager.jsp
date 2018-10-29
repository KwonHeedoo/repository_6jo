<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- google CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="./resources//js/Admin/reportManager.js"></script>

<style type="text/css">
th {
    color: #FFFFFF;
    background-color: #373737;
    text-align: center;
}
button{
border:none;
background-color:white;
}
.accept{
color:blue;
}
.cancel{
color:red;
}
</style>
<title>Report Management</title>
</head>
<body>
<%@ include file="/WEB-INF/views/admin/adminFrame.jsp"%>
	<div id="container" style="margin-left:350px;">
	<h1>Report Management</h1>
	<br/><br/>
	<div id="row" style="width:100%;">
	<div id="reportList" style="float:left;width:50%"></div>
	<div id="reportBox" style="float:right;width:50%"></div>
	</div>
	</div>
</body>
</html>