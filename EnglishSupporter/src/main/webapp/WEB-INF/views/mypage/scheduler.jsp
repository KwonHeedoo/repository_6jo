<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>My Schedule</title>
<!-- <script src="//code.jquery.com/jquery-1.11.1.min.js"></script> -->
<script src="resources/fullcalendar/lib/jquery.min.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css"/>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="resources/modal/bootstrap.min.css"></script>

<style type="text/css">
html,body{
height: inherit;
}
.datecol{
border: none;
}
.container{
    margin: 0;
    padding-left: 0;
    padding-right: 0;
    width: 100%;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/header.jsp"%>
	<%@ include file="/WEB-INF/views/mypage/mypage_sidebar.jsp"%>
		<!-- Main Content -->
		<div class="container-fluid">
			<div class="side-body">
				<%@ include file="/WEB-INF/views/mypage/mySchedule.jsp"%>
			</div>
		</div>
	<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
<link href="resources/fullcalendar/fullcalendar.min.css" rel="stylesheet">
<link href="resources/fullcalendar/fullcalendar.print.min.css" rel="stylesheet" media="print">
<script src="resources/fullcalendar/lib/moment.min.js"></script>
<script src="resources/fullcalendar/fullcalendar.min.js"></script>
<script src="resources/fullcalendar/theme-chooser.js"></script>
<script src="resources/modal/bootstrap.min.js"></script>

</html>