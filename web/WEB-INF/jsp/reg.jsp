<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" type="text/css">
    <link href="https://cdn.bootcss.com/bootstrap-validator/0.5.3/css/bootstrapValidator.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/reg.css" type="text/css">
</head>
<body>

<div id="top-header"></div>

<div id="title" class="container-reg">
    <div class="line-left"></div>
    <div class="txt">注册</div>
    <div class="line-right"></div>
</div>


<div id="reg-box" class="container-reg">
    <form action="/regsuccess" method="post">
        <div class="form-group reg-username">
            <label>请输入用户名</label>
            <input type="text" class="form-control" name="username"  placeholder="昵称(最少6位哦)"/>
        </div>
        <div class="form-group reg-password">
            <label>请输入你的密码</label>
            <input type="password" class="form-control" name="password"  placeholder="密码尽量复杂一些哦" />
        </div>
        <div class="form-group repassword">
            <label >确认密码：</label>
            <input type="password" class="form-control"  name="repassword" placeholder="请再一次输入密码"  />
        </div>
        <div class="form-group">
            <button id="saveButton" type="submit"  class="btn btn-primary reg-btn">我要注册</button>
        </div>
    </form>
</div>



<script src="${pageContext.request.contextPath}/static/js/jquery-3.4.1.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap-validator/0.5.3/js/bootstrapValidator.min.js"></script>
<script type="text/javascript">
    $(function () {
        $('form').bootstrapValidator({
            message: '检查一下哪里写错了',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                username: {
                    validators: {
                        notEmpty: {
                            message: '请输入一个你喜欢的用户名呀'
                        },
                        stringLength: {
                            min: 6,
                            max: 14,
                            message: '我们规定用户名长度必须在6到14位之间哦'
                        },
                        regexp: {
                            regexp: /^[a-zA-Z0-9_]+$/,
                            message: '我们规定用户名只能包含大写字母、小写字母、数字和下划线呢'
                        },
                        threshold:6,
                        remote: {
                            url: '/checkuser.do',
                            message: '该用户名已存在,请重新输入',
                            delay: 500,
                            type: 'POST'
                        },
                    }
                },
                password :{
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },
                        stringLength: {
                            min: 8,
                            max: 14,
                            message: '我们规定密码长度必须在8到14位之间'
                        },
                        different: {
                            field: 'username',
                            message: '请不要将用户名和密码设置成一样的哦'
                        },
                        identical: {
                            field: 'repassword',
                            message: '请输入确认密码与本密码保持一致'
                        }
                    }
                },
                repassword: {
                    validators: {
                        notEmpty: {
                            message: '确认密码不能为空'
                        },
                        stringLength: {
                            min: 8,
                            max: 14,
                            message: '我们规定密码长度必须在8到14位之间'
                        },
                        identical: {
                            field: 'password',
                            message: '两次输入的密码不一致,请检查一下哦'
                        }
                    }
                }
            }
        });
    });

    $("#saveButton").click(function () {

    })
</script>
</body>
</html>

