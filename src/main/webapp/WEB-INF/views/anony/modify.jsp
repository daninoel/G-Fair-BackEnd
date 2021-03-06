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
        <title>/anony/MODIFY.jsp</title>

        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js" referrerpolicy="no-referrer"></script>

        <script type="text/javascript" src="/resources/js/uploadFile.js"></script>
        
        <link rel="stylesheet" href="../resources/css/boardBasic.css">

        <script>
            $(function(){
    
                $('#listBtn').on('click',function(){
    
                    location.href = "/anony/list?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";
    
                });//regBtn
                
                $('#removeBtn').on('click',function(){
                    $('form').attr('action','/anony/remove').attr('method','POST').submit();
                                
                });//removeBtn
            })//.jq
        </script>
        
    </head>
    <body>
        <h1>WEB-INF/views/anony/modify.jsp</h1>
        <h2>${boardFileVO.fid}</h2>
        <h2>${boardFileVO.frename}</h2>
        <h2>${boardFileVO.fpath}</h2>
        <h2>${boardFileVO.forname}</h2>
        
        <hr>

        <div id="anonyWrapper">
            <form action="/anony/modify" method="POST" id="Reg">
                <div id="getPage">
                    <div class="contentLine">
                        <input type="hidden" name="currPage" value=${cri.currPage}>
                        <input type="hidden" name="amount" value=${cri.amount}>
                        <input type="hidden" name="pagesPerPage" value=${cri.pagesPerPage}>


                        <input type="hidden" name="bno" value="${board.bno}">
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
    
                        
                        <h2>???????????????</h2>
                        <p>&nbsp;</p>
                        <div><input type="text" name="title" value="${board.title}" required></div>
                        <p>&nbsp;</p>
                        ?????????&nbsp;&nbsp;${__LOGIN__.memberid}
                        <input type="radio" name="public_tf" value="T" checked>??????
                        <input type="radio" name="public_tf" value="F">?????????
                        <p>&nbsp;</p>
                        <div><textarea name="content" cols="30" rows="10" required>${board.content}</textarea></div>
                        <p>&nbsp;</p>
                        
                        <!----------- ???????????? ----------->
                        <div class="uploadDiv">
                            <!-- ?????? ????????? ????????? ??? ?????? ?????????! -->
                            <input type="file" name="uploadFile" accept="image/*" multiple>${boardFileVO.forname}
                        </div>
                
                        <div class="uploadResult">
                            <ul>
                                <!-- ????????? ?????? ?????????.????????? ??? ???????????? -->
                            </ul>
                        </div>
                
                        <div class="bigPictureWrapper">
                            <div class='bigPicture'>
                                <!-- ???????????? ???????????? ????????????.????????? ??? ???????????? -->
                            </div>
                        </div>
                    </div>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                </div>
                
                <button type="submit" class="buttonstyle" id="uploadBtn">??????</button>
                
                <button type="button" class="buttonstyle" id="removeBtn">??????</button>
                
                <button type="button" class="buttonstyle" id="listBtn">??????</button>
            </form>
        </div>
    </body>
</html>