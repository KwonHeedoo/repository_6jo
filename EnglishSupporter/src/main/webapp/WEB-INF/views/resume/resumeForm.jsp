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

input[type='text'], input[type='date'], input[type='email'], input[type='datetime-local'] {
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
.col-md-12{
margin-bottom: 20px;
}

</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/header.jsp"%>
	<div class="container">
		<div class="row justify-content-end">
			<div class="col-4">
			<br>
			<c:if test="${empty resume}">
			<h4>[ New Resume ]</h4>
				</c:if>
				<c:if test="${not empty resume}">
			<h4>[ Update Resume ]</h4>
				</c:if>
			<br>
			<form id="resume">
				<input type="hidden" name="userid" value="${sessionScope.loginId}" id="userid">
				<div class="row">
					<div class="col-md-5">
					<p>TITLE: </p><input id="title" type="text" name="title" value ="${resume.title}" placeholder="COMPANY NAME / JOB TITLE" />
					</div>
					<div class="col-md-4">
					<p>DEADLINE: </p><input type="datetime-local" name="deadline" />
					</div>
				</div>
				<br>
				<hr>
					<h5>Personal Information</h5>
				<div class="row">
					<div class="col-md-6">
						<p>NAME: </p><input type="text" name="username" value="" placeholder="First name Last name"/>
					</div>
					<div class="col-md-6">
						<p>EMAIL: </p><input id="email" type="email" name="email" value="${sessionScope.email}" />
					</div>
					<div class="col-md-6">
						<p>PHONE NUMBER: </p><input type="text" name="phone" value="${resume.phone}"/>
					</div>
					<div class="col-md-6">
						<p>ADDRESS: </p><input id="address" type="text" name="address" value="${resume.address}"/>
					</div>
					
				</div>
				</form>
				<br>
				<hr>
				<form id="education">
				<div class="row" id="edu">
					<div class="col-md-3">
						<h5>EDUCATION</h5>
					</div>
					<div class="col-md-1">
					<input type="button" value="+" class="add" id="addedu"/>
					</div>
					<div class="col-md-1">
					<input type="button" value="-" class="add" id="minusedu"/>
					</div>					
					<br>
					<br>
					<div class="box">
					<div class="col-md-2">
						<input type="date" name="education[0][enter_date]" placeholder="START DATE" />(start date)
					</div>
					<div class="col-md-2">
						<input type="date" name="education[0][graduate_date]" placeholder="END DATE" />(end date)
					</div>
					<div class="col-md-3">
						<input  type="text" name="education[0][school_name]" placeholder="educational institution" />
					</div>
					<div class="col-md-2">
						<input type="text" name="education[0][degree_level]" placeholder="degree" />
					</div>
					<div class="col-md-3">
						<input type="text" name="education[0][major]" placeholder="MAJOR" />
					</div>
					</div>
				</div>
				</form> 
				<br>
				<hr>
				<br>
				<form id="experience">
				<div class="row" id="exp">
					<div class="col-md-3">
					<h5>EXPERIENCES</h5>
					</div>
					<div class="col-md-1">
					<input type="button" value="+" class="add" id="addexp"/>
					</div>
					<div class="col-md-1">
					<input type="button" value="-" class="add" id="minusexp"/>
					</div>					
					<br>
					<br>
					<div class="box">
					<div class="col-md-3">
						<input type="date" name="experience[0][start_date]" placeholder="START DATE" />(start date)
					</div>
					<div class="col-md-3">
						<input type="date" name="experience[0][end_date]" placeholder="END DATE" />(end date)
					</div>
					<div class="col-md-6">
						<input type="text" name="experience[0][company_name]" placeholder="organization/company NAME" />
					</div>
					<div class="col-md-12">
						<input  type="text" name="experience[0][job_description]" placeholder="DESCRIPTION" />
					</div>
					</div>
				</div>
				</form>
				<br>
				<hr>
				<br>
				<form id="add_info">
				<div class="row" id="info">
					<div class="col-md-3">
					<h5>Additional Information</h5>
					</div>
					<div class="col-md-1">
					<input type="button" value="+" class="add" id="addinfo"/>
					</div>
					<div class="col-md-1">
					<input type="button" value="-" class="add" id="minusinfo"/>
					</div>
					<br>
					<br>
					<div class="box">
					<div class="col-md-2">
						<input type="date" name="additional_info[0][info_date]" placeholder="END DATE" />
					</div>
					<div class="col-md-2">
						<input type="text" name="additional_info[0][info_title]" placeholder="TITLE" />
					</div>
					<div class="col-md-4">
						<input type="text" name="additional_info[0][detail]" placeholder="DETAIL" />
					</div>
					<div class="col-md-4">
						<input type="text" name="additional_info[0][remarks]" placeholder="REMARK" />
					</div>
					</div>
				</div>
				</form>
				<br>
				<br>
				<div class="right">
				<c:if test="${empty resume}">
				<input type="button" class="btn" value="send Form" id="CVsend">
				</c:if>
				<c:if test="${not empty resume}">
				<input type="button" class="btn" value="Update Form" id="CVupdate">
				</c:if>
				
				<br>
				<br>
				</div>
				</div>
			</div>
		</div>
				
	<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
<script type="text/javascript">

$(function() {
	var userid = $('input[name="userid"]').val();
	console.log(userid);
	$.ajax({
		method: "post",
		url: "getUserInfo",
		data : {"userid": userid},
		dataType : "JSON",
		success: function(reps){
			var user= reps;
			$('input[name="email"]').val(user.email);
		},
		error: function(error){
			console.log("에러"+error);
		}
	});
});


var indexedu=0;
var indexexp=0;
var indexinfo=0;

$(function(){
	//edu 행추가
	$('#addedu').on('click',function(){
		var text = '<div class="box">';
		var boxes = $('#edu >.box');
		indexedu = boxes.length;
		text += '<div class="col-md-2"><input type="date" name="education['+indexedu+'][enter_date]" placeholder="START DATE" />(start date) </div>';
		text += '<div class="col-md-2"><input type="date" name="education['+indexedu+'][graduate_date]" placeholder="END DATE" />(end date)</div>';
		text += '<div class="col-md-3"><input type="text" name="education['+indexedu+'][school_name]" placeholder="educational institution" /></div>';
		text += '<div class="col-md-2"><input type="text" name="education['+indexedu+'][degree_level]" placeholder="degree" /></div>'
		text += '<div class="col-md-3"><input type="text" name="education['+indexedu+'][major]" placeholder="MAJOR" /></div></div>';
			//console.log(text);
			//console.log($('#edu'));
			$('#edu').append(text);
		});
	
	$('#minusedu').on('click',function(){
		//console.log($('#edu >.box:last-child'));
		indexedu =  $('#edu >.box').length;
		if(indexedu>1){
			$('#edu >.box:last-child').remove();
		}
	});
	//exp 행추가
	$('#addexp').on('click',function(){
		var text = '<div class="box">';
		var boxes = $('#exp >.box');
		indexexp = boxes.length;
		text += '<div class="col-md-3"><input type="date" name="experience['+indexexp+'][start_date]" placeholder="START DATE" />(start date)</div>';
		text += '<div class="col-md-3"><input type="date" name="experience['+indexexp+'][end_date]" placeholder="END DATE" />(end date)</div>';
		text += '<div class="col-md-6"><input type="text" name="experience['+indexexp+'][company_name]" placeholder="organization/company NAME" /></div>';
		text += '<div class="col-md-12"><input type="text" name="experience['+indexexp+'][job_description]" placeholder="DESCRIPTION" /></div></div>';
			//console.log(text);
			//console.log($('#edu'));
			$('#exp').append(text);
		});
	
	$('#minusexp').on('click',function(){
		//console.log($('#exp >.box:last-child'));
		indexexp = $('#exp >.box').length;
		console.log(indexexp);
		if(indexexp>1){
			$('#exp >.box:last-child').remove();
		}
	});
	
	$('#addinfo').on('click',function(){
		var text = '<div class="box">';
		var boxes = $('#info >.box');
		indexinfo = boxes.length;
		text += '<div class="col-md-2"><input type="date" name="additional_info['+indexinfo+'][info_date]" /></div>';
		text += '<div class="col-md-2"><input type="text" name="additional_info['+indexinfo+'][info_title]" placeholder="TITLE" /></div>';
		text += '<div class="col-md-4"><input type="text" name="additional_info['+indexinfo+'][detail]" placeholder="DETAIL" /></div>';
		text += '<div class="col-md-4"><input type="text" name="additional_info['+indexinfo+'][remarks]" placeholder="REMARK" /></div></div>';
			//console.log(text);
			//console.log($('#edu'));
			$('#info').append(text);
		});
	
	$('#minusinfo').on('click',function(){
	//	console.log($('#info >.box:last-child'));
		var boxes = $('#info >.box');
		if(boxes.length>1){
			$('#info >.box:last-child').remove();
		}
	});
	
	$.fn.serializeObject = FormSerializer.serializeObject;
	$.fn.serializeJSON   = FormSerializer.serializeJSON;
	
	//날자 체크 함수 
	function checkdate(array1, array2){
		for (var i = 0; i < array1.length; i++) {
			var array1Compare = array1[i].value;
				array1Compare = array1Compare.split('-');
			var array2Compare = array2[i].value;
				array2Compare = array2Compare.split('-');
	
			var stDate= new Date(array1Compare[0], array1Compare[1], array1Compare[2]);
			var edDate = new Date(array2Compare[0], array2Compare[1], array2Compare[2]);

			//console.log(array1[i].value);
			if(array1[i].value==""){
				alert("날자 입력이 되지 않았습니다..");
				array1[i].focus();
				return false;
			}
			if(array2[i].value==""){
				alert("날자 입력이 되지 않았습니다..");
				array2[i].focus();
				return false;
			}
			
			if(stDate.getTime()>edDate.getTime()){
				alert("종료일자보다 시작일자가 더 작아야 합니다.");
				array2[i].focus();
				return false;
			}
		}
		return true;
	}
	//공백 체크 함수 
	function checkblank(array){
		var result =true;
		$.each(array, function(index,item){
			//console.log(this);
			if(this.value==""){
				alert("빈칸을 채워주세요.");
				console.log(this)
				this.focus();
				result =false;
				return false;//each문 탈출용 return 
			}
		});
		return result;
	}
	
	function validation() {
		/*유효성 검사 
		길이체크, 숫자 아닌것 체크 / 시작일 <종료일 체크 /빈칸 체크 */ 
		var enterd= $('input[name$="[enter_date]"]');
		var graduated =$('input[name$="[graduate_date]"]');
		
		var stad =  $('input[name$="[start_date]"]');
		var endd =  $('input[name$="[end_date]"]');
		
		if(!checkdate(enterd,graduated))return false;
		if(!checkdate(stad,endd))return false;
		
		//공란 체크  학력 
		var school= $('input[name*="[school_name]"]');
		var dgree = $('input[name*="[degree_level]"]');
		var major = $('input[name*="[major]"]');
		
		if(!checkblank(school))return false;
		if(!checkblank(dgree))return false;
		if(!checkblank(major))return false;
		
		//공란 체크 경력 
		var company= $('input[name*="[company_name]"]');
		var job = $('input[name*="[job_description]"]');

		if(!checkblank(company))return false;
		if(!checkblank(job))return false;
		//공란 체크 추가정보
		var info_title= $('input[name*="[info_title]"]');
		if(!checkblank(info_title))return false;
		
		return true;
	}

	function formToObject() {
		var education = $('#education').serializeObject();
		var resume = $('#resume').serializeObject();
		var experience = $('#experience').serializeObject();
		var additional_info =$('#add_info').serializeObject();
		
		/* console.log("education : " + JSON.stringify(education));
		console.log("resume : "+ JSON.stringify(resume));
		console.log("experience : "+ JSON.stringify(experience));
		console.log("additional_info : "+ JSON.stringify(additional_info)); */
		
		$.extend(resume, education, experience, additional_info);
		console.log("resume_extended : "+JSON.stringify(resume));
		
		return resume;
	}
	
	
	$('#CVsend').on('click',function(){
		console.log('들어옵니까?');
		if(!validation()){
			return;
			console.log('너무어렵다구 ㅠㅠ');
		}
		console.log('여기 찍나요?ㅜ?')
		//폼 오브젝트화 
		var resume = formToObject();
		$.ajax({
			method: "post",
			url: "sendresumeForm",
			data : JSON.stringify(resume),
			contentType : 'application/json; charset=UTF-8',
			success: function(reps){
				var text="";
				text =reps;
				alert(text);
				if(text.includes("완료")){
					location.href = "${pageContext.request.contextPath}/goMyDocs?selectedTab=resume";
					}
			},
			error: function(error){
				console.log("에러"+error);
			}
		});
	});

	$('#CVupdate').on('click',function(){
		if(!validation()){return;}
		//폼 오브젝트화 
		var resume = formToObject();
		$.ajax({
			method: "post",
			url: "updateResumeForm",
			data : JSON.stringify(resume),
			contentType : 'application/json; charset=UTF-8',
			success: function(reps){
				var text="";
				text =reps;
				alert(text);
				if(text.includes("완료")){
					var title = $('input[name="title"]').val();
					var userid = $('input[name="userid"]').val();
					var link = 'viewMyCoverletter?userid='+userid+'&title='+encodeURI(title);
					location.href = "${pageContext.request.contextPath}/viewMyCoverletter?selectedTab=resume";
					}
			},
			error: function(error){
				console.log("에러"+error);
			}
		});
	});
	
	
});

</script>

</html>