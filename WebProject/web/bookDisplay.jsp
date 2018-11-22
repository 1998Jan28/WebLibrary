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
    <title>Title</title>

    <script type="text/javascript">
        $(document).ready(function () {
            var isbn=$("#isbn").text();console.log(isbn);
            var para={"isbn":isbn};
            var showimg="<img src='"+"./BookImg/"+isbn+".jpg' />"
            $("#img").html(showimg);
            console.log(para);
            $.post("/DisplayBook",para,function(obj){
                $("#bookname").html(obj.BookName);
                $("#author").html(obj.Author);
                $("#index").html(obj.Index);
                $("#price").html(obj.Price);
                $("#amount").html(obj.Amount);
                $("#digest").html("简介："+obj.Digest);
            },"json")
        })
    </script>
    <style>
        #container{
            position: relative;
            margin:0 auto;
            height: 380px;
            width:1000px;
        }
        span{
            font-size: 16px;
            font-weight: bold;
        }
        #img img{
            position:absolute;
            top:60px;
            left:20px;
            width: 200px;
            height:300px;
        }
        #s1{
            position: absolute;
            top:60px;
            left:250px;
        }
        #s2{
            position: absolute;
            top:90px;
            left:250px;
        }
        #s3{
            position: absolute;
            top:120px;
            left:250px;
        }
        #s4{
            position: absolute;
            top:150px;
            left:250px;
        }
        #s5{
            position: absolute;
            top:180px;
            left:250px;
        }
        #s6{
            position: absolute;
            top:210px;
            left:250px;
        }
        #digest{
            position: absolute;
            top:240px;
            left:250px;
            display: inline-block;
            width:600px;
            font-size: 16px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <%@include file="head.jsp" %>
        <div id="container">
            <div id="img"></div>

            <div id="information">
                <span id="s1">书名：<span id="bookname"></span></span>
                <span id="s2">作者：<span id="author"></span></span>
                <span id="s3">ISBN：<span id="isbn"><%=request.getParameter("ISBN")%></span></span>
                <span id="s4">索书号：<span id="index"></span></span>
                <span id="s5">价格：<span id="price"></span></span>
                <span id="s6">馆藏：<span id="amount"></span></span>
            </div>
            <div id="digest">

            </div>
        </div>
    <%@include file="footer.jsp"%>
</body>

</html>
