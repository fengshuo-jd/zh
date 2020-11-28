<%--
  Created by IntelliJ IDEA.
  User: 冯硕
  Date: 2020/11/7
  Time: 21:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>活动详情</title>
    <link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
    <!-- 引入样式 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/detail.css">
    <link href="https://cdn.bootcdn.net/ajax/libs/element-ui/2.14.0/theme-chalk/index.min.css" rel="stylesheet">
    <!-- 先引入 Vue -->
    <script src="${pageContext.request.contextPath}/resources/js/vue.js"></script>
    <!-- 引入组件库 -->
    <script src="https://cdn.bootcdn.net/ajax/libs/element-ui/2.14.0/index.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/css/fonts_1/iconfont.js"></script>
</head>

<body>
<div id="app">
    <div class="container">
        <!-- 顶部 -->
        <div class="top">
            <div class="top_container clearfix">
                <!-- meau -->
                <div class="top_meau clearfix">
                    <div class="name">
                        <span>天津理工大学中环信息学院</span>
                    </div>
                    <div class="login">
                        <div class="welcome">
                            <span style="color: #3697fc;">${empty sessionScope.wolcomeInfo?"欢迎来到中环志愿信息发布平台 ！":sessionScope.wolcomeInfo}</span>
                            <span class="message">
                                    <a href="#">
                                        <svg class="icon" aria-hidden="true">
                                            <use xlink:href="#icon-denglu" />
                                        </svg>
                                         <c:if test="${empty sessionScope.user}">
                                             <a href="${pageContext.request.contextPath}/resources/pages/Client/client_login_stu.jsp">点我登录</a>
                                         </c:if>
                                        <c:if test="${not empty sessionScope.user}">
                                            <a href="${pageContext.request.contextPath}/client/stuCenter?userId=${sessionScope.user.stu_id}">${sessionScope.user.username}</a>
                                            <a href="${pageContext.request.contextPath}/client/toIndex1">退出</a>
                                        </c:if>
                                    </a>
                                </span>
                        </div>
                    </div>
                </div>
                <!-- search -->
                <div class="top_search">
                    <div class="top_logo">
                        <img src="${pageContext.request.contextPath}/resources/images/logo2.png" />
                    </div>
                    <div class="search_box">
                        <el-input placeholder="搜索活动" v-model="queryInfo">
                            <el-button slot="append" icon="el-icon-search" class="search_button"></el-button>
                        </el-input>
                    </div>

                </div>
                <!-- 导航栏 -->
                <div class="nav">
                    <div class="nav_contanier">
                        <ul>
                            <li class="fl"><a href="${pageContext.request.contextPath}/client/toIndex"><span>首页</span></a></li>
                            <li class="fl"><a href="${pageContext.request.contextPath}/client/findSuchByTie?tie=2"><span class="tran">自动化工程系</span></a></li>
                            <li class="fl"><a href="${pageContext.request.contextPath}/client/findSuchByTie?tie=3"><span>机械工程系</span></a></li>
                            <li class="fl"><a href="${pageContext.request.contextPath}/client/findSuchByTie?tie=5"><span>电子信息工程系</span></a></li>
                            <li class="fl"><a href="${pageContext.request.contextPath}/client/findSuchByTie?tie=1"><span>计算机工程系</span></a></li>
                            <li class="fl"><a href="${pageContext.request.contextPath}/client/findSuchByTie?tie=4"><span>经济与管理系</span></a></li>
                            <li class="fl"><a href="${pageContext.request.contextPath}/client/findSuchByTie?tie=6"><span>院级组织</span></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- 主题区域 -->
        <div class="main">
            <div class="main_container">
                <div style="overflow: hidden; margin-bottom: 40px;">
                    <!-- 左边 -->
                    <el-card>
                        <!-- title -->
                        <div class="c_title">
                            <a>${requestScope.activity.activity_name}</a>
                            <div class="fr" style="margin-right:50px">
                                    <span class="view_num fr">
                                    【浏览次数：{{rand}}】
                                </span>
                            </div>
                            <img alt="" src="${pageContext.request.contextPath}/resources/images/detail.png" width="100" height="100" class="act_img">
                        </div>
                        <!-- detail -->
                        <div class="detail_info">
                            <div class="info_title"><i></i>基本信息:</div>
                            <div>
                                <span class="type">活动详情：</span>
                                <span>${requestScope.activity.activity_details}</span>
                            </div>
                            <div>
                                <span class="type">所属系别：</span>
                                <span>${requestScope.activity.tie}</span>
                            </div>
                            <div>
                                <span class="type">开始时间：</span>
                                <span>${requestScope.activity.time}</span>
                            </div>
                            <div>
                                <span class="type">结束时间：</span>
                                <span>${requestScope.activity.end_time}</span>
                            </div>
                            <div>
                                <span class="type">活动地点：</span>
                                <span>
                                    ${requestScope.activity.activity_place} </span>
                            </div>
                            <div>
                                <span class="type">活动人数：</span>
                                <span>${requestScope.activity.activity_total_number}</span>
                            </div>
                            <div>
                                <span class="type">活动学分：</span>
                                <span>${requestScope.activity.activity_score}</span>
                            </div>
                            <div>
                                <span class="type">活动类型：</span>
                                <span>
                                    ${requestScope.activity.activity_type}</span>
                            </div>
                        </div>
                        <div class="apply_person">
                            <p class="apply_title">
                                <span class="bg"></span>
                                <span>已申请人数：${requestScope.activity.activity_current_number}</span>
                            </p>
                        </div>
                        <div class="message">
                            <el-button type="primary" @click="open2($event)">${requestScope.activityHasSignUp}</el-button>
                        </div>
                    </el-card>
                    <!-- 右边 -->
                    <div class="send fr">
                        <p class="send_title">发布人展示</p>
                        <div class="person_info">
                                <span class="pic">
                                <a href="/member/group/218954.html" target="_blank">
                                    <img alt="" src="https://m.xinyixiaoyuan.com/default/uploads/avatar/3.jpg"
                                         width="100" height="100">
                                </a>
                            </span>
                        </div>
                        <div class="address">
                            <!-- 社团名称 -->
                            <p>
                                <span>${requestScope.activity.creator}</span>
                            </p>
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
    </div>
</div>
</div>
</div>
<script>
    new Vue({
        el: "#app",
        data() {
            return {
                username: "hlc123456",
                queryInfo: '',
            }
        },
        created() {
                this.rand = Math.floor(Math.random() * (100 - 1 + 1) + 1)
            },
        methods: {
            async open2($event) {
                Date.prototype.Format = function(fmt) { //author: meizz
                    var o = {
                        "M+": this.getMonth() + 1, //月份
                        "d+": this.getDate(), //日
                        "h+": this.getHours(), //小时
                        "m+": this.getMinutes(), //分
                        "s+": this.getSeconds(), //秒
                        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
                        "S": this.getMilliseconds() //毫秒
                    };
                    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
                    for (var k in o)
                        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
                    return fmt;
                }
                var oTime = new Date().Format("yyyy-MM-dd")
                console.log(oTime)
                if ($event.target.innerHTML == '我要报名') {

                    const confirmResult = await this.$confirm(
                        "是否参加此活动?",
                        "提示", {
                            confirmButtonText: "确定"
                        }
                    ).catch(err => err);

                    if (confirmResult !== "confirm") {
                        return this.$message.info("已取消报名");
                    }
                    window.location.href = '${pageContext.request.contextPath}/client/signUpActivity?activity_id=' + "${requestScope.activity.id}" + '&stu_id=' + ${sessionScope.user.stu_id} +'&time=' + oTime
                } else if($event.target.innerHTML == '已报名') {
                    return this.$message.info('请勿重复报名!')
                }else if($event.target.innerHTML == '人数已满'){
                    return this.$message.info('人数已满')
                }
            },
            signUp() {
                window.location.href=''
            }
        }
    })
</script>
<script src="${pageContext.request.contextPath}/resources/js/to-top.js"></script>
</body>

</html>
