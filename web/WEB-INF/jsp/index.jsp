<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Do All Thing With You</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/index.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/iconfont/iconfont.css">
</head>
<body>
<div id="top-header"></div>

<div id="title" class="container">
    <div class="line-left"></div>
    <div class="txt">登录</div>
    <div class="line-right"></div>
</div>

<div id="login-box" class="container">
    <div id="code">
        <i class="iconfont icon-weixin1" style="font-size: 40px"></i>
        <img class="wechat" src="${pageContext.request.contextPath}/static/image/wechat.png">
    </div>
    <div id="login">
        <form id="login-form" action="/goindex" method="post">
            <div class="form-group-1">
                <span class="glyphicon glyphicon-user"></span>
                <label>账号/手机号</label>
                <input type="text" class="form-control" id="username" name="username" placeholder="请输入你的账号/手机号" onblur="a()">
                <span id="userInfo"></span>
            </div>
            <div class="form-group-2">
                <span class="glyphicon glyphicon-lock"></span>
                <label>密码</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="请输入你的密码" onblur="b()">
                <span id="passInfo"></span>
            </div>
            <div class="checkbox">
                <input type="checkbox" class="check"> 记住密码
                <span style="color: #cccccc">不是自己的私有设备谨慎勾选</span>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="#">忘记密码?</a>
            </div>
            <button id="login-button" type="submit" class="btn btn-success">登录</button>
            <button id="reg-button" type="button" class="btn btn-info" onclick="window.open('/goreg')">注册</button>
            <i class="iconfont icon-kaixin2" style="font-size: 65px;color: #ff8965"></i>
            <div id="showWord"></div>
            <div id="word" style="display:none" >
                Happy forever ! !
            </div>
        </form>
    </div>
</div>

<div id="agreement" class="container">登录代表你同意<a href="#">用户协议</a>和<a href="#">隐私政策</a> </div>

<div id="footer">
    <label id="footer-txt">©版权所有 WeChat:zks66966 201912-现在</label>
</div>


<script src="${pageContext.request.contextPath}/static/js/jquery-3.4.1.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

<script type="text/javascript">
    function a() {
        $.ajax({
            url:"/userID",
            data:{"username":$("#username").val()},
            success:function (data) {
                if(data==='账号安全'){
                    $("#userInfo").css("color","green");
                }if(data==='该账号不存在'){
                    $("#userInfo").css("color","red");
                }else if(data==='输账号呀'){
                    $("#userInfo").css("color","green");
                }
                $("#userInfo").html(data);
            }
        })
    }
    function b(){
        if($("#userInfo").text()=="账号安全") {
            $.ajax({
                url: "/userPWD",
                data: {"username": $("#username").val(), "password": $("#password").val()},
                success: function (data) {
                    if (data === '密码正确') {
                        $("#passInfo").html(" ");
                    }else if(data === '密码错误'||data === '密码不能为空'){
                        $("#passInfo").css("color", "red");
                        $("#passInfo").html(data);
                    }
                }
            });
        }
    }
</script>
</body>
</html>
