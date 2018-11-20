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
    <script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#search").submit(
                function () {
                    $.post("/BookReturn",{"SearchCard":$("#SearchCard").val()},function(data){
                        alert(data);
                        $("#SearchResult").style.display = "block";
                        $("#test").innerHTML = data;
                        $("#dis").innerHTML = data;
                    })
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
        <form method="post" id="search">
            <span>卡号</span><input id= "SearchCard" name="SearchCard" type="text">
            <input type="submit"  value="提交"></input>
        </form>
    </div>
    <div id="dis"></div>
    <div>
        <table id="SearchResult" style="display: none">
            <caption id="CardNum"></caption>
            <tr>
                <th>索书号</th>
                <th>图书名</th>
                <th>借阅时间</th>
                <th></th>
            </tr>
            <td id="test"></td>
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
