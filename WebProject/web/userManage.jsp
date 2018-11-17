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
    <script>

        function ModifyUser() {
            alert("修改中");
        }

        function DeleteUser() {
            alert("删除成功");
        }

        function ShowAddUser() {
            var addUser = document.getElementById("addUser");
            var main = document.getElementById("main");
            var searchUser = document.getElementById("searchUser");
            addUser.style.display = "block";
            main.style.display = "none";
            searchUser.style.display = "none";
        }

        function ShowMain() {
            var addUser = document.getElementById("addUser");
            var main = document.getElementById("main");
            var searchUser = document.getElementById("searchUser");
            addUser.style.display = "none";
            main.style.display = "block";
            searchUser.style.display = "block";
        }

        function ShowAddResult() {
            alert("添加成功！");
        }
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
                <div id="searchUser">
                    <input type="text">
                    <button>搜索</button>
                </div>
                <div id="main">
                    <table id="SearchResult">
                    <caption id="CardNum">用户信息</caption>
                    <tr>
                        <th>卡号</th>
                        <th>姓名</th>
                        <th>手机号</th>
                        <th>余额</th>
                    </tr>
                    <%! String[] text = new String[4];%>
                    <%
                        text[0] = "10000000";
                        text[1] = "test";
                        text[2] = "12345678901";
                        text[3] = "20";
                        for(int i = 0; i < 5; i++){
                            out.print("<tr>" +
                                    "<td>" + text[0] + "</td>" +
                                    "<td>" + text[1] + "</td>" +
                                    "<td>" + text[2] + "</td>" +
                                    "<td>" + text[3] + "</td>" +
                                    "<td><button onclick=\"ModifyUser()\">修改</button></td>" +
                                    "<td><button onclick=\"DeleteUser()\">删除</button> </td>" +
                                    "</tr>"
                            );
                        }
                    %>
                    </table>
                </div>
                <div id="addUser" style="display: none;">
                    <form action="#">
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
                            <input type="submit" value="提交" onclick="ShowAddResult()">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
