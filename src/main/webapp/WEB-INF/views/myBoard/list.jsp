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

                $('#selectDelBtn').on('click',function(e){//체크박스 눌렀을 때
                    e.preventDefault();

                    if( $('input[name=bno]:checked').length >0 ){

                        var result = confirm("정말 삭제하시겠습니까?");

                        if(result){//확인 눌렀을 때
                            console.log("True")

                            var checkboxDelForm = $('#checkboxDelForm');
                            
                            checkboxDelForm.attr('action','/myBoard/remove');
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


                // 페이징
                $('a.prev, a.next, a.end').on('click',function(e) {
    
                    e.preventDefault();

                    var paginationForm = $('#paginationForm');

                    paginationForm.attr('action','/myBoard/list');
                    paginationForm.attr('method','GET');

                    paginationForm.find('input[name=currPage]').val($(this).attr('href'));
                    paginationForm.find('input[name=amount]').val('${page.cri.amount}');
                    paginationForm.find('input[name=pagesPerPage]').val('${page.cri.pagesPerPage}');
                    paginationForm.submit();

                })//onclick

                var boardVal='';


                $('#boardOption').change(function(){//
                   
                    boardVal = $(this).val();
                    
                    console.log('boardVal값:',boardVal);

                    var selectBoardForm = $('#selectBoardForm');
                    selectBoardForm.attr('action','/myBoard/list');
                    selectBoardForm.attr('method','GET');

                    selectBoardForm.append('<input type="hidden" name="memberid" value="${__LOGIN__.memberid}">');
                    selectBoardForm.append('<input type="hidden" name="currPage" value="1">');
                    selectBoardForm.append('<input type="hidden" name="amount" value="${page.cri.amount}">');
                    selectBoardForm.append('<input type="hidden" name="pagesPerPage" value="${page.cri.pagesPerPage}">');
                    selectBoardForm.append('<input type="hidden" name="bname" value="'+boardVal+'">');
                    selectBoardForm.append('<input type="hidden" name="type" value="${page.cri.type}">');
                    selectBoardForm.append('<input type="hidden" name="keyWord" value="${page.cri.keyWord}">');
                    selectBoardForm.submit();

                })//boardOption

            })//.jq
        </script>

    </head>
    <body>
        <h1>WEB-INF/views/myboard/list.jsp</h1>
        ${__LOGIN__.memberid}
        ${page.cri.type}
        
        <hr>

        <div id="myboard">
            <table>
                <thead>
                    <form id="selectBoardForm"></form>
                        <tr>
                            <th>&nbsp;</th>
                            <th>no</th>
                            <th>제목</th>
                            <th>내용</th>
                            <th>작성일</th>
                            <th>조회수</th>
                            <th>
                                <select id="boardOption" name="bname" class="searchcss">
                                    <option value=>전체게시판</option>
                                    <option value="anony" ${("anony" eq cri.bname) ? 'selected' : ''}>고객의소리</option>
                                    <option value="quest" ${("quest" eq cri.bname) ? 'selected' : ''}>질문게시판</option>
                                    <option value="free" ${("free" eq cri.bname) ? 'selected' : ''}>자유게시판</option>

                                </select>
                            </th>
                        </tr>
                    </form>
                </thead>
                <tbody>
                    <form id="checkboxDelForm">
                        <input type="hidden" name="memberid" value="${__LOGIN__.memberid}">

                        <c:set var="num" value="${page.totalAmount - ( page.cri.currPage - 1 ) * page.cri.amount}"/>
                        <c:forEach items="${list}" var="board">
                            <tr>
                                <td><input type="checkbox" name="bno" value="${board.bno}"></td>
                                <td>${num}</td>
                                <td>
                                    <c:forEach begin="1" end="${board.repstep}">
                                        &nbsp;[re:]
                                    </c:forEach>
                                    <a href="/${board.bname}/get?bno=${board.bno}&bname=${board.bname}&readcnt=${board.readcnt}&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}">
                                    ${board.title}</a>
                                    
                                    <c:if test="${board.renoCount > 0}">
                                    [${board.renoCount}]
                                    </c:if>
                                </td>

                                <td>${board.content}</td>
                                <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.insert_ts}"/></td>
                                <td>${board.readcnt}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${board.bname eq 'anony'}">고객의소리</c:when>
                                        <c:when test="${board.bname eq 'quest'}">질문게시판</c:when>
                                        <c:when test="${board.bname eq 'free'}">자유게시판</c:when>
                                        <c:otherwise>${board.bname}</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <c:set var="num" value="${num-1}"/>
                        </c:forEach>
                    </form>
                </tbody>
            </table>
            <div><button type="button" id="selectDelBtn" class="buttonstyle">선택삭제</button></div>
        
            <p>&nbsp;</p>

            <div id="pagination">
                <form action="/myBoard/list" id="paginationForm">
                    <input type="hidden" name="memberid" value="${__LOGIN__.memberid}">
                    <input type="hidden" name="currPage">
                    <input type="hidden" name="amount">
                    <input type="hidden" name="pagesPerPage">

                    <ul>
                        <c:if test="${page.prev}">
                            <li class="prev"><a href="/myBoard/list?memberid=${__LOGIN__.memberid}&currPage=1&amount=${page.cri.amount}&pagesPerPage=${page.cri.pagesPerPage}&type=${page.cri.type}&keyWord=${page.cri.keyWord}&bname=${page.cri.bname}"><<</a></li>
                            <li class="prev"><a class="prev" href="${page.startPage-1}"><</a></li>
                        </c:if>

                        <c:forEach var="pageNum" begin="${page.startPage}" end="${page.endPage}">
                            <li class="${page.cri.currPage == pageNum ? 'currPage' : ''}">
                                <a href="/myBoard/list?memberid=${__LOGIN__.memberid}&currPage=${pageNum}&amount=${page.cri.amount}&pagesPerPage=${page.cri.pagesPerPage}&type=${page.cri.type}&keyWord=${page.cri.keyWord}&bname=${page.cri.bname}">${pageNum}</a>
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
                    <form action="/myBoard/list" method="GET" id="searchMenuForm">
                        <input type="hidden" name="memberid" value="${__LOGIN__.memberid}">
                        <input type="hidden" name="currPage" value="1">
                        <input type="hidden" name="amount" value="${page.cri.amount}">
                        <input type="hidden" name="pagesPerPage" value="${page.cri.pagesPerPage}">
                        <input type="hidden" name="bname" value="${cri.bname}">
                        
                        <select name="type" class="searchcss">
                            <option>검색조건</option>
                            <option value="T" ${("T" eq page.cri.type) ? 'selected' : ''}>제목</option>
                            <option value="C" ${("C" eq page.cri.type) ? 'selected' : ''}>내용</option>
                            <option value="TC" ${("TC" eq page.cri.type) ? 'selected' : ''}>제목+내용</option>
                        </select>

                        <input type="text" class="searchcss" name="keyWord" value="${page.cri.keyWord}">
                        <button type="submit" id="searchBtn" class="buttonstyle">Search</button>
                    </form>
                </li>
            </ul>
        </div>
    </body>
</html>