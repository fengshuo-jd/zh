<%--
  Created by IntelliJ IDEA.
  User: 冯硕
  Date: 2020/11/11
  Time: 19:14
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
                    <el-breadcrumb-item>报名审核</el-breadcrumb-item>
                    <el-breadcrumb-item>{{actName}}</el-breadcrumb-item>
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
                        <el-select v-model="typeValue" placeholder="选择活动状态" @change="stateChanged">
                            <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value">
                            </el-option>
                        </el-select>
                    </el-row>
                    <!-- 表格 -->
                    <el-table :data="uselist" border stripe>
                        <el-table-column label="序号" type="index"></el-table-column>
                        <el-table-column label="姓名" prop="username"></el-table-column>
                        <el-table-column label="学号" prop="stu_id"></el-table-column>
                        <el-table-column label="性别" prop="gender"></el-table-column>
                        <el-table-column label="系别" prop="tie"></el-table-column>
                        <el-table-column label="报名时间" prop="time"></el-table-column>
                        <el-table-column label="状态">
                            <template slot-scope="scope">
                                <el-switch v-model="scope.row.state2" active-value="2" :active-text="scope.row.signUp_state" disabled>
                                </el-switch>
                            </template>
                        </el-table-column>
                        <el-table-column label="操作" width="190px">
                            <template slot-scope="scope">
                                <el-tooltip effect="dark" content="报名审核" placement="top" :enterable="false">
                                    <el-button type="primary" icon="el-icon-edit" size="mini" @click="showEditDialog(scope.row)"></el-button>
                                </el-tooltip>
                                <el-button type="danger" icon="el-icon-delete" size="mini" @click="removeUserById(scope.row)" >
                                </el-button>
                            </template>
                        </el-table-column>
                    </el-table>
                    <!-- 审核对话框 -->
                    <el-dialog title="报名审核" :visible.sync="examDialogVisible" width="50%">
                        <el-form :action="urlAction" method="post" :model="examForm" ref="examRuleFormRef" label-width="70px">
                                <input type="hidden" v-model="examForm.stu_id"   name="stu_id">
                                <el-form-item label="姓名">
                                    <el-input v-model="examForm.username" disabled name="username"></el-input>
                                </el-form-item>
                                <el-form-item label="学号">
                                    <el-input v-model="examForm.stu_id" disabled  name="stu_id"></el-input>
                                </el-form-item>
                                <el-form-item label="性别">
                                    <el-input v-model="examForm.gender" disabled name="gender"></el-input>
                                </el-form-item>
                                <el-form-item label="系别">
                                    <el-input v-model="examForm.tie" disabled name="state_id"></el-input>
                                </el-form-item>
                                <el-form-item label="手机号">
                                    <el-input v-model="examForm.phone_num" disabled name="phone_num"></el-input>
                                </el-form-item>
                                <el-form-item label="报名时间">
                                    <el-input v-model="examForm.time" disabled name="time"></el-input>
                                </el-form-item>
                                <div class="examRadio">
                                    <span>意见</span>
                                    <el-radio v-model="radio" label="2" name="radio">通过</el-radio>
                                    <el-radio v-model="radio" label="1" name="radio">未通过</el-radio>
                                </div>
                                <div style="overflow: hidden;">
                                    <el-button @click="examDialogVisible = false" style="float: right;margin-left: 10px;">取 消</el-button>
                                    <el-button type="primary" style="float: right;" @click="submitExam">确 定</el-button>
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
        el: '#app',
        data() {
            return {
                username: '武藤sb',
                actName: '',
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
                // 活动状态
                typeValue: '',
                // 选择
                options: [{
                    value: '0',
                    label: '全部'
                }, {
                    value: '1',
                    label: '未通过'
                }, {
                    value: '2',
                    label: '已通过'
                }],

                valueSwtich: '已通过',
                avtiveValue: '未通过',
                examForm: {},
                examDialogVisible: false,
                examFormRules: {},
                radio: '1',
                urlAction:'',
                urlType:'',
                uselist:[]
            }
        },
        created() {
            this.add()
            this.getUrl()
        },
        methods: {
            add() {
                let array = ${requestScope.jsonArray}
                    this.actName = "${sessionScope.actName}"
                    this.uselist = array
                    console.log(this.uselist)
            },
            getUrl() {
                var arrUrl = document.location.toString().split("?");
                var para = decodeURI(arrUrl[1])
                var params = para.split("&");
                var paramId = params[0].split('=')
                this.urlType = paramId[1]
                this.urlAction = '${pageContext.request.contextPath}/clientAdmin/updateState?activityId=' + paramId[1]
            },
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
            // 状态改变
            stateChanged(info) {
                console.log(info)

                window.location.href = '${pageContext.request.contextPath}/clientAdmin/suchFind1?activity_id=' + this.urlType + "&state_id=" + info
            },
            showEditDialog(info) {
                this.examForm = {...info
                }
                this.examDialogVisible = true
            },
            submitExam() {
                this.$refs.examRuleFormRef.$el.submit();
            },
            // 删除活动
            async removeUserById(info) {
                const confirmResult = await this.$confirm(
                    "是否将该学生删除?",
                    "提示", {
                        confirmButtonText: "确定"
                    }
                ).catch(err => err);

                if (confirmResult !== "confirm") {
                    return this.$message.info("已取消删除");
                }
                window.location.href = '${pageContext.request.contextPath}/clientAdmin/deleteSignUpUser?activity_id=' + this.urlType  + '&stu_id=' + info.stu_id
            },
            searchSumbit() {
                var patt = /[ `~!@#$%^&*()_\-+=<>?:"{}|,.\/;'\\[\]·~！@#￥%……&*（）——\-+={}|《》？：“”【】、；‘’，。、]/g
                if(patt.test(this.queryInfo.query)) {
                    return this.$message.info('请勿输入特殊字符!')
                } else if(this.queryInfo.query == '') {
                    return this.$message.info('请输入搜索内容!')
                }
                window.location.href = '${pageContext.request.contextPath}/clientAdmin/charBoxNum?activity_id=' + this.urlType + '&query=' + this.queryInfo.query
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

</html>>
