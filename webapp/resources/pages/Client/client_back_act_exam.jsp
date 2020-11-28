<%--
  Created by IntelliJ IDEA.
  User: 冯硕
  Date: 2020/11/11
  Time: 19:13
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
    <script src="${pageContext.request.contextPath}/resources/js/vue.js"></script>
    <!-- 引入组件库 -->
    <script src="https://cdn.bootcdn.net/ajax/libs/element-ui/2.14.0/index.min.js"></script>
    <style>
        .el-switch__label--right {
            color: #606266;
        }

        .el-switch__label--right span {
            font-size: 13px!important;
        }

        .cell {
            text-align: center;
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
                <el-menu background-color="#333744" text-color="#fff" unique-opened active-text-color="#409eff" :collapse='isCollapse' :collapse-transition="false" default-active="/exams">
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
                    <el-breadcrumb-item>活动管理</el-breadcrumb-item>
                    <el-breadcrumb-item>报名审核f</el-breadcrumb-item>
                </el-breadcrumb>
                <!-- 卡片视图 -->
                <el-card>
                    <!-- 搜索 -->
                    <el-row :gutter="20">
                        <el-col :span="8">
                            <el-input placeholder="请输入内容" v-model="queryInfo.query" maxlength="11" clearable>
                                <el-button slot="append" icon="el-icon-search" @click=searchSumbit></el-button>
                            </el-input>
                        </el-col>
                        <el-date-picker v-model="valueTime" value-format="yyyy-MM-dd" align="right" type="date" placeholder="选择活动日期" :picker-options="pickerOptions" @change="timeChange">
                        </el-date-picker>
                    </el-row>
                    <!-- 表格 -->
                    <el-table :data="activityList" border stripe>
                        <el-table-column label="序号" type="index"></el-table-column>
                        <el-table-column label="活动名称" prop="activity_name" width="300px"></el-table-column>
                        <el-table-column label="所属系别" prop="tie"></el-table-column>
                        <el-table-column label="活动总人数" prop="activity_total_number"></el-table-column>
                        <el-table-column label="当前报名人数" prop="activity_current_number"></el-table-column>
                        <el-table-column label="活动开始时间" prop="time"></el-table-column>
                        <el-table-column label="操作" width="100px" text-align="center">
                            <template slot-scope="scope">
                                <el-tooltip effect="dark" content="查看报名人数" placement="top" :enterable="false">
                                    <el-button type="primary" icon="el-icon-tickets" size="mini"
                                               @click="lookNumber(scope.row)"></el-button>
                                </el-tooltip>
                            </template>
                        </el-table-column>
                    </el-table>
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
                username: '武藤sb',
                queryInfo: {
                    query: "",
                    pagenum: 1,
                    pagesize: 2
                },
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
                    "order": null,
                    // 活动列表参数对象
                }],
                //   菜单图标对象
                iconsObj: {
                    "102": "iconfont icon-danju",
                    "145": "iconfont el-icon-setting"
                },
                //   折叠
                isCollapse: false,
                activePath: "",
                valueTime: '',
                pickerOptions: {
                    disabledDate(time) {
                        return time.getTime() > Date.now();
                    },
                    shortcuts: [{
                        text: '今天',
                        onClick(picker) {
                            picker.$emit('pick', new Date());
                        }
                    }, {
                        text: '昨天',
                        onClick(picker) {
                            const date = new Date();
                            date.setTime(date.getTime() - 3600 * 1000 * 24);
                            picker.$emit('pick', date);
                        }
                    }, {
                        text: '一周前',
                        onClick(picker) {
                            const date = new Date();
                            date.setTime(date.getTime() - 3600 * 1000 * 24 * 7);
                            picker.$emit('pick', date);
                        }
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
                    this.activityList = array
                console.log(this.activityList)
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
            // 状态改变
            stateChanged(info) {
                console.log(info)
            },
            // 时间改变
            timeChange(nowTime) {
                console.log(nowTime)
                window.location.href='${pageContext.request.contextPath}/clientAdmin/selectByTime?username=' + "${sessionScope.user.username}" +'&time=' + nowTime
            },
            // 活动审核
            lookNumber(info) {
                window.location.href = '${pageContext.request.contextPath}/clientAdmin/selectHasSignUpUser?activity_id=' + info.id
                //+'&activity_name=' + info.activity_name
            },
            searchSumbit() {
                var patt = /[ `~!@#$%^&*()_\-+=<>?:"{}|,.\/;'\\[\]·~！@#￥%……&*（）——\-+={}|《》？：“”【】、；‘’，。、]/g
                if(patt.test(this.queryInfo.query)) {
                    return this.$message.info('请勿输入特殊字符!')
                } else if(this.queryInfo.query == '') {
                    return this.$message.info('请输入搜索内容!')
                }
                window.location.href = '${pageContext.request.contextPath}/clientAdmin/charBoxByActivtyNameAndUserNameT?query=' + this.queryInfo.query + '&username=' + '${sessionScope.user.username}'
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
