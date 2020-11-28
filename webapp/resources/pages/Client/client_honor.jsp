<%--
  Created by IntelliJ IDEA.
  User: 冯硕
  Date: 2020/11/26
  Time: 10:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>查看证书</title>
    <link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
    <style>
        body {
            background-color: #ff503e;
        }


        .main .img {
            position: relative;
            margin-top: 100px;
            text-align: center;
            font-size: 16px;
        }

        .username {
            position: absolute;
            top: 140px;
            left: 520px;
        }

        .student {
            position: absolute;
            top: 140px;
            left: 506px;
        }

        .content {
            position: absolute;
            top: 180px;
            left: 545px;
            margin-left: 10px;
        }

        .good {
            position: absolute;
            top: 210px;
            left: 620px;
            display: block;
            font-size: 36px;
            color: #c60b16;
            margin-left: 50px;
        }
        .time {
            position: absolute;
            top: 330px;
            left: 870px;
        }
        a {
            text-decoration: none;
        }
    </style>
</head>

<body>
<div class="main">
    <div><a href="${pageContext.request.contextPath}/client/stuCenter?userId=${sessionScope.user.stu_id}">返回</a></div>
    <div class="img">
        <div class="username">${requestScope.honorName}</div>
        <div class="student">___________同学:</div>
        <div class="content">在年度活动排名中，表现优秀，总分名列前茅,获得
        </div>
        <div><span class="good">"第<span>${requestScope.rankNum}</span>名"</span></div>
        <img src="${pageContext.request.contextPath}/resources/images/cert.png" alt="">
        <div class="time">
            2020年12月30日
        </div>
    </div>
</div>
</body>

</html>>
