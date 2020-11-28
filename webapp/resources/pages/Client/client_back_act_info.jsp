<%--
  Created by IntelliJ IDEA.
  User: 冯硕
  Date: 2020/11/12
  Time: 8:21
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
                <el-menu background-color="#333744" text-color="#fff" unique-opened active-text-color="#409eff" :collapse='isCollapse' :collapse-transition="false" default-active="/info">
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
                    <el-breadcrumb-item>基本信息</el-breadcrumb-item>
                </el-breadcrumb>
                <!-- 卡片视图 -->
                <el-card>
                    <el-form action="${pageContext.request.contextPath}/clientAdmin/updateUserInfo" method="post" :model="addForm" :rules="addFormRules" ref="addRuleFormRef" label-width="70px">

                        <input type="hidden" name="id" v-model="addForm.id"/>

                        <el-form-item label="姓名" prop="username">
                            <el-input v-model="addForm.username" disabled name="username"></el-input>
                        </el-form-item>
                        <el-form-item label="学号" prop="stu_id">
                             <el-input v-model="addForm.stu_id" disabled name="stu_id"></el-input>
                        </el-form-item>
                        <el-form-item label="性别" prop="gender">
                            <el-input v-model="addForm.gender" name="gender"></el-input>
                        </el-form-item>
                        <el-form-item label="手机号" prop="phone_num">
                            <el-input v-model="addForm.phone_num" name="phone_num"></el-input>
                        </el-form-item>
                        <el-form-item class="btns">
                            <el-button type="primary" @click="set">确认修改</el-button>
                        </el-form-item>
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
            //   验证姓名
            var checkUsername = (rule, value, cb) => {
                // 正则表达式
                const regUsername = /^[\u4e00-\u9fa5]{2,6}$/;
                if (regUsername.test(value)) {
                    // 合法的姓名
                    return cb();
                }
                cb(new Error("请输入合法的姓名"));
            };
            //   验证性别
            var checkGender = (rule, value, cb) => {
                // 正则表达式
                const regGender = /^['男'|'女']$/;
                if (regGender.test(value)) {
                    // 合法的性别
                    return cb();
                }
                cb(new Error("请从男或女中选择输入"));
            };
            var checkMobile = (rule, value, cb) => {
                // 正则表达式
                const regMoible = /^1[0-9]{10}$/;
                if (regMoible.test(value)) {
                    // 合法的手机
                    return cb();
                }
                cb(new Error("请输入合法的手机号"));
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
                //   用户表单数据
                addForm: '',
                //   添加表单的验证对象
                addFormRules: {
                    gender: [{
                        required: true,
                        message: "请输入性别",
                        trigger: "blur"
                    }, {
                        validator: checkGender,
                        trigger: "blur"
                    }],
                    phone_num: [{
                        required: true,
                        message: "请输入手机号",
                        trigger: "blur"
                    }, {
                        validator: checkMobile,
                        trigger: "blur"
                    }]
                },
            }
        },
        created() {
            this.add()
        },
        methods: {
            add() {
                let array = ${requestScope.jsonArray}
                    this.addForm = array[0]
                console.log(this.addForm)
            },
            handleCommand(command) {
                if (command == 'info') {
                    window.location.href = '${pageContext.request.contextPath}/clientAdmin/updateUser?username=' + "${sessionScope.user.username}"
                } else if (command == 'psw') {
                    window.location.href = '${pageContext.request.contextPath}/resources/pages/Client/client_back_act_psw.jsp'
                } else {
                    window.location.href = '${pageContext.request.contextPath}/clientAdmin/logout?'
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
                    if (!valid) return;
                    else{
                        this.open2(this.$refs.addRuleFormRef)
                    }
                    // window.location.href = 'index.html'
                    // this.$router.push('/home')
                })
            },
            async open2(ref) {
                const confirmResult = await this.$confirm(
                    "是否确认修改?",
                    "提示", {
                        confirmButtonText: "确定"
                    }
                ).catch(err => err);

                if (confirmResult !== "confirm") {
                    return this.$message.info("已取消修改");
                }
                this.$message.success('修改成功')
                setTimeout(function() {
                    ref.$el.submit();
                }, 1000)
            }
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
