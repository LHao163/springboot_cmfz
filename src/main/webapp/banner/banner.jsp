<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<c:set var="app" value="${pageContext.request.contextPath}"></c:set>
<script>
    $(function () {
        $("#banner-show-table").jqGrid({
            url : '${app}/cmfz/banner/selectAll',
            datatype : "json",
            colNames : [ 'ID', '名称', '封面', '描述', '状态','上传日期'],
            colModel : [
                {name : 'id',hidden:true,editable:false},
                {name : 'name',editable:true},
                {name : 'cover',editable:true,edittype:"file",formatter:function (value,option,rows) {
                        return "<img style='width:100px;height:60px;' src='${app}/cmfz/banner/img/"+rows.cover+"'/>";

                    }},
                {name : 'description',editable:true},
                {name : 'status',editable:true,edittype:"select",editoptions:{value:"正常:正常;冻结:冻结"}},
                {name : 'createdate'}
            ],
            height:250,
            autowidth:true,
            styleUI:"Bootstrap",
            rowNum : 3,
            rowList : [ 5,8,11 ],
            pager : '#banner-page',
            sortname : 'id',
            viewrecords : true,
            caption : "<b style='font-size: 15px'>轮播图视图列表<b>",
            editurl : "${app}/cmfz/banner/edit"
        }).navGrid("#banner-page", {edit : true,add : true,del : true,search:false},{
            //控制修改
            closeAfterEdit:true,
            beforeShowForm:function (fmt) {
                fmt.find("#cover").attr("disabled",true);
            }
        },{
            //控制添加
            closeAfterAdd:true,
            afterSubmit:function (data) {
                console.log(data);
                var status = data.responseJSON.status;
                var id = data.responseJSON.message;
                if(status){
                    $.ajaxFileUpload({
                        url:"${app}/cmfz/banner/upload",
                        type:"post",
                        fileElementId:"cover",
                        data:{id:id},
                        success:function (response) {
                            //自动刷新jq grid表格
                            $("#banner-show-table").trigger("reloadGrid");
                        }
                    });
                }
                return "jq grid";
            }
        });
    })
</script>



<div class="panel panel-heading">
    <h4><b style="color: #4297d7">所有的轮播图</b></h4>
</div>
<table id="banner-show-table" ></table>
<div id="banner-page" style="height: 40px"></div>












