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
    <meta content="3;bookManage.jsp" http-equiv="Refresh"/>
    <title>结果</title>
</head>
<body>
<%
    boolean flag = (boolean)request.getAttribute("flag");
    String operation = (String)request.getAttribute("operation");
    String information = "";
    if(operation.equals("modify")){
        if(flag){
            information = "修改成功！";
        }
        else{
            information = "修改失败！";
        }
    }
    else if(operation.equals("add")){
        if(flag){
            information = "添加成功！";
        }
        else{
            information = "添加失败！";
        }
    }
    out.println(information);
%>
</body>
</html>
