<%@page import="sym.component.service.impl.OrderServiceImpl"%>
<%@page import="sym.component.service.OrderService"%>
<%@page import="sym.common.dto.SessionDto"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="sym.component.bean.OrderBean"%>
<%@page import="sym.component.action.OrderAction"%>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
SessionDto dto = (SessionDto) session.getAttribute("dto");
String user_owner_flg = dto.getUser_owner_flg();
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
	src="../../../js/lib/jquery/jquery.min.js"></script>
<script type="text/javascript"
	src="../../../js/lib/jquery_plugin/bs/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="../../../js/lib/jquery_plugin/placeholder/jquery.placeholder.js"></script>
<script src="../../../js/common/datepicker.js"></script>
<script type="text/javascript"
	src="../../../js/lib/jquery_plugin/ui/jquery-ui.js"></script>
<script type="text/javascript" src="../../../js/common/popup.js"></script>
<script src="../../../js/MonthPicker/WdatePicker.js"></script>
<script type="text/javascript"
	src="../../../js/lib/jquery_alert/jquery.alerts.js"></script>
<link id="icon" href="../../../images/s.ico" rel="icon">
<!--script 〓system-->

<!--styles common-->
<link href="../../../js/lib/jquery_plugin/bs/css/bootstrap.min.css"
	rel="stylesheet" type="text/css">

<link
	href="../../../js/lib/jquery_plugin/bs/css/bootstrap-responsive.css"
	rel="stylesheet" type="text/css">
<link href="../../../css/common/bootstrap_setup.css" rel="stylesheet"
	type="text/css">
<link href="../../../js/lib/jquery_plugin/ui/jquery-ui.css"
	rel="stylesheet" type="text/css">
<link href="../../../css/common/common.css" rel="stylesheet"
	type="text/css">
<link href="../../../css/common/popup.css" rel="stylesheet"
	type="text/css">
<link href="../../../css/common/datepicker.css" rel="stylesheet">
<link href="../../../js/MonthPicker/skin/WdatePicker.css"
	rel="stylesheet">
<link href="../../../js/lib/jquery_alert/jquery.alerts.css"
	rel="stylesheet" type="text/css">
<script type="text/javascript">
	var submitS = '确定';
	var cancelC = '取消';
	var alertS = '确定';
	function confirmInfo() {
		jAlert('保存成功', alertS, function(r) {
			window.location.href = "mainMenuG.html";
		});
	}

	$(function() {
		$(document).on('click', '.sort', function(e) {
			if ($(this).find('span')[0] == null) {
				flag = false;
			}
			$('.caret').remove();
			var sor = $('<span class="' + (flag ? 'caret up' : 'caret') + '"></span>')
			$(this).append(sor);
			flag = !flag;
		});
	});

	function selectCheckbox(item) {
		$("input[name='version_status']").each(function() {
			var check = this.checked;
			if (check) {
				$(this).parent().parent().parent().addClass('row-select');
			} else {
				$(this).parent().parent().parent().removeClass('row-select');
			}
		});
	}

	function contrast(){
		var count = 0;
		var checkeds = $("input[name='version_status']:checked");
		count = checkeds.length;
		var orders_id1;
		var orders_id2;
		if (count != 2) {
			jAlert('请选择两条记录进行对比', alertS, function(r) {});
		} else{
			orders_id1 = $(checkeds[0]).parent().children().eq(1).val();
			orders_id2 = $(checkeds[1]).parent().children().eq(1).val();
			window.location='orderContrast.jsp?orders_id1='+orders_id1+"&orders_id2="+orders_id2;
		}
		
	}

</script>
<style type="text/css">
a {
	cursor: pointer;
	color: #0088CC;
}
</style>
</head>
<body>
	<!--▼▼▼header▼▼▼-->
	<header>
		<%@ include file="../../common/header"%>
	</header>
	<!--▼▼▼search▼▼▼-->
	<div class="container-fluid search disabled">
		<div class="row-fluid"></div>
	</div>
	<!--▼▼▼contents(field type)▼▼▼-->
	<div class="main">
		<div class="banner">
			<span>订单履历</span>
		</div>
		<div class="content">
			<div class="search-result"
				style="margin-top: 5px; padding: 5px 20px;">
				<div id="search_result" style="padding: 1px;">
					<div style="padding-bottom: 10px; padding-top: 1px;">
						<span style="font-size: 22px; font-weight: bold;">履历一览表</span>
					</div>

					<table id="record_list" class="table table-striped table-bordered"
						style="background-color: #E4F4CB;">
						<thead>
							<tr>
								<th style="width: 10%; height: 21px;"></th>
								<th style="width: 15%"><a class="sort">版本号</a></th>
								<th style="width: 20%"><a class="sort">业务员</a></th>
								<th style="width: 20%"><a class="sort">更新者</a></th>
								<th style="width: 35%"><a class="sort">更新时间</a></th>
							</tr>
						</thead>
						<tbody id="search_tbody">
						<%
						String contract_no=request.getParameter("contract_no");
						OrderService orderService=new OrderServiceImpl();
						List<OrderBean> OrderVersionList=orderService.findOrderVersionList(contract_no);
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						for(OrderBean bean:OrderVersionList)
						{
						%>
							<tr>
								<td><div align="center">
										<input id="checkboxD" type="checkbox"
											onclick="selectCheckbox(this)" value="D"
											name="version_status"/>
										<input type="hidden" name="orders_id" value="<%=bean.getOrders_id()%>"/>
									</div></td>
								<td><%=bean.getOrders_version() %></td>
								<td><%=bean.getAgency_user_nm() %></td>
								<td><%=bean.getUpdate_user_nm() %></td>
								<td class="center_td"><%=sdf.format(bean.getUpdate_date()) %></td>
							</tr>
						<%} %>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="bottom_block">
			<a class="btn btn-primary btn-middle" onclick="contrast()">对比</a>
			<a class="btn btn-info btn-middle-aft" href="orderSearch.html">返回</a>
		</div>
	</div>
</body>
</html>

