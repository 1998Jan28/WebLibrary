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
    <script src="https://code.jquery.com/jquery-3.3.1.js"
            integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
            crossorigin="anonymous"></script>

    <script type="text/javascript">
        var user=[{"id": 1, "name": "张三","age":"25"},
            {"id": 2, "name": "李四","age":"35"},
            {"id": 3, "name": "王五","age":"20"},
            {"id": 4, "name": "老王","age":"20"},
            {"id": 5, "name": "老张","age":"25"},
            {"id": 6, "name": "李四","age":"35"},
            {"id": 7, "name": "王五","age":"20"},
            {"id": 8, "name": "老王","age":"20"},
            {"id": 9, "name": "abc","age":"25"},
            {"id": 10, "name": "李b四","age":"35"},
            {"id": 11, "name": "125","age":"20"},
            {"id": 12, "name": "246","age":"20"},
            {"id": 13, "name": "张三","age":"25"},
            {"id": 14, "name": "李四","age":"35"},
            {"id": 15, "name": "王五","age":"20"},
            {"id": 16, "name": "老王","age":"20"},
            {"id": 17, "name": "张三","age":"25"},
            {"id": 18, "name": "李四","age":"35"},
            {"id": 19, "name": "王五","age":"20"},
            {"id": 20, "name": "老王","age":"20"}];
        $(document).ready(function(){
            var search = $("#search");
            search.keyup(function (event) {
                var searchText = search.val();
                var table = "<center><table><tr><td>姓名</td><td>年龄</td></tr>"
                if(searchText != ""){
                    $.each(user,function(id,item){
                        if(item.name.indexOf(searchText)!=-1){
                            table += "<tr><td>"+ item.name +"</td><td>+ item.age +</td></tr>"
                        }
                    })
                    table += "</table></center>"
                    $("#showbooks").html(table);
                }else{
                    var tip = "<center>请输入您需要的书籍</center>";
                    $("#showbooks").html(tip);
                }
            })
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
    </style>
    <title>图书系统</title>
</head>
<body>
    <%@include file="head.jsp" %>
    <div style="display: inline-block;margin-top:-20px;z-index: 9999;position: absolute;margin-left: 1350px;">
        <span style="color: white">您好!<span id="username">whut </span>&nbsp;|&nbsp;</span>
        <a href="./index.jsp" style="color: white;text-decoration: none;">注销</a>
    </div>
    <div style="text-align: center;margin-top: 100px;">
        <form>
            <input id="search" class="seainput" type="text" maxlength="100" />
            <input id="searchbtn" class="seabtn" type="submit" value="搜索图书" />
        </form>
    </div>
    <div id="showbooks" style="height: 300px;text-align: center">

    </div>
    <%@include file="footer.jsp"%>
</body>
</html>
