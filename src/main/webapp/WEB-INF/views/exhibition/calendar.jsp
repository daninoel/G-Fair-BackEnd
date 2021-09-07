<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!DOCTYPE html>


<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        

        <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.js"></script>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.min.css">

        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js" referrerpolicy="no-referrer"></script>
	

<!-- 초기화코드-------------------------------------------------- -->
        <script>

        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');


            var calendar = new FullCalendar.Calendar(calendarEl, {
                
                // initialView: 'dayGridMonth',

                // 아래부터 추가
                headerToolbar: {
                     left: 'prevYear,prev',
                     center: 'title',
                     right: 'today,next,nextYear'
                
                }, // buttons for switching between views

                //일정 클릭시 이벤트...
                eventClick:function(){
                    
                },
                
                // eventLimit:true,
                dayMaxEventRows:true,
                views:{
                    dayMacEventRows: 3
                },
                events: getCalendarDataInDB()

            });//FullCalendar

            calendar.render();
        });//addEventListener
      
        var data = [];
        // 화면에 db일정 뿌려줌
        function getCalendarDataInDB(){
            console.log("getCalendarDataInDB() invoked");

            $.ajax({
                contentType: 'application/x-www-form-urlencoded; charset=utf8',
                dataType: 'json',
                url: '/exhibition/calendar',
                type: 'POST',
                async: false,
                success: function(result){
                    
                    console.log(result);
                    
                    data = result;
                }//success
                
            })//ajax
            return data;
        }//getCalendarDataInDB
        
  
        $(function(){
            $('#exRegBtn').on('click',function(){
                window.open("/exhibition/calRegister","tst","width=400, height=400, toolbar=no, menubar=no,scrollbars=no,resizable=yes");
            })//exRegBtn

            $('#exListBtn').on('click',function(){
                location.href = "/exhibition/list";
            })//exListBtn

        })//.jq

        
        </script>
    </head>
    <body>
        <div id='calendar'></div>
        <button type="button" id="exRegBtn">일정등록</button>
        <button type="button" id="exListBtn">일정관리게시판</button>
        <c:if test="">
        </c:if>
    </body>
</html>