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
        <title>/anony/list.jsp</title>
		
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js" referrerpolicy="no-referrer"></script>
			
        <!-- <link rel="stylesheet" href="../resources/css/boardBasic.css"> -->
        <link rel="stylesheet" href="../resources/css/boardBasic2.css">
        
        <script>
            $(function(){

               $('#regBtn').on('click',function(){

                    location.href = "/anony/register?bname=anony&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";

                });//regBtn

                $('#listBtn').on('click',function(){

                    location.href = "/anony/list?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";

                });//listBtn
            
                // 페이징
                $('a.prev, a.next, a.end').on('click',function(e) {
   
                    e.preventDefault();

                    var paginationForm = $('#paginationForm');

                    paginationForm.attr('action','/anony/list');
                    paginationForm.attr('method','GET');

                    paginationForm.find('input[name=currPage]').val($(this).attr('href'));
                    paginationForm.find('input[name=amount]').val('${page.cri.amount}');
                    paginationForm.find('input[name=pagesPerPage]').val('${page.cri.pagesPerPage}');
                    paginationForm.submit();

                })//onclick
            })//.jq
        </script>
		
        

    </head>
    <body>
        <h1>WEB-INF/views/anony/list.jsp</h1>
        ${__LOGIN__.memberid}
        
        <hr>

        <div id="anonyWrapper">
            <h1>고객의소리</h1>
            <table border="1">
                <thead>
                    <tr>
                        <th class="noStyle">no</th>
                        <th>제목</th>
                        <th class="writerStyle">작성자</th>
                        <th class="dateStyle">작성일</th>
                        <th class="noStyle">조회수</th>
                        <th>첨부파일</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="number" value="${page.totalAmount - (page.cri.currPage - 1) * page.cri.amount}"/>
                    <c:forEach items="${list}" var="board" >
                        <tr>
                            <td>${number}</td>
                            <td>
                                <c:forEach begin="1" end="${board.repstep}">
                                    &nbsp;ㄴre:
                                </c:forEach> &nbsp;

                                <a href="/anony/get?bno=${board.bno}&readcnt=${board.readcnt}&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}">
                                ${board.title}</a>
                                
                                <c:if test="${board.renoCount > 0}">
                                    [${board.renoCount}]
                                </c:if>
                            </td>

                            <c:choose>
                                <c:when test="${board.public_tf eq 'F'.toString()}">
                                    <td>비공개</td>
                                </c:when>
                                <c:otherwise>
                                    <td>${board.memberid}</td>
                                </c:otherwise>
                            </c:choose>

                            <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.insert_ts}"/></td>
                            <td>${board.readcnt}</td>
                            <!-- 파일fid여부로 첨부파일 알려주기 -->
                            <td>
                                <c:if test="${board.fid != null}">
                                    <img src="/resources/file.png">
                                </c:if>
                            </td>
                        </tr>
                        <c:set var="number" value="${number-1}"/>
                    </c:forEach>
                </tbody>
            </table>
            <p>&nbsp;</p>

            <div class="reg">
                <button type="button" class="buttonstyle" id="regBtn">글쓰기</button>&nbsp;&nbsp;
                <button type="button" class="buttonstyle" id="listBtn">목록</button>
            </div>

            <p>&nbsp;</p>
            <div id="pagination">
                <form action="/anony/list" id="paginationForm">
                    <input type="hidden" name="currPage">
                    <input type="hidden" name="amount">
                    <input type="hidden" name="pagesPerPage">
                    
                    <ul>
                        <c:if test="${page.prev}">
                            <li class="prev"><a href="/anony/list"><<</a></li>
                            <li class="prev"><a class="prev" href="${page.startPage-1}"><</a></li>
                        </c:if>
                        
                        <c:forEach var="pageNum" begin="${page.startPage}" end="${page.endPage}">
                            <li class="${page.cri.currPage == pageNum ? 'currPage' : ''}">
                                <a href="/anony/list?currPage=${pageNum}&amount=${page.cri.amount}&pagesPerPage=${page.cri.pagesPerPage}&type=${page.cri.type}&keyWord=${page.cri.keyWord}">${pageNum}</a>
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
                    <form action="/anony/list" method="GET">
                        <input type="hidden" name="currPage" value="1">
                        <input type="hidden" name="amount" value="${page.cri.amount}">
                        <input type="hidden" name="pagesPerPage" value="${page.cri.pagesPerPage}">
                        
                        <select name="type" class="searchcss">
                            <option>검색조건</option>
                            <option value="T" ${("T" eq page.cri.type) ? 'selected' : ''}>제목</option>
                            <option value="C" ${("C" eq page.cri.type) ? 'selected' : ''}>내용</option>
                            <option value="W" ${("W" eq page.cri.type) ? 'selected' : ''}>작성자</option>
                            <option value="TC" ${("TC" eq page.cri.type) ? 'selected' : ''}>제목+내용</option>
                        </select>

                        <input type="text" class="searchcss" name="keyWord" value="${page.cri.keyWord}">
                        <button type="submit" class="buttonstyle">Search</button>
                    </form>
                </li>
            </ul>
        </div>
    	
    </body>
    
</html>