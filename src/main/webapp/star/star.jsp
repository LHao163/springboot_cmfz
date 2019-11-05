<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<c:set var="app" value="${pageContext.request.contextPath}"></c:set>
<script>
    $(function () {
        $("#star-show-table").jqGrid({
            url : '${app}/cmfz/star/selectAll',
            datatype : "json",
            height : 300,
            editurl : "${app}/cmfz/star/edit",
            colNames : [ '编号', '艺名', '真名', '照片', '性别', '生日' ],
            colModel : [
                {name : 'id',hidden:true,editable:false},
                {name : 'nickname',editable:true},
                {name : 'realname',editable:true},
                {name : 'photo',editable:true,edittype:"file",formatter:function (value,option,rows) {
                        return "<img style='width:100px;height:70px' src='${app}/cmfz/star/img/"+rows.photo+"'>";
                    }},
                {name : 'sex',editable:true,edittype:"select",editoptions:{value:"男:男;女:女"}},
                {name : 'bir',editable:true,edittype:"date"}
            ],
            styleUI:'Bootstrap',
            autowidth:true,
            rowNum : 3,
            rowList : [ 3, 5, 10],
            pager : '#star-page',
            viewrecords : true,
            subGrid : true,
            caption : "所有明星列表",
            subGridRowExpanded : function(subgrid_id, id) {
                var subgrid_table_id, pager_id;
                subgrid_table_id = subgrid_id + "_t";
                pager_id = "p_" + subgrid_table_id;
                $("#" + subgrid_id).html(
                    "<table id='" + subgrid_table_id  +"' class='scroll'></table>" +
                    "<div id='" + pager_id + "' class='scroll'></div>");
                $("#" + subgrid_table_id).jqGrid(
                    {
                        url : "${app}/cmfz/user/selectUsersByStarIdAll?starId=" + id,
                        datatype : "json",
                        colNames : [ 'ID', '用户名', '昵称', '头像','电话', '性别','地址','签名' ],
                        colModel : [
                            {name : "id"},
                            {name : "username"},
                            {name : "nickname"},
                            {name : "photo"},
                            {name : "phone"},
                            {name : "sex"},
                            {name : "city"},
                            {name : "sign"}
                        ],
                        styleUI:"Bootstrap",
                        rowNum : 2,
                        pager : pager_id,
                        autowidth:true,
                        height : '100%'
                    });
                jQuery("#" + subgrid_table_id).jqGrid('navGrid',
                    "#" + pager_id, {
                        edit : false,
                        add : false,
                        del : false,
                        search:false
                    });
            },

        }).jqGrid('navGrid', '#star-page', {add : true, edit : false, del : false, search:false
        },{},{
            //控制添加
            closeAfterAdd:true,
                afterSubmit:function (data) {
                console.log(data);
                var status = data.responseJSON.status;
                var id = data.responseJSON.message;
                if(status){
                    $.ajaxFileUpload({
                        url:"${app}/cmfz/star/upload",
                        type:"post",
                        fileElementId:"photo",
                        data:{id:id},
                        success:function (response) {
                            //自动刷新jq grid表格
                            $("#star-show-table").trigger("reloadGrid");
                        }
                    });
                }
                return "jq grid";
            }
        });
    })
</script>


<div class="panel page-header">
    <h4><b style="color: #4297d7">展示所有的明星</b></h4>
</div>
<table id="star-show-table"></table>
<div id="star-page" style="height: 40px;"></div>