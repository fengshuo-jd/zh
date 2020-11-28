<%--
  Created by IntelliJ IDEA.
  User: 冯硕
  Date: 2020/11/25
  Time: 8:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>数据统计</title>
    <link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
    <!-- 引入样式 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_index.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/fonts/iconfont.css">
    <link href="https://cdn.bootcdn.net/ajax/libs/element-ui/2.14.0/theme-chalk/index.min.css" rel="stylesheet">
    <!-- 先引入 Vue -->
    <script src="${pageContext.request.contextPath}/resources/js/vue.js"></script>
    <!-- 引入组件库 -->
    <script src="https://cdn.bootcdn.net/ajax/libs/element-ui/2.14.0/index.min.js"></script>
    <!-- echars -->
    <script src="${pageContext.request.contextPath}/resources/js/echarts.common.js"></script>
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
                <el-menu background-color="#333744" text-color="#fff" unique-opened active-text-color="#409eff"
                         :collapse='isCollapse' :collapse-transition="false" default-active="/reports">
                    <!-- 一级 -->
                    <el-submenu :index="item.id + ''" v-for="item in menulist" :key="item.id">
                        <template slot="title">
                            <i :class="iconsObj[item.id]"></i>
                            <span>{{item.authName}}</span>
                        </template>
                        <!-- 二级 -->
                        <el-menu-item :index="'/' + subItem.path" v-for="subItem in item.children" :key="subItem.id"
                                      @click="saveNavState('/' + subItem.path)">
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
                    <el-breadcrumb-item>数据统计</el-breadcrumb-item>
                    <el-breadcrumb-item>数据报表</el-breadcrumb-item>
                </el-breadcrumb>
                <el-card>
                    <el-tabs v-model="activeName" @tab-click="handleClick">
                        <el-tab-pane label="学生分数排名" name="first">
                            <!-- 表格 -->
                            <el-table :data="rankingList" border stripe>
                                <el-table-column label="排名" type="index" width="100px"></el-table-column>
                                <el-table-column label="姓名" prop="username"></el-table-column>
                                <el-table-column label="学号" prop="stu_id"></el-table-column>
                                <el-table-column label="系别" prop="tie"></el-table-column>
                                <el-table-column label="活动分数" prop="credits"></el-table-column>
                            </el-table>
                        </el-tab-pane>
                        <el-tab-pane label="活动统计" name="second">
                            <div style="text-align: center;">活动总数:${sessionScope.actiivtyCount}</div>
                            <div id="main" style="width: 600px;height:400px;"></div>
                        </el-tab-pane>
                    </el-tabs>
                </el-card>
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
                activePath: "",
                activeName: 'first',
                rankingList: []
            }
        },
        mounted() {
            this.char()
        },
        created() {
            this.add()

        },
        methods: {
            quit() {
                window.location.href = '${pageContext.request.contextPath}/user/logout'
            },
            // 折叠效果
            toggleCollapse() {
                this.isCollapse = !this.isCollapse
            },
            add() {
                var array = ${requestScope.jsonArray}
                    this.rankingList = array
            },
            // 保存链接的激活状态
            saveNavState(activePath) {
                this.activePath = activePath
                console.log(this.activePath)
                if (this.activePath == '/users') {
                    window.location.href = '${pageContext.request.contextPath}/user/findall'
                } else if (this.activePath == '/orders') {
                    window.location.href = '${pageContext.request.contextPath}/activity/findAll'
                } else {
                    window.location.href = '${pageContext.request.contextPath}/date/show'
                }
            },
            handleClick(tab, event) {
                // console.log(tab, event);
            },
            char() {

                var myChart = echarts.init(document.getElementById('main'));
                option = {
                    tooltip: {
                        trigger: 'item',
                        formatter: '{a} <br/>{b}: {c} ({d}%)'
                    },
                    legend: {
                        orient: 'vertical',
                        left: 10,
                        data: ['自动化工程系', '机械工程系', '电子信息工程系', '计算机工程系', '经济与管理系', '院级组织']
                    },
                    series: [
                        {
                            name: '活动数量',
                            type: 'pie',
                            radius: ['50%', '70%'],
                            avoidLabelOverlap: false,
                            label: {
                                show: false,
                                position: 'center'
                            },
                            emphasis: {
                                label: {
                                    show: true,
                                    fontSize: '30',
                                    fontWeight: 'bold'
                                }
                            },
                            labelLine: {
                                show: false
                            },
                            data: [
                                { value: ${sessionScope.autoActCount}, name: '自动化工程系' },
                                { value: ${sessionScope.mechanicalActCount}, name: '机械工程系' },
                                { value: ${sessionScope.electronicActCount}, name: '电子信息工程系' },
                                { value: ${sessionScope.computerActCount}, name: '计算机工程系' },
                                { value: ${sessionScope.economicActCount}, name: '经济与管理系' },
                                { value: ${sessionScope.CollegeActCount}, name: '院级组织' }
                            ]
                        }
                    ]
                };
                myChart.setOption(option);
            }
        }
    })
</script>
<script>
    var index = document.getElementById('index');
    index.onclick = function() {
        window.location.href = "${pageContext.request.contextPath}/resources/pages/BACK/background_first_page.jsp"
    }
</script>
</body>

</html>
