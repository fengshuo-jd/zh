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
    <script src="${pageContext.request.contextPath}/resources/js/vue.js"></script>
    <!-- 引入组件库 -->
    <script src="https://cdn.bootcdn.net/ajax/libs/element-ui/2.14.0/index.min.js"></script>
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
                <el-menu background-color="#333744" text-color="#fff" unique-opened active-text-color="#409eff" :collapse='isCollapse' :collapse-transition="false" :default-active="activePath">
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
                <h2>欢迎进入活动管理系统</h2>
            </el-main>
        </el-container>
    </el-container>
</div>

<script>
    new Vue({
        el: '#app',
        data() {
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
                activePath: ""
            }
        },
        methods: {
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
            }
        },
    })
</script>
</body>

</html>
