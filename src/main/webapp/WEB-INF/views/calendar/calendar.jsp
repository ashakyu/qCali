<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<style>
div.fc-event-title.fc-sticky{
 text-align : right;
}
</style>
<meta charset='utf-8' />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- fullcalendar CDN -->
<link
	href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css'
	rel='stylesheet' />
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<!-- fullcalendar 언어 CDN -->
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
<!-- moment -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.0/moment.min.js"
	type="text/javascript"></script>


<script>

  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      headerToolbar: {
        left: 'prev,next today',
        center: 'title'
      },
//       navLinks: true, 
//       selectable: true,
      selectMirror: true,

      eventClick: function(arg) {
    	  
		var start = moment(arg.event.start).format('YYMMDD');
		console.log(moment(start).format('YYMMDD'));
		$.ajax({
			type : 'POST',
			url : '<c:url value="/board/listDay" />',
			dataType:'text',
			data : 'date='+start,
			async:false,
			success:function(data){
				window.location.href='<c:url value="/board/listDay?date=" />'+data;
			}
		
		})
      },
      dayMaxEvents: true,
      events:
	[
	<c:forEach var="list" items= "${listCal}">
			{
				title:'+'+${list.getCount()}+'개',
				start:'${list.getCalendarDay()}', 
				backgroundColor : "#ffffff", 
                textColor : "#2a5555",
                borderColor : "#2a5555",
			},
	</c:forEach>
	]
    });
    calendar.render();
  });
</script>

<style>
#calendar-body {
	margin: 5%;
	padding: 0;
	font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
	font-size: 10px;
}

#calendar {
	max-width: 100%;
	margin: 0 auto;
	width:100%;
	height: 500px
}
#fc-header-toolbar fc-toolbar fc-toolbar-ltr{
	font-size: .9em;
}
</style>
</head>
<body>
<div id='calendar-body'>
	<div class='calendar-parent'>
		<div id='calendar'></div>
	</div>
</div>
</body>
</html>
