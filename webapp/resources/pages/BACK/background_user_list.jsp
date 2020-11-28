<%--
  Created by IntelliJ IDEA.
  User: 冯硕
  Date: 2020/11/6
  Time: 10:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户管理</title>
    <link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
    <!-- 引入样式 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_index.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/fonts/iconfont.css">
    <link href="https://cdn.bootcdn.net/ajax/libs/element-ui/2.14.0/theme-chalk/index.min.css" rel="stylesheet">
    <!-- 先引入 Vue -->
    <script src="${pageContext.request.contextPath}/resources/js/vue.js"></script>
    <!-- 引入组件库 -->
    <script src="https://cdn.bootcdn.net/ajax/libs/element-ui/2.14.0/index.min.js"></script>
    <title>后台登录</title>
    <meta charset="UTF-8">
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
                <el-menu background-color="#333744" text-color="#fff" unique-opened active-text-color="#409eff" :collapse='isCollapse' :collapse-transition="false" default-active="/users">
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
                    <el-breadcrumb-item>用户管理</el-breadcrumb-item>
                    <el-breadcrumb-item>用户列表</el-breadcrumb-item>
                </el-breadcrumb>
                <!-- 卡片视图 -->
                <el-card>
                    <!-- 搜索 -->
                    <el-row :gutter="20">
                        <el-col :span="8">
                            <el-input placeholder="请输入姓名或学号" v-model="queryInfo.query" maxlength="11" clearable>
                            <el-button slot="append" icon="el-icon-search" @click=searchSumbit></el-button>
                        </el-input>
                        </el-col>
                        <el-col :span="4">
                            <el-button type="primary" @click="addDialogVisible=true">添加用户</el-button>
                        </el-col>

                    </el-row>
                    <!-- 表格 -->
                    <el-table :data="uselist" border stripe>
                        <%--                            <c:forEach items="${requestScope}" var="user">--%>
                        <el-table-column label="序号" type="index" ></el-table-column>
                        <el-table-column label="姓名" prop="username"></el-table-column>
                        <el-table-column label="学号" prop="stu_id" sortable></el-table-column>
                        <el-table-column label="性别" prop="gender"></el-table-column>
                        <el-table-column label="角色" prop="limit_id"></el-table-column>
                        <el-table-column label="手机号" prop="phone_num"></el-table-column>
                        <el-table-column label="操作" width="250px">
                            <template slot-scope="scope">
                                <el-tooltip effect="dark" content="重置密码" placement="top" :enterable="false">
                                    <el-button type="info" icon="el-icon-edit-outline" size="mini"
                                               @click="setPsw(scope.row.stu_id)">
                                    </el-button>
                                </el-tooltip>
                                <el-tooltip effect="dark" content="修改信息" placement="top" :enterable="false">
                                    <el-button type="primary" icon="el-icon-edit" size="mini"
                                               @click="showEditDialog(scope.row)">
                                    </el-button>
                                </el-tooltip>
                                <el-tooltip effect="dark" content="分配权限" placement="top" :enterable="false">
                                    <el-button type="warning" icon="el-icon-setting" size="mini"
                                               @click="setRole(scope.row)"></el-button>
                                </el-tooltip>
                                <el-tooltip effect="dark" content="删除用户" placement="top" :enterable="false">
                                    <el-button type="danger" icon="el-icon-delete" size="mini"
                                               @click="removeUserById(scope.row)">
                                    </el-button>
                                </el-tooltip>
                            </template>
                        </el-table-column>
                        <%--                            </c:forEach>   onclick=delete_A()--%>
                    </el-table>
                    <el-pagination @current-change="handleCurrentChange" :current-page.sync="currentPage3" :page-size="10" layout="total, prev, pager, next, jumper" :total="${sessionScope.userCount}">
                    </el-pagination>

                </el-card>
                <!-- 添加用户对话框 -->
                <el-dialog title="添加用户" :visible.sync="addDialogVisible" width="50%" @close="addDialogClosed">
                    <el-form action="${pageContext.request.contextPath}/user/addOneUser" method="post"  :rules="addFormRules" ref="addRuleFormRef" label-width="70px" :model="addForm" >

                        <el-form-item label="姓名" prop="username">
                            <el-input v-model="addForm.username" name="username"></el-input>
                        </el-form-item>
                        <el-form-item label="学号" prop="stu_id">
                            <el-input v-model="addForm.stu_id" name="stu_id"></el-input>
                        </el-form-item>
                        <el-form-item label="性别" prop="gender" width="100px">
                            <el-select v-model="addForm.gender" placeholder="请选择" name="gender">
                                <el-option v-for="item in optionsGender" :key="item.value" :label="item.label" :value="item.value">
                                </el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="角色" prop="limit_id" width="100px">
                            <el-select v-model="addForm.limit_id" placeholder="请选择" name="limit_id">
                                <el-option v-for="item in optionsType" :key="item.value" :label="item.label" :value="item.value">
                                </el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="手机号" prop="phone_num">
                            <el-input v-model="addForm.phone_num" name="phone_num"></el-input>
                        </el-form-item>
                        <div style="overflow: hidden;">
                            <el-button @click="addDialogVisible = false" style="float: right;margin-left: 10px;">取 消</el-button>
                            <el-button type="primary" @click="addUser" style="float: right;" >确 定</el-button>
                        </div>
                    </el-form>
                </el-dialog>
                <!-- 编辑对话框 -->
                <el-dialog title="修改信息" :visible.sync="editDialogVisible" width="50%" @close="editDialogClosed">
                    <el-form :model="editForm" :rules="editFormRules" ref="editRuleFormRef" label-width="70px" method="post" action="${pageContext.request.contextPath}/user/updateUserInfo">
                        <input type="hidden" name="action" value="updateInfo"/>
                        <input type="hidden" name="id" v-model="editForm.id"/>
                        <el-form-item label="姓名" prop="username">
                            <el-input v-model="editForm.username" name="username"></el-input>
                        </el-form-item>
                        <el-form-item label="学号" prop="stu_id">
                            <el-input v-model="editForm.stu_id" name="stu_id" ></el-input>
                        </el-form-item>
                        <el-form-item label="性别" prop="gender" width="100px">
                            <el-select v-model="editForm.gender" placeholder="请选择" name="gender">
                                <el-option v-for="item in optionsGender" :key="item.value" :label="item.label" :value="item.value">
                                </el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="手机号" prop="phone_num">
                            <el-input v-model="editForm.phone_num" name="phone_num"></el-input>
                        </el-form-item>
                        <div style="overflow: hidden;">
                            <el-button @click="editDialogVisible = false" style="float: right;margin-left: 10px;">取 消</el-button>
                            <el-button type="primary" @click="editUserInfo" style="float: right;" >确 定</el-button>
                        </div>
                    </el-form>
                </el-dialog>
                <!-- 分配角色对话框 -->
                <el-dialog title="分配角色" :visible.sync="setRoleDialogVisible" width="50%" @close="setRoleDialogClosed">
                    <div>
                        <p>当前的姓名：{{userInfo.username}}</p>
                        <p>当前的角色：{{userInfo.limit_id}}</p>
                        <p>
                            分配新角色：
                            <el-select v-model="selectdRoleId" placeholder="请选择">
                                <el-option v-for="item in rolesList" :key="item.id" :label="item.roleName" :value="item.id"></el-option>
                            </el-select>
                        </p>
                    </div>
                    <span slot="footer" class="dialog-footer">
                            <el-button @click="setRoleDialogVisible = false">取 消</el-button>
                            <el-button type="primary" @click="saveRoleInfo(userInfo.stu_id)">确 定</el-button>
                        </span>
                </el-dialog>
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
            //   验证学号
            var checkStu_id = (rule, value, cb) => {
                // 正则表达式
                const regStu_id = /^\d{8}$/;
                if (regStu_id.test(value)) {
                    // 合法的学号
                    return cb();
                }
                cb(new Error("请输入合法的学号"));
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
                // 用户列表参数对象
                queryInfo: {
                    query: "",
                    pagenum: 1,
                    pagesize: 2
                },

                uselist: [],
                total: 1,
                //   添加用户对话框
                addDialogVisible: false,
                //   添加用户表单数据
                addForm: {
                    username: "",
                    stu_id: "",
                    gender: "",
                    limit_id:"",
                    phone_num: "",
                },
                //   添加表单的验证对象
                addFormRules: {
                    username: [{
                        required: true,
                        message: "请输入姓名",
                        trigger: "blur"
                    }, {
                        validator: checkUsername,
                        trigger: "blur"
                    }],
                    stu_id: [{
                        required: true,
                        message: "请输入学号",
                        trigger: "blur"
                    }, {
                        validator: checkStu_id,
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
                optionsGender: [{
                        value: '0',
                        label: '男'
                    }, {
                        value: '1',
                        label: '女'
                    }],
                    optionsType: [{
                        value: '0',
                        label: '学生'
                    }, {
                        value: '1',
                        label: '活动管理员'
                    }],
                // 编辑用户
                editDialogVisible: false,
                // 编辑是获取的用户信息
                editForm: "",
                // 编辑的验证对象
                editFormRules: {
                    username: [{
                        required: true,
                        message: "请输入姓名",
                        trigger: "blur"
                    }, {
                        validator: checkUsername,
                        trigger: "blur"
                    }],
                    stu_id: [{
                        required: true,
                        message: "请输入学号",
                        trigger: "blur"
                    }, {
                        validator: checkStu_id,
                        trigger: "blur"
                    }],
                    gender: [{
                        required: true,
                        message: "请输入性别",
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
                // 分配角色
                setRoleDialogVisible: false,
                // 分配角色的用户信息
                userInfo: {},
                // 所有角色的数据列表
                rolesList: [],
                // 已选择的角色id
                selectdRoleId: "",
                currentPage3: 1,
            }
        },
        created() {
            this.add()

        },
        methods: {
            handleCurrentChange(val) {
                console.log(`当前页: ${val}`)
                this.currentPage3 = val
                window.location.href = '${pageContext.request.contextPath}/user/page?page=' + val
            },
            add() {
                var array = ${requestScope.jsonArray}
                    this.uselist = array
                this.addForm.gender = '男',
                    this.addForm.limit_id = '学生'
                this.currentPage3 = ${sessionScope.pageNum1}
                this.queryInfo.query = '${empty sessionScope.searchContent?"":sessionScope.searchContent}'

            },
            quit() {
                window.location.href='${pageContext.request.contextPath}/user/logout'
            },
            // 折叠效果
            toggleCollapse() {
                this.isCollapse = !this.isCollapse
            },
            // 保存链接的激活状态
            saveNavState(activePath) {
                window.sessionStorage.setItem('activePath', activePath)
                this.activePath = activePath
                console.log(this.activePath)
                if(this.activePath == '/users') {
                    window.location.href = '${pageContext.request.contextPath}/user/findall'
                }else if(this.activePath == '/orders') {
                    window.location.href = '${pageContext.request.contextPath}/activity/findAll'
                }else {
                    window.location.href = '${pageContext.request.contextPath}/date/show'
                }

                <%--window.location.href = '${pageContext.request.contextPath}/userListServlet?action=userList'--%>
            },
            // 监听switch开关的改变
            userStateChanged(userinfo) {
                this.$message.success("更新用户状态成功");
            },
            // 监听添加用户对话框的关闭事件
            addDialogClosed() {
                this.$refs.addRuleFormRef.resetFields();
            },
            // 点击按钮，添加新用户
            addUser() {
                this.$refs.addRuleFormRef.validate(valid => {
                    if(!valid) {
                        return
                    }
                    else {
                        this.$message.success("添加用户成功!");
                        this.addDialogVisible = false;
                        this.$refs.addRuleFormRef.$el.submit();
                    }

                })

            },
            // 编辑用户对话框
            showEditDialog(id) {
                this.editForm = {...id}
                console.log(id)
                this.editDialogVisible = true;
            },
            // 监听修改用户对话框的关闭事件
            editDialogClosed() {
                this.$refs.editRuleFormRef.resetFields();
            },
            editUserInfo() {
                this.$refs.editRuleFormRef.validate(valid => {
                    if(!valid) {
                        return
                    }
                    else {
                        // 关闭对话框
                        this.editDialogVisible = false;
                        // 提示修改成功
                        this.$message.success("更新用户信息成功");
                        this.$refs.editRuleFormRef.$el.submit();
                    }
                })

            },
            // 删除用户操作
            async removeUserById(id) {
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
                location.href="${pageContext.request.contextPath}/user/deleteUser?stu_id=" + id.stu_id
            },

            // 展示分配角色的对话框
            async setRole(userInfo) {
                console.log(userInfo)
                this.userInfo = userInfo;
                // 获取角色列表
                this.rolesList = [{
                    "id": 30,
                    "roleName": "活动管理员"
                }, {
                    "id": 31,
                    "roleName": "学生"
                }];
                this.setRoleDialogVisible = true;
            },
            // 点击按钮，分配角色
            async saveRoleInfo(stu_id) {
                if (!this.selectdRoleId) {
                    return this.$message.error("请选择要分配的角色");
                }

                this.$message.success("更新角色成功");
                this.setRoleDialogVisible = false;
                location.href="${pageContext.request.contextPath}/user/updateUserRoleInfo?limit_id=" + this.selectdRoleId+"&stu_id=" + stu_id
            },
            setRoleDialogClosed() {
                this.selectdRoleId = "";
                this.userInfo = {};
            },
            searchSumbit() {
                var patt = /[ `~!@#$%^&*()_\-+=<>?:"{}|,.\/;'\\[\]·~！@#￥%……&*（）——\-+={}|《》？：“”【】、；‘’，。、]/g
                if(patt.test(this.queryInfo.query)) {
                    return this.$message.info('请勿输入特殊字符!')
                } else if(this.queryInfo.query == '') {
                    return this.$message.info('请输入搜索内容!')
                }
                window.location.href = '${pageContext.request.contextPath}/user/charBoxByUsernameOrStuId?query=' + this.queryInfo.query
            },
            async setPsw(stu_id) {
                const confirmResult = await this.$confirm(
                    "此操作将重置用户密码, 是否继续?",
                    "提示", {
                        confirmButtonText: "确定"
                    }
                ).catch(err => err);

                if (confirmResult !== "confirm") {
                    return this.$message.info("已取消重置");
                }
                window.location.href="${pageContext.request.contextPath}/user/reset?stu_id=" + stu_id
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
