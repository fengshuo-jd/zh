<%--
  Created by IntelliJ IDEA.
  User: 冯硕
  Date: 2020/11/11
  Time: 19:10
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
            font-size: 13px !important;
        }

        .el-button+.el-button {
            margin-left: 0px !important;
        }

        .el-button [class*=el-icon-]+span {
            margin-left: 0px;
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
                            <el-input placeholder="请输入内容" v-model="queryInfo.query" maxlength="11" clearable>
                                <el-button slot="append" icon="el-icon-search" @click=searchSumbit></el-button>
                            </el-input>
                        </el-col>
                        <el-select v-model="typeValue" placeholder="选择活动状态" @change="stateChanged">
                            <el-option v-for="item in typeOptions" :key="item.value" :label="item.label" :value="item.value">
                            </el-option>
                        </el-select>
                    </el-row>
                    <el-table :data="activityList" border stripe>
                        <el-table-column label="序号" type="index"></el-table-column>
                        <el-table-column label="活动名称" prop="activity_name" width="300px"></el-table-column>
                        <el-table-column label="所属系别" prop="tie"></el-table-column>
                        <el-table-column label="创建人" prop="creator"></el-table-column>
                        <el-table-column label="活动开始时间" prop="time" width="130px"></el-table-column>
                        <el-table-column label="活动结束时间" prop="end_time" width="130px"></el-table-column>
                        <el-table-column label="状态">
                            <template slot-scope="scope">
                                <el-switch v-model="scope.row.state" active-value="2" :active-text="scope.row.stateStr" disabled>
                                </el-switch>
                            </template>
                        </el-table-column>
                        <el-table-column label="操作" width="200px">
                            <template slot-scope="scope">
                                <el-tooltip effect="dark" content="修改活动" placement="top" :enterable="false">
                                    <el-button type="primary" icon="el-icon-tickets" size="mini"
                                               @click="setList(scope.row)"></el-button>
                                </el-tooltip>
                                <el-button type="danger" icon="el-icon-delete" size="mini"
                                           @click="removeList(scope.row)">
                                </el-button>
                                <el-button type="primary" icon="el-icon-bell" size="mini" plain class="notify"
                                           @click="open5(scope.row)">
                                    消息
                                </el-button>
                            </template>
                        </el-table-column>
                    </el-table>
                    <!-- 修改对话框 -->
                    <el-dialog title="修改活动" :visible.sync="editDialogVisible" width="50%" @close="editDialogClosed">
                        <el-form action="${pageContext.request.contextPath}/clientAdmin/updateActivity" :rules="editFormRules" method="post" :model="editForm" ref="editRuleFormRef" label-width="80px">

                            <input type="hidden" name="creator" v-model="editForm.creator"/>
                            <input type="hidden" name="id" v-model="editForm.id"/>

                            <el-form-item label="活动名称" prop="activity_name">
                                <el-input v-model="editForm.activity_name" name="activity_name"></el-input>
                            </el-form-item>
                            <el-form-item label="活动简介" prop="activity_introduce">
                                <el-input v-model="editForm.activity_introduce" name="activity_introduce"></el-input>
                            </el-form-item>
                            <el-form-item label="活动内容" prop="activity_details">
                                <el-input v-model="editForm.activity_details" type="textarea" name="activity_details"></el-input>
                            </el-form-item>
                            <el-form-item label="活动分值" prop="activity_score">
                                <el-input v-model="editForm.activity_score" type="number" name="activity_score"></el-input>
                            </el-form-item>
                            <el-form-item label="活动地点" prop="activity_place">
                                <el-input v-model="editForm.activity_place" name="activity_place"></el-input>
                            </el-form-item>
                            <el-form-item label="活动类型" prop="activity_type">
                                <el-select name="activity_type" v-model="editForm.activity_type" placeholder="请选择">
                                    <el-option v-for="item in optionsType" :key="item.value" :label="item.label" :value="item.value">
                                    </el-option>
                                </el-select>
                            </el-form-item>
                            <el-form-item label="系别" prop="tie">
                                <!-- <el-input v-model="editForm.tie" name="tie"></el-input> -->
                                <el-select name="tie" v-model="editForm.tie" placeholder="请选择">
                                    <el-option v-for="item in optionsTie" :key="item.value" :label="item.label" :value="item.value">
                                    </el-option>
                                </el-select>
                            </el-form-item>
                            <el-form-item label="总人数" prop="activity_total_number">
                                <el-input v-model="editForm.activity_total_number" name="activity_total_number"></el-input>
                            </el-form-item>
                            <el-form-item label="活动时间" prop="time">
                                <el-date-picker
                                        v-model="editForm.time"
                                        type="datetimerange"
                                        range-separator="至"
                                        start-placeholder="开始日期"
                                        end-placeholder="结束日期"
                                        value-format="yyyy-MM-dd hh:mm"
                                        name="allTime">
                                </el-date-picker>
                            </el-form-item>
                            <div style="overflow: hidden;">
                                <el-button @click="editDialogVisible = false" style="float: right;margin-left: 10px;">取 消</el-button>
                                <el-button type="primary" @click="editAct" style="float: right;">确 定</el-button>
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
                // 活动列表参数对象
                queryInfo: {
                    query: "",
                    pagenum: 1,
                    pagesize: 2
                },
                typeValue: '',
                // 选择活动状态
                typeOptions: [{
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
                // 活动列表

                // 状态
                valueModel: false,
                valueActive: '未审核',

                // 修改话框
                editDialogVisible: false,
                editForm: {},
                // 编辑的验证对象
                editFormRules: {
                    activity_name: [{
                        required: true,
                        message: "请输入活动名称",
                        trigger: "blur"
                    }],
                    activity_introduce: [{
                        required: true,
                        message: "请输入活动简介",
                        trigger: "blur"
                    }],
                    activity_details: [{
                        required: true,
                        message: "请输入活动内容",
                        trigger: "blur"
                    }],
                    activity_total_number: [{
                        required: true,
                        message: "请输入活动总人数",
                        trigger: "blur"
                    }],
                    activity_score: [{
                        required: true,
                        message: "请输入活动分值",
                        trigger: "blur"
                    }],
                    activity_place: [{
                        required: true,
                        message: "请输入活动地点",
                        trigger: "blur"
                    }],
                    time: [{
                        required: true,
                        message: "请输入活动时间",
                        trigger: "blur"
                    }]
                },
                // 选择
                optionsType: [{
                    value: '1',
                    label: '文体活动'
                }, {
                    value: '2',
                    label: '实践实习'
                }, {
                    value: '3',
                    label: '公益志愿'
                }, {
                    value: '4',
                    label: '创新创业'
                }, {
                    value: '5',
                    label: '思想成长'
                }, {
                    value: '6',
                    label: '技能培训'
                }, {
                    value: '7',
                    label: '工作履历'
                }],
                // 选择
                optionsTie: [{
                    value: '0',
                    label: '自动化工程系'
                }, {
                    value: '1',
                    label: '机械工程系'
                }, {
                    value: '2',
                    label: '电子信息工程系'
                }, {
                    value: '3',
                    label: '计算机工程系'
                }, {
                    value: '4',
                    label: '经济与管理系'
                }, {
                    value: '5',
                    label: '院级组织'
                }],
                pickerOptions1: {
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
                    window.location.href = '${pageContext.request.contextPath}/clientAdmin/logout'
                }
            },
            // 折叠效果
            toggleCollapse() {
                this.isCollapse = !this.isCollapse
            },
            // 保存链接的激活状态
            saveNavState(activePath) {
                window.sessionStorage.setItem('activePath', activePath)
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
            },
            // 状态改变
            stateChanged(info) {
                console.log(info)

                window.location.href='${pageContext.request.contextPath}/clientAdmin/suchFind?stateId='+ info + '&creator=' + "${sessionScope.user.username}"

            },
            // 修改活动
            setList(info) {
                this.editForm = {
                    ...info
                }
                this.editForm.time = []
                this.editForm.time.push(info.time)
                this.editForm.time.push(info.end_time)
                this.editDialogVisible = true
            },
            editAct() {
                this.$refs.editRuleFormRef.validate(valid => {
                    console.log(valid)
                    if (!valid) return

                    else {
                        this.addDialogVisible = false;
                        this.$refs.editRuleFormRef.$el.submit();
                    }
                })

                // this.$message.success("添加用户成功!");
                // this.editDialogVisible = false;
                //this.$refs.addRuleFormRef.$el.action = "login/add"
            },
            // 监听修改用户对话框的关闭事件
            editDialogClosed() {
                this.$refs.editRuleFormRef.resetFields();
            },
            // 删除活动
            async removeList(id) {
                const confirmResult = await this.$confirm(
                    "此操作将永久删除该活动, 是否继续?",
                    "提示", {
                        confirmButtonText: "确定"
                    }
                ).catch(err => err);

                if (confirmResult !== "confirm") {
                    return this.$message.info("已取消删除");
                }
                //console.log(id)
                location.href="${pageContext.request.contextPath}/clientAdmin/deleteActivity?activity_id=" + id.id + '&creator=' + id.creator
            },
            open5(info) {
                this.$notify.info({
                    title: '消息',
                    message: info.activity_remarks
                });
            },
            searchSumbit() {
                var patt = /[ `~!@#$%^&*()_\-+=<>?:"{}|,.\/;'\\[\]·~！@#￥%……&*（）——\-+={}|《》？：“”【】、；‘’，。、]/g
                if(patt.test(this.queryInfo.query)) {
                    return this.$message.info('请勿输入特殊字符!')
                } else if(this.queryInfo.query == '') {
                    return this.$message.info('请输入搜索内容!')
                }
                window.location.href = '${pageContext.request.contextPath}/clientAdmin/charBoxByActivtyNameAndUserName?query=' + this.queryInfo.query + '&username=' + '${sessionScope.user.username}'
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
