<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>modify.jsp</title>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
    
        <script>
            $(function(){
                console.clear();
                console.log("start! "); 

                $('#listBtn').on('click',function(){
                   location.href= location.href="/news/listPerPage?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}"
                });

                $('#removeBtn').on('click',function(){
                   alert("정말 삭제하시겠습니까?")
                 });
                $('#removeBtn').on('click',function(){
                   let formObj = $('form');
                    formObj.attr('action',"/news/remove");
                    formObj.attr('method',"post");
                    formObj.submit();
                });
                
            });
        </script>
    
</head>
<body>
    <h1>modify.jsp</h1>

    <form action="/news/modify" method="POST">
        <table border="1">
            <thead>
	                <tr>
	                       <th><label for="bno">글번호</label></th>                                
	                       <td><input type="text" value="<c:out value='${board.bno}'/>"id = "bno" name="bno" readonly></td>
                    </tr>
	
	                <tr>
	                    <th><label for="title">title</label></th>
	                    <td><input type="text" value="<c:out value='${board.title}'/>" id="title" name="title" readonly></td>
	                </tr>
	
	                <tr>
	                    <th><label for="content">내용</label></th>
	                    <td><input type="text" value="<c:out value='${board.content}'/>" id="title" name="title"></>
	                </tr>
	                
	             <tr>
                    <td><label for="fid"></label></td>
                    <td><input type="hidden" id="fid" name="fid"></td>
                </tr>

                 <tr>
                    <td><label for="notice_tf"></label></td>
                    <td><input type="hidden" id="notice_tf" name="notice_tf" value="T" ></td>
                </tr>

                <tr>
                    <td><label for="public_tf"></label></td>
                    <td><input type="hidden" id="public_tf" name="public_tf" value="T"></td>
                </tr>

                <tr>
                    <td><label for="reply_tf"></label></td>
                    <td><input type="hidden" id="reply_tf" name="reply_tf" value="T" ></td>
                </tr> 
	                
	
           </thead>
        </table>
        
          <button type="submit" id="modifyBtn"> 수정완료</button>
            <button type="button" id="removeBtn"> 삭제</button>
            <button type="button" id="listBtn"> 목록으로</button>
    </form>

</body>
</html>