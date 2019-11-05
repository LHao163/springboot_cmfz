<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<c:set var="app" value="${pageContext.request.contextPath}"></c:set>
<script>
    $(function () {
        $("#album-show-table").jqGrid({
            url : '${app}/cmfz/album/selectAll',
            datatype : "json",
            height : 300,
            editurl : "${app}/cmfz/album/edit",
            colNames : [ '编号', '标题 ：', '封面 ：', '章节数 ：', '得分 ：', '作者 ：','简介 ：','时间 ：'],
            colModel : [
                {name : 'id',hidden:true,editable:false},
                {name : 'title',editable:true},
                {name : 'cover',editable:true,edittype:"file",
                    formatter:function (value,option,rows) {
                        return "<img style='width:100px;height:70px' src='${app}/cmfz/album/img/"+rows.cover+"'>";
                    }
                },
                {name : 'count',editable:true},
                {name : 'score',editable:true},
                {name : 'auther',editable:true,edittype:"select",
                    editoptions:{
                        dataUrl:"${app}/cmfz/album/findAll"
                    }
                 },
                {name : 'brief',editable:true,edittype:"textarea"},
                {name : 'createDate',editable:true,edittype:"date"}
            ],
            styleUI:'Bootstrap',
            autowidth:true,
            rowNum : 3,
            rowList : [ 3, 5, 10],
            pager : '#album-page',
            viewrecords : true,
            subGrid : true,
            caption : "所有专辑列表",
            subGridRowExpanded : function(subgrid_id, id) {
                var subgrid_table_id, pager_id;
                subgrid_table_id = subgrid_id + "_t";
                pager_id = "p_" + subgrid_table_id;
                $("#" + subgrid_id).html(
                    "<table id='" + subgrid_table_id  +"' class='scroll'></table>" +
                    "<div id='" + pager_id + "' class='scroll'></div>");
                $("#" + subgrid_table_id).jqGrid(
                    {
                        url : "${app}/cmfz/chapter/selectByAlbumIdAll?albumId="+id,
                        datatype : "json",
                        editurl : "${app}/cmfz/chapter/edit?albumId="+id,
                        colNames : [  '文件名 ：', '歌手 ：', '大小','时长','播放音频', '创建时间' ],
                        colModel : [
                            {name : "name",editable:true,edittype:'file'},
                            {name : "title",editable:true},
                            {name : "size",editable:false},
                            {name : "duration",editable:false},
                            {name : "music",width:300,formatter:function (value,option,rows) {
                                    return "<audio controls>\n" +
                                        "  <source src='${app}/cmfz/chapter/audios/"+rows.name+"' >\n" +
                                        "</audio>";
                                }},
                            // {name : "muc",width:300,formatter:function (value,option,rows) {
                            //         return "";
                            //     }},
                            {name : "createDate"}
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
                        add : true,
                        del : false,
                        search:false
                    },{},{
                        //控制添加
                        closeAfterAdd:true,
                        afterSubmit:function (data) {
                            console.log(data);
                            var status = data.responseJSON.status;
                            var cid = data.responseJSON.message;
                            if(status){
                                $.ajaxFileUpload({
                                    url:"${app}/cmfz/chapter/upload",
                                    type:"post",
                                    fileElementId:"name",
                                    data:{id:cid,albumId:id},
                                    success:function (response) {
                                        //自动刷新jq grid表格
                                        $("#album-show-table").trigger("reloadGrid");
                                    }
                                });
                            }
                            return "jq grid";
                        }
                    });
            },

        }).jqGrid('navGrid', '#album-page', {
            add : true,
            edit : false,
            del : false,
            search:false
        },{},{
            //控制添加
            closeAfterAdd:true,
            afterSubmit:function (data) {
                console.log(data);
                var status = data.responseJSON.status;
                var id = data.responseJSON.message;
                if(status){
                    $.ajaxFileUpload({
                        url:"${app}/cmfz/album/upload",
                        type:"post",
                        fileElementId:"cover",
                        data:{id:id},
                        success:function (response) {
                            //自动刷新jq grid表格
                            $("#album-show-table").trigger("reloadGrid");
                        }
                    });
                }
                return "jq grid";
            }
        });
    })
</script>


<div class="panel page-header">
    <h4><b style="color: #4297d7">展示所有的专辑</b></h4>
</div>
<table id="album-show-table"></table>
<div id="album-page" style="height: 40px;"></div>