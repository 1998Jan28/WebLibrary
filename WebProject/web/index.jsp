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
    <title>欢迎</title>
  </head>
  <body>
  <div>
    <h1>欢迎使用图书管理系统</h1>
  </div>
  <div>
    <form method="post">
      <div>
        卡号<input type="text">
      </div>
      <div>
        密码<input type="password">
      </div>
      <div>
        <input type="radio" name="role">普通用户
        <input type="radio" name="role">管理员
      </div>
      <div>
        <input id="login" type="submit" value="登陆">
        <button id="register">注册</button>
      </div>
    </form>
  </div>
  </body>
</html>
