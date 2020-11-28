<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>后台登录</title>
    <link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
    <!-- 引入样式 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login_sup.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/fonts/iconfont.css">
    <link href="https://cdn.bootcdn.net/ajax/libs/element-ui/2.14.0/theme-chalk/index.min.css" rel="stylesheet">
</head>

<body>
<div id="app">
    <div class="longin_container">
        <div class="login_box">
            <!-- 头像区域 -->
            <div class="avatar_box">
                <img src="${pageContext.request.contextPath}/resources/images/logo_sup.png" />
            </div>


            <!-- 登录表单区域 -->
            <el-form label-width="0px" action="${pageContext.request.contextPath}/user/login" class="login_form" :model="loginForm" :rules="loginFormRule" ref="loginFormRef" method="post">
                <input type="hidden" name="action" value="supLogin" />
                <!-- 用户名 -->
                <el-form-item prop="username">
                    <el-input name="username" prefix-icon="iconfont icon-user" v-model="loginForm.username"></el-input>
                </el-form-item>
                <!-- 密码 -->
                <el-form-item prop="password">
                    <el-input name="password" prefix-icon="iconfont icon-3702mima" v-model="loginForm.password" type="password"></el-input>
                </el-form-item>
                <span style="color: red">${empty requestScope.msg?"":requestScope.msg}</span>
                <!-- 按钮区域 -->
                <el-form-item class="btns">
                    <%--                    <input type="submit" value="登录"/>--%>
                    <el-button type="primary" @click="login">登录</el-button>
                    <el-button type="info" @click="resetLoginRorm">重置</el-button>
                </el-form-item>
            </el-form>
        </div>
    </div>
</div>
<!-- 先引入 Vue -->
<script src="${pageContext.request.contextPath}/resources/js/vue.js"></script>
<!-- 引入组件库 -->
<script src="${pageContext.request.contextPath}/resources/js/element-ui.js"></script>
<script>
    new Vue({
        el: '#app',
        data: function() {
            return {
                // 登录表单的数据绑定对象
                loginForm: {
                    username: "",
                    password: ""
                    //action: ""
                },
                // 表单验证规则
                loginFormRule: {
                    //   用户名
                    username: [{
                        required: true,
                        message: "请输入用户名",
                        trigger: "blur"
                    }, {
                        min: 3,
                        max: 10,
                        message: "长度在 3 到 10 个字符",
                        trigger: "blur"
                    }],
                    password: [{
                        required: true,
                        message: "请输入密码",
                        trigger: "blur"
                    }, {
                        min: 6,
                        max: 15,
                        message: "长度在 6 到 15 个字符",
                        trigger: "blur"
                    }]
                }
            }
        },
        methods: {
            //   重置
            resetLoginRorm() {
                this.$refs.loginFormRef.resetFields()
            },
            //   登录
            login() {
                //   表单预验证
                this.$refs.loginFormRef.validate(async valid => {
                    if (!valid){
                        return
                    }
                    else {
                        this.$refs.loginFormRef.$el.submit();
                    }
                })
            }
        }
    })
</script>
</body>

</html>
