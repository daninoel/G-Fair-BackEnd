<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>modify</title>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>

    <script>
        $(function(){
            console.clear();
            console.debug('jq started.');

            $('#listBtn').on('click', function(){
                console.log('listBtn button clicked...');

                location.href="/board/list";
                
            });//onclick
            
            $('#removeBtn').on('click', function(){
                console.log('removeBtn button clicked...');
				var obj = $('form')
                
				obj.attr('action','/board/remove');
				obj.attr('methood','POST');
				obj.submit();
            });//onclick
            
            

        }); //jq
    </script>

    <style>

    </style>
</head>
<body>
	<div id="wrap">
        <h1>modify</h1>
        <form action="/board/modify" method="post">
	        <p><label for="BNO">Bno</label></p>
	        <p><input type="text" name="bno" id="BNO" value="${__READ__.bno}" readonly></p>
	
	        <p><label for="TITLE">Title</label></p>
	        <p><input type="text" name="title" id="TITLE" value="${__READ__.title}"></p>
	
	        <p><label for="CONTENT">Content</label></p>
	        <p><input type="text" name="content" id="CONTENT" value="${__READ__.content}"></p>
			
			<p><label for="MEMBERID">MemberId</label></p>
	        <p><input type="text" name="memberId" id="MEMBERID" value="${__READ__.memberId}"></p>
	
			<p><label for="READCNT">Readcnt</label></p>
	        <p><input type="text" name="readcnt" id="READCNT" value="${__READ__.readcnt}" readonly></p>

	        <input type="submit" id="submitBtn" value="수정하기">
	        <button id="removeBtn" type="button">삭제하기</button>
	        <button id="listBtn" type="button">목록보기</button>
        </form>
</div>
</body>
</html>