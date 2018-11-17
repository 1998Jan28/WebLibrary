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
    <title>管理员</title>
    <script>
        function Jump(index) {
            var display = document.getElementById("display");
            if(index == 1){
                display.src = "./userManage.jsp";
            }
            else if(index == 2){
                display.src = "https://passport.weibo.com";
            }
            else if(index == 3){
                display.src = "./BookReturn.jsp";
            }
        }
    </script>
</head>
<body>
<div>
    <div style="margin-top: 10px;">
        <a href="./index.jsp" style="float: right;">注销</a>
        <label style="float: right;">whut，您好！</label>
    </div>
    <div style="margin-top: 30px;">
        <div>
            <ul style="float: left;list-style: none;">
                <li onclick="Jump(1)">用户管理</li>
                <li onclick="Jump(2)">图书管理</li>
                <li onclick="Jump(3)">图书归还</li>
            </ul>
        </div>
        <div>
            <iframe id="display" src="./BookReturn.jsp" style="float: right;margin-right: 10px;width: 80%;height: 500px;overflow-scrolling: auto;" >
                <p>您的浏览器不支持IE!</p>
            </iframe>
        </div>
    </div>
</div>
</body>
</html>
