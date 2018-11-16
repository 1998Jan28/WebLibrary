<%--
  Created by IntelliJ IDEA.
  User: lcy
  Date: 2018/11/15
  Time: 15:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>登陆系统</title>
  </head>
  <body>
    <h1>图书管理系统</h1>
    <form>
        <div>
            <span>账号 </span>
            <input type="text" id="userno" />
            <span>密码  </span>
            <input type="text" id="pwd" />
        </div>
        <div>
            <input type="submit" value="登陆" />
            <a href="./register.jsp">注册</a>
        </div>
    </form>
  </body>
</html>
