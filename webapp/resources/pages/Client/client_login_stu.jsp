<%--
  Created by IntelliJ IDEA.
  User: 冯硕
  Date: 2020/11/7
  Time: 16:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<%--<%@include file="/pages/common/login-js-css.jsp"%>--%>
<head>
    <meta charset="utf-8">
    <title>zhxxw</title>
    <link href="https://cdn.bootcdn.net/ajax/libs/element-ui/2.14.0/theme-chalk/index.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">
    <script src="${pageContext.request.contextPath}/resources/js/vue.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/css/fonts_1/iconfont.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/element-ui/2.14.0/index.min.js"></script>
</head>
<body>
<div id="app">
    <div class="longin_container">
        <!-- 登录注册 -->
        <div class="login_box">
            <!-- 左边 -->
            <div class="box_left">
                <div class="box_left_container">
                    <div class="box_left_header">
                        <div class="logo">
                            <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt = ""/>
                        </div>
                        <h2>中环志愿信息发布平台</h2>
                    </div>
                    <div class="box_left_content">中环志愿信息发布平台致力于在学校各部门（学生社团组织）与大学生之间架设一个桥梁，使学生可以便捷的查找并报名参与学校或社团发布的各类公益志愿活动。我们致力于打造一个校园公益活动宣传、组织和教育的品牌阵地。</div>
                    <div class="box_left_footer">
                        <span>志愿信息发布平台-校园活动发布平台</span>
                    </div>
                </div>
            </div>
            <!-- 右边 -->
            <div class="box_right">
                <div class="box_right_container">
                    <!-- 头部 -->
                    <div class="box_right_header">
                        <h2>
                            <span>登录</span>
                        </h2>
                    </div>
                    <!-- 表单 -->
                    <el-form action="${pageContext.request.contextPath}/client/login" label-width="0px" class="login_form" :model="loginForm" :rules="loginFormRule" ref="loginFormRef" method="post">

                        <input type="hidden" name="action" value="login"/>
                        <!-- 用户名 -->
                        <el-form-item prop="username">
                            <el-input name="username_a" prefix-icon="iconfont icon-user" v-model="loginForm.username" placeholder="学号 / 手机" clearable></el-input>
                        </el-form-item>
                        <!-- 密码 -->
                        <el-form-item prop="password">
                            <el-input name="password_a" prefix-icon="iconfont icon-3702mima" v-model="loginForm.password" type="password" clearable placeholder="请输入密码"></el-input>
                        </el-form-item>
                        <span style="color: red">${empty requestScope.msg?"":requestScope.msg}</span>
                        <!-- 忘记密码 -->
                        <div class="field">
                            <span></span>
                            <div class="forget" @click="goForgotpwd">忘记密码？</div>
                        </div>
                        <!-- 按钮区域 -->
                        <el-form-item class="btns">
                            <el-button type="warning" @click="login">登录</el-button>
                        </el-form-item>
                    </el-form>
                </div>
            </div>
        </div>
        <!-- 底部 -->
        <div class="login_footer">
                <span>
                <a @click="goIntroduce">关于我们</a>
              </span>
            <span>
                <a @click="goIntroduce">使用条款</a>
              </span>
            <span>
                <a @click="goIntroduce">常见问题</a>
              </span>
            <span>
                <a @click="goIntroduce">意见建议</a>
              </span>
            <span>
                <a @click="goIntroduce">友情链接</a>
              </span>
        </div>
    </div>
</div>
<script>
    new Vue({
        el: '#app',
        data() {
            return {
                // 登录验证
                loginForm: {
                    username: "",
                    password: "",
                },
                loginFormRule: {
                    //   用户名
                    username: [{
                        required: true,
                        message: "请输入用户名",
                        trigger: "blur"
                    }, {
                        min: 6,
                        max: 11,
                        message: "长度在 6 到 11 个字符",
                        trigger: "blur",
                    }, ],
                    password: [{
                        required: true,
                        message: "请输入密码",
                        trigger: "blur"
                    }, {
                        min: 6,
                        max: 15,
                        message: "长度在 6 到 15 个字符",
                        trigger: "blur",
                    }, ],
                },
                value1: false,
            }
        },
        methods: {
            login() {
                //   表单预验证
                this.$refs.loginFormRef.validate(async(valid) => {
                    if (!valid) return;
                    console.log(valid);
                    this.$refs.loginFormRef.$el.submit();
                    // this.$router.push("/home");
                });
            },
            goIntroduce() {
            <%--<a href="${pageContext.request.contextPath}/resources/pages/Client/cilent_about.jsp">--%>
                window.location.href = '${pageContext.request.contextPath}/resources/pages/Client/cilent_about.jsp'
            },
            goForgotpwd() {
                this.$message.info('请联系管理员!')
            }
        }
    })
</script>
</body>
</html>
