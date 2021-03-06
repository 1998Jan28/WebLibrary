<%--
  Created by IntelliJ IDEA.
  User: lcy
  Date: 2018/11/15
  Time: 15:48
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

    <script>
        function check(){
            var username = document.getElementById("reg_username").value;
            var password = document.getElementById("reg_password").value;
            var cfmpassword = document.getElementById("reg_cfmpassword").value;
            var identi = document.getElementById("reg_identi").value;
            var tel = document.getElementById("reg_tel").value;

            if(username==null || username==""){
                document.getElementById("notify").innerHTML = "姓名不能为空";
                return false;
            }
            if(password==null || password==""){
                document.getElementById("notify").innerHTML = "密码不能为空";
                return false;
            }
            if(cfmpassword==null || cfmpassword==""){
                document.getElementById("notify").innerHTML = "确认密码不能为空";
                return false;
            }
            if(identi==null || identi==""){
                document.getElementById("notify").innerHTML = "身份证号码不能为空";
                return false;
            }
            if(tel==null || tel==""){
                document.getElementById("notify").innerHTML = "手机号码不能为空";
                return false;
            }
            if(password != cfmpassword){
                document.getElementById("notify").innerHTML = "两次密码输入不一致";
                return false;
            }
            return true;
        }
    </script>

    <style>
        body{background: url(./img/loginBG.jpg)no-repeat;background-size:cover;font-size: 16px;}
        form{
            background-color: rgba(255,255,255,0.9);
            padding:20px;
            padding-left: 40px;
            padding-right:40px;
        }
    </style>
    <title>用户注册</title>
</head>
<body>
<div>
    <div class="container" style="margin-top:200px;margin-left: -30px;">
        <form class="col-sm-offset-4col-sm-4 col-sm-offset-4 form form-horizontal" action="Register" method="post" onsubmit="return check()">
            <h3 class="text-center">用户注册</h3>
            <p id = "notify" style="color: red;margin-left:120px;"></p>
            <%
                request.setCharacterEncoding("UTF-8");
                String cardNum = (String)request.getAttribute("cardNum");
                if( cardNum != null){
                    out.print("<h3>注册成功！您的卡号为：" + cardNum + "</h3>");
                }
            %>
            <div class="form-group">
                <label class="col-sm-2 control-label">姓&nbsp;&nbsp;&nbsp;&nbsp;名</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control"  id="reg_username" name="reg_username" placeholder="请输入您的姓名" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;码</label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" id="reg_password" name="reg_password" placeholder="请输入您的密码" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">确认密码</label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" id="reg_cfmpassword" placeholder="请再次输入您的密码" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">身&nbsp;份&nbsp;证</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="reg_identi" name="reg_identi" placeholder="请输入您的身份证号码" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">手&nbsp;&nbsp;&nbsp;&nbsp;机</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="reg_tel" name="reg_tel" placeholder="请输入您的手机号码" />
                </div>
            </div>
            <button type="submit" class="btn btn-success center-block">注&nbsp;册</button>
            <div class="text-right">
                <a href="./index.jsp">返回系统</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
