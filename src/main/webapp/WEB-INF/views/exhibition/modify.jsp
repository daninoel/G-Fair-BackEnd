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
        <title>/anony/MODIFY.jsp</title>

        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js" referrerpolicy="no-referrer"></script>

        
        <link rel="stylesheet" href="../resources/css/boardBasic.css">
        <script>
            $(function(){
    
                $('#exListBtn').on('click',function(){
    
                    location.href = "/exhibition/list?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";
    
                });//regBtn
                
                $('#removeBtn').on('click',function(){
                    $('form').attr('action','/exhibition/remove').attr('method','POST').submit();
                                
                });//removeBtn
       
      // -----------------------------------------------------------------------------------
            
            })//.jq
        </script>
        
    </head>
    <body>
        <h1>WEB-INF/views/exhibition/modify.jsp</h1>
        
        <hr>

        <div id="anonyWrapper">
            <form action="/exhibition/modify" method="POST">
                <h2>전시회일정</h2>
                <input type="hidden" name="currPage" value=${cri.currPage}>
                <input type="hidden" name="amount" value=${cri.amount}>
                <input type="hidden" name="pagesPerPage" value=${cri.pagesPerPage}>

                <input type="hidden" name="exno" value=${schedule.exno}>
                <table>
                    <tbody>
                        <tr>
                            <th>전시명</th>
                            <td><input type="text" name="exname" value="${schedule.exname}" required></td>
                        </tr>
                        <tr>
                            <th>전시시작일</th>
                            <td><input type="date" name="exstart" value="${schedule.exstart}" required></td>
                        </tr>
                        <tr>
                            <th>전시마감일</th>
                            <td><input type="date" name="exend" value="${schedule.exend}" required></td>
                        </tr>
                        <tr>
                            <th>전시내용</th>
                            <td><textarea name="excontent"cols="30" rows="10" value="${schedule.excontent}" required>${schedule.excontent}</textarea></td>
                        </tr>
                    </tbody>
                </table>
                                
                <button type="submit" class="buttonstyle" id="modifyBtn">수정</button>
                
                <button type="button" class="buttonstyle" id="removeBtn">삭제</button>
                
                <button type="button" class="buttonstyle" id="listBtn">목록</button>
            </form>
        </div>
    </body>
</html>