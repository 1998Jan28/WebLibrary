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
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.3.1.js"
            integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
            crossorigin="anonymous"></script>
    <title>图书归还</title>
    <script>
        var borrowBooks;
        var books;
        $(document).ready(function () {
            if(sessionStorage.getItem("username")=="" || sessionStorage.getItem("username")=="null" || sessionStorage.getItem("username")== undefined){
                alert("您还没有登陆！")
                window.location.href = "./index.jsp";
            }
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
                        content+="<tr><th>索书号</th><th>图书名</th><th>借阅时间</th><th>还书</th></tr>";
                        document.getElementById("SearchResult").style.display="block";
                        $.each(record,function(id,item){
                            content+="<tr><td>"+item.Index+"</td><td>"+item.BookName+"</td><td>"+item.BorrowTime+"</td>";
                            content+="<td><input type='button' class='btn btn-success' value='还书' id='returnBtn"+item.Index+"' onclick='ReturnBook(\""+item.Index+"\")'></td>";
                            content+="</tr>";
                        })
                        $("#SearchResult").html(content);
                    },"json")
                }
            );
            $("#searchBorrowBookBtn").click(function () {
                var index = $("#SearchBook").val();
                var content = "<caption id=\"CardNum\">"+$("#SearchCard").val()+"的借书记录</caption>";
                content+="<tr><th>索书号</th><th>图书名</th><th>借阅时间</th><th>还书</th></tr>";
                document.getElementById("SearchResult").style.display="block";
                $.each(borrowBooks, function (id, item) {
                    if(item.Index == index){
                        content+="<tr>";
                        content+="<td>"+item.Index+"</td><td>"+item.BookName+"</td><td>"+item.BorrowTime+"</td>";
                        content+="<td><input type='button' class='btn btn-success' value='还书' id='returnBtn"+index+"' onclick='ReturnBook(\""+index+"\")'></td>";
                        content+="</tr>";
                    }
                })
                if(content == null){
                    content = "用户的借阅记录中没有该记录！";
                }
                $("#SearchResult").html(content);
            });

            $("#searchBookBtn").click(function(){
                var index = $("#SearchBook").val();
                var content = "<caption></caption>"
                content += "<tr><th>索书号</th><th>图书名</th><th>作者</th><th>借阅</th></tr>";
                document.getElementById("SearchResult").style.display="block";
                $.each(books, function (id, item) {
                    if(item.Index == index){
                        content+="<tr>";
                        content+="<td>"+item.Index+"</td><td>"+item.BookName+"</td><td>"+item.Author+"</td>";
                        content+="<td><input type='button' class='btn btn-success' value='借阅' id='borrowBtn' onclick='BorrowBook(\""+index+"\")'></td>";
                        content+="</tr>";
                    }
                })
                if(content == null){
                    content = "您所查找的书籍不存在!";
                }
                $("#SearchResult").html(content);
                $("#SearchResult").addClass('table');
                $("#SearchResult").addClass('table-hover');
            });
        });

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

                $("#booklList").removeClass("active");
                $("#addBook").addClass("active");
            }
            else{
                searchBorrowBookBtn.style.display = "none";
                searchBorrowUser.style.display = "none";
                searchBookBtn.style.display = "inline";

                $("#booklList").addClass("active");
                $("#addBook").removeClass("active");
            }
        }

        function ShowBook() {
            var index = $("#SearchBook").val();
            var content = "<tr><th>索书号</th><th>图书名</th><th>作者</th><th>借阅</th></tr>";
            document.getElementById("SearchResult").style.display="block";
            $.each(books, function (id, item) {
                if(item.Index == index){
                    content+="<tr>";
                    content+="<td>"+item.Index+"</td><td>"+item.BookName+"</td><td>"+item.Author+"</td>";
                    content+="<td><input type='button' class='btn btn-success' value='借阅' id='borrowBtn' onclick='BorrowBook(\""+index+"\")'></td>";
                    content+="</tr>";
                }
            })
            if(content == null){
                content = "您所查找的书籍不存在!";
            }
            $("#SearchResult").html(content);
            $("#SearchResult").addClass('table');
            $("#SearchResult").addClass('table-hover');
        }

        function Pay() {
            alert("赔偿成功")
        }
    </script>
</head>
<body>

<div>
    <ul class="nav nav-tabs">
        <li id="addBook" style="cursor: pointer;" class="active" onclick="ShowBorrow(false)"><a>还书</a></li>
        <li id="booklList" style="cursor: pointer;" onclick="ShowBorrow(true)"><a>借书</a></li>
    </ul>
</div>

<div style="margin-top: 3px;">
    <form role="form" id="borrowForm">
        <div class="form-group">
            <label>卡&nbsp;&nbsp;&nbsp;&nbsp;号</label>
            <input type="text" id= "SearchCard" name="SearchCard" class="form-control" style="margin-left:5px;display: inline-block;width: 300px;" name="BookName" maxlength="30" />
            <input type="button" class="btn btn-info" id="searchBorrowUser" style="width: 200px;margin-left: 5px;" value="根据查询借书记录" /></br>
        </div>
        <div class="form-group">
            <label>索书号</label>
            <input type="text" id= "SearchBook" name="SearchBook" class="form-control" style="margin-left:5px;display: inline-block;width: 300px;" name="BookName" maxlength="30" />
            <input type="button" class="btn btn-info" id="searchBorrowBookBtn" style="width: 200px;margin-left: 5px;" value="根据索书号查询借书记录" /></br>
            <input type="button" class="btn btn-info" id="searchBookBtn"  style="width: 200px;margin-left: 80px;margin-top:5px;display:none;" value="查询图书馆藏与借阅" />
        </div>
    </form>
</div>
<table id="SearchResult" class="table table-hover" style="display: none">

</table>

</body>
</html>
