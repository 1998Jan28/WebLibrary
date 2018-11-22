<%--
  Created by IntelliJ IDEA.
  User: lcy
  Date: 2018/11/15
  Time: 15:49
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

    <script type="text/javascript">
        // var user=[{"id": 1, "name": "张三","age":"25"},
        //     {"id": 2, "name": "李四","age":"35"},
        //     {"id": 3, "name": "王五","age":"20"},
        //     {"id": 4, "name": "老王","age":"20"},
        //     {"id": 5, "name": "老张","age":"25"},
        //     {"id": 6, "name": "李四","age":"35"},
        //     {"id": 7, "name": "王五","age":"20"},
        //     {"id": 8, "name": "老王","age":"20"},
        //     {"id": 9, "name": "abc","age":"25"},
        //     {"id": 10, "name": "李b四","age":"35"},
        //     {"id": 11, "name": "125","age":"20"},
        //     {"id": 12, "name": "246","age":"20"},
        //     {"id": 13, "name": "张三","age":"25"},
        //     {"id": 14, "name": "李四","age":"35"},
        //     {"id": 15, "name": "王五","age":"20"},
        //     {"id": 16, "name": "老王","age":"20"},
        //     {"id": 17, "name": "张三","age":"25"},
        //     {"id": 18, "name": "李四","age":"35"},
        //     {"id": 19, "name": "王五","age":"20"},
        //     {"id": 20, "name": "老王","age":"20"}];
        var booksInfo;
        var paras={};


        function showBooks(){
            var search = $("#search");
            var initip = "<div style='height: 300px;border: none;'><center>您查找的书籍不存在</center></div>";
            var searchText = search.val();
            // var table = "<center><table><tr><td>书名</td><td>作者</td><td>ISBN</td><td>价格</td></tr>"
            var content ="";
            var num=0;
            $.each(booksInfo,function(id,item){
                if(item.BookName.indexOf(searchText)!=-1 || item.Author.indexOf(searchText)!=-1){
                    // table += "<tr><td>"+ item.BookName +"</td><td>"+ item.Author +"</td><td>"
                    //     + item.ISBN+"</td><td>"+ item.Price +"</td></tr>"
                    content+="<div>";
                    content+="<a href='bookDisplay.jsp?ISBN="+item.ISBN+"'><img src='./BookImg/"+item.ISBN+".jpg' /></a>"
                    content+="<a href='bookDisplay.jsp?ISBN="+item.ISBN+"'><span>书名:"+item.BookName+"</span></a>";
                    content+="<span>作者:"+item.Author+"</span>";
                    content+="<span>ISBN:"+item.ISBN+"</span>";
                    content+="<span>索书号:"+item.Index+"</span>";
                    content+="<span id='"+item.ISBN+"_amount'>馆藏:"+item.Amount+"</span>"
                    // content+="<button type=\"button\" class=\"btn btn-info\" id='"+item.ISBN+"_borrow'>借阅</button>"
                     content+="</div>";
                    num++;
                }
            })
            if(num==0){
                $("#showbooks").html(initip);
            }else{
                $("#showbooks").html(content);
            }
        }

        $(document).ready(function(){
            $.ajaxSettings.async = false;
            $.post("/UserSearchBooks",paras,function(obj){
                booksInfo=obj;
                console.log(booksInfo);
                //console.log(user);
            },"json");
            $.ajaxSettings.async = true;
            showBooks();
        });

        function jq_get(){
            //$.get("/demo","username=zhangsan&password=123",function(obj){})
            var paras = {
                "name":"zhangsan",
                "password":"123"
            }
            $.get("/demo",paras,function (obj) {
                console.log(obj);
            },"json");
        }

        function jq_post(){
            var paras = {
                "name":"zhangsan",
                "password":"123"
            }
            $.post("/demo",paras,function(obj){
                console.log(obj);
            },"json")
        }

        function jq_ajax(){
            $.ajax({
                "url":"/demo",
                "type":"post",
                "data":{"name":"zhangsan","password":"123"},
                "success":function(obj){console.log(obj);},
                "error":function(obj){console.log(obj);},
                "datatype":"json",
                "async":true
            });
        }
    </script>

    <style>
        .seainput{
            width: 480px;
            height:38px;
            font-size: 16px;
            border:1px solid #b8b8b8;
            border-bottom: 1px solid #ccc;
            border-right: 0;
            padding:0;
            margin:0;
        }
        .seabtn{
            cursor: pointer;
            width:102px;
            height:38px;
            line-height: 38px;
            padding:0;
            border:0;
            background-color: #38f;
            font-size:16px;
            color:white;
            margin-left: -4px;
        }
        #showbooks div{
            text-align: left;
            display: inline-block;
            border: 2px solid #b8b8b8;
            width: 1000px;
        }
        #showbooks div img{
            display: inline-block;
            margin-left: 20px;
            padding: 10px;
            float: left;
            width:150px;
            height:200px;
        }
        #showbooks div span{
            display:block;
            padding:10px;
            margin-left: 200px;
        }
        #showbooks div button{
            display:block;
            padding:10px;
            width: 100px;
            margin-right:200px;
            margin-top:-130px;
            font-size:20px;
            font-weight: bold;
            float:right;
        }
        .link{
            width:650px;
            height:70px;
            color:#eee;
        }
        .link span{
            margin:0;
            padding:0;
            display: inline-block;
        }
        .link a{
            text-decoration: none;
            font-size: 20px;
            color: #eee;
            width: 120px;
            height:70px;
            display: block;
            text-align: center;
        }
        .link a:hover ,
        .active{
            background-color: #000;
        }
    </style>
    <title>图书系统</title>
</head>
<body>
    <%@include file="head.jsp" %>
    <div style="line-height:70px;display: inline-block;margin-top:-70px;z-index: 9999;position: absolute;height:70px;left: 700px;">
        <nav class="link">
            <span><a href="user.jsp" class="active">首页</a></span><span><a href="userRecord.jsp">借书记录</a></span><span><a href="userPay.jsp">账户充值</a></span>
        </nav>
    </div>
    <div style="display: inline-block;margin-top:-20px;z-index: 9999;position: absolute;margin-left: 1350px;">
        <span style="color: white">您好!<span id="username">whut </span>&nbsp;|&nbsp;</span>
        <a href="./index.jsp" style="color: white;text-decoration: none;">注销</a>
    </div>
    <div style="text-align: center;margin-top: 100px;">
        <form>
            <input id="search" class="seainput" value="" onkeyup="showBooks()" type="text" maxlength="100" />
            <input id="searchbtn" class="seabtn" type="button" onclick="showBooks()" value="搜索图书" />
        </form>
    </div>
    <div id="showbooks" style="text-align: center;">

    </div>
    <%@include file="footer.jsp"%>
</body>
</html>
