<%--
  Created by IntelliJ IDEA.
  User: 冯硕
  Date: 2020/11/12
  Time: 8:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>活动管理系统</title>
    <link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
    <!-- 引入样式 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/act_index.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/fonts2/iconfont.css">
    <link href="https://cdn.bootcdn.net/ajax/libs/element-ui/2.14.0/theme-chalk/index.min.css" rel="stylesheet">
    <!-- 先引入 Vue -->
    <script src="${pageContext.request.contextPath}/resources/js/vue.js"></script>
    <!-- 引入组件库 -->
    <script src="https://cdn.bootcdn.net/ajax/libs/element-ui/2.14.0/index.min.js"></script>
    <style>
        .el-form {
            width: 500px;
        }
    </style>
</head>

<body>
<div id="app">
    <el-container class="home-container">
        <!-- 头部区域 -->
        <el-header>
            <div>
                <img src="${pageContext.request.contextPath}/resources/images/logo_2.png" width="50px" height="50px" />
                <span style="margin-left: 10px;">活动管理系统</span>
            </div>
            <el-dropdown @command="handleCommand">
                    <span class="el-dropdown-link" style="color: #fff; cursor: pointer;">
                       ${sessionScope.user.username} <i class="el-icon-arrow-down el-icon--right"></i>
                    </span>
                <el-dropdown-menu slot="dropdown">
                    <el-dropdown-item command="info">基本信息</el-dropdown-item>
                    <el-dropdown-item command="psw">修改密码</el-dropdown-item>
                    <el-dropdown-item command="exit" divided>退出</el-dropdown-item>
                </el-dropdown-menu>
            </el-dropdown>
        </el-header>
        <!-- 页面主题区域 -->
        <el-container background-color="#eee">
            <!-- 侧边栏 -->
            <el-aside :width="isCollapse?'64px':'200px'">
                <!-- 折叠 -->
                <div class="toggle-botton" @click="toggleCollapse">|||</div>
                <!-- 菜单区域 -->
                <el-menu background-color="#333744" text-color="#fff" unique-opened active-text-color="#409eff" :collapse='isCollapse' :collapse-transition="false" default-active="/password">
                    <!-- 一级 -->
                    <el-submenu :index="item.id + ''" v-for="item in menulist" :key="item.id">
                        <template slot="title">
                            <i :class="iconsObj[item.id]"></i>
                            <span>{{item.authName}}</span>
                        </template>
                        <!-- 二级 -->
                        <el-menu-item :index="'/' + subItem.path" v-for="subItem in item.children" :key="subItem.id" @click="saveNavState('/' + subItem.path)">
                            <template slot="title">
                                <i class="el-icon-menu"></i>
                                <span>{{subItem.authName}}</span>
                            </template>
                        </el-menu-item>
                    </el-submenu>
                </el-menu>
            </el-aside>
            <!-- 内容主体 -->
            <el-main>
                <!-- 面包屑导航 -->
                <el-breadcrumb separator-class="el-icon-arrow-right">
                    <el-breadcrumb-item :to="{ path: '/home' }" id="index">首页</el-breadcrumb-item>
                    <el-breadcrumb-item>设置</el-breadcrumb-item>
                    <el-breadcrumb-item>修改密码</el-breadcrumb-item>
                </el-breadcrumb>
                <!-- 卡片视图 -->
                <el-card>
                    <el-form action="${pageContext.request.contextPath}/clientAdmin/updateUserInfoHasMore" method="post" :model="addForm" :rules="addFormRules" ref="addRuleFormRef" label-width="70px">

                        <input type="hidden" name="stu_id" value="${sessionScope.user.stu_id}"/>

                        <el-form-item label="旧密码" prop="oldPassword">
                            <el-input v-model="addForm.oldPassword" name="oldPassword" type="password"></el-input>
                        </el-form-item>
                        <el-form-item label="新密码" prop="newPassword">
                            <el-input v-model="addForm.newPassword" name="newPassword" type="password"></el-input>
                        </el-form-item>
                        <el-form-item class="btns">
                            <el-button type="primary" @click="set">确认修改</el-button>
                            <el-button type="info" @click="resetPswRorm">重置</el-button>
                        </el-form-item>
                        <span style="color: red">${empty requestScope.passwordMsg?"":requestScope.passwordMsg}</span>
                    </el-form>
                </el-card>


            </el-main>
        </el-container>
    </el-container>
</div>

<script>
    new Vue({
        el: '#app',
        data() {
            //   验证旧密码
            var oldPassword = (rule, value, cb) => {
                // 正则表达式
                const regPassword = /^[A-Za-z0-9]+$/
                if (regPassword.test(value)) {
                    return cb();
                }
                cb(new Error("默认6个0"));
            };
            //   验证新密码
            var newPassword = (rule, value, cb) => {
                // 正则表达式
                const regPassword = /^[a-zA-Z]\w{5,17}$/;
                if (regPassword.test(value)) {
                    return cb();
                }
                cb(new Error("以字母开头，长度在6~18之间，只能包含字母、数字和下划线"));
            };
            return {
                username: '武藤sb',
                // 左测菜单数据
                menulist: [{
                    "id": 102,
                    "authName": "活动管理",
                    "path": "orders",
                    "children": [{
                        "id": 107,
                        "authName": "活动列表",
                        "path": "orders",
                        "children": [],
                        "order": null
                    }, {
                        "id": 108,
                        "authName": "报名审核",
                        "path": "exams",
                        "children": [],
                        "order": null
                    }, {
                        "id": 101,
                        "authName": "发布活动",
                        "path": "add",
                        "children": [],
                        "order": null
                    }],
                    "order": 4
                }, {
                    "id": 145,
                    "authName": "设置",
                    "path": "add",
                    "children": [{
                        "id": 109,
                        "authName": "基本信息",
                        "path": "info",
                        "children": [],
                        "order": null
                    }, {
                        "id": 111,
                        "authName": "修改密码",
                        "path": "password",
                        "children": [],
                        "order": null
                    }],
                    "order": null
                }],
                //   菜单图标对象
                iconsObj: {
                    "102": "iconfont icon-danju",
                    "145": "iconfont el-icon-setting"
                },
                //   折叠
                isCollapse: false,
                activePath: "",
                addForm: {
                    oldPassword: '',
                    newPassword: ''
                }, //   添加表单的验证对象
                addFormRules: {
                    oldPassword: [{
                        required: true,
                        message: "请输入旧密码,默认000000",
                        trigger: "blur"
                    }, {
                        validator: oldPassword,
                        trigger: "blur"
                    }],
                    newPassword: [{
                        required: true,
                        message: "请输入新密码",
                        trigger: "blur"
                    }, {
                        validator: newPassword,
                        trigger: "blur"
                    }],
                },
            }
        },
        methods: {
            handleCommand(command) {
                if (command == 'info') {
                    window.location.href = '${pageContext.request.contextPath}/clientAdmin/updateUser?username=' + "${sessionScope.user.username}"
                } else if (command == 'psw') {
                    window.location.href = '${pageContext.request.contextPath}/resources/pages/Client/client_back_act_psw.jsp'
                } else {
                    window.location.href = '${pageContext.request.contextPath}/clientAdmin/logout'
                }
            },
            // 折叠效果
            toggleCollapse() {
                this.isCollapse = !this.isCollapse
            },
            // 保存链接的激活状态
            saveNavState(activePath) {
                this.activePath = activePath
                if (this.activePath == '/orders') {
                    window.location.href = '${pageContext.request.contextPath}/clientAdmin/activityList?username=' + "${sessionScope.user.username}"
                } else if (this.activePath == '/exams') {
                    window.location.href = '${pageContext.request.contextPath}/clientAdmin/selectActivityListAndSignUp?username=' + "${sessionScope.user.username}"
                } else if (this.activePath == '/add') {
                    window.location.href = '${pageContext.request.contextPath}/resources/pages/Client/client_back_act_add.jsp?username=' + "${sessionScope.user.username}"
                } else if (this.activePath == '/info') {
                    window.location.href = '${pageContext.request.contextPath}/clientAdmin/updateUser?username=' + "${sessionScope.user.username}"
                } else {
                    window.location.href = '${pageContext.request.contextPath}/resources/pages/Client/client_back_act_psw.jsp'
                }
                console.log(this.activePath)
                // window.location.href = './admin_user.html'
            },
            //   修改
            set() {
                //   表单预验证
                this.$refs.addRuleFormRef.validate(async valid => {
                    if (!valid) return
                    else {
                        this.$refs.addRuleFormRef.$el.submit();
                    }
                    // window.location.href = 'index.html'
                    // this.$router.push('/home')
                })
            },
            //   重置
            resetPswRorm() {
                this.$refs.addRuleFormRef.resetFields()
            },
        },
    })
</script>
<script>
    var index = document.getElementById('index');
    index.onclick = function() {
        window.location.href = '${pageContext.request.contextPath}/resources/pages/Client/client_back_act_index.jsp'
    }
</script>
</body>

</html>
