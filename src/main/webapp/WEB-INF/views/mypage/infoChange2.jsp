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

        <link rel="stylesheet" href="../resources/css/infoChange.css">

        <script>
            $(function(){

               
                $('#changeCancel').on('click',function(){
                    location.href = "/mypage/checkPass";
                })//changeCancel

                var numberRegex = /0[0-9]{1,2}-[^0][0-9]{2,3}-[0-9]{3,4}$/;//숫자만(연락처)
                // var numberRegex = /^\d{2,3}-\d{3,4}-\d{4}$/;//숫자만(연락처)
                var emailRegex = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;//이메일
               
                var changeEmailAddress = '${member.email}';//바뀔 이메일 주소=> 기본값 원래 주소


                
// ---------------------------------이메일변경----------------------------------------------
                        
                //로직 : 0. 이메일수정버튼을 누르면 인증번호전송 탭이 나타난다 ==ok!
                // 1. 제대로 수행했을 때 ( 변경할 이메일을 입력하고 인증과정 수행) ==ok!
                // 2. 제대로 수행 안했을 때 ( 인증을 제대로 수행안하고 회원변경 버튼 눌렀을 때) ==ok!
                // 3. 인증을 수행했는데 취소했을때 ==ok!
                // 4. 그냥 취소했을 때 ==ok!

                //추가. 변경할 이메일주소가 기존회원메일이면 안된다!


                var mailWrapBtn = document.getElementById('mail_wrap');//이메일 인증관련 body
                var email = $('.mail_input');//메일적는칸 가져오기
                

                // 0.메일 수정하기 눌렀을 때
                $('#emailBtn').on('click',function(){

                    mailWrapBtn.style.display = "block"//이메일인증 body를 보여준다
                    console.log('email.val():',email.val(''));//메일 초기화

                    
                });//emailBtn


                //4.메일 수정취소 눌렀을 때
                $('#mailCancleBtn').on('click',function(){

                    mailWrapBtn.style.display = "none"//이메일인증 body를 없앤다

                    changeEmailAddress = '${member.email}'; // 

                    console.log('email.val():',email.val(''));//메일 초기화
                });//emailCancleBtn

                
      // -------------------------------이메일 전송하고 시간제한-----------------------------

                var timer = null;
                var code="";
                
                var infoChangeForm;

                // 인증번호 이메일 전송
                $('.mail_check_button').click(function(){//인증코드버튼 눌렀을 때 --> 메일을 발송하고 시간체크해야함.
                //    changeEmailAddress = '${member.email}';//일단 초기값으로..

                   // -----------------------이메일 체크------------------  
                    var emailElement = document.getElementById('email');//id값으로 요소얻기
                    var pemail = document.getElementById('pemail');//id값으로 요소얻기
                    
                    var emailResult;

                    infoChangeForm = $('#infoChange').serialize();

                    $.ajax({
                        url: '/mypage/checkInfo',
                        type: 'POST',
                        data: infoChangeForm,
                        async: false,//동기식으로 변경함
                        success: function(result){
                            console.log('1. emailReseult',result);

                            emailResult = result
                        }//success
                    })//ajax

                    // function checkAjax(){
                        
                    // }
                    console.log('2. emailReseult',emailResult);
                    if(emailResult != 0){//등록된 정보 체크

                        console.log('3. emailReseult',emailResult);

                        alert("이미 등록된 정보입니다.");
                        emailElement.focus();

                        return false;

                    }else if(emailRegex.test(emailElement.value)){//이메일형식이 맞을 때
                        alert("인증메일이 발송되었습니다.");

                        emailElement.style.color = "black";

                        pemail.innerHTML="&nbsp;";

                        console.log("이메일 완료!");

            // ------------------------------------------------------------------
                        var boxWrap = $(".mail_check_input_box");    // 인증번호 입력란 박스
                        var checkBox = $(".mail_check_input");        // 인증번호 입력란

                        //시간표시영역
                        var display = $('.time');
                        //유효시간 설정
                        var leftSec = 20;
                        
                        startTimer(leftSec, display);

                        $.ajax({
                            url: "/mypage/sendMail?email="+email.val(),
                            type: 'GET',
                            success: function(result){//인증코드 받아오기

                                console.log("result : "+result);

                                //성공했으니 비활성은 꺼버리고 색깔 변경
                                checkBox.attr("disabled",false);
                                boxWrap.attr("id","mail_check_input_box_true");

                                code = result;
                            }//success
                        });//.ajax

                    }else{//이메일형식이 안맞을 때
                        emailElement.focus();
                        emailElement.style.color = "red";
                        
                        pemail.innerHTML = "형식이 안맞습니다.";
                        
                        return false;
                    }//if-else

                });//인증코드버튼 눌렀을 때

                
                function startTimer(count,display){

                    var minutes;
                    var seconds;
                
                    timer = setInterval(function(){
                        
            
                        minutes = parseInt(count / 60, 10); //분 구하기. 뒤에 10은 뭐지?
                        seconds = parseInt(count % 60, 10); //초 구하기. 뒤에 10은 뭐지?

                        minutes = minutes < 10 ? "0" + minutes : minutes; //한자릿수 맞추기
                        seconds = seconds < 10 ? "0" + seconds : seconds; //한자릿수 맞추기

                        display.html(minutes + ":" + seconds);

                        //타이머 끝
                        if(--count < 0 ){//시간이 초과 됐을 때

                            clearInterval(timer);

                            display.html('인증번호를 다시 받으세요');
                            
                            $(".mail_check_input").attr('disabled',true);

                            changeEmailAddress = '${member.email}';//시간초과시 원래 메일

                        }else {//
                            
                            $('.mail_check').on('click',function(){//인증번호확인 눌렀을 때

                                if( inputCode == code){//if - 번호 일치했을 때
                                    
                                    clearInterval(timer);
                                    
                                    display.html('인증완료!');
                                    
                                    $(".mail_check_input").attr('disabled',true);
                                    changeEmailAddress = email.val();//입력된 값으로

                                }//if - 번호 일치했을 때
                            })//인증번호확인 눌렀을 때

                        }//if-else
                    },1000)//timer = setInterval() ==1초
                }//startTimer

                var inputCode;//입력된코드

                // 인증번호 일치하는지 확인
                $('.mail_check_input').blur(function(){

                    inputCode = $('.mail_check_input').val();//입력된코드
                    
                    console.log('inputCode',inputCode);

                    var checkResult = $('#mail_check_input_box_warn');//비교결과

                    if( inputCode == code){//리턴받은 코드값 비교(일치할 경우)
                        checkResult.html('인증번호가 일치합니다.');
                        checkResult.attr('class','correct');

                        // 입력된 메일주소를 전송함
                        changeEmailAddress = email.val();
                        console.log('중간체크 :',changeEmailAddress);

                        
                    } else {//일치 안할 경우
                        checkResult.html('인증번호를 다시 확인해주세요.');
                        checkResult.attr('class','incorrect');

                        changeEmailAddress = '${member.email}'; // 
                        console.log('중간체크 :',changeEmailAddress);
                    }//if-else
                });//데이터입력 후 실행되는 함수

                var pcResult='';

                //최종 변경버튼 눌렀을 때
                $('#infoChangeBtn').on('click',function(e){
                    e.preventDefault;
                     // 이메일 최종주소
                    $('#mailParam').val(changeEmailAddress)//확인용
                    console.log('중간체크 :',changeEmailAddress);//확인용
                    // return false;
                
                    infoChangeForm = $('#infoChange').serialize(); //폼태그

                    $.ajax({
                        url: '/mypage/checkInfo',
                        type: 'POST',
                        data: infoChangeForm,
                        async: false,//동기식으로 변경함
                        success: function(result){
                            console.log('1. pcResult',result);

                            pcResult = result;
                        }//success
                    })//ajax

                    if(pcResult != 0){//등록된 정보 체크
                        console.log('2. pcResult',pcResult);
                        alert("이미 등록된 정보입니다.");

                        return false;
                    }
// ------------------------------------연락처 체크---------------------------------------------------                    
                    var phone = document.getElementById('phone');//id값으로 요소얻기
                    var pphone = document.getElementById('p_phone');//id값으로 요소얻기
                   
                    if(numberRegex.test(phone.value)){//정규표현식에 만족할 때

                        if(phone.value.length > 13 || phone.value.length < 9){
                            phone.focus();

                            pphone.innerHTML="자릿수가 안맞습니다.";

                            return false;
                        }//폰번호가 9자리보다 작거나 11자리가 넘을때
                        phone.style.color = "black";

                        pphone.innerHTML="&nbsp;";

                        console.log("연락처 완료!");

                    } else {//번호로만 기재 안했을 때
                        phone.focus();
                        phone.style.color = "red";

                        pphone.innerHTML="형식이 안맞습니다.";

                        return false;
                    }//if-else
     
                    

// ------------------------------------사업자번호 체크---------------------------------------------------
                    var cbno = document.getElementById('cbno');//id값으로 요소얻기
                    var pcbno = document.getElementById('p_cbno');//id값으로 요소얻기
                    
                    console.log("test!!!",);

                    if(numberRegex.test(cbno.value)){//숫자만 기재했을 때

                        if(cbno.value.length != 10){//자릿수 안맞을 때
                            cbno.focus();
    
                            pcbno.innerHTML="자릿수가 안맞습니다.";
    
                            return false;
                        }//자릿수 안맞을 때
                        cbno.style.color = "black";

                        pcbno.innerHTML="&nbsp;";

                        console.log("사업자번호 완료!");

                    } else {//숫자만 아닐때
                        cbno.focus();
                        cbno.style.color = "red";

                        pcbno.innerHTML="형식이 안맞습니다.";

                        return false;
                    }//if-else

// --------------------------------파일형식체크------------------------------------------------------  
                    var regex = new RegExp("(.*?)\.(JPG|PNG|jpg|png)$");//파일확장명 제한

                    var maxSize = 2097152;//2mb

                    function checkExtension(fileName,fileSize){//파일확장자와 크기를 확인해주는 메소드

                        if(fileSize >= maxSize){
                            alert("첨부파일이 너무 큽니다.");
                            console.log("로그를 찍어보자1");

                            return false;
                        }//파일사이즈

                        if(!regex.test(fileName)){
                            alert("해당 종류의 파일은 업로드할 수 없습니다.");

                            return false;
                        }//확장자 체크

                    }//checkExtension
                    
        // -------------------------------------------------------------------------------------------      
                        
                    $('input[type="file"]').change(function(e){//파일이 변화했을 때
                        //--> 파일 첨부하자마자 복사됌
                        var formData = new FormData();

                        var inputFile = $('input[name="uploadFile"]');

                        files = inputFile[0].files;

                        for(var i=0; i<files.length; i++){//여러개의 파일이 업로드 됐을 때
                            
                            if(!checkExtension(files[i].name, files[i].size)){
                            
                                return false;
                            }
                            
                            formData.append("uploadFile",files[i]);
                        }//for

                    });//upload

                });//infoChangeBtn
    
                
            });//.jq        
        </script>
        <script language="javascript">
             //주소 API

			function goPopup(){
				var pop = window.open("/mypage/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
			}//goPopup

			function jusoCallBack(roadFullAddr){
                // 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록
                document.form.roadFullAddr.value = roadFullAddr;
			}//jusoCallBack
        </script>
    </head>
    <body>
        <h1>WEB-INF/views/mypage/infoChange.jsp</h1>
        
        
        <hr>
        <form action="/mypage/infoChange" method="POST" id="infoChange" name="form" >
            <div class="memberInfoWrap">
                <input type="hidden" name="mno" value="${member.mno}">
                <div class="memberInfo">
                    <div class='contentLine'>
                        <h4>아이디</h4>
                        <div><input type="hidden" name="memberid" value="${member.memberid}">${member.memberid}</div>
                    </div>
                    <p>&nbsp;</p>
                    <div class='contentLine'>
                        <h4>회원명</h4>
                        <div><input type="hidden" name="membername" value="${member.membername}">${member.membername}</div>
                    </div>
                    <p>&nbsp;</p>
                    <div class='contentLine'>
                        <h4>주소</h4>
                        <div>
                            <input type="text" id="roadFullAddr" name="memberaddress" value="${member.memberaddress}">
                            <button type="button" class="mailbuttonStyle" onclick="goPopup()">주소찾기</button>
                        </div>
                    </div>
                    <p>&nbsp;</p>
                    <div class='contentLine'>
                        <h4>연락처</h4>
                        <div><input type="tel" name="phone" id="phone" placeholder="${member.phone}" value="${member.phone}">'-'을 붙여서 입력해주세요<br>
                            <p id="p_phone"></p></div>
                    </div>
                    
                    <p>&nbsp;</p>
                    <c:if test="${member.membertype == '기업'}">
                        <div class='contentLine'>
                            <h4>사업자번호</h4>
                            <div><input type="hidden" name="cbno" value="${member.cbno}">${member.cbno}</div>
                        </div>
                        <p>&nbsp;</p>
                    </c:if>

                    <div class='contentLine'>
                        <h4>가입일자</h4>
                        <div><input type="hidden" name="signdate" value="${member.signdate}">
                            <fmt:formatDate pattern="yyyy-MM-dd" value="${member.signdate}"/></div>
                    </div>
                    <p>&nbsp;</p>
                    <div class='contentLine'>
                        <h4>회원유형</h4>
                        <div><input type="hidden" name="membertype" value="${member.membertype}">${member.membertype}</div>
                    </div>
                    <p>&nbsp;</p>
                    
                    <div class='contentLine'>
                    <h4>이메일</h4>
                        <input type="hidden" name="email" id='mailParam' value="${member.email}">${member.email}
                        <button type="button" class="mailbuttonStyle" id="emailBtn">수정하기</button>
                    </div>

                    <p>&nbsp;</p>
                    <!--============================================= 이메일관련  =============================================-->                            
                    <div class='contentLine' id="mail_wrap" style="display: none;">
                        <div class="mail_name"><h5>변경할 이메일주소</h5></div>
                        <div class="mail_input_box">
                            <input class="mail_input" id='email' name="emailSub" value="">
                            <p id="pemail"></p>
                        </div>
                        
                        <div class="mail_check_wrap">
                            <div class="mail_check_input_box" id="mail_check_input_box_false">
                                <input class="mail_check_input" disabled="disabled"><!-- 인증코드 체크 -->
                            </div>
                            <div class="mail_check_button">
                                <span>인증메일발송</span>
                            </div>
                        </div>

                        <div class="mail_check_wrap">
                            <span id="mail_check_input_box_warn">&nbsp;</span><!-- 인증번호 일치여부 -->
                            
                            <div class="time"></div>
                        </div>    
                        
                        <div class="mail_check_wrap">
                            <button type="button" class="mail_check_Message">인증번호확인</button>
                            <button type="button" id="mailCancleBtn" class="cancleBtnStyle">수정취소</button>
                        </div>
                    </div>  
                    <!--============================================= 이메일관련  =============================================-->
                    
                </div> 
            </div>

            <p>&nbsp;</p>
            <div>
                <button type="submit" id="infoChangeBtn" class="buttonstyle">변경</button>
                <button type="button" id="changeCancel" class="buttonstyle" >취소</button>
            </div>
        </form>

    </body>
</html>