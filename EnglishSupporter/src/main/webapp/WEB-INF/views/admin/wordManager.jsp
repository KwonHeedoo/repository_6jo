<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Word Training Management</title>
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
	width: 80%; 
}
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
</head>
<body>
<%@ include file="/WEB-INF/views/admin/adminFrame.jsp"%>
	<div id="container" style="margin-left:350px;">
	<h2>Word Training Management</h2>
	<br>
	 
	<div align="left">
		<select id="level">
			<option value="1" ${wordlevel=='1' ? 'selected' : ''}>Level 1</option>
			<option value="2" ${wordlevel=='2' ? 'selected' : ''}>Level 2</option>
			<option value="3" ${wordlevel=='3' ? 'selected' : ''}>Level 3</option>
		</select>
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		<input type="text" id="newWord" placeholder="WORD">
		<input type="text" id="newMeaning" placeholder="MEANING">
		<input type="button" value="ADD" id="addWord">
	</div>
	<br>
		<table border="1" style="text-align:center;">
			<tr>
				<th>No</th>
				<th>Word</th>
				<th>Meaning</th>
				<th>Update</th>
				<th>Delete</th>
			</tr>
			<c:forEach var="w" items="${wordlist}" varStatus="status">
			<tr>
				<td><input type="hidden" value="${w.wordNum}">
				${(navi.currentPage-1)*20+status.count}</td>
				<td><input type="text" name="word" value="${w.word}" readonly="true"></td>
				<td><input type="text" name="mean" value="${w.meaningK}" readonly="true"></td>
				<td><input id="update" type="button" value="UPDATE"></td>
				<td><input id="delete" type="button" value="DELETE"></td>
			</tr>
			</c:forEach>
		</table>
		<br>
		<div id="navigator">
			<a href="goWordManager?page=1&wordlevel=${wordlevel}">◀◀</a>&emsp; 
			<a href="goWordManager?page=${navi.currentPage-1}&wordlevel=${wordlevel}">Prev</a>&emsp;
			
			<c:forEach var="num" begin="${navi.startPageGroup}" end="${navi.endPageGroup}">
				<a href="goWordManager?page=${num}&wordlevel=${wordlevel}">
				<span <c:if test="${navi.currentPage == num}"> style="font-weight:bold;" </c:if>>
				${num}</span></a>&emsp;
			</c:forEach>
			
			<a href="goWordManager?page=${navi.currentPage+1}&wordlevel=${wordlevel}">Next</a>&emsp;
			<a href="goWordManager?page=${navi.totalPageCount}&wordlevel=${wordlevel}">▶▶</a>
		</div>
		<br><br>
	</div>
</body>
<script type="text/javascript">

$(function() {
	
	// 레벨에 따라 단어 출력
	$('#level').change(function() {
		location.href = "${pageContext.request.contextPath}/goWordManager?page=1&wordlevel="+$(this).val();
	});
	
	// 새로운 단어 추가
	$('#addWord').on('click',function(){
		var word = $('#newWord').val();
		var mean = $('#newMeaning').val();
		var sendData = {"word" : word, "meaningK" : mean, "wordlevel" : "${wordlevel}"};
		console.log(sendData);
		
		$.ajax({
			url : 'wordAdd'
			, type : 'post'
			, data : JSON.stringify(sendData)
			, contentType : 'application/json;charset=UTF-8'
			, success : function(resp){
				if(resp == 1){
					alert("Add Completed.");
					location.href = "${pageContext.request.contextPath}/goWordManager?page=${navi.currentPage}&wordlevel=${wordlevel}";
				}else if(resp == 0){
					alert("Add Failed.");
					location.href = "${pageContext.request.contextPath}/goWordManager?page=${navi.currentPage}&wordlevel=${wordlevel}";
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
			var wordNum = tr.children().children('input[type="hidden"]').val();
			var word = tr.children().children('input[name="word"]').val();
			var mean = tr.children().children('input[name="mean"]').val();
			var sendData = {"wordNum" : wordNum, "word" : word, "meaningK" : mean};
			
			$.ajax({
				url : 'wordUpdate'
				, type : 'post'
				, data : JSON.stringify(sendData)
				, contentType : 'application/json;charset=UTF-8'
				, success : function(resp){
					if(resp == 1){
						alert("Update Completed.");
						location.href = "${pageContext.request.contextPath}/goWordManager?page=${navi.currentPage}&wordlevel=${wordlevel}";
					}else if(resp == 0){
						alert("Update Failed.");
						location.href = "${pageContext.request.contextPath}/goWordManager?page=${navi.currentPage}&wordlevel=${wordlevel}";
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
		var wordNum = tr.children().children('input[type="hidden"]').val();
		console.log(wordNum);
		$.ajax({
			url : 'wordDelete'
			, type : 'post'
			, data : {"wordNum" : wordNum}
			, success : function(resp){
				if(resp == 1){
					alert("Delete Completed.");
					location.href = "${pageContext.request.contextPath}/goWordManager?page=${navi.currentPage}&wordlevel=${wordlevel}";
				}else if(resp == 0){
					alert("Delete Failed.");
					location.href = "${pageContext.request.contextPath}/goWordManager?page=${navi.currentPage}&wordlevel=${wordlevel}";
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