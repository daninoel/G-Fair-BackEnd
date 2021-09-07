<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!DOCTYPE html>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>list.jsp</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js" referrerpolicy="no-referrer"></script>
    <script>
        $(function () {
            
            console.clear();
            console.debug("start ");
            
            $('#regBtn').on('click',function(){
            	location.href = "/news/register"
            });

            $('a.prev, a.next').on('click',function (e) {
                console.debug("onclicked a. next and a.prec ");
                console.log("/t+ this:"+ this);  

                e.preventDefault(); 

                var paginationForm = $('#paginationForm'); 
                paginationForm.attr('action','/listPerPage');
                paginationForm.attr('method','GET');   //버튼이 눌려서 가는 요청이 컨트롤러로 가도록 한다. 
        
                paginationForm.find('input[name=currPage]').val($(this).attr('href'));
                paginationForm.find('input[name=amount]').val('${pageMaker.cri.amount}');
                paginationForm.find('input[name=pagesPerPage]').val('${pageMaker.cri.pagesPerPage}');
      
                            paginationForm.submit();
            // on  click prev / next 
    		
    		
    	});
        
        });
    </script>
  <style>
    *{
        margin: 0 auto;
        padding: 0;

     }

    #wrapper{
        width: 1024;

        font-family: 'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
        font-size: 14px;
    }

    table{
        width: 95%;

        border: 1px ridge green;
        border-collapse: collapse;
    }

    th{
        padding: 10px;

        color: white;
        background-color: orange;

        font-size: 16px;
    }

    td{
        padding: 3px;
    }
    
    caption{
        font-size: 16px;
        font-weight: bold;

        padding: 0;
    }
    #topmenu > li {
        float: left;

        text-align: center;
        line-height: 50px;
        list-style: none;

        width: 33%;
        height: 50px;
    }

    #regBtn{
        width: 150px;
        height: 40px;

        border: 0;

        font-size: 15px;
        font-weight: bold;

        color: white;
        background-color: blue;

        cursor: pointer;
    }

    tr:hover{
        background-color:yellowgreen;

    }

    a, a:link, a:visited{
        text-decoration: none;

        color: black;

        cursor:pointer;
    }

    th:nth-child(){
        text-align: left;

        width: 40%;
        padding-left: 10px;
    }

    /* -------------------------페이지 스타일 추가 -------------------- */

    #pagenation{
        width: 95%;  /*전체 컨텐츠 영역은 wrapper로 되어있는데 이를 기준으로 95%의 괄호를 차지해라 */
        margin: 0 auto;
        
    }

    #pagination li{
        float: left;

        width: 30px;
        height: 30px;
        border: 1px gray dotted;

        text-align: center;
        list-style: none;
        line-height: 30px;  /*세로 정렬 */
    }

    #pagination ul{
        float: right;
    }

        /*class 속성이 prev와 next인 곳에 적용해라 */
    .prev, .next{
        width: 70px !important;
        
        background-color: lightslategrey;
        color: white !important;
    }

    .currPage{ /*부여된 속성값에 해당하는 것만 스타일이 적용된다.  >> 3항 연산자 */
        background-color: orange;
        color: honeydew;
    }


</style>

</head>
<body>
    <h1>newslist.jsp</h1>
</body>

<div class="wrapper">
<table border =1 >
            <caption>tbl
                <ul id="topmenu">
                    <li>
                        <form id="searchForm" action="/news/listPerPage"method="GET">
                            <input type="hidden" name="currPage"  value="1">
                            <input type="hidden" name="amount"  value="${pageMaker.cri.amount}">
                            <input type="hidden" name="pagesPerPage"  value="${pageMaker.cri.pagesPerPage}">

                            <select name="type" id="search1">  <!--eq >> 동등비교 연산자 -->
                                <option value="T" ${ ("T" eq pageMaker.cri.type) ? "selected" : ""}>제목</option>
                                <option value="C" ${ ("C" eq pageMaker.cri.type) ? "selected" : ""}>내용</option>
                                <option value="W" ${ ("W" eq pageMaker.cri.type) ? "selected" : ""}>작성자</option>
                            </select>

                            <input type="text" name="keyword" class="search2" value="${pageMaker.cri.keyword}">
                        
                            <button class="search1">Search</button>
                        </form>
                        </li>
                        
                        <li>tbl_board(${pageMaker.totalAmount}</li>
                        
                    </ul>
                </caption>


    <thead>
        <th>글번호</th>
        <th>기사제목</th>
        <th>작성자</th>
        <th>조회수</th>
        <th>등록일</th>
        <th>수정일</th>
    </thead>

    <c:forEach items="${list}" var="board">
        <tr>
         
        
        
            <td><c:out value="${board.bno}"/></td>
            <td><a href ="/news/get?bno=${board.bno}">
            <c:out value="${board.title}"/></a></td>
            <td><c:out value="${board.memberid}"/></td>
            <td><c:out value="${board.readcnt}"/></td>
            <td><fmt:formatDate pattern="yyyy/MM/dd" value="${board.insetts}"/></td>
             <td><fmt:formatDate pattern="yyyy/MM/dd" value="${board.updatets}"/></td>

        </tr>
    </c:forEach>
	
	<button type="button" id="regBtn"> 등록하기 </button></li>
</table>
</div>

<!--페이징 처리 -->
 
<div id="wrapper">
    <div id="pagination">
        <div id="paginationForm">
            <input type="hidden" name="currPage">
            <input type="hidden" name="amount">
            <input type="hidden" name="pagePerPage">
        

            <ul>  
                <c:if test="${pageMaker.prev}">                 
                    <li class="prev"><a class ="prev" href="${pageMaker.startPage -1 }">Prev</a></li>   <!--왜 클래스 사용했을까? 공통된 특성을 두군데 같이 중복 적용하기 위해서 -->
                </c:if>

                      <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
                
                    <li class="${pageMaker.cri.currPage == pageNum? 'currPage' : ''}">
                        <a    
                        class="${pageMaker.cri.currPage == pageNum? 'currPage' : ''}"
                        href="/news/listPerPage?currPage=${pageNum}&amount=${pageMaker.cri.amount}&pagesPerPage=${pageMaker.cri.pagesPerPage}">
                        ${pageNum}
                        </a>
                    </li>
        

                </c:forEach>

                <c:if test="${pageMaker.next}">
                    <li class="next"><a class ="next" href="${pageMaker.endPage +1 }">next</a></li>
                </c:if>
        
            </ul>
        </div>
    </div>
</div>

</body> 

</html>