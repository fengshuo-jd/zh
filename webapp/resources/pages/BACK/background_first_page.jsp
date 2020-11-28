<%--
  Created by IntelliJ IDEA.
  User: 冯硕
  Date: 2020/11/5
  Time: 16:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<%--    <%@include file="/pages/common/admin-back-js-css.jsp"%>--%>
    <title>后台管理系统</title>
    <meta charset="UTF-8">
    <link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
    <!-- 引入样式 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_index.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/fonts/iconfont.css">
    <link href="https://cdn.bootcdn.net/ajax/libs/element-ui/2.14.0/theme-chalk/index.min.css" rel="stylesheet">
    <!-- 先引入 Vue -->
    <script src="${pageContext.request.contextPath}/resources/js/vue.js"></script>
    <!-- 引入组件库 -->
    <script src="https://cdn.bootcdn.net/ajax/libs/element-ui/2.14.0/index.min.js"></script>
    <style>
        .cell {
            padding-right: 0px !important;
        }
    </style>
</head>

<body>
<div id="app">
    <el-container class="home-container">
        <!-- 头部区域 -->
        <el-header>
            <div>
                <img src="${pageContext.request.contextPath}/resources/images/logo_admin.png" />
                <span style="margin-left: 10px;">后台管理系统</span>
            </div>
            <el-button @click="quit">退出</el-button>
        </el-header>
        <!-- 页面主题区域 -->
        <el-container>
            <!-- 侧边栏 -->
            <el-aside :width="isCollapse?'64px':'200px'">
                <!-- 折叠 -->
                <div class="toggle-botton" @click="toggleCollapse">|||</div>
                <!-- 菜单区域 -->
                <el-menu background-color="#333744" text-color="#fff" unique-opened active-text-color="#409eff" :collapse='isCollapse' :collapse-transition="false" >
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
                <h2>welcome</h2>
            </el-main>
        </el-container>
    </el-container>
</div>

<script>
    new Vue({
        el: '#app',
        data() {
            return {
                // 左测菜单数据
                menulist: [{
                    "id": 125,
                    "authName": "用户管理",
                    "path": "users",
                    "children": [{
                        "id": 110,
                        "authName": "用户列表",
                        "path": "users",
                        "children": [],
                        "order": null
                    }],
                    "order": 1
                }, {
                    "id": 102,
                    "authName": "活动管理",
                    "path": "orders",
                    "children": [{
                        "id": 107,
                        "authName": "活动列表",
                        "path": "orders",
                        "children": [],
                        "order": null
                    }],
                    "order": 4
                }, {
                    "id": 145,
                    "authName": "数据统计",
                    "path": "reports",
                    "children": [{
                        "id": 146,
                        "authName": "数据报表",
                        "path": "reports",
                        "children": [],
                        "order": null
                    }],
                    "order": 5,
                }],
                //   菜单图标对象
                iconsObj: {
                    "125": "iconfont icon-users",
                    "103": "iconfont icon-tijikongjian",
                    "101": "iconfont icon-shangpin",
                    "102": "iconfont icon-danju",
                    "145": "iconfont icon-baobiao"
                },
                //   折叠
                isCollapse: false,
                activePath: ""
            }
        },
        methods: {
            // 折叠效果
            toggleCollapse() {
                this.isCollapse = !this.isCollapse
            },
            quit() {
                window.location.href='${pageContext.request.contextPath}/user/logout'
            },
            // 保存链接的激活状态
            saveNavState(activePath) {
                this.activePath = activePath
                console.log(this.activePath)
                if(this.activePath == '/users') {
                    console.log("right")
                    window.location.href = '${pageContext.request.contextPath}/user/findall'
                }else if(this.activePath == '/orders') {
                    window.location.href = '${pageContext.request.contextPath}/activity/findAll'
                }else {
                    window.location.href = '${pageContext.request.contextPath}/date/show'
                }
            }
        },
    })
</script>

</body>

</html>
