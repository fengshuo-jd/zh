<%--
  Created by IntelliJ IDEA.
  User: 冯硕
  Date: 2020/11/26
  Time: 11:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<%--    <link rel="stylesheet" href="F:\Desktop\idea_project\ZH_volunteer\zh-volunteer\src\main\webapp\resources\css\element.css">--%>
    <script src="${pageContext.request.contextPath}/resources/css\element.css"></script>
    <!-- 先引入 Vue -->
    <script src="${pageContext.request.contextPath}/resources/js/vue.js"></script>
    <!-- 引入组件库 -->
    <script src="${pageContext.request.contextPath}/resources/js/element-ui.js"></script>

    <title>介绍</title>
<%--    <script src="${pageContext.request.contextPath}/resources/images/favicon.ico"></script>--%>
    <link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
    <style>
        body {
            margin: 0;
            padding: 0;
        }

        a {
            text-decoration: none;
        }

        .header {
            background-color: #3399ee;
        }

        .header_content {
            width: 1200px;
            margin: 0 auto;
            height: 42px;
            line-height: 42px;
        }

        .login {
            float: right;
        }

        .main_content {
            width: 1200px;
            margin: 0 auto;
        }
    </style>
</head>

<body>
<div id="app">
    <div class="header">
        <div class="header_content">

            <img src="${pageContext.request.contextPath}/resources/images/logo11.png">
            <div class="login">
                <a href="#">登录</a>
                <a href="#">注册</a>
            </div>
        </div>
    </div>
    <div class="main">
        <div class="main_content">
            <el-tabs v-model="activeName">
                <el-tab-pane label="关于我们" name="first">天津中环信息科技有限公司</el-tab-pane>
                <el-tab-pane label="使用条款" name="second">如果您的帐号违反当地相关法律法规或网站使用条款，在未经事先通知的情况下，奥思网络有权自行判断并立即终止您对本网站的使用，或者采取措施禁止您对本网站的再次访问。</el-tab-pane>
                <el-tab-pane label="常见问题" name="third">为什么我收不到激活/通知/重置密码等邮件:查看是否被识别为垃圾邮件</el-tab-pane>
                <el-tab-pane label="意见建议" name="fourth">意见建议</el-tab-pane>
                <el-tab-pane label="友情链接" name="fifth">友情链接</el-tab-pane>
            </el-tabs>
        </div>
    </div>
</div>
<script>
    new Vue({
        el: "#app",
        data() {
            return {
                activeName: 'first'
            }
        },
        methods: {

        },
    })
</script>
</body>

</html>
