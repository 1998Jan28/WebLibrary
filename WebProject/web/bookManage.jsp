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
    <script language="JavaScript">
        function addBook() {
            document.getElementById("addBookForm").style.display="block";
            document.getElementById("bookListTab").style.display="none";
        }
        function bookList()
        {
            document.getElementById("addBookForm").style.display="none";
            document.getElementById("bookListTab").style.display="block"
        }

    </script>
</head>
<body>
<div>
    <ul>
        <li id="addBook" onclick="addBook()">添加图书</li>
        <li id="booklList" onclick="bookList()">图书列表</li>
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
<div style="width: 500px">
     <table border="1px" id="bookListTab" style="display: block;" >
         <caption>图书信息表</caption>
         <tr>
             <td>书名</td>
             <td>作者</td>
             <td>ISBN</td>
             <td>馆藏</td>
             <td>索书号</td>
             <td>售价</td>
             <td>删除</td>
             <td>修改</td>
         </tr>
     </table>

</div>

</body>
</html>
