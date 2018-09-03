<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- google CDN -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
<!-- google chart API -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
$(function(){
	// 회원가입 & 방문자 수 그래프
	callJoinAndVisit();
	// 신고 & 재제 수 그래프
	callRptAndSanc();
});

// 회원가입 & 방문자 수 정보 요청
function callJoinAndVisit(){
	var period = $('#period1 option:selected').val();
	
	$.ajax({
		url : 'countByJoinVisit'
		, type : 'get'
		, data : {'period' : period}
		, success : function(resp){
			var countByJoinVisit = resp;
			var array = [[ 'Date', 'Visitor', 'Join' ]];
			
			$.each(countByJoinVisit, function(index, item) {
				array.push([item.day, item.countOne, item.countTwo]);
			});
			
			graphJoinAndVisit(array);
		}
		, error : function(resp){
			alert('Error!');
		} 
	});
};

//  회원가입 & 방문자 수 정보 그래프 응답
function graphJoinAndVisit(array) {
	google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(drawChart);
	function drawChart(scoreGraph) {
		var data = google.visualization.arrayToDataTable(array);
			var options = {
			chart : {
				title : 'Count By Visitor & Join'
				, subtitle : '[방문자] 및 [가입자] : 주간 별 & 월 별'
			}
		};
			var chart = new google.charts.Bar(document.getElementById('joinAndVisitGraph'));
		chart.draw(data, google.charts.Bar.convertOptions(options));
	}
};

//신고 & 재제 수 정보 요청
function callRptAndSanc(){
	var period = $('#period2 option:selected').val();
	
	$.ajax({
		url : 'countByRptSanc'
		, type : 'get'
		, data : {'period' : period}
		, success : function(resp){
			var countByRptSanc = resp;
			var array = [[ 'Date', 'Report', 'Sanction' ]];
			
			$.each(countByRptSanc, function(index, item) {
				array.push([item.day, item.countOne, item.countTwo]);
			});
			
			graphRptAndSanc(array);
		}
		, error : function(resp){
			alert('Error!');
		} 
	});
};

// 신고 & 재제 수 정보 그래프 응답
function graphRptAndSanc(array) {
	google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(drawChart);
	function drawChart(scoreGraph) {
		var data = google.visualization.arrayToDataTable(array);
			var options = {
			chart : {
				title : 'Count By Report & Sanction'
				, subtitle : '[신고] 및 [재제] : 주간 별 & 월 별'
			}
		};
			var chart = new google.charts.Bar(document.getElementById('rptAndSancGraph'));
		chart.draw(data, google.charts.Bar.convertOptions(options));
	}
};
</script>
<title>Dashboard</title>
</head>
<body>
	<h1>Dashboard</h1>
	<div>
		<select id="period1">
			<option value="week">Week</option>
			<option value="month">Month</option>
		</select>
		<div id="joinAndVisitGraph"></div>
	</div>
	<div>
		<select id="period2">
			<option value="week">Week</option>
			<option value="month">Month</option>
		</select>
		<div id="rptAndSancGraph"></div>
	</div>
	<div>
		<select id="period3">
			<option value="week">Week</option>
			<option value="month">Month</option>
		</select>
		<div id="ageGraph"></div>
	</div>
</body>
</html>