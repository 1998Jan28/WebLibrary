<%--
  Created by IntelliJ IDEA.
  User: lcy
  Date: 2018/11/17
  Time: 10:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #fff;
            font-family: "Helvetica Neue",Helvetica,Arial,"Microsoft Yahei UI","Microsoft Yahei",SimHei,"宋体",simsun,sans-serif;
        }

        #footer {
            height: 360px;
            background-color: #222;
            clear: both;
            position: relative;
            top: 20px;
        }

        #footer .top{
            width: 1263px;
            height: 280px;
            margin: 0 auto;
            text-align: center;
        }

        #footer .block{
            width: 410px;
            height: 280px;
            display: inline-block;
            text-align: left;
            color: #ccc;
            vertical-align: top;
        }

        #footer h2{
            font-size: 24px;
            font-weight: normal;
            padding: 20px 0 0 20px;
        }

        #footer hr{
            width: 90%;
            border: 1px dashed #333;
        }

        #footer ul{
            font-size: 18px;
            color: #777;
            text-indent: 20px;
            line-height: 2;
        }

        #footer .bottom{
            height: 80px;
            line-height: 80px;
            text-align: center;
            color: #777;
            background-color: #000;
            border-top: 1px solid #444;
        }

        #footer ul a{
            color: #777;
            text-decoration: none;
        }
    </style>

    <title></title>
</head>
<body>
<footer id="footer">
    <div class ="top">
        <div class="block" style="margin-right:200px;">
            <h2>友情链接</h2>
            <hr>
            <ul>
                <a href="http://lib.whut.edu.cn"><li>武汉理工大学图书馆</li></a>
                <a href="http://www.whlib.org.cn"><li>武汉市图书馆</li></a>
                <a href="http://www.library.hb.cn"><li>湖北省图书馆</li></a>
                <a href="http://www.nlc.cn"><li>中国国家图书馆</li></a>
            </ul>
        </div>
        <div class="block" style="margin-left:200px;">
            <h2>联系方式</h2>
            <hr>
            <ul>
                <li>电话：15871786290</li>
                <li>邮件：951072650@qq.com</li>
                <li>地址：湖北省武汉理工大学H4-411</li>
            </ul>
        </div>
    </div>
    <div class ="bottom">Copyright © 2018 by WHUT. All rights reserved</div>
</footer>
</body>
</html>
