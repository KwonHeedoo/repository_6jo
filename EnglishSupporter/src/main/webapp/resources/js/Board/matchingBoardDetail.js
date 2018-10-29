
$(function(){	
	$('#interview').addClass('active');
	init();
});

// ajax로 전체 comment를 끌어옴
function init() {
	$('.comments').val("");
	var boardNum = $('#boardNum').val();
	
	$.ajax({
		url  : 'commentList'
		, type : 'get'
		, data : {'boardNum' : boardNum, 'boardType' : 'matching'}
		, success : output
		, error : function(){alert("Error!");}
	});
}

// 가져온 전체 comment를 html에 뿌리기
function output(resp){
	var loginId = $('#loginId').val();
	var loginType = $('#loginType').val();
	var commentList = resp;
	var commentResult = '';
	var parentGroup = 0;
	var matchingCount = 0;
	
	
	$.each(commentList, function(index, item){
		if(item.matchingId != null){
			matchingCount++;
		}
	});
	
	commentResult += '<div class="container">';
	commentResult += '<div class="row reples">';
	commentResult += '<div>';
	commentResult += '<h2 class="page-header">Comments</h2>';
	commentResult += '<div class="writeComment">';
	commentResult += '<div><input id="comment" class="comments" type="text" placeholder="댓글 내용" />';
	commentResult += '&ensp;<input id="insertComment" type="button" value="댓글 추가" /></div><br>';
	commentResult += '</div>';// writeComment
	commentResult += '<section class="comment-list">';
	$.each(commentList, function(index, item){
		if(item.parentId == null){
			parentGroup = item.groupNum;
		}
		commentResult += '<article class="row">';
		if(item.parentId == null){
			commentResult += '<div class="col-md-2 col-sm-2 hidden-xs">';
		}else{
			commentResult += '<div class="col-md-2 col-sm-2 col-md-offset-1 col-sm-offset-0 hidden-xs">';
		}
		commentResult += '<figure class="thumbnail">'; 
		commentResult += '<figcaption class="text-center">' + item.nickname + '</figcaption>'
		commentResult += '</figure>';//thumbnail
		if(item.imgFilePath == null){
			commentResult += '<img class="img-responsive" src="./resources/images/icons/user-avatar-placeholder.png" />';
		}else if(item.imgFilePath != null && item.nickname == '*****'){
			commentResult += '<img class="img-responsive" src="./resources/images/icons/user-avatar-placeholder.png" />';
		}else if(item.imgFilePath != null && item.nickname != '*****'){
			commentResult += '<img class="img-responsive" src="./getProfileImg?userid=' + item.userid + '" />';
		}
		commentResult += '</div>';//col-md-2 col-sm-2 hidden-xs | col-md-2 col-sm-2 col-md-offset-1 col-sm-offset-0 hidden-xs 
		if(item.parentId == null){
			commentResult += '<div class="col-md-10 col-sm-10">';
		}else{
			commentResult += '<div class="col-md-9 col-sm-9">';
		}
		commentResult += '<div class="panel panel-default arrow left">';
		commentResult += '<div class="panel-body">';
		commentResult += '<header class="text-left">';
		commentResult += '<div class="comment-user">';
		if(item.parentId == null && item.nickname != '*****'){
			commentResult += '<i class="fa fa-user"></i>Comment'
		}else if(item.parentId != null && item.nickname != '*****'){
			commentResult += '<i class="fa fa-user"></i>' + item.parentNick;
		}
		if(item.nickname != '*****'){
			commentResult += '<button class="text-right" onclick="matching(\'' + item.userid + '\', ' + matchingCount + ', ' + item.commentNum + ')" style="border:none; background-color:white;">';
			if(item.matchingId == null){
				commentResult += '<img id="match' + item.commentNum + '" alt="match" src="./resources/images/icons/silver.png">';
			}else{
				commentResult += '<img id="match' + item.commentNum + '" alt="match" src="./resources/images/icons/golden.png">';
			}
			commentResult += '</button>';
		}
		if(item.parentId == null && item.nickname != '*****'){
			commentResult += '<span style="float:right"><button id ="report' + item.commentNum + '" style="font-size:x-small; border:none; background-color:white; color:red;">신고</button></span>';
			$(function(){
				$('#report' + item.commentNum).on('click',function(){
					report(item.userid, item.comments);
				});
			});
		}else if(item.parentId != null && item.nickname != '*****'){
			commentResult += '<span style="float:right"><button id ="report' + item.commentNum + '" style="font-size:x-small; border:none; background-color:white; color:red;">신고</button></span>';
			$(function(){
				$('#report' + item.commentNum).on('click',function(){
					report(item.userid, item.comments);
				});
			});
		}
		commentResult += '</div>';//comment-user
		commentResult += '<time class="comment-date" datetime="' + item.regdate + '">';//
		commentResult += '<i class="fa fa-clock-o"></i>' + item.regdate;
		commentResult += '</time>';//comment-date
		commentResult += '</header>';//text-left
		commentResult += '<div class="comment-post">';
		commentResult += '<p class="comment-text"><input id="cmt'+ item.commentNum +'" value="' + item.comments + '" disabled="true" style="border:0px; background-color:white; width: 100%;" /></p>';
		commentResult += '</div>';//comment-post
		commentResult += '<p class="text-right">';
		if(loginId === item.userid){
			commentResult += '<button class="btn2 btn-sm btn-default" id="update' + item.commentNum + '" onclick="modifyComment(' + item.commentNum + ')">Modify</button>';
		}
		if(loginId === item.userid || loginType === 'admin'){
			commentResult += '<button class="btn2 btn-sm btn-default" onclick="deleteComment('+ item.commentNum + ', ' + item.groupNum +')">Delete</button>';
		}
		if(item.parentId == null && item.nickname != '*****'){
			commentResult += '<button class="btn2 btn-sm btn-default" onclick="reply(\'' + item.userid + '\', \'' + item.nickname + '\', ' + item.groupNum + ', ' + item.commentNum + ', this)"><i class="fa fa-reply"></i> Reply</button>';
		}else if(item.parentId != null && item.nickname != '*****'){
			commentResult += '<button class="btn2 btn-sm btn-default" onclick="reply(\'' + item.userid + '\', \'' + item.nickname + '\', ' + parentGroup + ', ' + item.commentNum + ', this)"><i class="fa fa-reply"></i> Reply</button>';
		}else{
			commentResult += '<br /><br />';
		}
		commentResult += '</p>';//text-right
		commentResult += '</div>';//panel-body
		commentResult += '</div>';//panel panel-default arrow left
		commentResult += '</div>';//col-md-10 col-sm-10 | col-md-9 col-sm-9
		commentResult += '</article>';//row
		commentResult += '<br><div id="reply' + item.commentNum + '"></div><br>';
	});
	commentResult += '</section>';//comment-list
	commentResult += '</div>';//col-md-8
	commentResult += '</div>';//row
	commentResult += '</div>';//container
	
	
	$('#commentResult').html(commentResult);
	$('#insertComment').click(insertComment);
}

// 댓글 삭제
function deleteComment(commentNum, groupNum) {
	//확인
	if (confirm("Are you Sure??") == true){
		$.ajax({
			url  : 'deleteComment'
			, type : 'get'
			, data : {'commentNum' : commentNum, 'groupNum' : groupNum, 'boardType' : 'matching'}
			, success : init
			, error : function(){alert("Error!");}
		});
	//취소
	}else{
	    return;
	}
}

// 댓글수정
function modifyComment(commentNum) {
	$('#cmt' + commentNum).attr('disabled', false);
	$('#cmt' + commentNum).css('border', '1px solid');
	$('#cmt' + commentNum).css('width', '100%');
	document.getElementById('cmt' + commentNum).focus();
	
	$('#update' + commentNum).on('click', update);
			
	function update(){
		var userid = $('#loginId').val();
		var nickname = $('loginNick').val();
		var comments = $('#cmt' + commentNum).val();
		
		$.ajax({
			url  : 'updateComment'
			, type : 'post'
			, data : {'commentNum' : commentNum, 'userid' : userid, 'nickname' : nickname
					 ,'comments' : comments, 'boardType' : 'matching'}
			, success : function(){
				init();
			}
			, error : function(){alert("Error!");}
		});
	 
	}
}

// 댓글 삽입
function insertComment() {
	var boardNum = $('#boardNum').val();
	var userid = $('#loginId').val();
	var nickname = $('#loginNick').val();
	var comments = $('.comments').val();
	
	if(comments.length == 0) {
		alert("Please Write Your Comment");
		return ;
	}
	
	$.ajax({
		url  : 'insertComment'
		, type : 'post'
		, data : {'userid' : userid, 'nickname' : nickname, 'boardNum' : boardNum
				 , 'comments' : comments, 'boardType' : 'matching'}
		, success : init
		, error : function(){alert("Error!");}
	});
}

//reply 달기
function reply(parentId, parentNick, groupNum, commentNum, btn){
	var reply = '';
	reply += '<span class="parentNick">To.' + parentNick+'</span>';
	reply += '&emsp;<input id="replybox" type="text" />&emsp;';
	reply += '<button id="sendReply">Send</button><br>';
	$('#reply' + commentNum).append(reply);
	$(this).html('Cancel');
	
	btn.onclick = function(){
		$('#reply' + commentNum).remove();
		init();
	};
	
	$('#sendReply').on('click', function(){
		var boardNum = $('#boardNum').val();
		var comments = $('#replybox').val();
		var userid = $('#loginId').val();
		var nickname = $('#loginNick').val();

		$.ajax({
			url : 'insertComment'
			, type : 'post'
			, data : {'userid' : userid
					  , 'nickname' : nickname
					  , 'boardNum' : boardNum
					  , 'comments' : comments
					  , 'parentId' : parentId
					  , 'parentNick' : parentNick
					  , 'groupNum' : groupNum
					  , 'reply' : 'reply'
					  , 'boardType' : 'matching'}
			, success : init
			, error : function(){alert("Error!");} 
		});
	});
}

//matching ID 선택
function matching(matchingId, matchingCount, commentNum){
	var userid = $('#userid').val();
	var loginId = $('#loginId').val();
	var boardNum = $('#boardNum').val();
	var appointedTime = $('#appointedTime').val();
	var check = $('#match' + commentNum).attr('src');
	
	if(userid === loginId && matchingCount <= 1){
		// 이미 매칭이 되어있는 경우 매칭 취소
		if(check.includes('golden') && matchingCount === 1){
			//확인
			if (confirm("Are you Sure??") == true){
				$.ajax({
					url : 'unmatching'
					, type : 'post'
					, data : {'boardNum' : boardNum, 'userid' : userid, 'matchingId' : matchingId
							 , 'appointedTime' : appointedTime, 'boardType' : 'matching', 'commentNum' : commentNum}
					, success : function(resp){
						if(resp == 1){
							$('#match' + commentNum).attr('src', './resources/images/icons/silver.png');
							init();
						}
					}
					, error : function(){alert('Error!');}
				});
			//취소
			}else{
			    return;
			}
		}else if(matchingCount === 0 && matchingId !== loginId){
			//확인
			if (confirm("Are you Sure??") == true){
				// 매칭
				$.ajax({
					url : 'matching'
					, type : 'post'
					, data : {'boardNum' : boardNum, 'userid' : userid, 'matchingId' : matchingId
							 , 'appointedTime' : appointedTime, 'boardType' : 'matching', 'commentNum' : commentNum}
					, success : function(resp){
						if(resp == 1){
							$('#match' + commentNum).attr('src', './resources/images/icons/golden.png');
							init();
						}
					}
					, error : function(){alert('Error!');}
				});
			//취소
			}else{
			    return;
			}
		}
	}
}

// 게시물 삭제 확인
function checkDel(){
	//확인
	if (confirm("Are you Sure??") == true){
		return true;
	//취소
	}else{
	    return false;
	}
}

//신고 페이지 오픈 및 데이터 값 보내기
function report(reportee, report){
	var reporter = $('#loginId').val();
	var boardNum = $('#boardNum').val();
	var page = $('#page').val();
	var searchItem = $('#searchItem').val();
	var searchText = $('#searchText').val();
	
	var form = document.createElement('form');
	form.setAttribute('method', 'post');
	form.setAttribute('action', 'goReportBox');
	form.setAttribute('target', 'ReportBox');
	
	input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'reporter';
	input.value = reporter;
	form.appendChild(input);

	input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'reportee';
	input.value = reportee;
	form.appendChild(input);
	
	input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'report';
	input.value = report;
	form.appendChild(input);
	
	input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'page';
	input.value = page;
	form.appendChild(input);
	
	input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'boardNum';
	input.value = boardNum;
	form.appendChild(input);
	
	input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'boardType';
	input.value = 'matching';
	form.appendChild(input);
	
	input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'searchItem';
	input.value = searchItem;
	form.appendChild(input);
	
	input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'searchText';
	input.value = searchText;
	form.appendChild(input);
	
	document.body.appendChild(form);
	
	window.open('', 'ReportBox', 'width=450, height=585, location=no, toolbar=no, menubar=no, scrollbars=no, resizable=no');
	
	form.submit();
	
	document.body.removeChild(form); // 만든 폼을 삭제한다. 
}	
