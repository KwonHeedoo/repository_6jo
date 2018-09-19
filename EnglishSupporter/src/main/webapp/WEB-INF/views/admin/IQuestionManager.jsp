<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Interview Question Management</title>
<script>
</script>
<style type="text/css">
.trandsinput {
border-color: transparent;
background-color: transparent;
}
.borderless {
border-color: #D7D7D7;
background-color: white;
}
table{
	width: 63%; 
}
th {
    color: #FFFFFF;
    background-color: #373737;
    text-align: center;
}
input[type=text]{
	width: 500px;
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
</head>
<body>
<%@ include file="/WEB-INF/views/admin/adminFrame.jsp"%>
	<div id="container" style="margin-left:350px;">
	<h2>Mock Interview Management</h2>
	<br>
	 
	<div align="left">
		<input type="text" id="newQuestion" placeholder="NEW QUESTION">
		<input type="button" id="addQuestion" value="ADD">
	</div>
	<br>
		<table border="1" style="text-align:center;">
			<tr>
				<th>No</th>
				<th>Question</th>
				<th>Update</th>
				<th>Delete</th>
			</tr>
			<c:if test="${empty iQuestionList}">
				<tr>
					<td colspan="4" align="center" ><b>There is no Item</b></td>
				</tr>
			</c:if>
			<c:forEach var="i" items="${iQuestionList}" varStatus="status">
			<tr>
				<td><input type="hidden" value="${i.questionNum}">
				${(navi.currentPage-1)*20+status.count}</td>
				<td><input class="trandsinput" type="text" name="question" value="${i.question}" readonly="true"></td>
				<td><input id="update" type="button" value="UPDATE"></td>
				<td><input id="delete" type="button" value="DELETE"></td>
			</tr>
			</c:forEach>
		</table>
		<br>
		<div id="navigator">
			<a href="goIQuestionManager?page=1">◀◀</a>&emsp; 
			<a href="goIQuestionManager?page=${navi.currentPage-1}">Prev</a>&emsp;
			
			<c:forEach var="num" begin="${navi.startPageGroup}" end="${navi.endPageGroup}">
				<a href="goIQuestionManager?page=${num}">
				<span <c:if test="${navi.currentPage == num}"> style="font-weight:bold;" </c:if>>
				${num}</span></a>&emsp;
			</c:forEach>
			
			<a href="goIQuestionManager?page=${navi.currentPage+1}">Next</a>&emsp;
			<a href="goIQuestionManager?page=${navi.totalPageCount}">▶▶</a>
		</div>
		<br><br>
	</div>
</body>
<script type="text/javascript">

$(function() {
	
	// 새로운 질문 추가
	$('#addQuestion').on('click',function(){
		var question = $('#newQuestion').val();
		
		$.ajax({
			url : 'questionAdd'
			, type : 'post'
			, data : {"question" : question}
			, success : function(resp){
				if(resp == 1){
					alert("Add Completed.");
					location.href = "${pageContext.request.contextPath}/goIQuestionManager?page=${navi.currentPage}";
				}else if(resp == 0){
					alert("Add Failed.");
					location.href = "${pageContext.request.contextPath}/goIQuestionManager?page=${navi.currentPage}";
				}
			}
			, error: function(resp){
				alert("Add Error!");
			}
		});
	});
	
	$('input[value="UPDATE"]').on('click',function(){
		var type= $(this).val();
		
		// UPDATE 버튼 누르면 SAVE 버튼으로 바뀌고 해당 질문이 수정가능한 상태로 바뀜
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
			var questionNum = tr.children().children('input[type="hidden"]').val();
			var question = tr.children().children('input[name="question"]').val();
			var sendData = {"questionNum" : questionNum, "question" : question};
			
			$.ajax({
				url : 'questionUpdate'
				, type : 'post'
				, data : JSON.stringify(sendData)
				, contentType : 'application/json;charset=UTF-8'
				, success : function(resp){
					if(resp == 1){
						alert("Update Completed.");
						location.href = "${pageContext.request.contextPath}/goIQuestionManager?page=${navi.currentPage}";
					}else if(resp == 0){
						alert("Update Failed.");
						location.href = "${pageContext.request.contextPath}/goIQuestionManager?page=${navi.currentPage}";
					}
				}
				, error: function(resp){
					alert("Update Error!");
				}
			});
		}
		
	});
	
	// DELETE 버튼 누르면 해당 질문 삭제
	$('input[value="DELETE"]').on('click',function(){
		console.log('in delete');
		var tr = $(this).parent().parent();
		var questionNum = tr.children().children('input[type="hidden"]').val();
		console.log(questionNum);
		$.ajax({
			url : 'questionDelete'
			, type : 'post'
			, data : {"questionNum" : questionNum}
			, success : function(resp){
				if(resp == 1){
					alert("Delete Completed.");
					location.href = "${pageContext.request.contextPath}/goIQuestionManager?page=${navi.currentPage}";
				}else if(resp == 0){
					alert("Delete Failed.");
					location.href = "${pageContext.request.contextPath}/goIQuestionManager?page=${navi.currentPage}";
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