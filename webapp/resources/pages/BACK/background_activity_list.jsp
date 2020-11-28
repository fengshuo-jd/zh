<%--
  Created by IntelliJ IDEA.
  User: 冯硕
  Date: 2020/11/6
  Time: 19:43
  To change this template use File | Settings | File Templates.
--%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <title>活动管理</title>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
            <!-- 引入样式 -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_index.css">
            <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/fonts/iconfont.css">
            <link href="https://cdn.bootcdn.net/ajax/libs/element-ui/2.14.0/theme-chalk/index.min.css" rel="stylesheet">
            <!-- 先引入 Vue -->
            <script src="${pageContext.request.contextPath}/resources/js/vue.js"></script>
            <!-- 引入组件库 -->
            <script src="https://cdn.bootcdn.net/ajax/libs/element-ui/2.14.0/index.min.js"></script>
            <meta charset="UTF-8">

            <style>
                .el-switch__label--right {
                    color: #606266;
                }
                
                .el-switch__label--right span {
                    font-size: 13px!important;
                }
                
                .examRadio {
                    margin-left: 27px;
                    margin-bottom: 25px;
                }
                
                .el-radio {
                    margin-left: 30px;
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
                            <el-menu background-color="#333744" text-color="#fff" unique-opened active-text-color="#409eff" :collapse='isCollapse' :collapse-transition="false" default-active="/orders">
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
                                <el-breadcrumb-item>活动列表</el-breadcrumb-item>
                            </el-breadcrumb>
                            <!-- 卡片视图 -->
                            <el-card>
                                <!-- 搜索 -->
                                <el-row :gutter="20">
                                    <el-col :span="8">
                                        <el-input placeholder="请输入活动名称" v-model="queryInfo.query" maxlength="11" clearable @clear="clearInfo">
                                            <el-button slot="append" icon="el-icon-search" @click=searchSumbit></el-button>
                                        </el-input>
                                    </el-col>
                                    <el-select v-model="value" placeholder="选择活动状态" @change="stateChanged">
                                        <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value">
                                        </el-option>
                                    </el-select>
                                </el-row>
                                <!-- 表格 -->
                                <el-table :data="activityList" border stripe id="el-table">
                                    <el-table-column label="序号" type="index"></el-table-column>
                                    <el-table-column label="活动名称" prop="activity_name" width="200px"></el-table-column>
                                    <el-table-column label="所属系别" prop="tie"></el-table-column>
                                    <el-table-column label="活动类型" prop="activity_type"></el-table-column>
                                    <el-table-column label="创建人" prop="creator"></el-table-column>
                                    <el-table-column label="活动开始时间" prop="time" width="130px" sortable></el-table-column>
                                    <el-table-column label="活动结束时间" prop="end_time" width="130px" sortable></el-table-column>
                                    <el-table-column label="状态" width="150px">
                                        <template slot-scope="scope">
                                              <el-switch v-model="scope.row.state" active-value="2" :active-text="scope.row.stateStr" disabled>
                                            </el-switch>
                                        </template>
                                    </el-table-column>
                                    <el-table-column label="操作"  width="150px">
                                        <template slot-scope="scope">
                                            <el-tooltip effect="dark" content="活动审核" placement="top" :enterable="false">
                                                <el-button type="primary" icon="el-icon-tickets" size="mini"
                                                           @click="setList(scope.row)"></el-button>
                                            </el-tooltip>
                                            <el-tooltip effect="dark" content="删除活动" placement="top" :enterable="false">
                                                <el-button type="danger" icon="el-icon-delete" size="mini"
                                                           @click="removeList(scope.row)">
                                                </el-button>
                                            </el-tooltip>
                                        </template>
                                    </el-table-column>
                                </el-table>
                                <el-pagination @current-change="handleCurrentChange" :current-page.sync="currentPage3" :page-size="10" layout="total, prev, pager, next, jumper" :total="${sessionScope.activityCount}">
                                </el-pagination>
                                <!-- 审核对话框 -->
                                <el-dialog title="活动审核" :visible.sync="examDialogVisible" width="50%">
                                    <el-form action="${pageContext.request.contextPath}/activity/activityExam" method="post" v-model="examForm" ref="examRuleFormRef" label-width="70px">
                                        <input type="hidden" name="id" v-model="examForm.id" />
                                        <el-form-item label="活动名称">
                                            <el-input v-model="examForm.activity_name" name="activity_name" disabled></el-input>
                                        </el-form-item>
                                        <el-form-item label="活动简介" prop="activity_introduce">
                                            <el-input v-model="examForm.activity_introduce" name="activity_introduce" disabled></el-input>
                                        </el-form-item>
                                        <el-form-item label="活动内容">
                                            <el-input v-model="examForm.activity_details" type="textarea" name="activity_details" disabled></el-input>
                                        </el-form-item>
                                        <el-form-item label="活动分值" prop="activity_score">
                                            <el-input v-model="examForm.activity_score" type="number" disabled></el-input>
                                        </el-form-item>
                                        <el-form-item label="活动地点" prop="activity_place">
                                            <el-input v-model="examForm.activity_place" name="activity_place" disabled></el-input>
                                        </el-form-item>
                                        <el-form-item label="系别">
                                            <el-input v-model="examForm.tie" name="tie" disabled></el-input>
                                        </el-form-item>
                                        <el-form-item label="活动类型">
                                            <el-input v-model="examForm.activity_type" name="activity_type" disabled></el-input>
                                        </el-form-item>
                                        <el-form-item label="创建人">
                                            <el-input v-model="examForm.creator" name="creator" disabled></el-input>
                                        </el-form-item>
                                        <el-form-item label="开始时间">
                                            <el-input v-model="examForm.time" name="time" disabled></el-input>
                                        </el-form-item>
                                        <el-form-item label="结束时间">
                                            <el-input v-model="examForm.end_time" name="end_time" disabled></el-input>
                                        </el-form-item>
                                        <div class="examRadio">
                                            <span>意见</span>
                                            <el-radio v-model="radio" label="2" name="radio">通过</el-radio>
                                            <el-radio v-model="radio" label="1" name="radio">未通过</el-radio>
                                        </div>
                                        <el-form-item label="备注">
                                            <el-input v-model="examForm.remark" type="textarea" maxlength="20" name="remarks" placeholder="最长20字"></el-input>
                                        </el-form-item>
                                        <div style="overflow: hidden;">
                                            <el-button @click="examDialogVisible = false" style="float: right;margin-left: 10px;">取 消</el-button>
                                            <el-button type="primary" style="float: right;" native-type="submit">确 定</el-button>
                                        </div>
                                    </el-form>
                                </el-dialog>
                            </el-card>
                        </el-main>
                    </el-container>
                </el-container>
            </div>
            <script>
                new Vue({
                    el: "#app",
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
                            // 活动列表参数对象
                            queryInfo: {
                                query: "",
                                pagenum: 1,
                                pagesize: 2
                            },
                            // 选择
                            options: [{
                                value: '3',
                                label: '全部'
                            }, {
                                value: '0',
                                label: '未审核'
                            }, {
                                value: '1',
                                label: '审核未通过'
                            }, {
                                value: '2',
                                label: '已审核'
                            }],
                            value: '',
                            activityList: [],
                            value1: '未审核',
                            value2: '已审核',
                            value2: false,
                            // 审核
                            examDialogVisible: false,
                            examForm: "",
                            radio: "1",
                            currentPage3: 1,

                        }
                    },
                    created() {
                        this.add()
                    },

                    methods: {
                        add() {
                            var array = ${requestScope.jsonArray}
                            console.log(array)
                            this.activityList = array
                            this.currentPage3 = ${sessionScope.pageNum2}
                            this.queryInfo.query = '${empty sessionScope.searchActContent?"":sessionScope.searchActContent}'
                        },
                        // 折叠效果
                        toggleCollapse() {
                            this.isCollapse = !this.isCollapse
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
                        quit() {
                            window.location.href = '${pageContext.request.contextPath}/user/logout'
                        },
                        // 状态改变
                        stateChanged(info) {
                            this.value = info
                            console.log(info)
                            window.location.href = '${pageContext.request.contextPath}/activity/suchFind?id=' + info
                        },
                        // 活动审核
                        setList(listInfo) {
                            console.log(listInfo)
                            this.examForm = {...listInfo
                            }
                            this.examDialogVisible = true
                        },
                        // 删除活动
                        async removeList(id) {
                            const confirmResult = await this.$confirm(
                                "此操作将永久删除该用户, 是否继续?",
                                "提示", {
                                    confirmButtonText: "确定"
                                }
                            ).catch(err => err);

                            if (confirmResult !== "confirm") {
                                return this.$message.info("已取消删除");
                            }
                            console.log(id)
                            this.$message.success("删除用户成功！");
                            location.href = "${pageContext.request.contextPath}/activity/deleteActivity?id=" + id.id
                        },
                        searchSumbit() {
                            var patt = /[ `~!@#$%^&*()_\-+=<>?:"{}|,.\/;'\\[\]·~！@#￥%……&*（）——\-+={}|《》？：“”【】、；‘’，。、]/g
                            if(patt.test(this.queryInfo.query)) {
                                return this.$message.info('请勿输入特殊字符!')
                            } else if(this.queryInfo.query == '') {
                                return this.$message.info('请输入搜索内容!')
                            }
                            window.location.href = '${pageContext.request.contextPath}/activity/charBoxByActivityName?query=' + this.queryInfo.query
                        },
                        handleCurrentChange(val) {
                            console.log(`当前页: ${val}`)
                            this.currentPage3 = val
                            window.location.href = '${pageContext.request.contextPath}/activity/page?page=' + val
                        },
                        clearInfo() {
                            console.log("das")
                            <%--this.queryInfo.query =  "${empty sessionScope.searchActContent?"":""}"--%>
<%--                            <c:remove var="searchActContent" scope="session" />--%>
<%--                            ${sessionScope.remove("searchActContent")}--%>
<%--                            ${sessionScope.re}--%>
<%--                            ${sessionScope.replace("searchActContent","shabi","bisha")}--%>
                            <%--this.queryInfo.query = '${empty sessionScope.searchActContent?"true":"false"}'--%>

                        }
                    },
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