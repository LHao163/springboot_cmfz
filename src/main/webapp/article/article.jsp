<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<c:set var="app" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title></title>

    <%--引入kindeditor--%>
    <script charset="utf-8" src="../kindeditor/kindeditor-all-min.js"></script>
    <script charset="utf-8" src="../kindeditor/lang/zh-CN.js"></script>
    <script>
        $(function () {
            $("#article-show-table").jqGrid({
                url : '${app}/cmfz/article/selectAll',
                datatype : "json",
                colNames : [ 'ID', '标题', '作者', '简介','内容','创建时间', '操作'],
                colModel : [
                    {name : 'id',hidden:true,editable:false},
                    {name : 'title',editable:true},
                    {name : 'name',editable:true},
                    {name : 'brief',editable:true},
                    {name : 'content',editable:true,hidden:true},
                    {name : 'createDate'},
                    {name : 'cover',editable:false,formatter:function (value,option,rows) {
                            return "<a class='btn btn-warning' onclick=\"openModal('edit','"+rows.id+"')\">修改</a>" +
                                "&nbsp;&nbsp;&nbsp;&nbsp;<a class='btn btn-danger' onclick=\"del('"+rows.id+"')\">删除</a>";

                        }}
                ],
                height:250,
                autowidth:true,
                styleUI:"Bootstrap",
                rowNum : 3,
                rowList : [ 5,8,11 ],
                pager : '#article-page',
                sortname : 'id',
                viewrecords : true,
                caption : "<b style='font-size: 15px'>展示所用文章<b>",
                editurl : "${app}/cmfz/article/edit"
            }).navGrid("#article-page", {edit : false,add : false,del : false,search:false},{
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
                            url:"${app}/cmfz/article/upload",
                            type:"post",
                            fileElementId:"cover",
                            data:{id:id},
                            success:function (response) {
                                //自动刷新jq grid表格
                                $("#article-show-table").trigger("reloadGrid");
                            }
                        });
                    }
                    return "jq grid";
                }
            });
        })

        //添加add 点击事件
        function openModal(oper,id) {
            if("add"==oper){
                $("#article-id").val("");
                $("#article-title").val("");
                $("#article-name").val("");
                $("#article-brief").val("");
                KindEditor.html("#editor_id","");
            }
            if("edit"==oper){
                var article = $("#article-show-table").jqGrid("getRowData",id);
                console.log(article);
                $("#article-id").val(article.id);
                $("#article-title").val(article.title);
                $("#article-name").val(article.name);
                $("#article-brief").val(article.brief);
                KindEditor.html("#editor_id",article.content);
            }
            $("#dome").modal("show");
        }
        function del(id) {
            $.ajax({
                url:"${app}/cmfz/article/del",
                type:"post",
                data:{id:id},
                datatype:"json",
                success:function () {
                    $("#article-show-table").trigger("reloadGrid");
                }
            });
        }

        //提交文章路径
        function save(){
            var id = $("#article-id").val();
            var url = "";
            if(id){
                url= "${app}/cmfz/article/edit";
            }else{
                url = "${app}/cmfz/article/add";
            }
            $.ajax({
                url:url,
                type:"post",
                data:$("#article-form").serialize(),
                datatype:"json",
                success:function () {
                    $("#article-show-table").trigger("reloadGrid");
                }
            })
            $("#dome").modal("hide");
        }


        //书写 KindEditor
        KindEditor.create('#editor_id',{
            width : '570px',
            //点击图片空间按钮时发送的请求
            fileManagerJson:"${app}/cmfz/article/browse",
            //展示图片空间按钮
            allowFileManager:true,
            //上传图片所对应的方法
            uploadJson:"${app}/cmfz/article/upload",
            //上传图片是图片的形参名称
            filePostName:"articleImg",
            //内容回显
            afterBlur:function () {
                this.sync();
            }
        });



    </script>


</head>

<body>

<ul id="myTab" class="nav nav-tabs">
    <li class="active"><a href="#home" data-toggle="tab">所用文章</a></li>
    <li><a href="#" onclick="openModal('add','')">添加文章</a></li>
</ul>
<div id="myTabContent" class="tab-content">
    <div class="tab-pane fade in active" id="home">
        <table id="article-show-table" ></table>
        <div id="article-page" style="height: 40px"></div>
    </div>
</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="dome" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 680px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h5 class="modal-title" id="myModalLabel"><strong>文章操作</strong></h5>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" role="form" id="article-form">
                    <input type="hidden" name="id" id="article-id">
                    <div class="form-group">
                        <label for="article-title" class="col-sm-2 control-label">文本标题:</label>
                        <div class="col-sm-10">
                            <input type="text" name="title" class="form-control" id="article-title"
                                   placeholder="请输入文本标题">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="article-name" class="col-sm-2 control-label">文本作者:</label>
                        <div class="col-sm-10">
                            <input type="text" name="name" class="form-control" id="article-name"
                                   placeholder="请输入文本作者">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="article-brief" class="col-sm-2 control-label">文本简介:</label>
                        <div class="col-sm-10">
                            <input type="text" name="brief" class="form-control" id="article-brief"
                                   placeholder="请输入文本简介">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="editor_id" class="col-sm-2 control-label">文本内容:</label>
                        <div style="padding-left: 15px">
                             <textarea id="editor_id" name="content" style="width:570px;height:300px;">

                             </textarea>
                        </div>
                    </div>
                </form>


            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="save()">提交更改</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->






</body>
</html>