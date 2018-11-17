<%--
  Created by IntelliJ IDEA.
  User: whutk
  Date: 2018/11/17
  Time: 8:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" import="java.util.*,java.io.*"%>
<html>
<head>
    <title>图书归还</title>
    <script>
        function SearchRecord() {
            var cardNum = document.getElementById("CardNum");
            var searchCard = document.getElementById("SearchCard");
            var searchResult = document.getElementById("SearchResult");
            cardNum.innerText = searchCard.value + "的借阅记录";
            searchResult.style.display = "table";
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
        <span>卡号</span><input id= "SearchCard" type="text">
        <button onclick="SearchRecord()">查询</button>
    </div>
    <div>
        <table id="SearchResult" style="display: none">
            <caption id="CardNum"></caption>
            <tr>
                <th>索书号</th>
                <th>图书名</th>
                <th>借阅时间</th>
                <th></th>
            </tr>
            <%! String[] text = new String[3];%>
            <%
                text[0] = "BC-5-121";
                text[1] = "Javascript学习指南";
                text[2] = "2018/11/17 9:11";
                for(int i = 0; i < 5; i++){
                    out.print("<tr>" +
                            "<td>" + text[0] + "</td>" +
                            "<td>" + text[1] + "</td>" +
                            "<td>" + text[2] + "</td>" +
                            "<td><button onclick=\"ReturnBook()\">归还</button></td>" +
                            "<td><button onclick=\"Pay()\">赔偿</button> </td>" +
                            "</tr>"
                    );
                }
            %>
        </table>
    </div>
</div>
</body>
</html>
