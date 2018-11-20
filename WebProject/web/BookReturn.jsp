<%--
  Created by IntelliJ IDEA.
  User: whutk
  Date: 2018/11/17
  Time: 8:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" import="java.util.*,java.io.*,org.json.JSONArray"%>
<%@ page import="org.json.JSONArray" %>
<html>
<head>
    <title>图书归还</title>
    <script src="https://code.jquery.com/jquery-3.3.1.js"
            integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
            crossorigin="anonymous"></script>
    <script>
        $(document).ready(function () {
            $("#search").click(function () {
                    $.post("/BookReturn",{"SearchCard":$("#SearchCard").val()},function(data){
                        console.log(1);
                        //alert(data);
                        var record=data;
                        var content="<caption id=\"CardNum\">"+$("#SearchCard").val()+"的借书记录</caption>"
                        content+="<tr><th>索书号</th><th>图书名</th><th>借阅时间</th><th></th></tr>";
                        document.getElementById("SearchResult").style.display="block";
                        $.each(record,function(id,item){
                            content+="<tr><td>"+item.Index+"</td><td>"+item.BookName+"</td><td>"+item.BorrowTime+"</td></tr>";
                        })
                        $("#SearchResult").html(content);
                    },"json")
                }
            );
        })
        function SearchRecord() {
            var cardNum = document.getElementById("CardNum");
            var searchCard = document.getElementById("SearchCard");
            var searchResult = document.getElementById("SearchResult");
            if(searchCard.value.trim() == ""){
                alert("请输入卡号");
            }
            else{
                cardNum.innerText = searchCard.value + "的借阅记录";
            }
        }

        function ReturnBook(){
            alert("归还成功");
        }

        function Pay() {
            alert("赔偿成功")
        }
    </script>
</head>
<body>
<div>
    <div>
        <form method="post">
            <span>卡号</span><input id= "SearchCard" name="SearchCard" type="text">
            <input type="button" id="search" value="提交" />
        </form>
    </div>
    <div id="dis"></div>
    <div>
        <table id="SearchResult" style="display: none">

            <%--<%--%>
                <%--JSONArray list = (JSONArray)request.getAttribute("records");--%>
                <%--if(list != null){--%>
                    <%--text[0] = "BC-5-121";--%>
                    <%--text[1] = "Javascript学习指南";--%>
                    <%--text[2] = "2018/11/17 9:11";--%>
                    <%--for(int i = 0; i < 5; i++){--%>
                        <%--out.print("<tr>" +--%>
                                <%--"<td>" + text[0] + "</td>" +--%>
                                <%--"<td>" + text[1] + "</td>" +--%>
                                <%--"<td>" + text[2] + "</td>" +--%>
                                <%--"<td><button onclick=\"ReturnBook()\">归还</button></td>" +--%>
                                <%--"<td><button onclick=\"Pay()\">赔偿</button> </td>" +--%>
                                <%--"</tr>"--%>
                        <%--);--%>
                    <%--}--%>
                <%--}--%>
            <%--%>--%>
        </table>
    </div>
</div>
</body>
</html>
