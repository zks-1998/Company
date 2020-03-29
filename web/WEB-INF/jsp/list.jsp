<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<html>
<head>
    <title>首页</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <%-- 不以/开始的是相对路径 找资源 是以当前资源为的路径为基准 容易出问题
         以/开始的相对路径 找资源 以服务器的路径为标准;
    --%>
    <script src="${APP_PATH}/static/js/jquery-3.4.1.js"></script>
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<%--员工修改的模态框--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_update_static" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-8">
                            <p class="form-control-static" id="empName_update_static"></p>
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_update_input" class="col-sm-2 control-label">员工邮箱</label>
                        <span  class="help-block"></span>
                        <div class="col-sm-8">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="员工邮箱">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门名</label>
                        <div class="col-sm-4">
                            <%--部门提交ID即可--%>
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>
<%--员工添加的模态框--%>
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-8">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="员工姓名">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">员工邮箱</label>
                        <span  class="help-block"></span>
                        <div class="col-sm-8">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="员工邮箱">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门名</label>
                        <div class="col-sm-4">
                            <%--部门提交ID即可--%>
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>


<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-success" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <table class="table table-bordered table-hover"  id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>员工ID</th>
                    <th>员工姓名</th>
                    <th>性别</th>
                    <th>邮箱</th>
                    <th>所属部门</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6" id="page_info_area">
        </div>
        <div class="col-md-6" id="page_nav_area">
        </div>
    </div>
</div>


<script type="text/javascript">
    var totalRecord,currentPage;
    //页面加载完成  发一个ajax请求到第一页
    $(function () {
        to_Page(1);
    });

    function to_Page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                //console.log(result);
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                build_page_nav(result);
            }
        });
    }

    function build_emps_table(result) {
        //清空table数据
        $("#emps_table tbody").empty();
        var emps = result.extendn.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == "M" ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            /**
             *  <button class="btn btn-info btn-sm">
             <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
             </button>
             * @type {jQuery|HTMLElement}
             */
            var editBtn = $("<button></button>").addClass("btn btn-success btn-sm edit_btn")
                .append("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑");
            //为编辑按钮添加一个自定义属性 来表示员工的属性
            editBtn.attr("edit-id",item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append("<span></span>").addClass("glyphicon glyphicon-trash").append("删除");
            //为删除按钮添加自定义属性 来表示当前删除的员工ID
            delBtn.attr("del-id",item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        })
    }
    //解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前"+result.extendn.pageInfo.pageNum+"页," +
            "总共有"+result.extendn.pageInfo.pages+"页," +
            "总共"+result.extendn.pageInfo.total+"条记录");
        totalRecord = result.extendn.pageInfo.total;
        currentPage = result.extendn.pageInfo.pageNum;
    }
    //解析显示分页条
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        //page_nav_area
        var ul = $("<ul></ul>").addClass("pagination");

        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extendn.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else {
            firstPageLi.click(function () {
                to_Page(1);
            });
            prePageLi.click(function () {
                to_Page(result.extendn.pageInfo.pageNum-1);
            });
        }
        //为元素添加点击翻页的事件

        var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        if(result.extendn.pageInfo.hasNextPage == false){
            lastPageLi.addClass("disabled");
            nextPageLi.addClass("disabled");
        }else{
            lastPageLi.click(function () {
                to_Page(result.extendn.pageInfo.pages);
            });
            nextPageLi.click(function () {
                to_Page(result.extendn.pageInfo.pageNum+1);
            });
        }

        //添加首页和前一页
        ul.append(firstPageLi).append(prePageLi);

        $.each(result.extendn.pageInfo.navigatepageNums,function (index,item) {

            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if(result.extendn.pageInfo.pageNum==item){
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_Page(item);
            });
            ul.append(numLi);
        });
        ul.append(nextPageLi).append(lastPageLi);

        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }
    //清空表单样式及内容
    function reset_form(ele){
        $(ele)[0].reset();
        //清空校验样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }
    //点击新增按钮弹出模态框
    $("#emp_add_modal_btn").click(function (){
        //点击新增 清除表单数据和校验样式
        reset_form("#empAddModal form");
        //$("")[0].reset();
        //发送ajax请求 显示部门信息
        getDepts("#empAddModal select");
        $("#empAddModal").modal({
            //点击背景不会消失
            backdrop:"static"
        });
    });
    //查出所有的部门信息并显示在下拉列表
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type: "GET",
            success:function (result) {
                //console.log(result)
                //{"code":100,"msg":"处理成功!","extendn":{"depts":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"测试部"}]}}
                //$("#empAddModal select").append("")
                $.each(result.extendn.depts,function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo(ele);
                });

            }
        });
    }

    function validate_add_form() {
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
        if (!regName.test(empName)) {
            //alert("用户名只能是2-5位的中文或者6-16位的英文和数字");
            show_validate_msg("#empName_add_input", "error", "用户名只能是2-5位的中文或者6-16位的英文和数字");
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "");
        }

        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            //alert("请输入正确的邮箱格式地址,如1355776458@qq.com");
            show_validate_msg("#email_add_input", "error", "请输入正确的邮箱格式地址,如1355776458@qq.com");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }
        return true
    }

    function show_validate_msg(ele,status,msg){
        //清除当前元素
        $(ele).parent().removeClass("has-success has-error");
        if(status=="success"){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if(status=="error"){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    //校验用户名是否可用
    $("#empName_add_input").change(function () {
        //发送ajax请求 校验用户名是否可用
        var empName = this.value;
        $.ajax({
            url:"${APP_PATH}/checkuser",
            data:"empName="+empName,
            type:"POST",
            success:function (result) {
                if(result.code==100){
                    show_validate_msg("#empName_add_input","success","用户名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                }else {
                    show_validate_msg("#empName_add_input","error",result.extendn.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }

        })
    });
    //保存按钮
    $("#emp_save_btn").click(function () {
        //先对要提交给服务器的数据进行校验
        if(!validate_add_form()){
            return false;
        }
        if($(this).attr("ajax-va")=="error"){
            return false;
        }
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function (result) {
                //alert(result.msg);
                if(result.code == 100){
                    //员工保存成功  关闭模态框
                    $("#empAddModal").modal('hide');
                    //来到最后一页 显示数据
                    //发送ajax 显示最后一页数据
                    to_Page(totalRecord);
                }else{
                    //失败显示失败信息
                    //console.log(result);
                    //有哪个字段的错误信息就显示哪个字段
                    if(!undefined ==result.extendn.errorFields.email){
                        //显示员工的邮箱错误信息
                        show_validate_msg("#email_add_input", "error", result.extendn.errorFields.email);
                    }
                    if(!undefined ==result.extendn.errorFields.empName){
                        //显示员工名字的错误信息
                        show_validate_msg("#email_add_input", "error", result.extendn.errorFields.empName);
                    }
                }
            }
        });
    });
    //编辑按钮创建之前就绑定了click 所以绑定不上
    $(document).on("click",".edit_btn",function () {
        //alert("eidt");
        //1.查出员工信息
        //2.查出部门信息,显示部门列表
        getDepts("#empUpdateModal select");
        getEmp($(this).attr("edit-id"));
        //3.把员工id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
        $("#empUpdateModal").modal({
            //点击背景不会消失
            backdrop:"static"
        });
    });

    //单个删除按钮
    $(document).on("click",".delete_btn",function () {
        //1.确认删除对话框
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("del-id");
        if(confirm("确认删除["+empName+"]吗?")){
            //确认 发送ajax请求
            $.ajax({
                url:"${APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_Page(currentPage);
                }
            })
        }
    });

    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                // console.log(result);
                var empData = result.extendn.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        });
    }

    //点击更新 更新员工信息
    $("#emp_update_btn").click(function () {
        //验证邮箱是否合法
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_update_input","error", "请输入正确的邮箱格式地址,如1355776458@qq.com");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }

        //发送ajax请求保存
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function (result) {
                //alert(result.msg);
                //1.关闭对话框
                $("#empUpdateModal").modal('hide');
                //2.回到本页面
                to_Page(currentPage);
            }
        });
    });
    //全选
    $("#check_all").click(function () {
        //attr获取checked是undefined;
        //我们这些原生的属性 用attr获取自定义属性的值
        //prop修改和读取dom原生属性的值
        //alert($(this).prop("checked"));
        $(".check_item").prop("checked",$(this).prop("checked"));
    });
    //下面全选  上面也选
    $(document).on("click",".check_item",function () {
        //判断当前选中的元素是否为5个
        var flag = $(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });

    //点击全部删除 批量删除
    $("#emp_delete_all_btn").click(function () {
        var empNames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"),function () {
            //this
            empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
            //组装员工id字符串
            del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //去除多余的逗号
        empNames = empNames.substring(0,empNames.length-1);
        //去除多余的 -
        del_idstr = del_idstr.substring(0,del_idstr.length-1);
        if(confirm("确认删除["+empNames+"]吗?")){
            //发送ajax请求
            $.ajax({
                url:"${APP_PATH}/emp/"+del_idstr,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_Page(currentPage);
                }
            })
        }
    })

</script>
</body>
</html>
