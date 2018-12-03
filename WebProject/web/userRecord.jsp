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
    <script>
        $(document).ready(function(){
            if(sessionStorage.getItem("username")=="" || sessionStorage.getItem("username")=="null" || sessionStorage.getItem("username")== undefined){
                alert("您还没有登陆！")
                window.location.href = "./index.jsp";
            }
            var cardNum=sessionStorage.getItem("cardnum");
            $("#username").html(sessionStorage.getItem("username"));
            $.post("/BookReturn",{"SearchCard":cardNum},function(data){
                console.log(data);
                var content="<center><table class='table table-hover'><tr><td>#</td><td>书名</td><td>索引号</td><td>借阅时间</td></tr>";
                var num=1;
                $.each(data,function(id,item){
                    content+="<tr>";
                    content+="<td>"+num+"</td>";
                    content+="<td>"+item.BookName+"</td>";
                    content+="<td>"+item.Index+"</td>";
                    content+="<td>"+item.BorrowTime+"</td>";
                    content+="</tr>";
                    num++;
                })
                content+="</table></center>";
                $("#showRecords").html(content);
            },"json")
        });

        function quit(){
            sessionStorage.clear();
        }
    </script>
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
        #showRecords{
            text-align: center;
            display: inline-block;
            width: 1000px;
            height:580px;
            margin-left:350px;
        }
        #showRecords table{
            font-size: 23px;
            margin-top:20px;
        }
        #showRecords table tr{

        }
        #showRecords table td{

        }
    </style>
    <title>图书系统</title>
</head>
<body>
<%@include file="head.jsp" %>
<div style="line-height:70px;display: inline-block;margin-top:-70px;z-index: 9999;position: absolute;height:70px;left: 700px;">
    <nav class="link">
        <span><a href="user.jsp">首页</a></span><span><a href="userRecord.jsp" class="active">借书记录</a></span><span><a href="userPay.jsp">余额查询</a></span>
    </nav>
</div>
<div style="display: inline-block;margin-top:-20px;z-index: 9999;position: absolute;margin-left: 1350px;">
    <span style="color: white">您好!<span id="username">whut </span>&nbsp;|&nbsp;</span>
    <a href="./index.jsp" style="color: white;text-decoration: none;" onclick="quit();">注销</a>
</div>
<div id="showRecords">

</div>
<%@include file="footer.jsp"%>
</body>
</html>
