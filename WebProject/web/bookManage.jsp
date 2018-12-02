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
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.3.1.js"
            integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
            crossorigin="anonymous"></script>
    <title>图书管理</title>
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
            content+="<caption>图书信息表</caption><tr> <th>索书号</th> <th>ISBN</th> <th>书名</th> <th>作者</th> <th>馆藏</th> <th>售价</th><th>修改信息</th></tr>";
            $.each(books,function(id,item){
                if(select == 1 || item.BookName.indexOf(searchText)!=-1 || item.Author.indexOf(searchText)!=-1){
                    content+="<tr>";
                    content+="<td>"+item.Index+"</td>";
                    content+="<td id='"+num+"'>"+item.ISBN+"</td>";
                    content+="<td>"+item.BookName+"</td>";
                    content+="<td>"+item.Author+"</td>";
                    content+="<td>"+item.Amount+"</td>";
                    content+="<td>"+item.Price+"</td>";
                    content+="<td><input type='submit' class='btn btn-warning' value='修改信息' onclick='showModifyBook("+num+")'></td>";
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
        function showAddBook() {
            document.getElementById("addBookForm").style.display="block";
            document.getElementById("bookForm").style.display = "none";
            document.getElementById("modifyBookForm").style.display = "none";
            $("#booklList").removeClass("active");
            $("#addBook").addClass("active");
        }
        function showBookList()
        {
            document.getElementById("addBookForm").style.display="none";
            document.getElementById("bookForm").style.display = "block";
            document.getElementById("modifyBookForm").style.display = "none";
            $("#booklList").addClass("active");
            $("#addBook").removeClass("active");
        }
    </script>
</head>
<body>
<div>
    <ul class="nav nav-tabs">
        <li id="booklList" style="cursor: pointer;" class="active" onclick="showBookList()"><a>图书列表</a></li>
        <li id="addBook" style="cursor: pointer;" onclick="showAddBook()"><a>添加图书</a></li>
    </ul>
</div>

<div id="addBookForm" style="display: none">
    <form role="form" method="post" action="/BookAdd" enctype="multipart/form-data">
        <div class="form-group">
            <label>书&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</label>
            <input type="text" class="form-control" style="margin-left:5px;display: inline-block;width: 300px;" name="BookName" maxlength="30" />
        </div>
        <div class="form-group">
            <label>I&nbsp;&nbsp;S&nbsp;&nbsp;B&nbsp;&nbsp;N&nbsp;&nbsp;</label>
            <input type="text" class="form-control" style="margin-left:5px;display: inline-block;width: 300px;" name="ISBN" maxlength="13"  />
        </div>
        <div class="form-group">
            <label>作&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;者</label>
            <input type="text" class="form-control" style="margin-left:5px;display: inline-block;width: 300px;" name="Author" maxlength="20" />
        </div>
        <div class="form-group">
            <label>售&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价</label>
            <input type="text" class="form-control" style="margin-left:5px;display: inline-block;width: 300px;" name="Price" />
        </div>
        <div class="form-group">
            <label>数&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;量</label>
            <input type="text" class="form-control" style="margin-left:5px;display: inline-block;width: 300px;" name="Amount" />
        </div>
        <div class="form-group">
            <label>索书号&nbsp;&nbsp;&nbsp;&nbsp;</label>
            <input type="text" class="form-control" style="margin-left:5px;display: inline-block;width: 300px;" name="Index" />
        </div>
        <div class="form-group">
            <label>内容简介</label>
            <input type="text" class="form-control" maxlength="200" style="margin-left:5px;display: inline-block;width: 300px;" name="Digest" />
        </div>
        <div class="form-group" style="border: none;">
            <label>图书封面</label>
            <input type="file" maxlength="200" style="border:none;margin-left:5px;display: inline-block;width: 300px;" name="uploadFile" />
        </div>
        <input type="submit" class="btn btn-success" style="margin-left: 150px;width: 100px;" value="添&nbsp;&nbsp;&nbsp;&nbsp;加" id="submit" />
    </form>
</div>
<div id="bookForm">
    <form style="margin-top: 3px;">
        <input class="form-control" style="display: inline-block;width: 200px;" id="search" placeholder="请输入书名或作者" type="text" onkeyup="showBooks(0)">
        <input id="search_btn" class="btn btn-default" type="button" onclick="showBooks(0)" value="搜索">
    </form>
     <table id="bookListTab" class="table table-hover" >

     </table>
</div>
<div id="modifyBookForm" style="display: none">
    <form role="form" method="post" action="/BookModify" enctype="multipart/form-data">
        <input type="text" id="proISBN" name="proISBN" style="display: none">
        <div class="form-group">
            <label for="modifyBookName">书&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</label>
            <input type="text" class="form-control" style="margin-left:5px;display: inline-block;width: 300px;" id="modifyBookName" name="BookName" maxlength="30" />
        </div>
        <div class="form-group">
            <label for="modifyISBN">I&nbsp;&nbsp;S&nbsp;&nbsp;B&nbsp;&nbsp;N&nbsp;&nbsp;</label>
            <input type="text" class="form-control" style="margin-left:5px;display: inline-block;width: 300px;" id="modifyISBN" name="ISBN" maxlength="13"  />
        </div>
        <div class="form-group">
            <label for="modifyAuthor">作&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;者</label>
            <input type="text" class="form-control" style="margin-left:5px;display: inline-block;width: 300px;" id="modifyAuthor" name="Author" maxlength="20" />
        </div>
        <div class="form-group">
            <label for="modifyPrice">售&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价</label>
            <input type="text" class="form-control" style="margin-left:5px;display: inline-block;width: 300px;" id="modifyPrice" name="Price" />
        </div>
        <div class="form-group">
            <label for="modifyAmount">数&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;量</label>
            <input type="text" class="form-control" style="margin-left:5px;display: inline-block;width: 300px;" id="modifyAmount" name="Amount" />
        </div>
        <div class="form-group">
            <label for="modifyIndex">索书号&nbsp;&nbsp;&nbsp;&nbsp;</label>
            <input type="text" class="form-control" style="margin-left:5px;display: inline-block;width: 300px;" id="modifyIndex" name="Index" />
        </div>
        <div class="form-group">
            <label for="modifyDigest">内容简介</label>
            <input type="text" class="form-control" maxlength="200" style="margin-left:5px;display: inline-block;width: 300px;" id="modifyDigest" name="Digest" />
        </div>
        <div class="form-group" style="border: none;">
            <label for="modifyCover">图书封面</label>
            <input type="file" maxlength="200" style="border:none;margin-left:5px;display: inline-block;width: 300px;" id="modifyCover" name="uploadFile" />
        </div>
        <input class="btn btn-success" style="margin-left: 80px;width: 100px;" type="submit" value="确定" id="modify" />
        <input class="btn btn-info" style="margin-left: 50px;width: 100px;" type="button" value="返回" onclick="showBookList()" />
    </form>
</div>
</body>
</html>
