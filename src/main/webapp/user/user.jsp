<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<c:set var="app" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <script>
        $(function () {
            $("#user-show-table").jqGrid({
                url : "${app}/cmfz/user/selectUsersByStarIdAll",
                datatype : "json",
                colNames : [ 'ID', '用户名', '昵称', '头像','电话', '性别','地址','签名' ],
                colModel : [
                    {name : "id",hidden:true},
                    {name : "username"},
                    {name : "nickname"},
                    {name : "photo"},
                    {name : "phone"},
                    {name : "sex"},
                    {name : "city"},
                    {name : "sign"}
                ],
                height:250,
                autowidth:true,
                styleUI:"Bootstrap",
                rowNum : 3,
                rowList : [ 5,8,11 ],
                pager : '#user-page',
                sortname : 'id',
                viewrecords : true,
                caption : "<b style='font-size: 15px'>用户列表<b>",
                editurl : "${app}/cmfz/user/edit"
            }).navGrid("#user-page", {edit : false,add : false,del : false,search:false});
        })
    </script>

</head>

<body>

<ul id="myTab" class="nav nav-tabs">
    <li class="active"><a href="#home" data-toggle="tab">所用用户</a></li>
    <li><a href="${app}/cmfz/user/easyPoi" onclick="openModal('add','')">导出用户</a></li>
</ul>
<div id="myTabContent" class="tab-content">
    <div class="tab-pane fade in active" id="home">
        <table id="user-show-table" ></table>
        <div id="user-page" style="height: 40px"></div>
    </div>
</div>








</body>
</html>











