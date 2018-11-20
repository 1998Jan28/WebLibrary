<%--
  Created by IntelliJ IDEA.
  User: lcy
  Date: 2018/11/20
  Time: 20:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>上传文件</title>
</head>
<body>
    <img src="./BookImg/tt.png" />
    <form method="post" action="/uploadFile" enctype="multipart/form-data">
        <input type="file" name="uploadFile" />
        <br/>
        <input type="submit" value="上传" />
    </form>
</body>
</html>
