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

        <link rel="stylesheet" href="../resources/css/boardBasic.css">

        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js" referrerpolicy="no-referrer"></script>

        <script>
            $(function () {
                console.log('jq started')

                var comparePass;

                var password = $('#pw');//입력된 패스워드
                
                $("#loginBtn").on('click',function(){//로그인 버튼을 눌렀을 때

                        
                    if(comparePass != password.val()){//패스워드가 틀렸을 때
                        alert("잘못된 접근입니다.");

                        password.focus();

                        return false;
                    } else {//패스워드가 일치했을 때
                        console.log('로그인!!')
                    }//if-else

                })//loginBtn

                // on("propertychange change keyup paste input", function(){}
                //비밀번호 일치여부확인(입력되는대로 인식함)
                $('#pw').on("propertychange change keyup paste input",function(){

                    var memberid = '${__LOGIN__.memberid}';//아이디값

                    $.ajax({
                        url: '/mypage/getPass?memberid='+memberid,
                        type: 'GET',
                        success : function(result){

                            comparePass = result;
                        }//success
                    })//.ajax
                });

            })//.jq
        </script>
    </head>
    
    <body>
        <h1>WEB-INF/views/mypage/checkPass.jsp</h1>
        <H2>${__LOGIN__.memberid}</H2>
        <H2>${__LOGIN__.memberpw}</H2>
        <form action="/mypage/checkPass" method="POST">

            <div>
                <input type="hidden" name="memberid" value="${__LOGIN__.memberid}">
                
                비밀번호 : <input type="password" name="memberpw" id="pw" placeholder="MemberPassword">
            </div>
            <div><button type="submit" class="buttonstyle" id="loginBtn">로그인</button></div>
        </form>
    </body>
</html>