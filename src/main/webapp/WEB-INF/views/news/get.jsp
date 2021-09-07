<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>get.jsp</title>
    
        
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>

    <script>
     $(function () {
         console.clear();
         console.debug("jq start")


         $('#listBtn').on('click',function () {
        	 location.href= location.href="/news/listPerPage?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}"
         });
         
 
         $('#modifyBtn').on('click', function(){
      	   console.log("modifyBtn button clicked"); 
      	   
      	   location.href="/news/modify?bno=${board.bno}"
      	   
          });// .onclick
          
        
     }); 

    </script>
</head>
<body>
    <h1>get.jsp</h1>

    <div class="wraper">
        <form action="#">
            <table border="1">
                <tr>
                    <td>글번호</td>
                     <td>${board.bno}</td>
                     
                      <td>작성자</td>
                     <td>${board.memberid}</td>
                </tr>
                <tr>
                    <td colspan="2">제목</td>
                     <td>${board.title}</td>
                </tr>
                <tr>
                    <td colspan="2">내용</td>
                     <td>${board.content}</td>
                </tr>
                  
                   </tr>
            
                
           
            </table>
            <button type="button" id="modifyBtn">수정</button> 
            <button type="button" id="listBtn">목록</button>

        </form>
    </div>
</body>
</html>