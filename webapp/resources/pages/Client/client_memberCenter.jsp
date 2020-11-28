<%--
  Created by IntelliJ IDEA.
  User: 冯硕
  Date: 2020/11/7
  Time: 21:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人中心</title>
    <link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
    <!-- 引入样式 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/conter.css">
    <link href="https://cdn.bootcdn.net/ajax/libs/element-ui/2.14.0/theme-chalk/index.min.css" rel="stylesheet">
    <!-- 先引入 Vue -->
    <script src="${pageContext.request.contextPath}/resources/js/vue.js"></script>
    <!-- 引入组件库 -->
    <script src="https://cdn.bootcdn.net/ajax/libs/element-ui/2.14.0/index.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/css/fonts_1/iconfont.js"></script>

    <style>
        .el-input {
            width: 500px !important;
        }
    </style>
</head>

<body>
<div id="app">
    <div class="herder">
        <div class="top">
            <div class="top_content">
                <!-- 左边 -->
                <div class="top_left fl">
                    <a class="index" href="${pageContext.request.contextPath}/client/toIndex">返回首页</a>
                    <a class="username">${requestScope.username}</a>

                </div>
                <!-- 右边 -->
                <div class="top_right fr">
                    <a href="${pageContext.request.contextPath}/client/toIndex1">退出</a>
                </div>
            </div>
        </div>
        <div class="wrapper">
            <div class="wrapper_main">
                <div class="logo fl">
                    <img src="${pageContext.request.contextPath}/resources/images/logo2.png" width="227px" height="90px">
                    <span></span>
                </div>
                <div class="center fl">
                    <a href="#" class="seft_center" target="_blank">个人中心</a>
                </div>
            </div>
        </div>
    </div>
    <div class="main">
        <div class="main_content">
            <el-tabs tab-position="left" type="border-card" style="height: 100%;">
                <el-tab-pane label=" 个人主页 ">
                    <el-card>
                        <div class="detail">
                            <div class="img fl">
                                <a href="#" target="_blank">
                                    <img src="https://m.xinyixiaoyuan.com/default/uploads/avatar/11.jpg " alt="用户头像" width="100" height="100">
                                </a>
                            </div>
                            <div class="user_wrap fl">
                                <div class="user_name">
                                    <span style="font-size:16px">用户名：${requestScope.username}</span>
                                    <span style="font-size:16px;display: block; margin-top: 10px;">手机号：${requestScope.phoneNumber}</span>
                                </div>
                                <div class="icons">
                                    <svg class="icon icon1" aria-hidden="true">
                                        <use xlink:href="#icon-shangcheng-shoujijiadianshuma"></use>
                                    </svg>
                                    <svg class="icon icon1" aria-hidden="true">
                                        <use xlink:href="#icon-youxiang"></use>
                                    </svg>
                                </div>
                            </div>
                            <div class="rule">
                                <ul class="rule_state">
                                    <li><span>活动总分</span><span>${empty requestScope.credits?"0":requestScope.credits}</span></li>
                                    <li><span>年度排名</span><span>${empty requestScope.rank?"暂无": requestScope.rank}</span></li>
                                </ul>
                                <c:if test="${requestScope.rank <= 10}">
                                <el-button @click="honor" type="danger">查看荣誉证书</el-button>
                                </c:if>
                            </div>
                        </div>
                    </el-card>
                    <div class="myAct">
                        <div class="mine">我的活动</div>
                    </div>
                    <div class="list">
                        <el-table :data="activityList" stripe>
                            <el-table-column align="center" label="活动名称" prop="activity_name" width="300px"></el-table-column>
                            <el-table-column align="center" label="所属系别" prop="tie"></el-table-column>
                            <el-table-column align="center" label="活动结束时间" prop="end_time" sortable></el-table-column>
                            <el-table-column align="center">
                                <template slot-scope="scope">
                                    <el-button type="primary" @click="detail(scope.row.id)">活动详情</el-button>
                                    <el-button @click="toCert(scope.row)">查看证书</el-button>
                                </template>
                            </el-table-column>
                        </el-table>
                    </div>
                </el-tab-pane>
                <el-tab-pane label="修改信息">
                    <div class="info">
                        <div class="info_title">
                            <span>基本信息</span>
                        </div>
                        <div class="info_main">
                            <el-form action="" method="post" :model="addForm" :rules="addFormRules" ref="addRuleFormRef" label-width="70px">
                                <el-form-item label="姓名" prop="username">
                                    <el-input v-model="addForm.username" name="username" disabled></el-input>
                                </el-form-item>
                                <el-form-item label="学号" prop="stu_id">
                                    <el-input v-model="addForm.stu_id" name="stu_id" disabled></el-input>
                                </el-form-item>
                                <el-form-item label="性别" prop="gender" width="100px">
                                    <el-select v-model="addForm.gender" placeholder="请选择">
                                        <el-option v-for="item in optionsGender" :key="item.value" :label="item.label" :value="item.value">
                                        </el-option>
                                    </el-select>
                                </el-form-item>
                                <el-form-item label="手机号" prop="phone_num">
                                    <el-input v-model="addForm.phone_num" name="phone_num"></el-input>
                                </el-form-item>
                                <div style="overflow: hidden;">
                                    <el-button type="primary" style="float: right;" @click="setInfo">确认修改</el-button>
                                </div>
                            </el-form>
                        </div>
                    </div>
                </el-tab-pane>
                <el-tab-pane label="修改密码">
                    <div class="info">
                        <div class="info_title">
                            <span>修改密码</span>
                        </div>
                        <div class="info_main">
                            <el-form action="${pageContext.request.contextPath}/client/updateStuPsw" method="post" :model="editForm" :rules="editFormRules" ref="editRuleFormRef" label-width="70px">

                                <input type="hidden" name="stu_id" value="${sessionScope.user.stu_id}"/>
                                <el-form-item label="旧密码" prop="oldPassword">
                                    <el-input v-model="editForm.oldPassword" name="oldPassword" type="password"></el-input>
                                </el-form-item>
                                <el-form-item label="新密码" prop="newPassword">
                                    <el-input v-model="editForm.newPassword" name="newPassword" type="password"></el-input>
                                </el-form-item>
                                <el-form-item class="btns">
                                    <el-button type="primary" @click="setPsw">确认修改</el-button>
                                    <el-button type="info" @click="resetPswRorm">重置</el-button>
                                </el-form-item>

                                <span style="color: red">${empty requestScope.passwordMsge?"":requestScope.passwordMsge}</span>
                            </el-form>
                        </div>
                    </div>
                </el-tab-pane>
            </el-tabs>
        </div>
    </div>
    <!-- footer -->
    <div id="footer">
        <div class="footer_content">
            <div class="f_nav">
                <a href="${pageContext.request.contextPath}/resources/pages/Client/cilent_about.jsp">
                    关于我们 </a>
                <a href="${pageContext.request.contextPath}/resources/pages/Client/cilent_about.jsp">
                    使用条款 </a>
                <a href="${pageContext.request.contextPath}/resources/pages/Client/cilent_about.jsp">
                    常见问题</a>
                <a href="${pageContext.request.contextPath}/resources/pages/Client/cilent_about.jsp">
                    意见建议 </a>
                <a href="${pageContext.request.contextPath}/resources/pages/Client/cilent_about.jsp">
                    友情链接 </a>
            </div>
            <p><a href="#" style="color: #FFFFFF">中环志愿信息发布平台
                www.zhzyw.com | 粤ICP备16028038号-2 | 天津中环信息科技有限公司</a></p>
            <div class="certification">
                <a href="#" target="_blank" rel="nofollow"><img src="${pageContext.request.contextPath}/resources/images/360.png"></a>
                <a href="#" target="_blank" rel="nofollow"><img src="${pageContext.request.contextPath}/resources/images/aiclogo.gif"></a>
            </div>
        </div>
    </div>
    <!-- 右边 -->
    <div class="to_top">
        <div class="s_to_top" id="top">
            <svg class="icon" aria-hidden="true">
                <use xlink:href="#icon-dingbu"></use>
            </svg>
        </div>
    </div>
</div>
<script>
    new Vue({
        el: "#app ",
        data() {
            var checkMobile = (rule, value, cb) => {
                // 正则表达式
                const regMoible = /^1[0-9]{10}$/;
                if (regMoible.test(value)) {
                    // 合法的手机
                    return cb();
                }
                cb(new Error("请输入合法的手机号 "));
            };
            //   验证旧密码
            var oldPassword = (rule, value, cb) => {
                // 正则表达式
                const regPassword = /^[A-Za-z0-9]+$/
                if (regPassword.test(value)) {
                    return cb();
                }
                cb(new Error("默认密码6个0"));
            };
            //   验证新密码
            var newPassword = (rule, value, cb) => {
                // 正则表达式
                const regPassword = /^[a-zA-Z]\w{5,17}$/;
                if (regPassword.test(value)) {
                    return cb();
                }
                cb(new Error("以字母开头，长度在6~18之间，只能包含字母、数字和下划线"));
            };
            return {
                username: "hlc123456 ",
                mobile: '13888888888',
                queryInfo: '',
                activityList: [],
                addForm: {
                    username: '',
                    stu_id: '',
                    gender: '',
                    state_id: '',
                    phone_num: '',
                },
                editForm: {
                    oldPassword: '',
                    newPassword: ''
                },
                editFormRules: {
                    oldPassword: [{
                        required: true,
                        message: "请输入旧密码，默认000000",
                        trigger: "blur"
                    }, {
                        validator: oldPassword,
                        trigger: "blur"
                    }],
                    newPassword: [{
                        required: true,
                        message: "请输入新密码",
                        trigger: "blur"
                    }, {
                        validator: newPassword,
                        trigger: "blur"
                    }],
                },
                optionsGender: [{
                    value: '男',
                    label: '男'
                }, {
                    value: '女',
                    label: '女'
                }],
                //   添加表单的验证对象
                addFormRules: {
                    phone_num: [{
                        required: true,
                        message: "请输入手机号",
                        trigger: "blur"
                    }, {
                        validator: checkMobile,
                        trigger: "blur"
                    }],
                },
            }
        },
        created() {
            this.add()

        },
        methods: {
            add() {
                this.addForm.username = "${requestScope.username}"
                this.addForm.stu_id = "${requestScope.stu_id}"
                this.addForm.gender = "${requestScope.gender}"
                this.addForm.phone_num = "${requestScope.phoneNumber}"
                    console.log(this.addForm.username)
                let array = ${requestScope.jsonArray}
                    this.activityList = array
                console.log(this.activityList)
            },
            detail(id) {
                window.location.href='${pageContext.request.contextPath}/client/gotoHasSignUpActivityDetail?activity_id=' + id + '&stu_id=' + "${requestScope.stu_id}"
            },
            //   修改
            setInfo() {
                //   表单预验证
                this.$refs.addRuleFormRef.validate(async valid => {
                    if (!valid){
                        return
                    }
                    else {
                        const confirmResult = await this.$confirm(
                            "是否确定修改?",
                            "提示", {
                                confirmButtonText: "确定"
                            }
                        ).catch(err => err);

                        if (confirmResult !== "confirm") {
                            return this.$message.info("已取消修改");
                        }
                        window.location.href='${pageContext.request.contextPath}/client/updateStuInfo?stu_id=' + "${requestScope.stu_id}" + "&gender=" + this.addForm.gender + "&phone_num=" +  this.addForm.phone_num

                    }
                })
            },
            //   重置
            resetPswRorm() {
                this.$refs.editRuleFormRef.resetFields()
            },
            //   修改
            setPsw() {
                //   表单预验证
                this.$refs.editRuleFormRef.validate(async valid => {
                    if (!valid) {
                        return
                    }else {
                        const confirmResult = await this.$confirm(
                            "是否确定修改?",
                            "提示", {
                                confirmButtonText: "确定"
                            }
                        ).catch(err => err);

                        if (confirmResult !== "confirm") {
                            return this.$message.info("已取消修改");
                        }
                        this.$refs.editRuleFormRef.$el.submit();
                    }
                })
            },
            toCert(info) {

                    window.location.href = "${pageContext.request.contextPath}/client/certificate?username=" + '${requestScope.username}' + "&activityName=" + info.activity_name + "&endTime=" + info.end_time
                },
            honor() {
                    window.location.href = '${pageContext.request.contextPath}/client/honor?username=' +'${requestScope.username}' + "&rankNum=" + '${empty requestScope.rank?"none":requestScope.rank}'
                }
        }
    })
</script>
<script src="${pageContext.request.contextPath}/resources/js/to-top.js"></script>
</body>

</html>
