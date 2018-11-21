<%--
  Created by IntelliJ IDEA.
  User: lcy
  Date: 2018/11/17
  Time: 10:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>图书管理</title>
    <style type="text/css">
        ul {
            overflow: hidden;
            white-space:nowrap;
        }
        li {
            list-style: none;
            float: left;
            margin-left:25px;
            width: 130px;
        }
        td {
            cellspacing: 30px;
        }

    </style>
    <%--<script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js"></script>--%>
    <script src="https://code.jquery.com/jquery-3.3.1.js"
            integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
            crossorigin="anonymous"></script>
    <script>
        var paras = {};
        var books;
        function showBooks(select){
            var search = $("#search");
            var initip = "<div style='height: 300px;border: none;'><center>您查找的书籍不存在</center></div>";
            var searchText = search.val();
            // var table = "<center><table><tr><td>书名</td><td>作者</td><td>ISBN</td><td>价格</td></tr>"
            var content ="";
            var num=0;
            content+="<caption>图书信息表</caption><tr> <th>索书号</th> <th>ISBN</th> <th>书名</th> <th>作者</th> <th>馆藏</th> <th>售价</th></tr>";
            $.each(books,function(id,item){
                if(select == 1 || item.BookName.indexOf(searchText)!=-1 || item.Author.indexOf(searchText)!=-1){
                    content+="<tr>";
                    content+="<td>"+item.Index+"</td>";
                    content+="<td id='"+num+"'>"+item.ISBN+"</td>";
                    content+="<td>"+item.BookName+"</td>";
                    content+="<td>"+item.Author+"</td>";
                    content+="<td>"+item.Amount+"</td>";
                    content+="<td>"+item.Price+"</td>";
                    content+="<td style='border: 0px'><input type='submit' value='修改' onclick='showModifyBook("+num+")'></td>";
                    content+="<td style='border: 0px'><input type='submit' value='删除' onclick='deleteBook("+num+")'></td>";
                    content+="</tr>";
                    num++;
                }
            })
            if(num==0){
                $("#bookListTab").html(initip);
            }else{
                $("#bookListTab").html(content);
            }
            $("#bookForm").style.display = "block";
        }

        $(document).ready(function () {
            $.ajaxSettings.async = false;
            $.post("/UserSearchBooks", paras, function (data) {
                books = data;
            }, "json")
            $.ajaxSettings.async = true;
            showBooks(1);
        });
        function modifyBook(num){
            var ISBN = $("#"+num).text();

        };
        function deleteBook(num) {
            var ISBN = {"ISBN":$("#"+num).text()};
            $.post("/BookDelete", ISBN, function (result) {
                var flag;
                $.each(result, function (index) {
                    flag = result[index];
                })
                console.log(flag)
                if(flag){
                    alert("删除成功！");
                }
                else{
                    alert("删除失败！");
                }
                location.reload();
            }, "json")
        }
        function showModifyBook(num)
        {
            document.getElementById("addBookForm").style.display="none";
            document.getElementById("bookForm").style.display = "none";
            document.getElementById("modifyBookForm").style.display = "block";
            var ISBN = $("#"+num).text();
            $.each(books, function (id, item) {
                if(item.ISBN == ISBN){
                    $("#modifyBookName").attr("value", item.BookName);
                    $("#modifyISBN").attr("value", ISBN);
                    $("#modifyAuthor").attr("value", item.Author);
                    $("#modifyDigest").attr("value", item.Digest);
                    $("#modifyPrice").attr("value", item.Price);
                    $("#modifyAmount").attr("value", item.Amount);
                    $("#modifyIndex").attr("value", item.Index);
                    $("#proISBN").attr("value", ISBN);
                }
            })
        }
    </script>
    <script language="JavaScript">
        function showAddBook() {
            document.getElementById("addBookForm").style.display="block";
            document.getElementById("bookForm").style.display = "none";
            document.getElementById("modifyBookForm").style.display = "none";
        }
        function showBookList()
        {
            document.getElementById("addBookForm").style.display="none";
            document.getElementById("bookForm").style.display = "block";
            document.getElementById("modifyBookForm").style.display = "none";
        }

    </script>
</head>
<body>
<div>
    <ul>
        <li id="addBook" onclick="showAddBook()">添加图书</li>
        <li id="booklList" onclick="showBookList()">图书列表</li>
    </ul>
</div>
<div id="addBookForm" style="display: none">
    <form method="post" action="/BookAdd" enctype="multipart/form-data">
        书名：<input type="text" name="BookName" maxlength="30"><br/>
        ISBN:<input type="text" name="ISBN" maxlength="13"><br/>
        作者：<input type="text" name="Author" maxlength="20"><br/>
        售价：<input type="text" name="Price"><br/>
        数量：<input type="text" name="Amount"><br/>
        索书号：<input type="text" name="Index"><br/>
        内容简介：<input type="text" name="Digest" size="8" maxlength="200"><br/>
        图书封面：<input type="file" name="uploadFile" /><br/>
        <input type="submit" value="添加" id="submit" />
    </form>
</div>
<div id="bookForm" style="width: 500px">
    <form>
        <input id="search" type="text" onkeyup="showBooks(0)">
        <input id="search_btn"type="button" onclick="showBooks(0)" value="搜索">
    </form>
     <table border="1" id="bookListTab" style="display: block;" >

     </table>
</div>
<div id="modifyBookForm" style="display: none">
    <form method="post" action="/BookModify" enctype="multipart/form-data">
        <input type="text" id="proISBN" name="proISBN" style="display: none">
        书名：<input type="text" id="modifyBookName" name="BookName" maxlength="30"><br/>
        ISBN:<input type="text" id="modifyISBN" name="ISBN" maxlength="13"><br/>
        作者：<input type="text" id="modifyAuthor" name="Author" maxlength="20"><br/>
        售价：<input type="text" id="modifyPrice" name="Price"><br/>
        数量：<input type="text" id="modifyAmount" name="Amount"><br/>
        索书号：<input type="text" id="modifyIndex" name="Index"><br/>
        内容简介：<input type="text" id="modifyDigest" name="Digest" size="8" maxlength="200"><br/>
        图书封面：<input type="file" id="modifyCover" name="uploadFile" /><br/>
        <input type="submit" value="确定" id="modify" />
        <input type="button" value="返回" onclick="showBookList()" />
    </form>
</div>
</body>
</html>
