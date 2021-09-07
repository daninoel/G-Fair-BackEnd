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
        
        <link rel="stylesheet" href="../resources/css/mypage.css">

        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js" referrerpolicy="no-referrer"></script>
	
        <script>
            $(function(){
             
                //일정등록
                $('#exRegBtn').on('click',function(){
                    
                    location.href = "/exhibition/register?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";

                });//regBtn

                //목록보기
                $('#exListBtn').on('click',function(){
 
                    location.href = "/exhibition/list?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";

                });//listBtn

                // 페이징
                $('a.prev, a.next, a.end').on('click',function(e) {
    
                    e.preventDefault();

                    var paginationForm = $('#paginationForm');

                    paginationForm.attr('action','/exhibition/list');
                    paginationForm.attr('method','GET');

                    paginationForm.find('input[name=currPage]').val($(this).attr('href'));
                    paginationForm.find('input[name=amount]').val('${page.cri.amount}');
                    paginationForm.find('input[name=pagesPerPage]').val('${page.cri.pagesPerPage}');
                    paginationForm.submit();

                })//onclick

                $('#selectDelBtn').on('click',function(e){//체크박스 눌렀을 때
                    e.preventDefault();
                    
                    if( $('input[name=exno]:checked').length >0 ){

                        var result = confirm("정말 삭제하시겠습니까?");
    
                        if(result){//확인 눌렀을 때
                            console.log("True")

                            var checkboxDelForm = $('#checkboxDelForm');
                            
                            checkboxDelForm.attr('action','/exhibition/remove');
                            checkboxDelForm.attr('method','POST');
                            
                            checkboxDelForm.submit();
                            
                        } else {//취소 눌렀을 때
                            console.log("False")
                            return false;
                        }//if-else

                    } else {
                        alert("선택된 것이 없습니다.")
                    }//if-else

                })//selectDelBtn

                $('#calendarBtn').click(function(){
                    location.href = "/exhibition/calendar";
                })

            })//.jq
        </script>
    </head>
    <body>
        <h1>WEB-INF/views/exhibition/list.jsp</h1>

        <hr>

        <div id="exhibitionWrap">
           <h1>전시일정관리</h1>
           <h3>${ex.exno}</h3>
           <form id="checkboxDelForm">
                <table>
                    <thead>
                        <tr>
                            <th>&nbsp;</th>
                            <th>no</th>
                            <th>전시명</th>
                            <th>전시시작일</th>
                            <th>전시마감일</th>
                            <th>등록일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="num" value="${page.totalAmount - (page.cri.currPage - 1) * page.cri.amount}"></c:set>
                        <c:forEach items="${exList}" var="ex">
                            <tr>
                                <td><input type="checkbox" name="exno" value="${ex.exno}"></td>
                                <td>${num}</td>
                                <td><a href="/exhibition/get?exno=${ex.exno}">${ex.exname}</a></td>
                                <td><fmt:formatDate pattern="yyyy-MM-dd" value="${ex.exstart}"/></td>
                                <td><fmt:formatDate pattern="yyyy-MM-dd" value="${ex.exend}"/></td>
                                <td><fmt:formatDate pattern="yyyy-MM-dd" value="${ex.exinsert}"/></td>
                            </tr>
                        <c:set var="num" value="${num - 1}"></c:set>
                        </c:forEach>
                    </tbody>
                </table>
                <div>
                    <button type="submit" id="selectDelBtn" class="buttonstyle">선택삭제</button>
                    <button type="button" class="buttonstyle" id="exRegBtn">일정등록</button>&nbsp;&nbsp;
                </div>
                <div class="exreg">
                    <button type="button" class="buttonstyle" id="exListBtn">목록</button>
                    <button type="button" class="buttonstyle" id="calendarBtn">달력으로가기</button>
                </div>
            
            </form>    
            <p>&nbsp;</p>

            <div id="pagination">
                <form action="/exhibition/list" id="paginationForm">
                    <input type="hidden" name="currPage">
                    <input type="hidden" name="amount">
                    <input type="hidden" name="pagesPerPage">

                    <ul>
                        <c:if test="${page.prev}">
                            <li class="prev"><a href="/exhibition/list?currPage=1&amount=${page.cri.amount}&pagesPerPage=${page.cri.pagesPerPage}&type=${page.cri.type}&keyWord=${page.cri.keyWord}"><<</a></li>
                            <li class="prev"><a class="prev" href="${page.startPage-1}"><</a></li>
                        </c:if>

                        <c:forEach var="pageNum" begin="${page.startPage}" end="${page.endPage}">
                            <li class="${page.cri.currPage == pageNum ? 'currPage' : ''}">
                                <a href="/exhibition/list?currPage=${pageNum}&amount=${page.cri.amount}&pagesPerPage=${page.cri.pagesPerPage}&type=${page.cri.type}&keyWord=${page.cri.keyWord}">${pageNum}</a>
                            </li>
                        </c:forEach>

                        <c:if test="${page.next}">
                            <li class="next"><a class="next" href="${page.endPage+1}">></a></li>
                            <li class="next"><a class="end" href="${page.realEndPage}">>></a></li>
                        </c:if>
                    </ul>
                </form>
            </div>
            <ul id="searchMenu">
                <li>
                    <form action="/exhibition/list" method="GET" id="searchMenuForm">
                        <input type="hidden" name="currPage" value="1">
                        <input type="hidden" name="amount" value="${page.cri.amount}">
                        <input type="hidden" name="pagesPerPage" value="${page.cri.pagesPerPage}">
                        
                        <select name="type" class="searchcss">
                            <option>검색조건</option>
                            <option value="T" ${("T" eq page.cri.type) ? 'selected' : ''}>전시명</option>
                            <option value="C" ${("C" eq page.cri.type) ? 'selected' : ''}>내용</option>
                            <option value="TC" ${("TC" eq page.cri.type) ? 'selected' : ''}>전시명+내용</option>
                        </select>

                        <input type="text" class="searchcss" name="keyWord" value="${page.cri.keyWord}">
                        <button type="submit" id="searchBtn" class="buttonstyle">Search</button>
                    </form>
                </li>
            </ul>
        </div>
    </body>
</html>