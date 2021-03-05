<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@page import="sym.common.dto.SessionDto"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
SessionDto dto = (SessionDto)session.getAttribute("dto");
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
		<script type="text/javascript" src="../../js/lib/jquery/jquery.min.js"></script>
		<script type="text/javascript" src="../../js/lib/jquery_plugin/bs/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="../../js/lib/jquery_plugin/placeholder/jquery.placeholder.js"></script>
		<!--script 〓system-->

		<!--styles common-->
		<link href="../../js/lib/jquery_plugin/bs/css/bootstrap.min.css" rel="stylesheet" type="text/css">
		<link href="../../js/lib/jquery_plugin/bs/css/bootstrap-responsive.css" rel="stylesheet" type="text/css">
		<link href="../../css/common/bootstrap_setup.css" rel="stylesheet" type="text/css">
		<link href="../../css/common/common.css" rel="stylesheet" type="text/css">
		<link href="../../css/menu/main.css" rel="stylesheet" type="text/css">
		<link id="icon" href="../../images/s.ico" rel="icon">
	</head>
<body>
<!--▼▼▼header▼▼▼-->
<header>
	<div class="navbar navbar-inverse">
		<div class="navbar-inner">
			<div class="container">
				<button data-target=".nav-collapse" data-toggle="collapse" class="btn btn-navbar" type="button">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<!--logo-->
				<ul class="nav nav-pills logo">
					<li>
						<a class="logo" href="<%=basePath%>loginAction?method=main" style="padding: 0px;">
						<img alt="" src="../../images/logo.png"><span style="padding-left: 10px;padding-top:10px;padding-bottom:5px;color:#EEEEEE;font-size: 23px;font-weight: bold;vertical-align:middle;">订单管理系统</span>
						</a>
					</li>
				</ul>
				<!--navi-->
				<div class="nav-collapse collapse">
					<ul class="nav pull-right user">
						<li class="dropdown">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="icon-user icon-white unit"></i>${dto.user_nm}<b class="caret"></b>
							</a>
							<ul class="dropdown-menu" style="z-index:1000000;">
								<li><a href="../common/resetPassword.jsp">修改密码</a></li>
								<li class="divider"></li>
								<li><a href="<%=basePath%>/loginAction?method=logout">退出系统</a></li>
							</ul>
						</li>
						<li class="" style="border-left-width: 0px;">
							<a class="" style="border-left-width: 0px;" data-toggle="dropdown" href="#">
									<%if ("M".equals(dto.getUser_owner_flg())) {%>
										<span class="label label-info" style="background:#4f81bd;padding: 3px 4px;width:30px;height: 14px;text-align:center;border-radius:10px;font-size: 13px;">
										管理</span>
									<%} else if ("S".equals(dto.getUser_owner_flg())) {%>
										<span class="label label-success" style="background:#9bbb59;padding: 3px 4px;width:30px;height: 14px;text-align:center;border-radius:10px;font-size: 13px;">
										业务</span>
									<%} else if ("F".equals(dto.getUser_owner_flg())) {%>
										<span class="label label-warning" style="background:#f79646;padding: 3px 4px;width:30px;height: 14px;text-align:center;border-radius:10px;font-size: 13px;">
										财务</span>
									<%} %>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</header>
<!--▼▼▼search▼▼▼-->
<div class="container-fluid search disabled">
	<div class="row-fluid">
	</div>
</div>
<!--▼▼▼contents(field type)▼▼▼-->
<div class="container-fluid contents">
	<div class="row-fluid">
		<div class="span">
			<div class="row-fluid entrance" style="padding-top: 50px;">
				<div class="" align="center">
					<div class="row-fluid search-button" >
						<table>
								<tbody>
									<tr>
										<td>
											<div  class="btn btn-success btn-panel" onclick="window.location='../component/order/orderInsert.jsp'">
												<img src="../../images/newOrderform.png"><p class="font-title">新订单录入</p>
											</div>
										</td>
										<td>
											<div  class="btn btn-success btn-panel" onclick="window.location='../component/order/orderSearch.jsp'">
												<img src="../../images/editOrderform.png"><p class="font-title">订单查询・变更</p>
											</div>
										</td>
										<td>
											<div  class="btn btn-success btn-panel" onclick="window.location='/OMS/OrderPageListAction?method=firstPage&action=invoiceInsert'">
												<img src="../../images/invoice.png"><p class="font-title">发票录入</p>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
					</div>

				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
