<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<c:set var="app" value="${pageContext.request.contextPath}"></c:set>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <!--当前页面更好支持移动端-->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="viewport" content="width=device-width, user-scalable=no,
        initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>首页</title>

    <%--引入bootstrap的样式--%>
    <link rel="stylesheet" href="../statics/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="../statics/jqgrid/css/trirand/ui.jqgrid-bootstrap.css">
    <script src="../statics/boot/js/jquery-3.3.1.min.js"></script>
    <!--引入bootstrap核心js-->
    <script src="../statics/boot/js/bootstrap.min.js"></script>
    <%--引入jqgrid--%>
    <script src="../statics/jqgrid/js/trirand/i18n/grid.locale-cn.js"></script>
    <script src="../statics/jqgrid/js/trirand/jquery.jqGrid.min.js"></script>
    <%--文件上传引入--%>
    <script src="../statics/jqgrid/js/ajaxfileupload.js"></script>

    <%--引入kindeditor--%>
    <script charset="utf-8" src="../kindeditor/kindeditor-all-min.js"></script>
    <script charset="utf-8" src="../kindeditor/lang/zh-CN.js"></script>

    <%--引入echarts--%>
    <script charset="utf-8" src="../echarts/echarts.min.js"></script>

    <script>
        $(function () {

            $("#btn").click(function(){
               //修改中心布局的内容
                $("#centerLayout").load("${app}/cmfz/banner/banner.jsp");//引入一张页面到当前页面中
            });

        })




    </script>
    <style type="text/css">
        .uu{width: 1242px;height: 490px;}
        .w{height: 50px;}
        .ww{line-height: 50px;}
        .size{font-size: 13px;}
    </style>
</head>
<body>
<!--导航条-->
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <!--导航标题-->
        <div class="navbar-header">
            <a class="navbar-brand" href="#">持明法州后台管理系统 <small>v2.0</small></a>
        </div>
        <div class="navbar-header">
            <a class="navbar-brand" href="${app}/cmfz/back/main.jsp"><span class="glyphicon glyphicon-home"></span></a>
        </div>
        <!--导航条内容-->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">欢迎:<span style="color:aqua" >${loginAdmin.username}</span></a></li>
                <li><a href="${app}/admin/secede">退出登录 <span class="glyphicon glyphicon-log-out"></span> </a></li>
            </ul>
        </div>
    </div>
</nav>
<!--页面主体内容-->
<div class="container-fluid ">
    <!--row-->
    <div class="row">

        <!--菜单-->
        <div class="col-sm-2">

            <!--手风琴控件-->
            <div class="panel-group" id="accordion" >

                <!--面板-->
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="userPanel">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#userLists" aria-expanded="true" aria-controls="collapseOne">
                                轮播图管理
                            </a>
                        </h4>
                    </div>
                    <div id="userLists" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                        <div class="panel-body">
                            <ul class="list-group">
                                <li class="list-group-item"><a href="javascript:$('#centerLayout').load('${app}/cmfz/banner/banner.jsp');" id="btn">所有轮播图</a></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!--类别面板-->
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="categoryPanel">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#categoryLists" aria-expanded="true" aria-controls="collapseOne">
                                专辑管理
                            </a>
                        </h4>
                    </div>
                    <div id="categoryLists" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                        <div class="panel-body">
                            <ul class="list-group">
                                <li class="list-group-item"><a href="javascript:$('#centerLayout').load('${app}/cmfz/album/album.jsp');">所有专辑列表</a></li>
                                <li class="list-group-item"><a href="">类别添加</a></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!--面板-->
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="bookPanel">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#bookLists" aria-expanded="true" aria-controls="collapseOne">
                                文章管理
                            </a>
                        </h4>
                    </div>
                    <div id="bookLists" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                        <div class="panel-body">
                            <ul class="list-group">
                                <li class="list-group-item"><a href="javascript:$('#centerLayout').load('${app}/cmfz/article/article.jsp');">所用文章</a></li>
                                <li class="list-group-item"><a href="">图书添加</a></li>
                            </ul>
                        </div>
                    </div>
                </div>


                <!--面板-->
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="orderPanel">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#orderLists" aria-expanded="true" aria-controls="collapseOne">
                                用户管理
                            </a>
                        </h4>
                    </div>
                    <div id="orderLists" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                        <div class="panel-body">
                            <ul class="list-group">
                                <li class="list-group-item"><a href="javascript:$('#centerLayout').load('${app}/cmfz/user/user.jsp');">用户列表</a></li>
                                <li class="list-group-item"><a href="javascript:$('#centerLayout').load('${app}/cmfz/user/user_echarts.jsp');">用户趋势</a></li>
                            </ul>
                        </div>



                    </div>
                </div>

                <!--面板-->
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="orderPanel1">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#orderLists1" aria-expanded="true" aria-controls="collapseOne">
                                明星管理
                            </a>
                        </h4>
                    </div>
                    <div id="orderLists1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                        <div class="panel-body">
                            <ul class="list-group">
                                <li class="list-group-item"><a href="javascript:$('#centerLayout').load('${app}/cmfz/star/star.jsp');">明星列表</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--中心布局-->
        <div class="col-sm-10" id="centerLayout">

            <!--巨幕-->
            <div class="jumbotron">
                <h4><b style="color: #4297d7">欢迎来到后台管理系统</b></h4>
            </div>
            <div class="uu">
                <img src="../img/timg.jpg" class="img-thumbnail uu">
            </div>

        </div>
    </div>
</div>
<div>
        <div class="navbar navbar-default navbar-fixed-bottom w">
            <div class="container text-center ww">
                <strong class="size">后台管理系统</strong>
                <small>
                    <%SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                        String date= format.format(new Date());
                        out.print(date);%>
                </small>
                </div>

        </div>
    </div>
</div>



</body>
</html>