<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="utf-8">
<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
<link href="resources/fullcalendar/fullcalendar.min.css" rel="stylesheet">
<link href="resources/fullcalendar/fullcalendar.print.min.css" rel="stylesheet" media="print">
<script src="resources/fullcalendar/lib/moment.min.js"></script>
<script src="resources/fullcalendar/lib/jquery.min.js"></script>
<script src="resources/fullcalendar/fullcalendar.min.js"></script>
<script src="resources/fullcalendar/theme-chooser.js"></script>
<script>
var dbevents=[];
var today = new Date(); //오늘날짜 생성 
	today = today.toISOString();
	today = today.substring(0,10);
// event Db에서 끌어오기 
$(function() {
	var userid = '${sessionScope.loginId}';
	$.ajax({
		method:'post',
		url:'getschedule',
		data:{'userid':userid},
		dateType : 'json',
		success :function(data){
			dbevents = data;
		}
	});
});

// 이벤트 수정 창 띄우기

// 날짜 클릭시 이벤트 생성 하기 



  $(document).ready(function() {

    initThemeChooser({

      init: function(themeSystem) {
        $('#calendar').fullCalendar({
          themeSystem: themeSystem,
          header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay,listMonth'
          },
          defaultDate: today,
          weekNumbers: true,
          navLinks: true, // can click day/week names to navigate views
          editable: true,
          eventLimit: true, // allow "more" link when too many events
          dayClick: function(date, jsEvent, view, resourceObj) { // 클릭 이벤트 
      	    alert('Date: ' + date.format());
          	var link = "./makeMyschedule?date="+date.format();
      	  	window.open(link, "Schedule", "width=400, height=400, location=no, toolbar=no, menubar=no, scrollbars=no, resizable=no");

          //alert('Resource ID: ' + resourceObj.id);
          // 일단 입력받아서 달력에 띄우고  ajax로 Db에 보낸다 ?
      	    var newEvent = {
      	    	title:'event@@', 	
      	    	start: date.format(),
      	    	allDay : true,
      	    	stick : true
      	    };
	      	  $('#calendar').fullCalendar('renderEvent', newEvent);
      	  },
      	  eventClick: function(event, element) { // 일정 클릭 이벤트 
			// 새창을 띄워서 id 값으로 db에서 이벤트 상세 받아서 출력하기 
      	    event.title = "CLICKED!";

      	    $('#calendar').fullCalendar('updateEvent', event);

      	  },
          events: [ // 이벤트 띄우는 부분   이벤트를 ajax로 띄워서 가져온 후 출력하는 메소드를 사용할것인가?
            {
              title: 'All Day Event',
              start: '2018-09-01'
            },
            {
              title: 'Long Event',
              start: '2018-09-07',
              end: '2018-03-10'
            },
            {
              id: 999,
              title: 'Repeating Event',
              start: '2018-03-09T16:00:00'
            },
            {
              id: 999,
              title: 'Repeating Event',
              start: '2018-03-16T16:00:00'
            },
            {
              title: 'Conference',
              start: '2018-03-11',
              end: '2018-03-13'
            },
            {
              title: 'Meeting',
              start: '2018-03-12T10:30:00',
              end: '2018-03-12T12:30:00'
            },
            {
              title: 'Lunch',
              start: '2018-03-12T12:00:00'
            },
            {
              title: 'Meeting',
              start: '2018-03-12T14:30:00'
            },
            {
              title: 'Happy Hour',
              start: '2018-03-12T17:30:00'
            },
            {
              title: 'Dinner',
              start: '2018-03-12T20:00:00'
            },
            {
              title: 'Birthday Party',
              start: '2018-03-13T07:00:00'
            },
            {
              title: 'Click for Google',
              url: 'http://google.com/',
              start: '2018-03-28'
            }
          ]
          
        });
        
      },

      change: function(themeSystem) {
        $('#calendar').fullCalendar('option', 'themeSystem', themeSystem);
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
    max-width: 900px;
    margin: 40px auto;
    padding: 0 10px;
  }

</style>
<body>

<div id='calendar'></div>

</body>
<script type="text/javascript">
$(function() {

	
});

</script>
</html>