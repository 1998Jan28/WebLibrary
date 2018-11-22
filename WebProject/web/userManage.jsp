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
    <title>用户管理</title>
    <script src="https://code.jquery.com/jquery-3.3.1.js"
            integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
            crossorigin="anonymous"></script>

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
        }

        function ShowMain() {
            var main = document.getElementById("main");
            var addUser = document.getElementById("addUser");
            var modifyUser = document.getElementById("modifyUser");
            var modifyBtn = document.getElementById("modifyBtn");main.style.display = "block"
            addUser.style.display = "none";
            modifyUser.style.display = "none";
            modifyBtn.style.display = "none";
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
            content+="<caption>用户信息表</caption><tr> <th>卡号</th> <th>姓名</th> <th>身份证号</th> <th>电话号码</th> <th>余额</th> <th>密码</th></tr>";
            $.each(users,function(id,item){
                if(select == 1 || item.CardNum.indexOf(searchText)!=-1 || item.Name.indexOf(searchText)!=-1 || item.Identification.indexOf(searchText) != -1){
                    content+="<tr>";
                    content+="<td id='"+num+"'>"+item.CardNum+"</td>";
                    content+="<td id='Name"+num+"'>"+item.Name+"</td>";
                    content+="<td id='Identification"+num+"'>"+item.Identification+"</td>";
                    content+="<td id='Tele"+num+"'>"+item.Tele+"</td>";
                    content+="<td>"+item.Money+"</td>";
                    content+="<td id='Pwd"+num+"'>"+item.Pwd+"</td>";
                    content+="<td style='border: 0px'><input type='submit' value='修改' onclick='ShowModifyUser("+num+")'></td>";
                    content+="<td style='border: 0px'><input type='submit' value='删除' onclick='DeleteUser("+num+")'></td>";
                    content+="</tr>";
                    num++;
                }
            })
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
</head>
<body>
<div>
    <div>
        <span>admin</span>
        <span>,您好</span>
    </div>
    <div>
        <div>
            <div>
                <ul style="list-style: none;float: left">
                    <li onclick="ShowMain()">用户列表</li>
                    <li onclick="ShowAddUser()">增加用户</li>
                </ul>
            </div>
            <div style="float: left;margin-left: 20px;">
                <div id="main">
                    <div>
                        <input id="search" type="text" onkeyup="showUsers(0)">
                        <button onclick="showUsers(0)">搜索</button>
                    </div>
                    <div id="userList">

                    </div>
                </div>
                <div id="addUser" style="display: none;">
                    <form>
                        <div id="modifyUser" style="display: none">
                            卡号<input id="cardNum" type="text" readonly="readonly">
                        </div>
                        <div>
                            姓名<input id="userName" type="text">
                        </div>
                        <div>
                            身份证号<input id="identification" type="text">
                        </div>
                        <div>
                            电话号码<input id="tele" type="text">
                        </div>
                        <div>
                            密码<input id="pwd" type="password">
                        </div>
                        <div>
                            确认密码<input id="confirmPwd" type="password">
                        </div>
                        <div>
                            <input type="button" value="提交" id="addBtn">
                            <input type="button" value="提交" id="modifyBtn" style="display: none">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
