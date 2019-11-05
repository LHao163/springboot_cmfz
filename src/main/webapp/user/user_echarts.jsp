<c:set var="app" value="${pageContext.request.contextPath}"></c:set>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ECharts</title>
    <!-- 引入 echarts.js -->
    <script src="../echarts/echarts.min.js"></script>
</head>
<body>
<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<div id="main" style="width: 1000px;height:470px;"></div>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));

    // 指定图表的配置项和数据

    var option = {
        title: {
            text: '用户注册反馈表'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data:['男','女']
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        toolbox: {
            feature: {
                saveAsImage: {}
            }
        },
        xAxis: {
            type: 'category',
            boundaryGap: false,
            data: ['一月','二月','三月','四月','五月','六月']
        },
        yAxis: {
            //type: 'value'
        },
        series: [
            {
                name:'男',
                type:'line',
                stack: '人数',
                data:[5,10, 15, 20, 25, 30, 35]
            },
            {
                name:'女',
                type:'line',
                stack: '人数',
                data:[15, 20, 25, 30, 35, 40, 45]
            }
        ]
    };


    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);


    $.ajax({
        url:"${app}/cmfz/user/echarts",
        type:"post",
        datatype:"json",
        success:function (data) {
            myChart.setOption({
                series: [{
                    name: '男',
                    type: 'line',
                    data: data.nan
                },{
                    name: '女',
                    type: 'line',
                    data: data.nv
                }]
            });
        }
    })

</script>
</body>
</html>