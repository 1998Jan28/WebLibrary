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
        var borrowBooks;
        var books;
        $(document).ready(function () {
            $.ajaxSettings.async = false;
            $.post("/UserSearchBooks", function (data) {
                books = data;
            }, "json")
            $.ajaxSettings.async = true;
            $("#searchBorrowUser").click(function () {
                    $.post("/BookReturn",{"SearchCard":$("#SearchCard").val()},function(data){
                        borrowBooks = data;
                        var record=data;
                        var content="<caption id=\"CardNum\">"+$("#SearchCard").val()+"的借书记录</caption>"
                        content+="<tr><th>索书号</th><th>图书名</th><th>借阅时间</th><th></th></tr>";
                        document.getElementById("SearchResult").style.display="block";
                        $.each(record,function(id,item){
                            content+="<tr><td>"+item.Index+"</td><td>"+item.BookName+"</td><td>"+item.BorrowTime+"</td>";
                            content+="<td><input type='button' value='归还' id='returnBtn"+item.Index+"' onclick='ReturnBook(\""+item.Index+"\")'></td>";
                            content+="</tr>";
                        })
                        $("#SearchResult").html(content);
                    },"json")
                }
            );
            $("#searchBorrowBookBtn").click(function () {
                var index = $("#SearchBook").val();
                var content = null;
                $.each(borrowBooks, function (id, item) {
                    if(item.Index == index){
                        content+="<tr><th>索书号</th><th>图书名</th><th>借阅时间</th>/tr>";
                        content+="<tr>";
                        content+="<td>"+item.Index+"</td><td>"+item.BookName+"</td><td>"+item.BorrowTime+"</td>";
                        content+="<td><input type='button' value='归还' id='returnBtn"+index+"' onclick='ReturnBook(\""+index+"\")'></td>";
                        content+="</tr>";
                    }
                })
                if(content == null){
                    content = "用户的借阅记录中没有该记录！";
                }
                $("#SearchResult").html(content);
            })
        })

        function ReturnBook(index){
            var cardNum = $("#SearchCard").val();
            $.post("/BorrowAndReturn", {"Index" : index, "Operation" : "1", "CardNum" : cardNum}, function (result) {
                var flag = result["flag"];
                if(flag == 2){
                    alert("用户余额不足！");
                }
                else if(flag == 1){
                    alert("归还成功！");
                    $("#searchBorrowUser").click();
                }
                else{
                    alert("归还失败!");
                }
            }, "json")
        }

        function BorrowBook(index){
            var cardNum = $("#SearchCard").val();
            if(cardNum != ""){
                $.post("/BorrowAndReturn", {"Index" : index, "Operation" : "2", "CardNum" : cardNum}, function (result) {
                    var flag = result["flag"];
                    if(flag == 1){
                        alert("借阅成功！");
                    }
                    else if(flag == 2){
                        alert("该用户不存在！");
                    }
                    else if(flag == 3){
                        alert("余额不足！")
                    }
                    else{
                        alert("借阅失败!");
                    }
                }, "json")
            }
            else{
                alert("请输入卡号！")
            }
        }

        function ShowBorrow(flag) {
            var searchBorrowUser = document.getElementById("searchBorrowUser");
            var searchUser = document.getElementById("searchUser");
            var searchBorrowBookBtn = document.getElementById("searchBorrowBookBtn");
            var searchBookBtn = document.getElementById("searchBookBtn");
            $("#SearchResult").html("");
            $("#SearchBook").attr("value", "");
            if(!flag){
                searchBorrowBookBtn.style.display = "inline";
                searchBorrowUser.style.display = "inline";
                searchBookBtn.style.display = "none";
            }
            else{
                searchBorrowBookBtn.style.display = "none";
                searchBorrowUser.style.display = "none";
                searchBookBtn.style.display = "inline";
            }
        }

        function ShowBook() {
            var index = $("#SearchBook").val();
            var content = null;
            $.each(books, function (id, item) {
                if(item.Index == index){
                    content+="<tr><th>索书号</th><th>图书名</th><th>作者</th></tr>";
                    content+="<tr>";
                    content+="<td>"+item.Index+"</td><td>"+item.BookName+"</td><td>"+item.Author+"</td>";
                    content+="<td><input type='button' value='借阅' id='borrowBtn' onclick='BorrowBook(\""+index+"\")'></td>";
                    content+="</tr>";
                }
            })
            if(content == null){
                content = "您所查找的书籍不存在!";
            }
            $("#SearchResult").html(content);
            document.getElementById("SearchResult").style.display = "block";
        }

        function Pay() {
            alert("赔偿成功")
        }
    </script>
</head>
<body>
<div>
    <div>
        <ul>
            <li onclick="ShowBorrow(true)">借书</li>
            <li onclick="ShowBorrow(false)">还书</li>
        </ul>
        <form id="borrowForm">
            <span>卡号</span><input id= "SearchCard" name="SearchCard" type="text">
            <input type="button" id="searchBorrowUser" value="查询" /></br>
            <span>索引号</span><input id="SearchBook" name="SearchBook" type="text">
            <input type="button" id="searchBorrowBookBtn" value="查询">
            <input type="button" id="searchBookBtn"  onclick="ShowBook()" style="display:none;" value="查询">
        </form>
    </div>
    <div>
        <table id="SearchResult" style="display: none">

        </table>
    </div>
</div>
</body>
</html>
