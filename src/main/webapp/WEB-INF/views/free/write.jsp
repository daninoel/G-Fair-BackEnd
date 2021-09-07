<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>write.jsp</title>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>

    <script>
    
        $(function() {
            console.clear();
            console.debug('jq started...');

            $('#listBtn').click(function() {
                console.log('onclick for #listBtn clicked...');

                location.href = '/board/list';
            });//onclick for #listBtn
            
            

        });//jq
        

        
        
    </script>
    
</head>
<body>
    <h1>write</h1>

    <div id="wrapper">
	    <form action="/board/write" method="post">
	    	
	        <table>
	            <tr>
	                <td><label for="TITLE">제목</label></td>
	                <td><input type="text" name="title" id="TITLE" size="50" placeholder="제목을 입력하세요"></td>
	            </tr>
	            <tr>
	                <td><label for="CONTENT">내용</label></td>
	                <td><textarea name="content" id="CONTENT" cols="52" rows="10" placeholder="내용을 입력하세요"></textarea></td>
	            </tr>
	            <tr>
	                <td><label for="MEMBERID">작성자</label></td>
	                <td><input type="text" name="memberId" id="MEMBERID" size="20" placeholder="작성자를 입력하세요"></td>
	            </tr>
	            
	            <tr>
	                <td colspan="2"></td>
	                <button type="submit" id="submitBtn">글등록</button>
	                <button type="button" id="listBtn">글목록</button>
	            </tr>
				<input type='hidden' name="bname"  value="자유게시판"/>
	        </table>
		</form>
    </div>

    
</body>
</html>