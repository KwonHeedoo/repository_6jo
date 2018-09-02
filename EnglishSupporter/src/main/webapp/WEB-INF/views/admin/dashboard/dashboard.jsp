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
	callSanction();
});

// 회원가입 & 방문자 수 정보 요청
function callJoinAndVisit(){
	var period = $('#visitPeriod option:selected').val();
	
	$.ajax({
		url : "countByJoinVisit"
		, type : "get"
		, data : {"period" : period}
		, success : function(resp){
			var scoreList = resp;
			var array = [[ 'Date', 'Visitor', 'Join' ]];
			
			$.each(scoreList, function(index, item) {
				array.push([item.userid, item.hateCount, item.likeCount]);
			});
			
			graphJoinAndVisit(array);
		}
		, error : function(resp){
			alert("Error!");
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
				title : 'Score By Gender & Age Group'
				, subtitle : '[남성] & [여성] : 10대 ~ 40대이상'
			}
		};
			var chart = new google.charts.Bar(document.getElementById('joinAndVisitGraph'));
		chart.draw(data, google.charts.Bar.convertOptions(options));
	}
};
</script>
<title>Dashboard</title>
</head>
<body>
	<h1>Dashboard</h1>
	<div>
		<div id="joinAndVisitGraph"></div>
	</div>
	<div id="sanctionGraph"></div>
	<div id="ageGraph"></div>
</body>
</html>