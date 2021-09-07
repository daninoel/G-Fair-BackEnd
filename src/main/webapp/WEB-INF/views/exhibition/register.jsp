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

		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js" referrerpolicy="no-referrer"></script>
			
        <link rel="stylesheet" href="../resources/css/boardBasic.css">

        <script>
            $(function(){

                $('#exCancleBtn').on('click',function(){
                    
                    history.back();
                })

            })//.jq
        </script>
    </head>
    <body>
        <div class="exhibitionWrap">
            <form id="exRegisterForm" method="POST" action="/exhibition/register">
                <table>
                    <tbody>
                        <tr>
                            <th>전시명</th>
                            <td><input type="text" name="exname" placeholder="전시명을 입력해주세요" required></td>
                        </tr>
                        <tr>
                            <th>전시시작일</th>
                            <td><input type="date" name="exstart" placeholder="전시시작일" required></td>
                        </tr>
                        <tr>
                            <th>전시마감일</th>
                            <td><input type="date" name="exend" placeholder="전시마감일" required></td>
                        </tr>
                        <tr>
                            <th>전시내용</th>
                            <td><textarea name="excontent"cols="30" rows="10" placeholder="전시일정 내용을 입력해주세요" required></textarea></td>
                        </tr>
                    </tbody>
                </table>
                <button type="submit" class="listBtnstyle" id="exRegBtn">등록</button>
                <button type="button" class="listBtnstyle" id="exCancleBtn">취소</button>
            </form>
        </div>
    </body>
</html>