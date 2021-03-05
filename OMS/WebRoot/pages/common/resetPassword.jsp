<%@page import="sym.common.dto.SessionDto"%>
<%@ page import="sym.common.bean.AdminUserBean"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";	
SessionDto dto = (SessionDto) session.getAttribute("dto");
%>
<!DOCTYPE html>
<!--[if lt IE 7]><html class="ie6 ie"><![endif]-->
<!--[if IE 7]><html class="ie7 ie"><![endif]-->
<!--[if IE 8]><html class="ie8 ie"><![endif]-->
<!--[if gt IE 8]><!-->
<html lang="ja" class="">
<!--<![endif]-->
<head>
<meta charset="UTF-8">
<!--script frontend-->
<script type="text/javascript"
	src="../../js/lib/jquery/jquery.min.js"></script>
<script type="text/javascript"
	src="../../js/lib/jquery_plugin/bs/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="../../js/lib/jquery_plugin/placeholder/jquery.placeholder.js"></script>
<script src="../../js/common/datepicker.js"></script>
<script type="text/javascript"
	src="../../js/lib/jquery_plugin/ui/jquery-ui.js"></script>
<script src="../../js/MonthPicker/WdatePicker.js"></script>
<script type="text/javascript"
	src="../../js/lib/jquery_alert/jquery.alerts.js"></script>
<link id="icon" href="../../../images/s.ico" rel="icon">
<!--script 〓system-->

<!--styles common-->
<link href="../../js/lib/jquery_plugin/bs/css/bootstrap.min.css"
	rel="stylesheet" type="text/css">

<link
	href="../../js/lib/jquery_plugin/bs/css/bootstrap-responsive.css"
	rel="stylesheet" type="text/css">
<link href="../../css/common/bootstrap_setup.css" rel="stylesheet"
	type="text/css">
<link href="../../js/lib/jquery_plugin/ui/jquery-ui.css"
	rel="stylesheet" type="text/css">
<link href="../../css/common/common.css" rel="stylesheet"
	type="text/css">
<link href="../../css/common/popup.css" rel="stylesheet"
	type="text/css">
<link href="../../css/common/datepicker.css" rel="stylesheet">
<link href="../../js/lib/jquery_alert/jquery.alerts.css"
	rel="stylesheet" type="text/css">

<script type="text/javascript">
var flag1 = false;//当前密码是否正确
var flag2 = false;//新密码是否非空
var flag3 = false;//两次密码是否一致
$(function() {
	
	//焦点离开时触发事件  
    $("#password_old").change(function(){    
        var password_old = $("#password_old").val();          
        $.ajax({  
            type : "GET",  
            url : "<%=path%>/loginAction?method=resetPassword",
				data : {
					password : password_old,
				},
				dataType : "text",
				success : function(msg) {
					getMsg(msg);
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert(XMLHttpRequest.status);
				}
			});

		});

		function getMsg(msg) {
			var pw_msg = $("#pw_msg");
			if ($.trim(msg) == "true") {
				pw_msg.text("");
				flag1 = true;
			} else {
				flag1 = false;
				pw_msg.text("当前密码错误，请重新输入");
			}
			check();
		}
		
	});
	function check1() {
		var passwd1 = $("#password_1").val();
		var explain1 = $("#explain1");
		if (passwd1 == "") {
			explain1.text("密码空，请输入");
			flag2 = false;
		} else if (passwd1.length > 15) {
			explain1.text("密码长度不得超过15位，请重新输入");
			flag2 = false;
		} else {
			explain1.text("");
			flag2 = true;
		}
		check2();
		check();
	}
	function check2() {
		var passwd1 = $("#password_1").val();
		var passwd2 = $("#password_2").val();
		var explain2 = $("#explain2");
		if (passwd2 != passwd1) {
			explain2.text("两次密码不一致");
			flag3 = false;
		}
		else {
			explain2.text("");
			flag3 = true;
		}
		check();
	}
	
	function check(){
		if(flag1 && flag2 && flag3){
			$("#sub").removeAttr("disabled");
			$("#sub").attr("href", "javascript:$('#form1').submit()");
		}else{
			$("#sub").attr("disabled", "disabled");
			$("#sub").attr("href", "#");
		}
	}
</script>

</head>
<body>
	<!--▼▼▼header▼▼▼-->
	<header> 
		<%@ include file="header"%>
	</header>
	<!--▼▼▼search▼▼▼-->
	<div class="container-fluid search disabled">
		<div class="row-fluid"></div>
	</div>
	<!--▼▼▼contents(field type)▼▼▼-->
	<div class="main">
		<div class="banner">
			<span>修改密码</span>
		</div>
		<form action="../../resetPasswordAction" method="post" id="form1">
			<div class="content"
				style=" min-height: 300px;border-top:1px solid #0088CC;">
				<div class="search-result">
					<div id="search_result" style="padding:10px;margin-top:80px;">
						<table class="table-edit table-striped table-bordered">
							<tbody>
								<tr>
									<td style="width:230px" class="right_align">
										<div class="">当前密码:</div>
									</td>
									<td>
										<div>
											<input id="password_old" class="span3 jq-placeholder must"
												type="password" title="" value="" name="password_old"
												placeholder="请输入当前密码"> <span
												style="font-size: 2px;color: red" id="pw_msg"></span>
										</div>
									</td>
								</tr>
								<tr>
									<td class="right_align">
										<div class="">新密码:</div>
									</td>
									<td>
										<div>
											<input id="password_1" class="span3 jq-placeholder must"
												type="password" title="" value="" name="password_1"
												placeholder="请输入新密码" onBlur="check1()"> <span
												style="font-size: 10px;color: red" id="explain1"></span>
										</div>
									</td>
								</tr>
								<tr>
									<td class="right_align">
										<div class="">确认新密码:</div>
									</td>
									<td>
										<div>
											<input id="password_2" class="span3 jq-placeholder must"
												type="password" title="" value="" name="password_2"
												placeholder="请确认新密码" onBlur="check2()"> <span
												style="font-size: 10px;color: red" id="explain2"></span>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

			</div>

			<div class="bottom_block">
				<a class="btn btn-primary btn-middle" id="sub" disabled
					href="">确定</a> 
				<a class="btn btn-info btn-middle-aft" style=""
					href="<%=basePath%>/loginAction?method=main">返回主菜单</a>
			</div>
		</form>
	</div>
</body>
</html>

