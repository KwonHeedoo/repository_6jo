<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>My Info</title>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<style type="text/css">
.trandsinput {
border-color: transparent;
background-color: transparent;
}
.borderless {
border-color: #D7D7D7;
background-color: white;
}

</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/header.jsp"%>
	<%@ include file="/WEB-INF/views/mypage/mypage_sidebar.jsp"%>
		<!-- Main Content -->
		<div class="container-fluid">
			<div class="side-body">
				<h2>[ My Words ]</h2>
				
				<br>
				<input type="text" id="newWord" placeholder="WORD">
				<input type="text" id="newMeaning" placeholder="MEANING">
				<input type="button" value="ADD" id="addWord">
				<br><br>
				
				<table>
					<tr>
						<th>No</th>
						<th>Word</th>
						<th>Meaning</th>
						<th>Update</th>
						<th>Delete</th>
					</tr>
					<c:if test="${empty wordlist}">
					<tr>
						<td colspan="5" align="center" ><b>There is no Word</b></td>
					</tr>
					</c:if>
					<c:forEach var="w" items="${wordlist}" varStatus="status">
					<tr>
						<td><input type="hidden" value="${w.myword_no}">
						${(navi.currentPage-1)*20+status.count}</td>
						<td><input class="trandsinput" type="text" name="word" value="${w.word}" readonly="true"></td>
						<td><input class="trandsinput" type="text" name="mean" value="${w.meaningK}" readonly="true"></td>
						<td><input id="update" type="button" value="UPDATE"></td>
						<td><input id="delete" type="button" value="DELETE"></td>
					</tr>
					</c:forEach>
				</table>
				<br>
				<div id="navigator">
					<a href="goMyWords?page=1">◀◀</a>&emsp; 
					<a href="goMyWords?page=${navi.currentPage-1}">Prev</a>&emsp;
					
					<c:forEach var="num" begin="${navi.startPageGroup}" end="${navi.endPageGroup}">
						<a href="goMyWords?page=${num}">
						<span <c:if test="${navi.currentPage == num}"> style="font-weight:bold;" </c:if>>
						${num}</span></a>&emsp;
					</c:forEach>
					
					<a href="goMyWords?page=${navi.currentPage+1}">Next</a>&emsp;
					<a href="goMyWords?page=${navi.totalPageCount}">▶▶</a>
				</div>
			</div>
		</div>
	<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
<style>
.side-menu{
margin-top: 0;
    position: absolute;
    float: left;
    width: 280px;
    height: 130%;
    background-color: #f8f8f8;
    border-right: 1px solid #e7e7e7;
}
.side-body {
  margin-top: 20px;
  margin-left: 300px;
  margin-bottom: 50px;
  height: 1000px;
 }
 </style>
<script type="text/javascript">
$(function() {
	
	// 새로운 단어 추가
	$('#addWord').on('click',function(){
		var word = $('#newWord').val();
		var mean = $('#newMeaning').val();
		var sendData = {"word" : word, "meaningK" : mean};
		console.log(sendData);
		
		$.ajax({
			url : 'mywordAdd'
			, type : 'post'
			, data : JSON.stringify(sendData)
			, contentType : 'application/json;charset=UTF-8'
			, success : function(resp){
				if(resp == 1){
					alert("Add Completed.");
					location.href = "${pageContext.request.contextPath}/goMyWords";
				}else if(resp == 0){
					alert("Add Failed.");
					location.href = "${pageContext.request.contextPath}/goMyWords";
				}
			}
			, error: function(resp){
				alert("Add Error!");
			}
		});
	});
	
	$('input[value="UPDATE"]').on('click',function(){
		var type= $(this).val();
		
		// UPDATE 버튼 누르면 SAVE 버튼으로 바뀌고 해당 word + meaning 이 수정가능한 상태로 바뀜
		if(type=='UPDATE'){
			console.log('in update');
			$(this).val('SAVE');
			var tr = $(this).parent().parent();
			tr.children().children('input[type="text"]').addClass('borderless'); // 텍스트 박스 border 활성화
			tr.children().children('input[type="text"]').attr('readonly',false); // 텍스트 편집 가능
		}
		
		// SAVE 버튼 누르면 다시 UPDATE 버튼으로 바뀌고 완료/실패 알림창 뜸
		if(type=='SAVE'){
			console.log('in save');
			$(this).val('UPDATE');
			var tr = $(this).parent().parent();
			tr.children().children('input[type="text"]').removeClass('borderless'); // 텍스트 박스 border 비활성화
			var myword_no = tr.children().children('input[type="hidden"]').val();
			var word = tr.children().children('input[name="word"]').val();
			var mean = tr.children().children('input[name="mean"]').val();
			var sendData = {"myword_no" : myword_no, "word" : word, "meaningK" : mean};
			
			$.ajax({
				url : 'mywordUpdate'
				, type : 'post'
				, data : JSON.stringify(sendData)
				, contentType : 'application/json;charset=UTF-8'
				, success : function(resp){
					if(resp == 1){
						alert("Update Completed.");
						location.href = "${pageContext.request.contextPath}/goMyWords";
					}else if(resp == 0){
						alert("Update Failed.");
						location.href = "${pageContext.request.contextPath}/goMyWords";
					}
				}
				, error: function(resp){
					alert("Update Error!");
				}
			});
		}
		
	});
	
	// DELETE 버튼 누르면 해당 단어 삭제
	$('input[value="DELETE"]').on('click',function(){
		console.log('in delete');
		var tr = $(this).parent().parent();
		var myword_no = tr.children().children('input[type="hidden"]').val();
		console.log(myword_no);
		$.ajax({
			url : 'mywordDelete'
			, type : 'post'
			, data : {"myword_no" : myword_no}
			, success : function(resp){
				if(resp == true){
					alert("Delete Completed.");
					location.href = "${pageContext.request.contextPath}/goMyWords";
				}else if(resp == false){
					alert("Delete Failed.");
					location.href = "${pageContext.request.contextPath}/goMyWords";
				}
			}
			, error: function(resp){
				alert("Delete Error!");
			}
		});
	});
});

</script>
</html>