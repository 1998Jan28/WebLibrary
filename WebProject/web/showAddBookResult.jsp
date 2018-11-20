<%--
  Created by IntelliJ IDEA.
  User: whutk
  Date: 2018/11/20
  Time: 22:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta content="5;bookManage.jsp" http-equiv="Refresh"/>
    <title>结果</title>
</head>
<body>
<%
    boolean flag = (boolean)request.getAttribute("flag");
    if(flag){
        out.println("添加书籍成功！");
    }
    else{
        out.println("添加书籍失败！");
    }
%>
</body>
</html>
