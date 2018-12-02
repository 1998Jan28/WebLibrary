<%--
  Created by IntelliJ IDEA.
  User: lcy
  Date: 2018/11/17
  Time: 10:42
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
    <title>用户管理</title>

    <script>

        var users;

        function DeleteUser(num) {
            var cardNum = $("#"+num).text();
            $.post("/DeleteUser",{"CardNum" : cardNum}, function (result) {
                var flag = result["flag"];
                if(flag){
                    location.reload();
                    alert("删除成功！");
                }
                else{
                    alert("删除失败！");
                }
            }, "json")
        }

        function ShowAddUser() {
            var main = document.getElementById("main");
            var addUser = document.getElementById("addUser");
            var modifyUser = document.getElementById("modifyUser");
            var modifyBtn = document.getElementById("modifyBtn");
            var addBtn = document.getElementById("addBtn");
            main.style.display = "none"
            addUser.style.display = "block";
            modifyUser.style.display = "none";
            modifyBtn.style.display = "none";
            addBtn.style.display = "block";

            $("#nav_adduser").addClass("active");
            $("#nav_showuser").removeClass("active");
        }

        function ShowMain() {
            var main = document.getElementById("main");
            var addUser = document.getElementById("addUser");
            var modifyUser = document.getElementById("modifyUser");
            var modifyBtn = document.getElementById("modifyBtn");main.style.display = "block"
            addUser.style.display = "none";
            modifyUser.style.display = "none";
            modifyBtn.style.display = "none";

            $("#nav_showuser").addClass("active");
            $("#nav_adduser").removeClass("active");
        }

        function ShowModifyUser(num) {
            var card = $("#" + num).text();
            var modifyUser = document.getElementById("modifyUser");
            var modifyBtn = document.getElementById("modifyBtn");
            var addBtn = document.getElementById("addBtn");
            ShowAddUser();
            modifyUser.style.display = "block";
            modifyBtn.style.display = "block";
            addBtn.style.display = "none";
            $("#cardNum").attr("value", card);
            $("#userName").attr("value", $("#Name"+num).text());
            $("#pwd").attr("value", $("#Pwd"+num).text());
            $("#identification").attr("value", $("#Identification"+num).text());
            $("#tele").attr("value", $("#Tele"+num).text());
            $("#confirmPwd").attr("value", $("#Pwd"+num).text());
        }

        function showUsers(select){
            var search = $("#search");
            var initip = "<div style='height: 300px;border: none;'><center>您查找的用户不存在</center></div>";
            var searchText = search.val();
            var content ="";
            var num=0;
            content+="<table class='table table-hover'><caption>用户信息表</caption><tr> <th>卡号</th> <th>姓名</th> <th>身份证号</th> <th>电话号码</th> <th>余额</th> <th>密码</th><th>修改信息</th></tr>";
            $.each(users,function(id,item){
                if(select == 1 || item.CardNum.indexOf(searchText)!=-1 || item.Name.indexOf(searchText)!=-1 || item.Identification.indexOf(searchText) != -1){
                    content+="<tr>";
                    content+="<td id='"+num+"'>"+item.CardNum+"</td>";
                    content+="<td id='Name"+num+"'>"+item.Name+"</td>";
                    content+="<td id='Identification"+num+"'>"+item.Identification+"</td>";
                    content+="<td id='Tele"+num+"'>"+item.Tele+"</td>";
                    content+="<td>"+item.Money+"</td>";
                    content+="<td id='Pwd"+num+"'>"+item.Pwd+"</td>";
                    content+="<td><input type='submit' class='btn btn-warning' value='修改信息' onclick='ShowModifyUser("+num+")'></td>";
                    content+="</tr>";
                    num++;
                }
            })
            content+="</table>";
            if(num==0){
                $("#userList").html(initip);
            }else{
                $("#userList").html(content);
            }
        }

        $(document).ready(function () {
            $.ajaxSettings.async = false;
            $.post("/UserList", function (data) {
                users = data;
            }, "json")
            $.ajaxSettings.async = true;
            showUsers(1);

            $("#addBtn").click(function () {
                var paras = {
                    "Pwd" : $("#pwd").val(),
                    "Name" : $("#userName").val(),
                    "Identification" : $("#identification").val(),
                    "Tele" : $("#tele").val()
                };
                if($("#pwd").val() == $("#confirmPwd").val()){
                    $.post("/AddUser", paras, function (result) {
                        var cardNum = result["CardNum"];
                        if(cardNum == -1){
                            alert("添加失败！");
                        }
                        else{
                            location.reload();
                            alert("添加成功！卡号为：" + cardNum);
                        }
                    }, "json")
                }
                else{
                    alert("两次输入密码不一样");
                }
            })
            $("#modifyBtn").click(function () {
                var paras = {
                    "CardNum": $("#cardNum").val(),
                    "Pwd" : $("#pwd").val(),
                    "Name" : $("#userName").val(),
                    "Identification" : $("#identification").val(),
                    "Tele" : $("#tele").val()
                };
                if($("#pwd").val() == $("#confirmPwd").val()){
                    $.post("/ModifyUser", paras, function (result) {
                        if(!result["flag"]){
                            alert("修改失败！");
                        }
                        else{
                            location.reload();
                            alert("修改成功！");
                        }
                    }, "json")
                }
                else{
                    alert("两次输入密码不一样");
                }
            })
        })
    </script>
    <style>

    </style>
</head>
<body>
<div>
    <div>
        <ul class="nav nav-tabs">
            <li id="nav_showuser" style="cursor: pointer;" class="active" onclick="ShowMain()"><a>用户列表</a></li>
            <li id="nav_adduser" style="cursor: pointer;" onclick="ShowAddUser()"><a>增加用户</a></li>
        </ul>
    </div>
    <div style="margin-top: 3px;">
        <div id="main">
            <div>
                <input class="form-control" style="display: inline-block;width: 200px;" id="search" placeholder="请输入卡号" type="text" onkeyup="showUsers(0)">
                <button class="btn btn-default" onclick="showUsers(0)">搜索</button>
            </div>
            <div id="userList">

            </div>
        </div>
        <div id="addUser" style="display: none;">
            <form  role="form">
                <div  id="modifyUser" class="form-group">
                    <label for="cardNum">卡&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号</label>
                    <input type="text" readonly="readonly" class="form-control" style="margin-left:5px;display: inline-block;width: 300px;" id="cardNum" />
                </div>
                <div class="form-group">
                    <label for="userName">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</label>
                    <input type="text" class="form-control" style="margin-left:5px;display: inline-block;width: 300px;" id="userName" placeholder="请输入姓名" />
                </div>
                <div class="form-group">
                    <label for="identification">身份证号</label>
                    <input type="text" class="form-control" style="margin-left:5px;display: inline-block;width: 300px;" id="identification" placeholder="请输入身份证号" />
                </div>
                <div class="form-group">
                    <label for="tele">电话号码</label>
                    <input type="text" class="form-control" style="margin-left:5px;display: inline-block;width: 300px;" id="tele" placeholder="请输入电话号码" />
                </div>
                <div class="form-group">
                    <label for="password">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码</label>
                    <input type="password" class="form-control" style="margin-left:5px;display: inline-block;width: 300px;" id="password" placeholder="请输入密码" />
                </div>
                <div class="form-group">
                    <label for="confirmPwd">确认密码</label>
                    <input type="password" class="form-control" style="margin-left:5px;display: inline-block;width: 300px;" id="confirmPwd" placeholder="请确认密码" />
                </div>
                <div>
                    <input type="button" value="提&nbsp;&nbsp;&nbsp;&nbsp;交" class="btn btn-success" style="margin-left: 150px;width: 100px;" id="addBtn">
                    <input type="button" value="提&nbsp;&nbsp;&nbsp;&nbsp;交"class="btn btn-success" style="margin-left: 150px;width: 100px;" id="modifyBtn" style="display: none">
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
