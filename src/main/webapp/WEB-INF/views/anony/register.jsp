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
    <title>/anony/REGISTER.jsp</title>

    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js" referrerpolicy="no-referrer"></script>

    <script type="text/javascript" src="/resources/js/uploadFile.js"></script>

    <link rel="stylesheet" href="../resources/css/boardBasic.css">
    <link rel="stylesheet" href="../resources/css/uploadBasic.css">
    
    <script>
        $(function(){

            $('#listBtn').on('click',function(){

                location.href = "/anony/list?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";

            });//regBtn
    
        })//jq
    </script>
</head>
<body>
    <h1>WEB-INF/views/anony/register.jsp</h1>
    
    <hr>

    <div id="anonyWrapper">
        <form action="/anony/register" method="POST" id="Reg">
            <div id="getPage">
                <div class="contentLine">
                    <input type="hidden" name="currPage" value='${cri.currPage}' >
                    <input type="hidden" name="amount" value='${cri.amount}' >
                    <input type="hidden" name="pagesPerPage" value='${cri.pagesPerPage}' >

                    <input type="hidden" name="bname" value="${board.bname}">
                    <input type="hidden" name="memberid" value="${__LOGIN__.memberid}">
                    <input type="hidden" name="reproot" value="${board.reproot}">
                    <input type="hidden" name="repstep" value="${board.repstep}">
                    <input type="hidden" name="repindent" value="${board.repindent}">
                    <input type="hidden" name="readcnt" value="0">
                    <input type="hidden" name="notice_tf" value="F">
                    <input type="hidden" name="reply_tf" value="F">

                    
                    <input type='hidden' name='fileName'>
                    <input type='hidden' name='uuid'>
                    <input type='hidden' name='uploadPath'>
                    <input type='hidden' name='fileType' value="false">


                    
                    <h2>고객의소리</h2>
                    <p>&nbsp;</p>
                    
                    <div><input type="text" name="title" placeholder="제목을 입력해 주세요" required></div>
                    <p>&nbsp;</p>
                    작성자&nbsp;&nbsp;${__LOGIN__.memberid}
                    
                    <input type="radio" name="public_tf" value="T" checked>공개
                    <input type="radio" name="public_tf" value="F">비공개
                    
                    <p>&nbsp;</p>
                    <div><textarea name="content" cols="30" rows="10" placeholder="내용을 입력해 주세요" required></textarea></div>
                    <p>&nbsp;</p>

                <!----------- 파일첨부 ----------->
                    <div class="uploadDiv">
                        <!-- 파일 하나만 저장할 수 있게 만든다! -->
                        <input type="file" name="uploadFile" accept="image/*" multiple>
                    </div>
            
                    <div class="uploadResult">
                        <ul>
                            <!-- 첨부된 파일 리스트.함수로 값 넣어준다 -->
                        </ul>
                    </div>
            
                    <div class="bigPictureWrapper">
                        <div class='bigPicture'>
                            <!-- 그림파일 원본으로 보여주기.함수로 값 넣어준다 -->
                        </div>
                    </div>

                </div>
                
                <p>&nbsp;</p>
                <p>&nbsp;</p>
                <p>&nbsp;</p>
                <p>&nbsp;</p>
            </div>
            
            <button type="submit" class="buttonstyle" id="uploadBtn">등록</button>
            <button type="button" class="buttonstyle" id="listBtn">목록</button>
        </form>
    </div>
</body>
</html>