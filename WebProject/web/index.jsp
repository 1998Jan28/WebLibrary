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
      <!-- Latest compiled and minified CSS -->
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
      <!-- Optional theme -->
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
      <!-- Latest compiled and minified JavaScript -->
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

      <style>
          body{background: url(./img/loginBG.jpg)no-repeat;background-size:cover;font-size: 16px;}
          form{
              background-color: rgba(255,255,255,0.4);
              padding:20px;
              padding-left: 40px;
              padding-right:40px;
          }
      </style>

      <title>登陆系统</title>
  </head>
  <body>
    <div class="container" style="margin-top:200px;margin-left: -30px;">
        <form class="col-sm-offset-4col-sm-4 col-sm-offset-4 form form-horizontal" action="#" method="post">
            <h3 class="text-center">用户登陆</h3>
            <div class="form-group">
                <label class="col-sm-2 control-label">账&nbsp;号</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control"  id="username" placeholder="请输入卡号" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">密&nbsp;码</label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" id="password" placeholder="请输入密码" />
                </div>
            </div>
            <button type="submit" class="btn btn-success center-block">登&nbsp;陆</button>
            <div class="text-right">
                <a href="./register.jsp" style="color: white">注册新账号</a>
            </div>
        </form>
    </div>
  </body>
</html>
