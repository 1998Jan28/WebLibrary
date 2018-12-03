<%--
  Created by IntelliJ IDEA.
  User: lcy
  Date: 2018/11/22
  Time: 21:19
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
    <style>
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

    <script>
        $(document).ready(function(){
            if(sessionStorage.getItem("username")=="" || sessionStorage.getItem("username")=="null" || sessionStorage.getItem("username")== undefined){
                alert("您还没有登陆！")
                window.location.href = "./index.jsp";
            }
            $("#username").html(sessionStorage.getItem("username"));
            $("#money").html(sessionStorage.getItem("money"));
        });
        function quit(){
            sessionStorage.clear();
        }
    </script>
</head>
<body>
<%@include file="head.jsp" %>
<div style="line-height:70px;display: inline-block;margin-top:-70px;z-index: 9999;position: absolute;height:70px;left: 700px;">
    <nav class="link">
        <span><a href="user.jsp">首页</a></span><span><a href="userRecord.jsp">借书记录</a></span><span><a href="userPay.jsp" class="active">余额查询</a></span>
    </nav>
</div>
<div style="display: inline-block;margin-top:-20px;z-index: 9999;position: absolute;margin-left: 1350px;">
    <span style="color: white">您好!<span id="username">whut </span>&nbsp;|&nbsp;</span>
    <a href="./index.jsp" style="color: white;text-decoration: none;" onclick="quit();">注销</a>
</div>
<div style="width: 100%;height:300px;position: relative">
    <span style="position:absolute;top:100px;left:600px;font-size: 30px;font-weight: bolder;">您的余额为：<span id="money"></span>元</span>
    <p style="position:absolute;color:red;float: right;bottom: 5px;right:5px;">充值请联系管理员</p>
</div>
<%@include file="footer.jsp"%>
</body>
</html>
