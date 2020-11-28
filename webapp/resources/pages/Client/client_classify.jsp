<%--
  Created by IntelliJ IDEA.
  User: 冯硕
  Date: 2020/11/7
  Time: 20:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${sessionScope.tittle}</title>
    <link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
    <!-- 引入样式 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/classify.css">
    <link href="https://cdn.bootcdn.net/ajax/libs/element-ui/2.14.0/theme-chalk/index.min.css" rel="stylesheet">
    <!-- 先引入 Vue -->
    <script src="${pageContext.request.contextPath}/resources/js/vue.js"></script>
    <!-- 引入组件库 -->
    <script src="https://cdn.bootcdn.net/ajax/libs/element-ui/2.14.0/index.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/css/fonts_1/iconfont.js"></script>
    <style>
        .el-pagination__editor .el-input__inner {
            height: 28px!important;
            padding-left:10px!important;
        }
    </style>
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
                        <img src="${pageContext.request.contextPath}/resources/images/logo11.png" />
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
                            <li style="width: 12.5% !important;" class="fl"><a href="${pageContext.request.contextPath}/client/toIndex"><span>首页</span></a></li>
                            <li style="width: 12.5% !important;" class="fl"><a href="${pageContext.request.contextPath}/client/findSuchByActivityType?activtyType=1"><span>文体活动</span></a></li>
                            <li style="width: 12.5% !important;" class="fl"><a href="${pageContext.request.contextPath}/client/findSuchByActivityType?activtyType=2"><span>实践实习</span></a></li>
                            <li style="width: 12.5% !important;" class="fl"><a href="${pageContext.request.contextPath}/client/findSuchByActivityType?activtyType=3"><span>公益志愿</span></a></li>
                            <li style="width: 12.5% !important;" class="fl"><a href="${pageContext.request.contextPath}/client/findSuchByActivityType?activtyType=4"><span>创新创业</span></a></li>
                            <li style="width: 12.5% !important;" class="fl"><a href="${pageContext.request.contextPath}/client/findSuchByActivityType?activtyType=5"><span>思想成长</span></a></li>
                            <li style="width: 12.5% !important;" class="fl"><a href="${pageContext.request.contextPath}/client/findSuchByActivityType?activtyType=6"><span>技能培训</span></a></li>
                            <li style="width: 12.5% !important;" class="fl"><a href="#"><span>工作履历</span></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- 主题区域 -->
        <div class="main">
            <div class="main_container">
                <el-card>
                    <p class="card_title">筛选条件</p>
                    <div class="card_content">
                        <p>活动类别:</p>
                        <a @click="send($event)">不限</a>
                        <a @click="send($event)">自动化工程系</a>
                        <a @click="send($event)">机械工程系</a>
                        <a @click="send($event)">电子信息工程系</a>
                        <a @click="send($event)">计算机工程系</a>
                        <a @click="send($event)">经济与管理系</a>
                        <a @click="send($event)">院级组织</a>
                    </div>
                </el-card>
            </div>
        </div>
        <!-- 活动列表 -->
        <div class="content">
            <div class="content_main">
                <div class="a_list">
                    <div class="title">
                        <p>活动列表</p>
                    </div>
                    <!-- 左边 -->
                    <div class="list">
                        <!-- 左边 -->
                        <div class="table1 fl">
                            <el-table :data="activityList" stripe >
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
<%--                            <div class="pages">--%>
<%--                                <div>--%>
<%--                                    <span class="current">1</span>--%>
<%--                                    <a href="#">2</a>--%>
<%--                                    <a href="#">3</a>--%>
<%--                                    <a href="#">4</a>--%>
<%--                                    <a href="#">5</a>--%>
<%--                                    <a href="#">></a>--%>
<%--                                    <a href="#">末页</a>--%>
<%--                                    <span style="font-size:14px">共:50条记录</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>
                            <div class="pages">
                                <div class="block">
                                    <el-pagination @current-change="handleCurrentChange" :current-page.sync="currentPage3" :page-size="10" layout="prev, pager, next, jumper" :total="${requestScope.page}">
                                    </el-pagination>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 右边 -->
                    <div class="list_right">
                        <p>热门活动</p>
                        <ul>
                            <li class="list_right_li">
                                <a href="#" title="国防实践(首届校园真人cs挑战赛)">
                                    <span>1.</span> 国防实践(首届校园真人cs挑战赛) </a>
                            </li>
                            <li class="list_right_li"><a href="#"><span>2.国防实践(首届校园真人cs挑战赛)</span></a></li>
                            <li class="list_right_li"><a href="#"><span>3.国防实践(首届校园真人cs挑战赛)</span></a></li>
                            <li class="list_right_li"><a href="#"><span>4.国防实践(首届校园真人cs挑战赛)</span></a></li>
                            <li class="list_right_li"><a href="#"><span>5.国防实践(首届校园真人cs挑战赛)</span></a></li>
                        </ul>

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
                currentPage3:1,
                // 活动列表
                activityList: []
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
                var arrUrl = document.location.toString().split("?");
                var para = decodeURI(arrUrl[1])
                var params = para.split("&")
                console.log(params[2])
                let parmPage = params[2].split('=')
                console.log(parmPage[1])
                if(parmPage[1] == undefined) {
                    this.currentPage3 = 1
                }else  {
                    this.currentPage3 = parmPage[1]
                }
            },
            send($event) {
                console.log(this.activityList[0])
                console.log($event.currentTarget.innerHTML)
                window.location.href='${pageContext.request.contextPath}/client/randomFind?activity_type=' + this.activityList[0].activity_type+'&tie=' + $event.currentTarget.innerHTML
            },

            detail(info) {
                console.log(info)
                window.location.href='${pageContext.request.contextPath}/client/activityDetail?activity_id=' + info.id + '&stu_id=' + "${sessionScope.user.stu_id}"
            },
            handleCurrentChange(val) {
                 var arrUrl = document.location.toString().split("?");
                 var para = decodeURI(arrUrl[1])
                 var params = para.split("&");
                 if(params[1] == undefined) {
                     params[1] = "none"
                     let parmType = params[0].split('=')
                     window.location.href='${pageContext.request.contextPath}/client/pageInfoSelect?activityType='+parmType[1]+'&tie='+params[1]+'&page='+val
                 }else {
                     let parmType = params[0].split('=')
                     let paramTie = params[1].split('=')
                     window.location.href='${pageContext.request.contextPath}/client/pageInfoSelect?activityType='+parmType[1]+'&tie='+paramTie[1]+'&page='+val
                 }
            },
        }
    })
</script>
<script src="${pageContext.request.contextPath}/resources/js/to-top.js"></script>
</body>

</html>
