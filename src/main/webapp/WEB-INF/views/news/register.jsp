<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>register.jsp</title>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js" referrerpolicy="no-referrer"></script>

    <script>
        $(function () {
            console.clear();
            console.debug(" jq start");

            $('#listBtn').on('click',function () {
                location.href="/news/listPerPage?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}"
            });
            
     
            
        }); //end jq
    </script>
</head>
<body>
    <h1>register.jsp</h1>

    <div id="wrapper">
        <form action="/news/register" method="POST">
            <table>
                <tr>
                    <td><label for="bno"></label></td>
                    <td><input type="hidden" id="bno" name="bno"></td>
                </tr>

                <tr>
                    <td><label for="reproot"></label></td>
                    <td><input type="hidden" id="reproot" name="reproot"></td>
                </tr>
                
                <tr>
                    <td><label for="bname"></label></td> 
                    <td><input type="hidden" id="bname" name="bname" value="뉴스게시판"></td>
                </tr>

                <tr>
                    <td><label for="title">제목</label></td>
                    <td><input type="text" id="title" name="title"size="20" placeholder="제목을 입력하세요."></td>
                </tr>
               
                <tr>
                    <td><label for="memberid">작성자 </label></td> 
                    <td><input name="memberid" rows="10" cols="20"  placeholder="작성자를 입력하세요." ></td>  
                </tr>
               
                <tr>
                    <td><label for="content">내용</label></td> 
                    <td><input name="content" rows="10" cols="50"  placeholder="내용을 입력하세요." ></td>  
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
                   
                </form>
                <tr>
                    <td colspan="2">&nbsp;</td>
                </tr>
                
                <tr>
                    <tr>
                        <td colspan="2">
                                <button type="submit" id="summitBtn">등록</button> 
                                <button type="button" id="listBtn">목록</button>
                                
                        </td>
                    </tr>
                </tr>

            </table>
        </form>
    </div>
</body>
</html>