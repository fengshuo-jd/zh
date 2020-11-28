<%--
  Created by IntelliJ IDEA.
  User: 冯硕
  Date: 2020/11/12
  Time: 8:19
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

    <link href="${pageContext.request.contextPath}/resources/css/quill.core.css" rel="stylesheet">

    <link href="${pageContext.request.contextPath}/resources/css/quill.snow.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/quill.bubble.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resources/js/quill.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/vue-quill-editor.js"></script>
    <script type="text/javascript">
        Vue.use(window.VueQuillEditor)
    </script>
    <style>
        .el-checkbox {
            margin: 0 10px 0 0 !important;
        }

        .previewImg {
            width: 100%;
        }

        .btnAdd {
            margin-top: 15px;
        }

        .el-steps {
            margin: 13px 0;
        }

        .el-step__title {
            font-size: 13px;
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
                <el-menu background-color="#333744" text-color="#fff" unique-opened active-text-color="#409eff" :collapse='isCollapse' :collapse-transition="false" default-active="/add">
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
                    <el-breadcrumb-item>发布活动</el-breadcrumb-item>
                </el-breadcrumb>
                <!-- 卡片视图 -->
                <el-card>
                    <!-- 提示区域 -->
                    <el-alert title="发布活动信息" type="info" center show-icon :closable="false">
                    </el-alert>
                    <!-- 步骤条区域 -->
                    <el-steps :space="300" :active="activeIndex - 0" finish-status="success" align-center>
                        <el-step title="基本信息"></el-step>
                        <el-step title="完成"></el-step>
                    </el-steps>
                    <!-- tab栏区域 -->
                    <el-form action="${pageContext.request.contextPath}/clientAdmin/addActivity" method="post" :model="addForm" :rules="addFormRules" ref="addFormRef" label-width="100px" label-position="top">
                        <el-tabs v-model="activeIndex" :tab-position="'left'" :before-leave="beforeTabLeave">
                            <el-tab-pane label="基本信息" name="0">
<%--                                <input type="hidden" name="fff" value=""--%>
                                <input type="hidden" name="name" value="${sessionScope.user.username}"/>

                                <input type="hidden" name="stuid" value="${sessionScope.user.stu_id}"/>
                                <el-form-item label="活动名称" prop="activity_name">
                                    <el-input name="activity_name" v-model="addForm.activity_name" maxlength="20" placeholder="最长20字"></el-input>
                                </el-form-item>
                                <el-form-item label="活动简介" prop="activity_introduce">
                                    <el-input name="activity_introduce" v-model="addForm.activity_introduce" maxlength="10" placeholder="最长10字"></el-input>
                                </el-form-item>
                                <el-form-item label="活动内容" prop="activity_details">
                                    <el-input name="activity_details" type="textarea" v-model="addForm.activity_details" maxlength="50" placeholder="最长5 0字"></el-input>
                                </el-form-item>
                                <el-form-item label="活动总人数" prop="activity_total_number">
                                    <el-input name="activity_total_number" v-model="addForm.activity_total_number" type="number"></el-input>
                                </el-form-item>
                                </el-form-item>
                                <el-form-item label="活动分值" prop="activity_score">
                                    <el-input v-model="addForm.activity_score" type="number" name="activity_score"></el-input>
                                </el-form-item>
                                <el-form-item label="活动地点" prop="activity_place">
                                    <el-input v-model="addForm.activity_place" name="activity_place" maxlength="10" placeholder="最长10字"></el-input>
                                </el-form-item>
                                <el-form-item label="活动类型" prop="activity_type">
                                    <!-- <el-input v-model="editForm.creator" name="creator"></el-input> -->
                                    <el-select name="activity_type" v-model="addForm.activity_type" placeholder="请选择">
                                        <el-option v-for="item in optionsType" :key="item.value" :label="item.label" :value="item.value">
                                        </el-option>
                                    </el-select>
                                </el-form-item>
                                <el-form-item label="系别" prop="tie">
                                    <!-- <el-input v-model="editForm.tie" name="tie"></el-input> -->
                                    <el-select name="tie" v-model="addForm.tie" placeholder="请选择">
                                        <el-option v-for="item in optionsTie" :key="item.value" :label="item.label" :value="item.value">
                                        </el-option>
                                    </el-select>
                                </el-form-item>
                                <el-form-item label="活动时间" prop="time">
                                    <el-date-picker
                                            v-model="addForm.time"
                                            type="datetimerange"
                                            range-separator="至"
                                            start-placeholder="开始日期"
                                            end-placeholder="结束日期"
                                            value-format="yyyy-MM-dd hh:mm"
                                            name="allTime">
                                    </el-date-picker>
                                </el-form-item>
                            </el-tab-pane>
                            <el-tab-pane label="完成" name="1">
                                <el-button type="primary" class="btnAdd" @click="addAct">发布活动</el-button>
                            </el-tab-pane>
                        </el-tabs>
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
                activeIndex: '0',
                addForm: {
                    activity_name: '',
                    activity_introduce: '',
                    activity_details: '',
                    activity_type: '',
                    tie: '',
                    activity_total_number: 10,
                    time: '',
                    activity_score:1,
                    activity_place:''
                },
                // 编辑的验证对象
                addFormRules: {
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
                    value: '0',
                    label: '文体活动'
                }, {
                    value: '1',
                    label: '实践实习'
                }, {
                    value: '2',
                    label: '公益志愿'
                }, {
                    value: '3',
                    label: '创新创业'
                }, {
                    value: '4',
                    label: '思想成长'
                }, {
                    value: '5',
                    label: '技能培训'
                }, {
                    value: '6',
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
                }]
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
            beforeTabLeave(activeName, oldActiveName) {
                if (oldActiveName === '0' && this.addForm.activity_type.length !== 1) {
                    this.$message.error('请先选择活动类型！')
                    return false
                } else if (oldActiveName === '0' && this.addForm.tie.length !== 1) {
                    this.$message.error('请先选择系别！')
                    return false
                }else if (oldActiveName === '0' && this.addForm.time.length !== 2) {
                    this.$message.error('请选择活动时间！')
                    return false
                }
            },
            addAct() {
                this.$refs.addFormRef.validate(valid => {
                    console.log(valid)
                    if (!valid) return this.$message.error('请填写必要的表单项！')
                    else {
                        this.addDialogVisible = false;
                        this.$refs.addFormRef.$el.submit();
                    }
                })
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
