<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="utf-8">
<style type="text/css">
table, th, td {
    border-style: solid;
    border-width: 1px;
    border-color: #7F7F7F;
}
.fc-today{
background-color: #d9edf7;
}
</style>
<script>
var today = new Date(); //오늘날짜 생성 
	today = today.toISOString();
	today = today.substring(0,10);
var userid = '${sessionScope.loginId}';

$(document).ready(function() {

	  $('#calendar').fullCalendar({
          themeSystem: 'bootstrap3',
          header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay,listMonth'
          },
          defaultDate: today,
          height: 680,
          //weekNumbers: true,
          //weekNumberTitle : 'weeks',
          navLinks: true, // can click day/week names to navigate views
          editable: true,
          eventLimit: true, // allow "more" link when too many events          
          dayClick: function(date, jsEvent, view, resourceObj) { // 클릭 이벤트 
        	$('#start').val(date.format('YYYY-MM-DD'))
  			$('#shour').val(date.format('HH'))
  			$('#smin').val(date.format('mm'))
  			$('#end').val(date.format('YYYY-MM-DD'))
  			$('#ehour').val(date.format('HH'))
  			$('#emin').val(date.format('mm'))
  			$('#title').val("");
        	$('#writeModal').modal('show');
 			// 자식창에서 값 받아서 캘린더 재시작하기 
      	  },
      	  eventClick: function(event, element) { // 일정 클릭 이벤트
      		$('#viewModalBody').text(event.title);
        	$('#id').val(event.id);
        	$('#eventDate').text(event.start.format('YYYY년 MM월 DD일 HH:mm'));
        	if( event.end != null && (event.start.format('YYYY년 MM월 DD일 HH:mm') != event.end.format('YYYY년 MM월 DD일 HH:mm')) ){
        		$('#eventDate').text($('#eventDate').text() + ' ~ ' + event.end.format('YYYY년 MM월 DD일 HH:mm'));
        	}
        	$('#viewModal').modal('show')
      	  	// 수정창에서 DB 수정/삭제시  캘린더 재시작하기 
      	  },
          events: function(start, end ,timezone, callback) {
        	 
        	  console.log(userid);
        	  $.ajax({
        	        method:'post',
        	        url: 'getschedule',
        	        data:{'userid':userid},
        	        success: function(doc) {
        	        	//console.log(doc);
        	          var events = [];
        	          $.each(doc,function() {
        	        	var obj = {
               	             title: $(this).attr('title'),
            	             start: $(this).attr('startDate'), // will be parsed
            	             id : $(this).attr('s_id')      
            	            };
        	        	console.log($(this).attr('allDay'));
        	            if(($(this).attr('allDay'))=='true'){
        	            	console.log('true일때드러옴..');
	        	         	obj.allDay= true;
        	            }
            	        if($(this).attr('endDate')!=null){
            	        	obj.end = $(this).attr('endDate');
            	        }  // if end 날짜가  null이면 어캄?...?...
        	            console.log('obj');
        	            console.log(obj);
        	        	events.push(obj);
        	          });        
        	          console.log(events);
        	          callback(events);      
        	        }
        	      });
        	    }
        });
        // 저장버튼 클릭이벤트 
    $('#saveBtn').click(function(){
    	var start = $('#start').val()
		var end = $('#end').val();
    	var title = $('#title').val();
    	if(title==""){
    		alert('일정의 제목이 입력되지 않았습니다.');
    		return;
    	}
		if(!$('#allDay').is(":checked")){
			start += " " + $('#shour').val() + ":" + $('#smin').val();
			end += " " + $('#ehour').val() + ":" + $('#emin').val();
		}else{
			end = moment($('#end').val()).add(1,'days').format('YYYY-MM-DD');
		}
    	var schedule = {'userid':userid,'startDate': start, 'endDate': (end == start) ? null : end, 'title': title , 'allDay' : $('#allDay').is(":checked")};
    	var scheduleview = {'start': start, 'end': (end == start) ? null : end, 'title': title , 'allDay' : $('#allDay').is(":checked")}  
    	$.ajax({
  	        method:'post',
  	        url: 'saveMyschedule',
  	        data: schedule,
  	        success: function(doc) {
  	        	console.log(doc);
  	        }
  	      });
    	  //$('#calendar').fullCalendar( 'refetchEvents' );
    	  $('#calendar').fullCalendar('renderEvent',scheduleview, true);
    	  $('#writeModal').modal('hide'); // 마지막으로 모달 창 지우기 
    });
        //수정버튼 클릭이벤트  해말어~~
     
        //삭제버튼 클릭 이벤트 
        $('#deleteBtn').click(function(){
		if(confirm("Do you really want to Delete?")){// 컨핌 창이 true 일 경우에만 들어옴!
			var id = $('#id').val();
			$('#calendar').fullCalendar( 'removeEvents' , $('#id').val());
	    	  $.ajax({
	    	        method:'post',
	    	        url: 'deleteMyschedule',
	    	        data: {'id':id},
	    	        success: function(doc) {
	    	        	console.log(doc);
	    	        }
	    	});
	    	 // $('#calendar').fullCalendar( 'refetchEvents' );
	    	  $('#viewModal').modal('hide');
		}
        });

  });
    

</script>
<style>
table,th,td{
    border-style: solid;
    border-width: 1px;
    border-color: #7F7F7F
}

  #top,
  #calendar.fc-unthemed {
    font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
  }

  body {
    margin: 0;
    padding: 0;
    font-size: 14px;
  }

  .left { float: left }
  .right { float: right }
  .clear { clear: both }

  #calendar {
    max-width: 1200px;
    margin: 40px auto;
    padding: 0 10px;
    height: 90%;
  }

</style>
<body>
<!-- 캘린더가 들어갈 div -->
<div id='calendar'></div>
<!-- Event View Modal -->
<div class="modal fade" id="viewModal" tabindex="-1" role="dialog" aria-labelledby="viewModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="viewModalLabel">
        	<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span> <span id="eventDate"></span><br>
        	<input type="hidden" id="id"/>
        </h4>
      </div>
      <div class="modal-body" id="viewModalBody">
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-warning" id="deleteBtn">Delete</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<!-- Event Write Modal -->
<div class="modal fade" id="writeModal" tabindex="-1" role="dialog" aria-labelledby="writeModalLabel" style="padding: 0;">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">
        	Add Schedule
        </h4>
      </div>
      <div class="modal-body">
	    <label class="sr-only" for="title">title</label>
	    <div class="input-group">
	      <input type="text" class="form-control" id="title" placeholder="title">
	    </div>
	    <br>
	    <div class="input-group">
	      <input type="checkbox" id="allDay" value="allDay"><label for="allDay" style="vertical-align: middle">All DAY</label>
	    </div>
		<br>
	    <div class="form-inline">
		    <label class="sr-only" for="start">start</label>
		    <div class="input-group">
		      <input type="text" class="form-control" id="start" placeholder="start">
		    </div>
		    <label class="sr-only" for="shour">shour</label>
		    <div class="input-group">
		      <select id="shour" class="form-control">
		      	<option value="00">00
		      	<option value="01">01
		      	<option value="02">02
		      	<option value="03">03
		      	<option value="04">04
		      	<option value="05">05
		      	<option value="06">06
		      	<option value="07">07
		      	<option value="08">08
		      	<option value="09">09
		      	<option value="10">10
		      	<option value="11">11
		      	<option value="12">12
		      	<option value="13">13
		      	<option value="14">14
		      	<option value="15">15
		      	<option value="16">16
		      	<option value="17">17
		      	<option value="18">18
		      	<option value="19">19
		      	<option value="20">20
		      	<option value="21">21
		      	<option value="22">22
		      	<option value="23">23
		      </select>
		    </div>
		    <label class="sr-only" for="smin">smin</label>
		    <div class="input-group">
		      <select id="smin" class="form-control">
		      	<option value="00">00
		      	<option value="15">15
		      	<option value="30">30
		      	<option value="45">45
		      </select>
		    </div>
	    </div>
	    <br>
	    <div class="form-inline">
		    <label class="sr-only" for="end">end</label>
		    <div class="input-group">
		      <input type="text" class="form-control" id="end" placeholder="end">
		    </div>
		    <label class="sr-only" for="ehour">ehour</label>
	    	<div class="input-group">
		      <select id="ehour" class="form-control">
		      	<option value="00">00
		      	<option value="01">01
		      	<option value="02">02
		      	<option value="03">03
		      	<option value="04">04
		      	<option value="05">05
		      	<option value="06">06
		      	<option value="07">07
		      	<option value="08">08
		      	<option value="09">09
		      	<option value="10">10
		      	<option value="11">11
		      	<option value="12">12
		      	<option value="13">13
		      	<option value="14">14
		      	<option value="15">15
		      	<option value="16">16
		      	<option value="17">17
		      	<option value="18">18
		      	<option value="19">19
		      	<option value="20">20
		      	<option value="21">21
		      	<option value="22">22
		      	<option value="23">23
		      </select>
		    </div>
		    <label class="sr-only" for="emin">emin</label>
		    <div class="input-group">
		      <select id="emin" class="form-control">
		      	<option value="00">00
		      	<option value="15">15
		      	<option value="30">30
		      	<option value="45">45
		      </select>
		    </div>
      </div>
      <br>
      <div class="modal-footer">
      	<button type="button" class="btn btn-warning" id="saveBtn">Save</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
</div>
</body>
</html>