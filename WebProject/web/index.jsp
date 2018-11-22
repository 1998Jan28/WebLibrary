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
      <script type="text/javascript" src="JS/ajax.js"></script>
      <script src="https://code.jquery.com/jquery-3.3.1.js"
              integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
              crossorigin="anonymous"></script>

      <script>

          function check(){
              var username = document.getElementById("username").value;
              var password = document.getElementById("password").value;

              //用户名和密码不能为空
              if(username==null || username==""){
                  document.getElementById("notify").innerHTML = "用户名不能为空";
                  return false;
              }
              if(password==null || password==""){
                  document.getElementById("notify").innerHTML = "密码不能为空";
                  return false;
              }

              //用户名和密码是否正确
              $.post("/Login",{"cardNum":username,"password":password},function(data){
                  console.log(data);
                    if(data.flag=="账号不存在" || data.flag=="密码错误") {
                        document.getElementById("notify").innerHTML = data.flag;
                    }else{
                        sessionStorage.setItem('username',username);
                        if(username.length>=8)
                            window.location.href="/user.jsp";
                        else
                            window.location.href="/administrator.jsp";
                    }
              },"json")

              var temp=document.getElementById("notify").innerText;
              console.log(temp);
              if(temp=="密码错误"||temp=="账号不存在") {
                  return false;
              }
              return true;
          }
          function ajaxcheckCardNum(){
              var url="Validate";
              var cardNum=document.getElementById("username").value;
              var params="cardNum="+cardNum;
              sendRequest(url,params,'POST',showresult);
          }
          function showresult(){
              if (httpRequest.readyState == 4) {
                  if (httpRequest.status == 200) {
                      var info=httpRequest.responseText;
                      document.getElementById("notify").innerHTML =info;
                  }
              }
          }
      </script>

      <style>
          body{background: url(./img/loginBG.jpg)no-repeat;background-size:cover;background-size: ;font-size: 16px;}
          form{
              background-color: rgba(255,255,255,0.9);
              padding:20px;
              padding-left: 40px;
              padding-right:40px;
          }
      </style>

      <title>登陆系统</title>
  </head>
  <body>
    <div class="container" style="margin-top:200px;margin-left: -30px;">
        <form class="col-sm-offset-4col-sm-4 col-sm-offset-4 form form-horizontal" method="post">
            <h3 class="text-center">用户登陆</h3>
            <p id = "notify" style="color: red;margin-left:120px;"></p>
            <div class="form-group">
                <label class="col-sm-2 control-label">账&nbsp;号</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control"  id="username" name="cardNum" placeholder="请输入卡号" onblur="ajaxcheckCardNum()"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">密&nbsp;码</label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码" />
                </div>
            </div>

            <button type="button" onclick="check()" class="btn btn-success center-block">登&nbsp;陆</button>
            <div class="text-right">
                <a href="./register.jsp">注册新账号</a>
            </div>
        </form>
    </div>
  </body>
</html>
