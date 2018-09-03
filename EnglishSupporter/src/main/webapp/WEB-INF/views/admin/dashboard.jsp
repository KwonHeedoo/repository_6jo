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
	callJoinAndVisit('week');
	// 신고 & 재제 수 그래프
	callRptAndSanc('week');
	// 회원 연령대 별 분포도
	graphAgePercent();
	// 오늘의 게시물, 코멘트, Coverlette, Resume 수
	//countToday();
});

// 회원가입 & 방문자 수 정보 요청
function callJoinAndVisit(period){
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

// 회원가입 & 방문자 수 정보 그래프 응답
function graphJoinAndVisit(array) {
	google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(drawChart);
	function drawChart(scoreGraph) {
		var data = google.visualization.arrayToDataTable(array);
			var options = {
		/* chart : {
				title : '[방문자] 및 [가입자] : 주간 별 & 월 별'
					, subtitle : '[방문자] 및 [가입자] : 주간 별 & 월 별'
			} */
		};
			var chart = new google.charts.Bar(document.getElementById('joinAndVisitGraph'));
		chart.draw(data, google.charts.Bar.convertOptions(options));
	}
};

// 신고 & 재제 수 정보 요청
function callRptAndSanc(period){
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
			/* chart : {
				title : '[신고] 및 [재제] : 주간 별 & 월 별'
				, subtitle : '[신고] 및 [재제] : 주간 별 & 월 별'
			} */
		};
			var chart = new google.charts.Bar(document.getElementById('rptAndSancGraph'));
		chart.draw(data, google.charts.Bar.convertOptions(options));
	}
};


// 회원 연령대 별 분포도 정보 그래프 응답
function graphAgePercent() {
	google.charts.load("current", {packages:["corechart"]});
    google.charts.setOnLoadCallback(drawChart);
    function drawChart() {
    	// 회원 연령대 별 분포도 정보 요청
    	$.ajax({
    		url : 'countByUserAge'
    		, type : 'get'
    		, success : function(resp){
    			var percent = resp;
    			
    			var data = google.visualization.arrayToDataTable([
    				['Age', 'Age per Users'],
    				['10대', percent.countOne],
    				['20대', percent.countTwo],
    				['30대', percent.countThree],
    				['40대 이상', percent.countFour]
    			]);
    			
    			var options = {
    				/* title: 'Percent of User\'s Age', */
    				is3D: true,
    			};

    			var chart = new google.visualization.PieChart(document.getElementById('ageGraph'));
    			chart.draw(data, options);
    		}
    		, error : function(resp){
    			alert('Error!');
    		} 
    	});
	}
};

// 오늘의 게시물, 코멘트, Coverlette, Resume 수
function countToday(){
	$.ajax({
		url : 'countToday'
		, type : 'get'
		, success : function(resp){
			panel(resp);
		}
		, error : function(resp){
			alert('Error!');
		} 
	});
}

// panel출력
function panel(resp){
	var countList = resp;
	var resultDiv = '';
	var color = ['primary', 'green', 'yellow', 'red'];
	var category = ['Boards', 'Comments', 'Coverletters', 'Resume'];
	var icon = ['fa-list-alt', 'fa-comments', 'fa-edit', 'fa-edit'];
	var count = 0;
	
	$.each(countList, function(index, item){
		resultDiv += '<div class="col-lg-3 col-md-6">';
		resultDiv += '<div class="panel panel-' + color[count++] + '">';
		resultDiv += '<div class="panel-heading">';
		resultDiv += '<div class="row">';
		resultDiv += '<div class="col-xs-3">';
		resultDiv += '<i class="fa ' + icon[count++] + ' fa-5x"></i>';
		resultDiv += '</div>';// col-xs-3
		resultDiv += '<div class="col-xs-9 text-right">';
		resultDiv += '<div class="huge">26</div>';
		resultDiv += '<div>New ' + category[count++] + '!</div>';
		resultDiv += '</div>';// col-xs-9 text-right
		resultDiv += '</div>';// row
		resultDiv += '</div>';// panel-heading
		resultDiv += '<a href="#">';
		resultDiv += '<div class="panel-footer">';
		resultDiv += '<span class="pull-left">View Details</span>';
		resultDiv += '<span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>';
		resultDiv += '<div class="clearfix"></div>';
		resultDiv += '</div>';// panel-footer
		resultDiv += '</a>';
		resultDiv += '</div>';// panel panel-primary
		resultDiv += '</div>';// col-lg-3 col-md-6
	});
	
	$('#panels').html(resultDiv);
}
</script>
<title>Dashboard</title>
</head>
<body>
<%@ include file="/WEB-INF/views/admin/adminFrame.jsp"%>
	<div id="container" style="margin-left:350px;">
	<h1>Dashboard</h1>
		<div class="row">
			<div id="panels"></div>
		</div>
		<div class="row">
			<div class="col-md-10">
				<h4>Count By Visitor & Join</h4>
				<button class="period" onclick="callJoinAndVisit('week')">Week</button>
				<button class="period" onclick="callJoinAndVisit('month')">Month</button>
				<div id="joinAndVisitGraph"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-10">
				<h4>Count By Report & Sanction</h4>
				<button class="period" onclick="callRptAndSanc('week')">Week</button>
				<button class="period" onclick="callRptAndSanc('month')">Month</button>
				<div id="rptAndSancGraph"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6">
				<h4>Percent of User\'s Age</h4>
				<div id="ageGraph" style="width:900px; height:500px;"></div>
			</div>
		</div>
	</div>
</body>
</html>