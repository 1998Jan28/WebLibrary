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
</head>
<body>
<%@include file="head.jsp" %>
<div style="line-height:70px;display: inline-block;margin-top:-70px;z-index: 9999;position: absolute;height:70px;left: 700px;">
    <nav class="link">
        <span><a href="user.jsp">首页</a></span><span><a href="userRecord.jsp">借书记录</a></span><span><a href="userPay.jsp" class="active">账户充值</a></span>
    </nav>
</div>
<div style="display: inline-block;margin-top:-20px;z-index: 9999;position: absolute;margin-left: 1350px;">
    <span style="color: white">您好!<span id="username">whut </span>&nbsp;|&nbsp;</span>
    <a href="./index.jsp" style="color: white;text-decoration: none;">注销</a>
</div>
<%@include file="footer.jsp"%>
</body>
</html>
