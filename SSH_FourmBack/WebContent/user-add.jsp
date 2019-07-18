<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>泉师释疑</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="./css/font.css">
<link rel="stylesheet" href="./css/xadmin.css">
<script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="./lib/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="./js/xadmin.js"></script>
<!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
<!--[if lt IE 9]>
      <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
      <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
	<div class="x-body layui-anim layui-anim-up">
		<form class="layui-form" action="${pageContext.request.contextPath }/UserAction_addUser" method="post">
			<!-- <div class="layui-form-item">
				<label for="L_email" class="layui-form-label">
					<span class="x-red">*</span>
					邮箱
				</label>
				<div class="layui-input-inline">
					<input type="text" id="L_email" name="email" required="" lay-verify="email" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-form-mid layui-word-aux">
					<span class="x-red">*</span>
					将会成为您唯一的登入名
				</div>
			</div> -->
			<div class="layui-form-item">
				<label for="L_username" class="layui-form-label">
					<span class="x-red">*</span>
					用户名
				</label>
				<div class="layui-input-inline">
					<input type="text" id="username" name="username" required="" lay-verify="nikename" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-form-mid layui-word-aux"><span id="usernameInfo"></span></div>
			</div>
			<div class="layui-form-item">
				<label for="L_pass" class="layui-form-label">
					<span class="x-red">*</span>
					密码
				</label>
				<div class="layui-input-inline">
					<input type="password" id="L_pass" name="password" required="" lay-verify="pass" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-form-mid layui-word-aux">6到16个字符</div>
			</div>
			<div class="layui-form-item">
				<label for="L_repass" class="layui-form-label">
					<span class="x-red">*</span>
					确认密码
				</label>
				<div class="layui-input-inline">
					<input type="password" id="L_repass" name="repass" required="" lay-verify="repass" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="L_username" class="layui-form-label">
					<span class="x-red">*</span>
					真实姓名
				</label>
				<div class="layui-input-inline">
					<input type="text" id="L_username" name="name" required="" lay-verify="nikename" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="L_username" class="layui-form-label">
					<span class="x-red">*</span>
					邮箱
				</label>
				<div class="layui-input-inline">
					<input type="text" id="L_username" name="email" required="" lay-verify="nikename" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="L_username" class="layui-form-label">
					<span class="x-red">*</span>
					电话
				</label>
				<div class="layui-input-inline">
					<input type="text" id="L_username" name="telephone" required="" lay-verify="nikename" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="L_repass" class="layui-form-label"> </label>
				<button class="layui-btn" lay-submit="">添加</button>
			</div>
		</form>
	</div>
	<script>
	
		//异步校验用户名是否存在
		$(function(){
			
			$("#username").blur(function(){
				var usernameInput = $(this).val();
				//alert(usernameInput)
				//ajax异步校验
				$.post(
					//action的地址
					"${pageContext.request.contextPath}/UserAction_checkUsername",
					//提交数据
					{"username":usernameInput},
					//回调函数
					function(data)
					{
						var success = data.success;
						//alert(success);
						if(success)
						{
							$("#usernameInfo").css("color","green");
							$("#usernameInfo").html("用户名可以使用！");
						}
						else
						{
							$("#usernameInfo").css("color","red");
							$("#usernameInfo").html("用户名已经被注册！！");
						}
					},
					//数据格式
					"json"
				)
				
				
			})
			
		})
	
	
		layui.use([ 'form', 'layer' ], function() {
			$ = layui.jquery;
			var form = layui.form, layer = layui.layer;

			//自定义验证规则
			form.verify({
				nikename : function(value) {
					if (value.length < 5) {
						return '昵称至少得5个字符啊';
					}
				},
				pass : [ /(.+){6,12}$/, '密码必须6到12位' ],
				repass : function(value) {
					if ($('#L_pass').val() != $('#L_repass').val()) {
						return '两次密码不一致';
					}
				}
			});

			//监听提交
			form.on('submit(add)', function(data) {
				console.log(data);
				//发异步，把数据提交给php
				layer.alert("添加成功", {
					icon : 6
				}, function() {
					// 获得frame索引
					var index = parent.layer.getFrameIndex(window.name);
					//关闭当前frame
					parent.layer.close(index);
				});
				return false;
			});

		});
	</script>
	<script>
		var _hmt = _hmt || [];
		(function() {
			var hm = document.createElement("script");
			hm.src = "https://hm.baidu.com/hm.js?b393d153aeb26b46e9431fabaf0f6190";
			var s = document.getElementsByTagName("script")[0];
			s.parentNode.insertBefore(hm, s);
		})();
	</script>
</body>

</html>