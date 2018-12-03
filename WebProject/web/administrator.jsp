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
    <title>管理员</title>
    <script>
        function Jump(index) {
            var display = document.getElementById("display");
            if(index == 1){
                display.src = "./userManage.jsp";
            }
            else if(index == 2){
                display.src = "./bookManage.jsp";
            }
            else if(index == 3){
                display.src = "./BookReturn.jsp";
            }
        }
        function quit(){
            sessionStorage.clear();
        }

        $(document).ready(function(){
            if(sessionStorage.getItem("username")=="" || sessionStorage.getItem("username")=="null" || sessionStorage.getItem("username")== undefined){
                alert("您还没有登陆！")
                window.location.href = "./index.jsp";
            }
            $("#username").html(sessionStorage.getItem("username"));
            $("#usermanage").click(function(){
                $("#usermanage").addClass("active");
                $("#bookmanage").removeClass("active");
                $("#bookret").removeClass("active");
            });
            $("#bookmanage").click(function(){
                $("#usermanage").removeClass("active");
                $("#bookmanage").addClass("active");
                $("#bookret").removeClass("active");
            });
            $("#bookret").click(function(){
                $("#usermanage").removeClass("active");
                $("#bookmanage").removeClass("active");
                $("#bookret").addClass("active");
            });
        });
    </script>
    <style>
        #left {
            position:absolute;
            left: 10px;
            top: 20px;
            width: 150px;
            height: 150px;
            text-align: center;
        }
        #left a {

        }
        #right {
            position:absolute;
            left: 200px;
            top:15px;
            width: 1200px ;
            height: 550px;
        }
        #right iframe {
            width: 1200px ;
            height: 550px;
        }
    </style>
</head>
<body>
<%@include file="head.jsp" %>
<div style="display: inline-block;margin-top:-20px;z-index: 9999;position: absolute;margin-left: 1350px;">
    <span style="color: white">您好!<span id="username">whut </span>&nbsp;|&nbsp;</span>
    <a href="./index.jsp" style="color: white;text-decoration: none;" onclick="quit();">注销</a>
</div>
<div style="position: relative;width: 1500px;height: 600px;">
    <div id="left">
        <a href="./userManage.jsp" target="display" id="usermanage" class="list-group-item active">用户管理</a>
        <a href="./bookManage.jsp" target="display" id="bookmanage" class="list-group-item">图书管理</a>
        <a href="./BorrowAndReturn.jsp" target="display" id="bookret" class="list-group-item">图书归还</a>
        <%--<ul class="list-group">--%>
            <%--<li class="list-group-item" id="usermanage" onclick="Jump(1)">用户管理</li>--%>
            <%--<li class="list-group-item" id="bookmanage" onclick="Jump(2)">图书管理</li>--%>
            <%--<li class="list-group-item" id="bookret" onclick="Jump(3)">图书归还</li>--%>
        <%--</ul>--%>
    </div>
    <div id="right">
        <iframe name="display" src="userManage.jsp" frameborder="no" scrolling="yes" >

        </iframe>
    </div>
</div>
<%@include file="footer.jsp"%>
</body>
</html>
