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
        <title>/anony/get.jsp</title>
		
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js" referrerpolicy="no-referrer"></script>

        <!-- &uploadPath=${fileDTO.uploadPath}&uuid=${fileDTO.uuid}&fileName=${fileDTO.fileName} -->
        <link rel="stylesheet" href="../resources/css/boardBasic.css">
        <link rel="stylesheet" href="../resources/css/replyBasic.css">

        <script>
            $(function(){
                //일정등록
                $('#exRegBtn').on('click',function(){
                    
                    location.href = "/exhibition/register?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";

                });//regBtn

                //수정하기
                $('#exModifyBtn').on('click',function() {

                    location.href = "/exhibition/modify?exno=${schedule.exno}&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";

                })//modifyBtn

                //목록보기
                $('#exListBtn').on('click',function(){
 
                    location.href = "/exhibition/list?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";

                });//listBtn

            })
        </script>
    </head>
    <body>
        <h1>WEB-INF/views/exhibition/get.jsp</h1>
        
        <hr>
        
        <div id="exWrapper">
            <div id="getPage">
               <div class="contentLine">
                    <p>&nbsp;</p>
                    <!-- 글제목 -->
                   <div class="title">${schedule.exname}</div>
                    <!-- 작성자 공개/비공개 -->
                    <h3>관리자</h3>

                    <!-- 등록일 / 수정일 / 조회수-->
                    <p>&nbsp;&nbsp;
                       등록일<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${schedule.exinsert}"/>
                       <c:if test="${schedule.exupdate != null}">
                           &nbsp;&nbsp;수정일<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${schedule.exupdate}"/>
                       </c:if>
                        
               </div>
               <p>&nbsp;</p>
               <p>&nbsp;</p>
               <p>&nbsp;</p>
               <p>&nbsp;</p>
               <div class="contentLine">
                    <div class="content">
                        <h4>&nbsp;전 시 명 :  ${schedule.exname}</h4>
                        <p>&nbsp;</p>
                        <h4>전시시작일 : <fmt:formatDate pattern="yyyy-MM-dd" value="${schedule.exstart}"/></h4>
                        <h4>전시마감일 : <fmt:formatDate pattern="yyyy-MM-dd" value="${schedule.exend}"/></h4>
                        <p>&nbsp;</p>
                        <h4>&nbsp;전시내용&nbsp; :  ${schedule.excontent}</h4>
                    </div>
               </div>

                <div class=getBtn>
                    <div class=getBtn1>
                            <c:if test="${__LOGIN__.memberid != null}">
                            </c:if>
                            <button type="button" class="buttonstyle" id="exRegBtn">일정등록</button>&nbsp;&nbsp;
                            <button type="button" class="buttonstyle" id="exModifyBtn">수정</button>
                       
                    </div>
                    <div class=getBtn2>
                        <button type="button" class="listBtnstyle" id="exListBtn">목록</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>