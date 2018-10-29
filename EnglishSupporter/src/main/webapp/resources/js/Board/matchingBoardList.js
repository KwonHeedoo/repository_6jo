	$(function(){
		$('#interview').addClass('active');
		
		init();
	});

	function init(){
		var boardType = $('#boardType').val();
		var page = $('#page').val();
		var searchItem = $('#searchItem').val();
		var searchText = $('#searchText').val();
		
		$.ajax({
			url  : 'boardList'
			, type : 'get'
			, data : {'page' : page, 'boardType' : 'matching', 'searchItem' : searchItem, 'searchText' : searchText}
			, success : output
			, error : function(){alert("Error!");}
		});
	}

	// 게시판 출력
	function output(resp){
		var map = resp;
		var boardResult = '';
		var matchingCount = 0;
		// 매칭 된 게시판 카운트
		$.each(map.boardList, function(index, item){
			if(item.matchingId != null){
				matchingCount++;
			}
		});
		boardResult += '<div class="container">';
		boardResult += '<h1>Matching Board</h1>';
		boardResult += '<div class="row justify-content-end">';
		boardResult += '<div id="boardTable">';
		boardResult += '<table border="1">';
		// 게시판 제목부분
		boardResult += '<tr id="boardMenu">';
		boardResult += '<th style="width:5%;">No</th>';
		boardResult += '<th style="width:15%;">TIME</th>';
		boardResult += '<th class="boardTitle" style="width:45%;">TITLE</th>';
		boardResult += '<th style="width:10%;">USER</th>';
		boardResult += '<th style="width:15%;">REGDATE</th>';
		boardResult += '<th style="width:5%;">HITS</th>';
		boardResult += '<th style="width:10%;"><button id="unmatched" onclick="constraint(' + matchingCount + ')">MATCHING</button></th>'; 
		boardResult += '</tr>';
		// 공지글
		if(map.noticeList.length){
			$.each(map.noticeList, function(index, item){
				boardResult += '<tr>';
				boardResult += '<td colspan="2"><span style="color:red;">[공지]</span></td>';
				boardResult += '<td class="boardTitle"><a href="./detailBoard?boardNum=' + item.boardNum + '&boardType=matching&page=' + map.navi.currentPage + '&back=false&searchItem=' + map.searchItem + '&searchText=' + map.searchText + '">' + item.title + '</a></td>';
				boardResult += '<td>' + item.nickname + '</td>';
				boardResult += '<td>' + item.regdate + '</td>';
				boardResult += '<td>' + item.hitcount + '</td>';
				boardResult += '<td><span style="color:red;">[공지]</span></td>';
				boardResult += '</tr>';
			});
		}
		// 게시글
		// 게시판 내용부분 :: 데이터가 없을 경우
		if(!map.boardList.length){
			boardResult += '<tr>';
			boardResult += '<td colspan="7">There is no Board</td>';
			boardResult += '</tr>';
		}
		// 게시판 내용부분 :: 데이터가 있을 경우
		if(map.boardList.length){
			var count = 1;
			$.each(map.boardList, function(index, item){
				boardResult += '<tr>';
				boardResult += '<td>' + (map.navi.totalRecordsCount - map.navi.startRecord - (count - 1)) + '</td>';
				boardResult += '<td>' + item.appointedTime + '</td>';
				boardResult += '<td class="boardTitle"><a href="./detailBoard?boardNum=' + item.boardNum + '&boardType=matching&page=' + map.navi.currentPage + '&back=false&searchItem=' + map.searchItem + '&searchText=' + map.searchText + '">' + item.title + '</a></td>';
				boardResult += '<td>' + item.nickname + '</td>';
				boardResult += '<td>' + item.regdate + '</td>';
				boardResult += '<td>' + item.hitcount + '</td>';
				boardResult += '<td>';
				if(item.matchingId == null){
					boardResult += '<img alt="possible" src="./resources/images/icons/silver.png">';
				}else{
					boardResult += '<img alt="possible" src="./resources/images/icons/golden.png">';
				}
				boardResult += '</td>';
				boardResult += '</tr>';
				count++;
			});
		}
		boardResult += '</table>';
		boardResult += '</div>';// boardTable
		boardResult += '</div>';//row justify-content-end
		boardResult += '</div>';// container
		// 페이징
		boardResult += '<div id="page" align="center">';
		if(map.boardList.length){
			var i = 1;
			boardResult += '<a onclick="selectPage('+ 1 + ', \'' + map.searchItem + '\', \'' + map.searchText + '\')">◀◀</a>&emsp;'; 
			boardResult += '<a onclick="selectPage('+ (map.navi.currentPage - 1) + ', \'' + map.searchItem + '\', \'' + map.searchText + '\')">Prev</a>&emsp;';
			for(var i = map.navi.startPageGroup; i <= map.navi.endPageGroup; i++){
				boardResult += '<a onclick="selectPage('+ i + ', \'' + map.searchItem + '\', \'' + map.searchText + '\')">';
				if(map.navi.currentPage == i){
					boardResult += '<span style="font-size:12pt; font-weight:bold;">' + i + '&emsp;</span></a>';
				}else{
					boardResult += '<span>' + i + '&emsp;</span></a>';
				}
			}
			boardResult += '<a onclick="selectPage('+ (map.navi.currentPage + 1) + ', \'' + map.searchItem + '\', \'' + map.searchText + '\')">Next</a>&emsp;'; 
			boardResult += '<a onclick="selectPage('+ map.navi.totalPageCount + ', \'' + map.searchItem + '\', \'' + map.searchText + '\')">▶▶</a>';
			// 게시판 검색 기능
			boardResult += '<div class="container">';
			boardResult += '<form id="searchBox" action="boardList" method="get">';
			boardResult += '<input type="hidden" name="boardType" value="matching">';
			//boardResult += '<div class="col-md-3">';
			boardResult += '<select id="selectItemBox" name="searchItem">';
			if(map.searchItem === 'title'){
				boardResult += '<option value="title" selected="selected">Title</option>';
				boardResult += '<option value="nickname">User</option>';
				boardResult += '<option value="contents">Contents</option>';
			}else if(map.searchItem === 'userid'){
				boardResult += '<option value="title">Title</option>';
				boardResult += '<option value="nickname" selected="selected">User</option>';
				boardResult += '<option value="contents">Contents</option>';
			}else{
				boardResult += '<option value="title">Title</option>';
				boardResult += '<option value="nickname">User</option>';
				boardResult += '<option value="contents" selected="selected">Contents</option>';
			}
			boardResult += '</select>';
			//boardResult += '</div>';//col-md-1
			//boardResult += '<div class="col-md-3">';
			boardResult += '<input id="searchTextBox" type="text" name="searchText" value="' + map.searchText + '">';
			//boardResult += '</div>';//col-md-3
			//boardResult += '<div class="col-md-3">';
			boardResult += '<input id="search" type="button" value="Search">';
			//boardResult += '</div>';//col-md-1
			boardResult += '</form>';
		}
		boardResult += '</div><br>';//page
		boardResult += '<a href="./writeBoardForm?page=' + map.navi.currentPage + '&boardType=matching"><button class="btn">Write Board</button></a>';
		boardResult += '</div><br><br>';//container
		
		$('#boardResult').html(boardResult);
		$('#search').click(search);
	}

	// 페이지 이동
	function selectPage(page, searchItem, searchText){
		$.ajax({
			url  : 'boardList'
			, type : 'get'
			, data : {'page' : page, 'boardType' : 'matching', 'searchItem' : searchItem, 'searchText' : searchText}
			, success : output
			, error : function(){alert("Error!");}
		});
	}

	// 키워드로 게시물 찾기
	function search(){
		var searchItem = $('#selectItemBox').val();
		var searchText = $('#searchTextBox').val();
		$.ajax({
			url  : 'boardList'
			, type : 'get'
			, data : {'boardType' : 'matching', 'searchItem' : searchItem, 'searchText' : searchText}
			, success : output
			, error : function(){alert("Error!");}
		});
	}

	// 매칭 안된 게시글 찾기
	function constraint(matchingCount){
		// 전체 게시글
		if(matchingCount === 0){
			$.ajax({
				url  : 'boardList'
				, type : 'get'
				, data : {'boardType' : 'matching'}
				, success : output
				, error : function(){alert("Error!");}
			});
		// 매칭 안된 게시글
		}else{
			$.ajax({
				url  : 'boardList'
				, type : 'get'
				, data : {'boardType' : 'matching', 'constraint' : 'unmatched'}
				, success : output
				, error : function(){alert("Error!");}
			});
		}
	}	
