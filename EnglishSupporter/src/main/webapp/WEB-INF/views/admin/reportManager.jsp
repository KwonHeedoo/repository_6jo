<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- google CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#reportManager').addClass('active');
	
	// 신고리스트 요청
	reportList();
});

// 신고리스트 요청
function reportList(){
	$.ajax({
		url : 'reportList'
		, type : 'get'
		, success : function(resp){output(resp);}
		, error : function(){alert('Error!');}
	});
};

// 신고리스트 출력
function output(resp){
	var map = resp;
	var result = '';
	
	result += '<table border="1" style="text-align:center;">';
	// 신고 제목부분
	result += '<tr>';
	result += '<th>REPORTER</th>';
	result += '<th>REPORTEE</th>';
	result += '<th>REGDATE</th>';
	result += '<th>REPORT CONFIRM</th>';
	result += '<th>ACCEPT</th>';
	result += '</tr>';
	
	// 신고 내용부분 :: 데이터가 없을 경우
	if(!map.reportList.length){
		boardResult += '<tr>';
		boardResult += '<td colspan="5">There is no Report</td>';
		boardResult += '</tr>';
	}
	
	// 신고 내용부분 :: 데이터가 있을 경우
	if(map.reportList.length){
		$.each(map.reportList, function(index, item){
			result += '<tr>';
			result += '<td>' + item.reporter + '</td>';
			result += '<td>' + item.reportee + '</td>';
			result += '<td>' + item.regdate + '</td>';
			result += '<td><button id="report' + item.reportNum + '">Check</button></td>';
			$(function(){
				$('#report' + item.reportNum).on('click',function(){
					reportBox(item.report, item.reason, item.reportURL);
				});
			});
			if(item.status == 0){
				result += '<td><button class="accept" onclick="accept(' + item.reportNum + ', \'' + item.reportee + '\')">Accept</button></td>';
			}else{
				result += '<td><button class="cancel" onclick="cancel(' + item.reportNum + ', \'' + item.reportee + '\')">Cancel</button></td>';
			}
			result += '</tr>';
		});
	}
	result += '</table>';
	// 페이징
	result += '<div id="page" align="center">';
	if(map.reportList.length){
		var i = 1;
		result += '<a onclick="selectPage('+ 1 + ', \'' + map.searchItem + '\', \'' + map.searchText + '\')">◀◀</a>&emsp;'; 
		result += '<a onclick="selectPage('+ (map.navi.currentPage - 1) + ', \'' + map.searchItem + '\', \'' + map.searchText + '\')">Prev</a>&emsp;';
		for(var i = map.navi.startPageGroup; i <= map.navi.endPageGroup; i++){
			result += '<a onclick="selectPage('+ i + ', \'' + map.searchItem + '\', \'' + map.searchText + '\')">';
			if(map.navi.currentPage == i){
				result += '<span style="font-size:12pt; font-weight:bold;">' + i + '&emsp;</span></a>';
			}else{
				result += '<span>' + i + '&emsp;</span></a>';
			}
		}
		result += '<a onclick="selectPage('+ (map.navi.currentPage + 1) + ', \'' + map.searchItem + '\', \'' + map.searchText + '\')">Next</a>&emsp;'; 
		result += '<a onclick="selectPage('+ map.navi.totalPageCount + ', \'' + map.searchItem + '\', \'' + map.searchText + '\')">▶▶</a>';
	}	
	result += '</div>';// page
		
	$('#reportList').html(result);
}

// 신고 내용 및 이유 보기
function reportBox(report, reason, reportURL){
	var box = '';
	
	box += '<table border="1">';
	box += '<tr>';
	box += '<th>Report</th>';
	box += '<td>' + report + '</td>';
	box += '</tr>';
	box += '<tr>';
	box += '<th>Reason</th>';
	box += '<td>' + reason + '</td>';
	box += '</tr>';
	box += '<tr>';
	box += '<td colspan="2" style="text-align:center;"><a href="./' + reportURL + '" target="_blank">Going to ReportURL</a></td>';
	box += '</tr>';
	box += '</table>';
	
	$('#reportBox').html(box);
}

// 신고 수리
function accept(reportNum, reportee){
	//확인
	if (confirm("Are you Sure??") == true){
		$.ajax({
			url : 'reportAccept'
			, type : 'get'
			, data : {'reportNum' : reportNum, 'reportee' : reportee}
			, success : function(resp){if(resp == 1){reportList();}}
			, error : function(){alert('Error!');}
		});
	//취소
	}else{
	    return;
	}
}

//신고 수리 취소
function cancel(reportNum, reportee){
	//확인
	if (confirm("Are you Sure??") == true){
		$.ajax({
			url : 'acceptCancel'
			, type : 'get'
			, data : {'reportNum' : reportNum, 'reportee' : reportee}
			, success : function(resp){if(resp == 1){reportList();}}
			, error : function(){alert('Error!');}
		});
	//취소
	}else{
	    return;
	}
}
</script>
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