<%@ page language="java" pageEncoding="UTF-8" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";	
	session.invalidate();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>订单管理系统</title>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/lib/jquery/jquery.min.js"></script>
		<link href="${pageContext.request.contextPath}/js/lib/jquery_plugin/bs/css/bootstrap.min.css" rel="stylesheet" type="text/css">
		<link href="${pageContext.request.contextPath}/js/lib/jquery_plugin/bs/css/bootstrap-responsive.css" rel="stylesheet" type="text/css">
		<link href="${pageContext.request.contextPath}/css/common/bootstrap_setup.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/register.css"/>
		<link id="icon" href="${pageContext.request.contextPath}/images/s.ico" rel="icon">
		<link href="${pageContext.request.contextPath}/js/lib/jquery_plugin/ui/jquery-ui.css" rel="stylesheet" type="text/css">

		<script type="text/javascript">
			$(function(){
				$('.ok').hide();
				$('.rem').click(function(){
					$(this).toggleClass('selected');
				})

				$('#signup_select').click(function(){
					$('.form_row ul').show();
					event.cancelBubble = true;
				})

				$('#d').click(function(){
					$('.form_row ul').toggle();
					event.cancelBubble = true;
				})

				$('body').click(function(){
					$('.form_row ul').hide();
				})

				$('.form_row li').click(function(){
					var v  = $(this).text();
					$('#signup_select').val(v);
					$('.form_row ul').hide();
				})

				$('#signup_name').blur(function() {
					if($(this).val().length>0) {
						$('.ok').show();
					} else {
						$('.ok').hide();
					}
					if(!isPlaceholder()){
						if($("#signup_name").val()==""){
							$("#signup_name").val($("#signup_name").attr("placeholder"));
						}
					}
				});

				$('#signup_name').focus(function() {
					if(!isPlaceholder()){
						if($(this).val()==$(this).attr("placeholder")){
							$(this).val("");
						}
					}
				});

			
			});

			//判断浏览器是否支持 placeholder属性
			function isPlaceholder(){
				var input = document.createElement('input');
				return 'placeholder' in input;
			}

			if (!isPlaceholder()) {//不支持placeholder 用jquery来完成
				$(document).ready(function() {
					if(!isPlaceholder()){
						$("input").not("input[type='password']").each(//把input绑定事件 排除password框
							function(){
								if($(this).val()=="" && $(this).attr("placeholder")!=""){
									$(this).val($(this).attr("placeholder"));
									$(this).focus(function(){
										if($(this).val()==$(this).attr("placeholder")){
											$(this).val("");
										}
									});
									$(this).blur(function(){
										if($(this).val()==""){
											$(this).val($(this).attr("placeholder"));
										}
								});
							}
						});

						//对password框的特殊处理1.创建一个text框 2获取焦点和失去焦点的时候切换
						var pwdField = $("input[type=password]");
						var pwdVal = pwdField.attr('placeholder');
						pwdField.after('<input id="pwdPlaceholder" type="text" value='+pwdVal+' autocomplete="off" />');
						var pwdPlaceholder = $('#pwdPlaceholder');
						pwdPlaceholder.show();
						pwdField.hide();

						pwdPlaceholder.focus(function(){
							pwdPlaceholder.hide();
							pwdField.show();
							pwdField.focus();
						});

						pwdField.blur(function(){
							if(pwdField.val() == '') {
								pwdPlaceholder.show();
								pwdField.hide();
							}
						});
					}
				});
			}
			
			function check()
			{
				var sname=document.getElementById("signup_name").value;
				var pass=document.getElementById("signup_password").value;
			
				if(sname=="" || sname=="请输入用户名")
				{
					document.getElementById("msg").innerHTML="用户名不能为空";
					return false;
				}
				else if(pass=="")
				{
					document.getElementById("msg").innerHTML="密码不能为空";
					return false;
				}
				return true;
				
			}
			
			function login1()
			{
			  if(check()){
			  document.loginForm.action="<%=basePath %>loginAction?method=login";
			  document.loginForm.submit();
			  return true;
			  }
			}
		</script>
</head>
<body>
<div class='login_box_div'>
	<div class='signup_container'>
			<h1 class='signup_title'>用户登录<!-- <small class="label">用户登录</small> --></h1>
			<img src='${pageContext.request.contextPath}/images/people.png' id='admin'/>
			<form action="" name="loginForm" method="post">
			<div id="signup_forms" class="signup_forms clearfix" style="border:none">
				<!-- <form class="signup_form_form" id="signup_form" method="post" action="" data-secure-action="http://sc.chinaz.com" data-secure-ajax-action=""> -->
				
				<table>
					<tr>
					<td style="border:1px solid gray"><input type="text" name="user[cd]" placeholder="请输入用户名" id="signup_name" data-required="required" style="height:39px;width:260px;ime-mode: disabled"></td>
					</tr>

					<tr>
					<td style="border:1px solid gray">
					<!-- <input type="text" id="pwd" value="请输入密码" data-required="required" style="height:39px;ime-mode: disabled"/> -->
					<input type="password" name="user[password]" placeholder="请输入密码" id="signup_password" data-required="required" style="height:39px;ime-mode: disabled">
					<!-- <input type="password" id="password" style="display:none;"/> -->
					</td>
					</tr>
				</table>
			<span id="msg" style="color: red;font-size:14px">${errMsg }</span>
			</div>
			<div class="login-btn-set"><a href='javascript:login1()' onclick = "" class='btn btn-success' style="padding:5px 30px;margin-top: 5px;">登录</a></div>
            </form>
	</div>
	 
</div>

</body>
</html>