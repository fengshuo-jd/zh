<%--
  Created by IntelliJ IDEA.
  User: 冯硕
  Date: 2020/11/7
  Time: 16:05
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>首页</title>
    <link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
    <!-- 引入样式 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css">
    <link href="https://cdn.bootcdn.net/ajax/libs/element-ui/2.14.0/theme-chalk/index.min.css" rel="stylesheet">
    <!-- 先引入 Vue -->
    <script src="https://cdn.bootcss.com/vue/2.5.10/vue.min.js"></script>
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
<%--                                        <a href="${pageContext.request.contextPath}/resources/pages/Client/client_login_stu.jsp">${empty requestScope.username?"点我登录":requestScope.username}</a>--%>
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
<%--                        <div class="back">--%>
<%--                            <span style="color: #3697fc;">欢迎回来</span>--%>
<%--                            <el-dropdown size="mini" @command="handleCommand">--%>
<%--                                    <span class="el-dropdown-link" style="font-size: 13px;">--%>
<%--                                      苏龙海<i class="el-icon-arrow-down el-icon--right"></i>--%>
<%--                                    </span>--%>
<%--                                <el-dropdown-menu slot="dropdown">--%>
<%--                                    <el-dropdown-item command="个人中心">个人中心</el-dropdown-item>--%>
<%--                                    <el-dropdown-item command="退出">退出</el-dropdown-item>--%>
<%--                                </el-dropdown-menu>--%>
<%--                            </el-dropdown>--%>
<%--                        </div>--%>
                    </div>
                </div>
                <!-- search -->
                <div class="top_search">
                    <div class="top_logo">
                        <a href="#">
                            <img src="${pageContext.request.contextPath}/resources/images/logo11.png"/>
                        </a>
                    </div>
                    <div class="search_box">
                        <el-input placeholder="搜索活动" v-model="queryInfo">
                            <el-button slot="append" icon="el-icon-search" class="search_button" @click="search"></el-button>
                        </el-input>
                    </div>

                </div>
                <!-- 导航栏 -->
                <div class="nav">
                    <div class="nav_contanier">
                        <ul>
                            <li class="fl"><a href="#"><span class="tran">首页</span></a></li>
                            <li class="fl"><a href="${pageContext.request.contextPath}/client/findSuchByTie?tie=2"><span>自动化工程系</span></a></li>
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
                <!-- 左边 -->
                <div class="left">
                    <ol class="nav_list">
                        <li>
                            <a href="${pageContext.request.contextPath}/client/findSuchByActivityType?activtyType=1">文体活动</a>
                            <svg class="icon icon5" aria-hidden="true">
                                <use xlink:href="#icon-zhankai"></use>
                            </svg>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/client/findSuchByActivityType?activtyType=2">实践实习</a>
                            <svg class="icon icon5" aria-hidden="true">
                                <use xlink:href="#icon-zhankai"></use>
                            </svg>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/client/findSuchByActivityType?activtyType=3">公益志愿</a>
                            <svg class="icon icon5" aria-hidden="true">
                                <use xlink:href="#icon-zhankai"></use>
                            </svg>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/client/findSuchByActivityType?activtyType=4">创新创业</a>
                            <svg class="icon icon5" aria-hidden="true">
                                <use xlink:href="#icon-zhankai"></use>
                            </svg>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/client/findSuchByActivityType?activtyType=5">思想成长</a>
                            <svg class="icon icon5" aria-hidden="true">
                                <use xlink:href="#icon-zhankai"></use>
                            </svg>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/client/findSuchByActivityType?activtyType=6">技能培训</a>
                            <svg class="icon icon5" aria-hidden="true">
                                <use xlink:href="#icon-zhankai"></use>
                            </svg>
                        </li>
                        <li>
                            <a href="#">工作履历</a>
                            <svg class="icon icon5" aria-hidden="true">
                                <use xlink:href="#icon-zhankai"></use>
                            </svg>
                        </li>
                    </ol>
                </div>
                <!-- 轮播图 -->
                <div class="actmain">
                    <div class="block">
                        <el-carousel height="400px" autoplay>
                            <el-carousel-item v-for="item in carousel" :key="item.id">
                                <img :src="item.img" />
                            </el-carousel-item>
                        </el-carousel>
                    </div>
                </div>
                <!-- 右边 -->
                <div class="person">
                    <div class="_2yDxF _3luH4">
                        <div class="_3xsx0">欢迎参加学校各类活动</div>
                        <div class="_2EyS_"><img width="83" height="83" src="http://edu-image.nosdn.127.net/6e66dbdc55464a44889c6a25428b2b4b.png?imageView&amp;quality=100" alt="默认头像"></div>
                        <div class="_1Y4Ni">
                            <div class="_3uWA6" role="button" tabindex="0">
                                <c:if test="${empty sessionScope.user}">
                                        <a style="color: #fff" href="${pageContext.request.contextPath}/resources/pages/Client/client_login_stu.jsp">${empty sessionScope.userHone?"登录":sessionScope.userHone}</a></div>
                                </c:if>
                                <c:if test="${not empty sessionScope.user}">
                                        <a style="color: #fff" href="${pageContext.request.contextPath}/client/stuCenter?userId=${sessionScope.user.stu_id}">个人中心</a>
                                </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 活动列表 -->
        <div class="content">
            <div class="content_main">
                <div class="title">
                    <p>活动列表</p>
                </div>
                <div class="list">
                    <!-- 左边 -->
                    <div class="table1 fl">
                        <el-table :data="activityList" stripe>
                            <el-table-column align="center" label="活动名称" prop="activity_name" width="230px"></el-table-column>
                            <el-table-column align="center" label="所属系别" prop="tie"></el-table-column>
                            <el-table-column align="center" label="活动开始时间" prop="time" width="150px" sortable class-name="times"></el-table-column>
                            <el-table-column align="center" label="活动结束时间" prop="end_time" width="150px" sortable class-name="times"></el-table-column>
                            <el-table-column align="center" label="活动状态" prop="activityState" class-name="state"></el-table-column>
                            <el-table-column>
                                <template slot-scope="scope">
                                    <el-button @click="detail(scope.row)">活动详情</el-button>
                                </template>
                            </el-table-column>
                        </el-table>
                    </div>
                    <!-- 右边 -->
                    <div class="con fr">
                        <div class="con_title">
                            <ul class="title_list clearfix">
                                <li>年度活动分数排名</li>
                            </ul>
                            <table class="ranking" cellspacing="0" cellpadding="0">
                                <tbody>
                                <tr class="rangking_first">
                                    <td>排名</td>
                                    <td>姓名</td>
                                    <td>学号</td>
                                    <td>分数</td>
                                </tr>
                                <c:forEach items="${topTenStudents}" var="user" varStatus="vs">
                                    <tr>
                                        <td>${vs.index+1}</td>
                                        <td>${user.username}</td>
                                        <td>${user.stu_id}</td>
                                        <td>${user.credits}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
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
<script>
    new Vue({
        el: "#app",
        data() {
            return {
                username: "hlc123456",
                queryInfo: '',
                // 轮播图
                carousel: [{
                    id: 1,
                    img: '${pageContext.request.contextPath}/resources/images/11.jpg'
                }, {
                    id: 2,
                    img: '${pageContext.request.contextPath}/resources/images/12.jpg'
                }, {
                    id: 3,
                    img: '${pageContext.request.contextPath}/resources/images/11.jpg'
                }, {
                    id: 4,
                    img: '${pageContext.request.contextPath}/resources/images/11.jpg'
                }],
                activityList:[]

            }
        },
        created() {
            this.add()

        },
        methods: {
            search() {
              window.location.href='${pageContext.request.contextPath}/client/search?key=' + this.queryInfo
            },
            handleCommand(command) {
                console.log(command)
            },
            detail(info) {
                console.log(info)
            },
            add() {
                let array = ${requestScope.jsonArray}
                    this.activityList = array
                console.log(this.activityList)
            },
            detail(info) {
                console.log(info)
                window.location.href='${pageContext.request.contextPath}/client/activityDetail?activity_id=' + info.id + '&stu_id=' + "${sessionScope.user.stu_id}"
            },
            activityEnv() {

                window.location.href='${pageContext.request.contextPath}/clientAdmin/selectUserRole?id=' + ${empty sessionScope.user.id?"'none'":sessionScope.user.id}
            },
        }
    })
</script>
<script src="${pageContext.request.contextPath}/resources/js/to-top.js"></script>
</body>

</html>
