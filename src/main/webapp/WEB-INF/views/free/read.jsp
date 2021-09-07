<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>read</title>

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
            
            $('#modifyBtn').on('click', function(){
                console.log('listBtn button clicked...');
            
            	location.href="/board/modify?bno=${__READ__.bno}";
            });//onclick
            


        }); //jq
    </script>

    <style>

    </style>
</head>
<body>
    <h1>read</h1>
    <p>글번호: ${__READ__.bno}</p>
    <p>제 목:${__READ__.title}</p>
    <p>내 용:${__READ__.content}</p>
    <p>작성자:${__READ__.memberId}</p>
    <p>등록일:${__READ__.insert_ts}</p>
    <p>조회수${__READ__.readcnt}</p>
    
    <button id="modifyBtn" type="button">수정하기</button>
    <button id="listBtn" type="button">목록보기</button>
</body>
</html>