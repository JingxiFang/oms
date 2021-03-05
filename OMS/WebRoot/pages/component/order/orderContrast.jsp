<%@page import="sym.component.bean.OrderDetailBean"%>
<%@page import="sym.component.bean.OrderBean"%>
<%@page import="sym.component.service.impl.OrderServiceImpl"%>
<%@page import="sym.component.service.OrderService"%>
<%@page import="sym.common.dto.SessionDto"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	SessionDto dto = (SessionDto) session.getAttribute("dto");
	int orders_id1 = Integer.parseInt(request.getParameter("orders_id1"));
	int orders_id2 = Integer.parseInt(request.getParameter("orders_id2"));
	OrderService orderService = new OrderServiceImpl();
	OrderBean order1 = orderService.showOrderById(orders_id1);
	OrderBean order2 = orderService.showOrderById(orders_id2);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
		//字段对比
		allInputEquals();
		
		$('#scroll_in_right').scroll(function() {
			var $hidden_div = $('#scroll_in_left_in');
			var $left_div = $('#scroll_in_left');

			var scroll_left = $(this).scrollLeft();
			var scroll_top = $(this).scrollTop();

			$left_div.scrollLeft(scroll_left);
			$hidden_div.css('top', '-' + scroll_top + 'px');
		});
		$('#scroll_in_left').scroll(function() {
			var $right_div = $('#scroll_in_right');

			var scroll_left = $(this).scrollLeft();

			$right_div.scrollLeft(scroll_left);
		})
	})

	function allInputEquals() {
		inputEquals($('#orders_version_1'), $('#orders_version_2'));
		inputEquals($('#agency_user_nm_1'), $('#agency_user_nm_2'));
		inputEquals($('#agency_nm_1'), $('#agency_nm_2'));
		inputEquals($('#customer_type_1'), $('#customer_type_2'));
		inputEquals($('#customer_nm_1'), $('#customer_nm_1'));
		inputEquals($('#project_nm_1'), $('#project_nm_2'));
		inputEquals($('#expected_send_month_1'), $('#expected_send_month_2'));
		inputEquals($('#expected_energize_month_1'), $('#expected_energize_month_2'));
		inputEquals($('#shelf_months_1'), $('#shelf_months_2'));
		inputEquals($('#bid_cu_price_1'), $('#bid_cu_price_2'));
		inputEquals($('#bid_sum_money_1'), $('#bid_sum_money_2'));
		inputEquals($('#currency_nm_1'), $('#currency_nm_2'));
		inputEquals($('#contract_sum_money_1'), $('#contract_sum_money_2'));
		inputEquals($('#proportion_1'), $('#proportion_2'));
		inputEquals($('#commission_1'), $('#commission_2'));
		inputEquals($('#payments_proportion1_1'), $('#payments_proportion1_2'));
		inputEquals($('#payments_proportion2_1'), $('#payments_proportion2_2'));
		inputEquals($('#payments_proportion3_1'), $('#payments_proportion3_2'));
		inputEquals($('#payments_proportion4_1'), $('#payments_proportion4_2'));
		inputEquals($('#payments_proportion5_1'), $('#payments_proportion5_2'));
		inputEquals($('#payments_proportion6_1'), $('#payments_proportion6_2'));
		inputEquals($('#expected_payments_date1_1'), $('#expected_payments_date1_2'));
		inputEquals($('#expected_payments_date2_1'), $('#expected_payments_date2_2'));
		inputEquals($('#expected_payments_date3_1'), $('#expected_payments_date3_2'));
		inputEquals($('#expected_payments_date4_1'), $('#expected_payments_date4_2'));
		inputEquals($('#expected_payments_date5_1'), $('#expected_payments_date5_2'));
		inputEquals($('#expected_payments_date6_1'), $('#expected_payments_date6_2'));
		inputEquals($('#expected_payments_sum1_1'), $('#expected_payments_sum1_2'));
		inputEquals($('#expected_payments_sum2_1'), $('#expected_payments_sum2_2'));
		inputEquals($('#expected_payments_sum3_1'), $('#expected_payments_sum3_2'));
		inputEquals($('#expected_payments_sum4_1'), $('#expected_payments_sum4_2'));
		inputEquals($('#expected_payments_sum5_1'), $('#expected_payments_sum5_2'));
		inputEquals($('#expected_payments_sum6_1'), $('#expected_payments_sum6_2'));
	}

	function inputEquals(el1, el2) {
		if (el1.val() != el2.val()) {
			el1.css("color", "red");
			el2.css("color", "red");
		}
	}
</script>
<style type="text/css">
a {
	cursor: pointer;
	color: #0088CC;
}

.scroll_inline {
	border: 1px solid silver;
	padding: 5px;
}
</style>
</head>
<body>
	<!--▼▼▼header▼▼▼-->
	<header> <%@ include file="../../common/header"%>
	</header>
	<!--▼▼▼search▼▼▼-->
	<div class="container-fluid search disabled">
		<div class="row-fluid"></div>
	</div>
	<!--▼▼▼contents(field type)▼▼▼-->
	<div class="main">
		<div class="banner">
			<span>订单履历对比</span>
		</div>
		<div style="height:850px;margin-top:20px;overflow-y:auto;"
			id="scroll_out">
			<div style="margin-left:10px;height:800px;float:left">
				<span style="font-size:22px;color:color:red;font-weight:bold;">版本<%=order1.getOrders_version()%></span>
				<div id="scroll_in_left" class="scroll_inline"
					style="height:800px;width:465px;overflow-y:hidden;">
					<div style="position:relative" id="scroll_in_left_in">
						<div class="content" style="width:1000px;">
							<div style="margin:10px 0;padding:5px 20px;">
								<div class="edit-content"
									style="margin-bottom: 0px;padding-top:10px;">

									<table class="edit-table" style="width:95%">
										<tbody>
											<tr>
												<td width="60%">
													<table>
														<tbody>
															<tr>
																<td class="right_align">合同号&nbsp;:&nbsp;</td>
																<td>
																	<div style="margin-bottom:8px;">
																		<input class="input-xlarge" type="text" disabled
																			style="margin-bottom:0px;width: 120px;"
																			value="<%=order1.getContract_no()%>"> － <input
																			class="input-xlarge" type="text" disabled
																			id="orders_version_1"
																			style="margin-bottom:0px; width: 30px;"
																			value="<%=order1.getOrders_version()%>">
																	</div>
																</td>
																<td colspan="2"></td>
															</tr>
															<tr>
																<td class="right_align">业务员&nbsp;:&nbsp;</td>
																<td colspan="3">
																	<table>
																		<tr>
																			<td><input type="text" disabled
																				style="margin-bottom:5px;width: 120px;"
																				id="agency_user_nm_1"
																				value="<%=order1.getAgency_user_nm()%>"></input></td>
																			<td>&nbsp;&nbsp;&nbsp;&nbsp; <span>代理商&nbsp;:&nbsp;</span>
																			</td>
																			<td><input type="text" disabled
																				style="margin-bottom:5px;width:200px"
																				id="agency_nm_1" value="<%=order1.getAgency_nm()%>"></input></td>
																		</tr>
																	</table>
															</tr>
															<tr>
																<td class="right_align">客户类别&nbsp;:&nbsp;</td>
																<td colspan="3"><input id="customer_type_1"
																	value="<%=order1.getCustomer_type()%>" type="text"
																	disabled style="width:60px;"></input></td>
															</tr>
															<tr>
																<td class="right_align">客户名称&nbsp;:&nbsp;</td>
																<td colspan="3">
																	<div style="display: inline;">
																		<input type="text" disabled style="width: 300px;"
																			id="customer_nm_1"
																			value="<%=order1.getCustomer_nm()%>"></input>
																	</div>
																</td>
															</tr>
															<tr>
																<td class="right_align">项目名称&nbsp;:&nbsp;</td>
																<td colspan="3"><input id="project_nm_1" disabled
																	class="" type="text"
																	style="margin-bottom:5px;width: 300px;"
																	value="<%=order1.getProject_nm()%>"></td>
															</tr>
															<tr>
																<td class="right_align">预计发货月&nbsp;:&nbsp;</td>
																<td colspan="3"><input id="expected_send_month_1"
																	disabled class="" type="text"
																	value="<%=order1.getExpected_send_month()%>"
																	style="width: 70px; margin-bottom: 3px;"></td>
															</tr>
															<tr>
																<td class="right_align">预计送电月&nbsp;:&nbsp;</td>
																<td><input id="expected_energize_month_1" disabled
																	value="<%=order1.getExpected_energize_month()%>"
																	class="" type="text"
																	style="width: 70px; margin-bottom: 5px; ime-mode: disabled">
																</td>
																<td class="right_align">通电后保证月数&nbsp;:&nbsp;</td>
																<td><input id="shelf_months_1" type="text" disabled
																	value="<%=order1.getShelf_months()%>"
																	style="text-align:right;margin-bottom: 0; width: 60px;"></input>
																</td>
															</tr>
															<tr>

															</tr>
														</tbody>
													</table>
												</td>
												<td width="40%">
													<table style="margin-left:30px;">
														<tbody>
															<tr>
																<td class="right_align">投标铜价&nbsp;:&nbsp;</td>
																<td><input id="bid_cu_price_1" type="text" disabled
																	value="<%=order1.getBid_cu_price()%>"
																	style="margin-bottom: 5px; width: 150px; text-align: right;"></td>
															</tr>
															<tr>
																<td class="right_align">金额(货币)&nbsp;:&nbsp;</td>
																<td><input id="bid_sum_money_1" type="text"
																	disabled value="<%=order1.getBid_sum_money()%>"
																	style="margin-bottom: 5px; width: 150px; text-align: right; ime-mode: disabled">
																	<input id="currency_nm_1" type="text" disabled
																	value="<%=order1.getCurrency_nm()%>"
																	style="margin-bottom: 5px;width: 60px;"></input></td>
															</tr>
															<tr>
																<td colspan="2"><span>&nbsp;</span></td>
															</tr>
															<tr>
																<td class="right_align">合同总价&nbsp;:&nbsp;</td>
																<td><input id="contract_sum_money_1" class=""
																	disabled value="<%=order1.getContract_sum_money()%>"
																	type="text"
																	style="width: 150px; text-align: right; ime-mode: disabled">
																</td>
															</tr>
															<tr>
																<td class="right_align">佣金率&nbsp;:&nbsp;</td>
																<td><input id="proportion_1" type="text" disabled
																	value="<%=order1.getProportion() * 100%>"
																	style="margin-bottom: 5px; width: 50px; text-align: right; ime-mode: disabled">&nbsp;<label
																	style="display:inline;">%</label></td>
															</tr>
															<tr>
																<td class="right_align">佣金金额&nbsp;:&nbsp;</td>
																<td><input id="commission_1" type="text" disabled
																	value="<%=order1.getCommission()%>"
																	style="margin-bottom: 5px; width: 150px; text-align: right; ime-mode: disabled"></td>
															</tr>
															<tr>
																<td colspan="2"></td>
															</tr>
														</tbody>
													</table>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div>
									<table style="width:70%">
										<tr>
											<td>
												<div>
													<span
														style="position: relative; left: 10px; top: 8px; font-size: 14px; background-color: #FFFFFF;">
														回款比例/预计回款月/预计回款金额&nbsp;:&nbsp; </span>
													<div
														style="padding: 20px 10px;height:83px;margin-top: 0px; border: 1px solid #0088CC;">
														<table style=" margin-left:30px;width:90%">
															<tr>
																<td><input id="payments_proportion1_1"
																	class="right_align" disabled
																	value="<%=order1.getPayments_proportion1()%>"
																	type="text"
																	style="width: 45px; margin-bottom: 0; ime-mode: disabled">
																	:&nbsp;&nbsp;
																<td><input id="payments_proportion2_1"
																	class="right_align" disabled
																	value="<%=order1.getPayments_proportion2()%>"
																	type="text"
																	style="width: 45px; margin-bottom: 0; ime-mode: disabled">
																	:&nbsp;
																<td><input id="payments_proportion3_1"
																	class="right_align" disabled
																	value="<%=order1.getPayments_proportion3()%>"
																	type="text"
																	style="width: 45px; margin-bottom: 0; ime-mode: disabled">
																	:&nbsp;&nbsp;
																<td><input id="payments_proportion4_1"
																	class="right_align" disabled
																	value="<%=order1.getPayments_proportion4()%>"
																	type="text"
																	style="width: 45px; margin-bottom: 0; ime-mode: disabled">
																	:&nbsp;&nbsp;
																<td><input id="payments_proportion5_1"
																	class="right_align" disabled
																	value="<%=order1.getPayments_proportion5()%>"
																	type="text"
																	style="width: 45px; margin-bottom: 0; ime-mode: disabled">
																	:&nbsp;&nbsp;
																<td><input id="payments_proportion6_1"
																	class="right_align" disabled
																	value="<%=order1.getPayments_proportion6()%>"
																	type="text"
																	style="width: 45px; margin-bottom: 0; ime-mode: disabled">
															</tr>
															<tr>
																<td><input id="expected_payments_date1_1" class=""
																	type="text" disabled
																	value="<%=order1.getExpected_payments_date1()%>"
																	style="margin-bottom: 0; width: 70px; ime-mode: disabled">
																<td><input id="expected_payments_date2_1" class=""
																	type="text" disabled
																	value="<%=order1.getExpected_payments_date2()%>"
																	style="margin-bottom: 0; width: 70px; ime-mode: disabled">
																<td><input id="expected_payments_date3_1" class=""
																	type="text" disabled
																	value="<%=order1.getExpected_payments_date3()%>"
																	style="margin-bottom: 0; width: 70px; ime-mode: disabled">
																<td><input id="expected_payments_date4_1" class=""
																	type="text" disabled
																	value="<%=order1.getExpected_payments_date4()%>"
																	style="margin-bottom: 0; width: 70px; ime-mode: disabled">
																<td><input id="expected_payments_date5_1" class=""
																	type="text" disabled
																	value="<%=order1.getExpected_payments_date5()%>"
																	style="margin-bottom: 0; width: 70px; ime-mode: disabled">
																<td><input id="expected_payments_date6_1" class=""
																	type="text" disabled
																	value="<%=order1.getExpected_payments_date6()%>"
																	style="margin-bottom: 0; width: 70px; ime-mode: disabled">
															</tr>
															<tr>
																<td><input id="expected_payments_sum1_1"
																	class="right_align" disabled
																	value="<%=order1.getExpected_payments_sum1()%>"
																	type="text" style="width: 90px; ime-mode: disabled">
																<td><input id="expected_payments_sum2_1"
																	class="right_align" disabled
																	value="<%=order1.getExpected_payments_sum2()%>"
																	type="text" style="width: 90px; ime-mode: disabled">
																<td><input id="expected_payments_sum3_1"
																	class="right_align" disabled
																	value="<%=order1.getExpected_payments_sum3()%>"
																	type="text" style="width: 90px; ime-mode: disabled">
																<td><input id="expected_payments_sum4_1"
																	class="right_align" disabled
																	value="<%=order1.getExpected_payments_sum4()%>"
																	type="text" style="width: 90px; ime-mode: disabled">
																<td><input id="expected_payments_sum5_1"
																	class="right_align" disabled
																	value="<%=order1.getExpected_payments_sum5()%>"
																	type="text" style="width: 90px; ime-mode: disabled">
																<td><input id="expected_payments_sum6_1"
																	class="right_align" disabled
																	value="<%=order1.getExpected_payments_sum6()%>"
																	type="text" style="width: 90px; ime-mode: disabled">
															</tr>
														</table>
													</div>
												</div>
											</td>
										</tr>
									</table>
								</div>
								<div class="product-tab" style="margin-top:10px;">
									<ul class="nav nav-tabs"
										style="width:914px; margin-bottom: 0px;">
										<li class="active"><a id="li_1" href="#div_list_0"
											data-toggle="tab">电缆</a></li>
										<li class=""><a id="li_2" href="#div_list_1"
											data-toggle="tab">附件</a></li>
									</ul>
								</div>

								<div class="tab-content">
									<div class="div_list tab-pane active" id="div_list_0">
										<div class="" style="margin:auto;width:860px;">
											<div class="" style="width: 855px;">
												<table
													class="table table-striped table-bordered table-title"
													style="background-color:#E4F4CB;margin-bottom:0px;">
													<thead>
														<tr>
															<th style="width:5%;height:21px">序号</th>
															<th style="width:12%;">规格型号</th>
															<th style="width:10%">电压等级</th>
															<th style="width:10%;">合同数量</th>
															<th style="width:5%">单位</th>
															<th style="width:10%;">合同单价</th>
															<th style="width:20%;">金额</th>
															<th style="">备注</th>
														</tr>
													</thead>
												</table>
											</div>
											<div
												style="overflow-y:auto; padding-right: 5px;height:165px;width:870px;">
												<div style="width:855px;">
													<table id="product_list_table"
														class="table table-striped table-bordered table-body"
														style="background-color:#E4F4CB;">
														<tbody>
															<%
																for (OrderDetailBean orderDetailBean : order1.getOrder_detail_list()) {
																	if (orderDetailBean.getProduct_category().equals("1")) {
															%>
															<tr style="">
																<td style="width: 5%;"><%=orderDetailBean.getOrder_detail_id()%></td>
																<td style="width: 12%;"><%=orderDetailBean.getSpecification_type()%></td>
																<td style="width: 10%;"><%=orderDetailBean.getVoltage()%></td>
																<td style="width: 10%;" class="right_align"><%=orderDetailBean.getContract_quantity()%></td>
																<td style="width: 5%; text-align: center;" class="">项</td>
																<td style="width: 10%;" class="right_align"><%=orderDetailBean.getContract_unit_price()%></td>
																<td style="width: 20%;" class="right_align"><%=orderDetailBean.getContract_price()%></td>
																<td style=""><%=orderDetailBean.getRemark()%></td>
															</tr>
															<%
																}
																}
															%>
														</tbody>
													</table>
												</div>
											</div>
										</div>
									</div>
									<div class="div_list tab-pane" id="div_list_1">
										<div class="" style="margin:auto;width:860px;">
											<div class="" style="width: 855px;">
												<table
													class="table table-striped table-bordered table-title"
													style="background-color:#E4F4CB;margin-bottom: 0px;">
													<thead>
														<tr>
															<th style="width:5%;height:21px">序号</th>
															<th style="width:12%;">规格型号</th>
															<th style="width:10%">电压等级</th>
															<th style="width:10%;">合同数量</th>
															<th style="width:5%;">单位</th>
															<th style="width:10%;">合同单价</th>
															<th style="width:20%;">金额</th>
															<th style="">备注</th>
														</tr>
													</thead>
												</table>
											</div>
											<div
												style="overflow-y:auto; padding-right: 5px;height:165px;width:870px;">
												<div style="width:855px;">
													<table id="product_list_table"
														class="table table-striped table-bordered table-body"
														style="background-color:#E4F4CB;">
														<tbody>
															<%
																for (OrderDetailBean orderDetailBean : order1.getOrder_detail_list()) {
																	if (orderDetailBean.getProduct_category().equals("2")) {
															%>
															<tr>
																<td style="width: 5%;"><%=orderDetailBean.getOrder_detail_id()%></td>
																<td style="width: 12%;"><%=orderDetailBean.getSpecification_type()%></td>
																<td style="width: 10%;"><%=orderDetailBean.getVoltage()%></td>
																<td style="width: 10%;" class="right_align"><%=orderDetailBean.getContract_quantity()%></td>
																<td style="width: 5%; text-align: center;" class="">项</td>
																<td style="width: 10%;" class="right_align"><%=orderDetailBean.getContract_unit_price()%></td>
																<td style="width: 20%;" class="right_align"><%=orderDetailBean.getContract_price()%></td>
																<td style=""><%=orderDetailBean.getRemark()%></td>
															</tr>
															<%
																}
																}
															%>
														</tbody>
													</table>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div style="margin-left:10px;height:800px;float:left">
				<span style="font-size:22px;color:color:red;font-weight:bold;">版本<%=order2.getOrders_version()%></span>
				<div id="scroll_in_right" class="scroll_inline"
					style="height:800px;width:480px;overflow-y:auto;">
					<div class="content" style="width:1000px">
						<div style="margin:10px 0;padding:5px 20px;">

							<div class="edit-content"
								style="margin-bottom: 0px;padding-top:10px;">
								<table class="edit-table" style="width:95%">
									<tbody>
										<tr>
											<td width="60%">
												<table>
													<tbody>
														<tr>
															<td class="right_align">合同号&nbsp;:&nbsp;</td>
															<td>
																<div style="margin-bottom:8px;">
																	<input class="input-xlarge" type="text" disabled
																		style="margin-bottom:0px;width: 120px;"
																		value="<%=order2.getContract_no()%>"> － <input
																		class="input-xlarge" type="text" disabled
																		id="orders_version_2"
																		style="margin-bottom:0px; width: 30px;"
																		value="<%=order2.getOrders_version()%>">
																</div>
															</td>
															<td colspan="2"></td>
														</tr>
														<tr>
															<td class="right_align">业务员&nbsp;:&nbsp;</td>
															<td colspan="3">
																<table>
																	<tr>
																		<td><input type="text" disabled
																			style="margin-bottom:5px;width: 120px;"
																			id="agency_user_nm_2"
																			value="<%=order2.getAgency_user_nm()%>"></input></td>
																		<td>&nbsp;&nbsp;&nbsp;&nbsp; <span>代理商&nbsp;:&nbsp;</span>
																		</td>
																		<td><input type="text" disabled
																			style="margin-bottom:5px;width:200px"
																			id="agency_nm_2" value="<%=order2.getAgency_nm()%>"></input></td>
																	</tr>
																</table>
														</tr>
														<tr>
															<td class="right_align">客户类别&nbsp;:&nbsp;</td>
															<td colspan="3"><input id="customer_type_2"
																value="<%=order2.getCustomer_type()%>" type="text"
																disabled style="width:60px;"></input></td>
														</tr>
														<tr>
															<td class="right_align">客户名称&nbsp;:&nbsp;</td>
															<td colspan="3">
																<div style="display: inline;">
																	<input type="text" disabled style="width: 300px;"
																		id="customer_nm_2"
																		value="<%=order2.getCustomer_nm()%>"></input>
																</div>
															</td>
														</tr>
														<tr>
															<td class="right_align">项目名称&nbsp;:&nbsp;</td>
															<td colspan="3"><input id="project_nm_2" disabled
																class="" type="text"
																style="margin-bottom:5px;width: 300px;"
																value="<%=order2.getProject_nm()%>"></td>
														</tr>
														<tr>
															<td class="right_align">预计发货月&nbsp;:&nbsp;</td>
															<td colspan="3"><input id="expected_send_month_2"
																disabled class="" type="text"
																value="<%=order2.getExpected_send_month()%>"
																style="width: 70px; margin-bottom: 3px;"></td>
														</tr>
														<tr>
															<td class="right_align">预计送电月&nbsp;:&nbsp;</td>
															<td><input id="expected_energize_month_2" disabled
																value="<%=order2.getExpected_energize_month()%>"
																class="" type="text"
																style="width: 70px; margin-bottom: 5px; ime-mode: disabled">
															</td>
															<td class="right_align">通电后保证月数&nbsp;:&nbsp;</td>
															<td><input id="shelf_months_2" type="text" disabled
																value="<%=order2.getShelf_months()%>"
																style="text-align:right;margin-bottom: 0; width: 60px;"></input>
															</td>
														</tr>
														<tr>

														</tr>
													</tbody>
												</table>
											</td>
											<td width="40%">
												<table style="margin-left:30px;">
													<tbody>
														<tr>
															<td class="right_align">投标铜价&nbsp;:&nbsp;</td>
															<td><input id="bid_cu_price_2" type="text" disabled
																value="<%=order2.getBid_cu_price()%>"
																style="margin-bottom: 5px; width: 150px; text-align: right;"></td>
														</tr>
														<tr>
															<td class="right_align">金额(货币)&nbsp;:&nbsp;</td>
															<td><input id="bid_sum_money_2" type="text" disabled
																value="<%=order2.getBid_sum_money()%>"
																style="margin-bottom: 5px; width: 150px; text-align: right; ime-mode: disabled">
																<input id="currency_nm_2" type="text" disabled
																value="<%=order2.getCurrency_nm()%>"
																style="margin-bottom: 5px;width: 60px;"></input></td>
														</tr>
														<tr>
															<td colspan="2"><span>&nbsp;</span></td>
														</tr>
														<tr>
															<td class="right_align">合同总价&nbsp;:&nbsp;</td>
															<td><input id="contract_sum_money_2" class=""
																disabled value="<%=order2.getContract_sum_money()%>"
																type="text"
																style="width: 150px; text-align: right; ime-mode: disabled">
															</td>
														</tr>
														<tr>
															<td class="right_align">佣金率&nbsp;:&nbsp;</td>
															<td><input id="proportion_2" type="text" disabled
																value="<%=order2.getProportion() * 100%>"
																style="margin-bottom: 5px; width: 50px; text-align: right; ime-mode: disabled">&nbsp;<label
																style="display:inline;">%</label></td>
														</tr>
														<tr>
															<td class="right_align">佣金金额&nbsp;:&nbsp;</td>
															<td><input id="commission_2" type="text" disabled
																value="<%=order2.getCommission()%>"
																style="margin-bottom: 5px; width: 150px; text-align: right; ime-mode: disabled"></td>
														</tr>
														<tr>
															<td colspan="2"></td>
														</tr>
													</tbody>
												</table>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div>
								<table style="width:70%">
									<tr>
										<td>
											<div>
												<span
													style="position: relative; left: 10px; top: 8px; font-size: 14px; background-color: #FFFFFF;">
													回款比例/预计回款月/预计回款金额&nbsp;:&nbsp; </span>
												<div
													style="padding: 20px 10px;height:83px;margin-top: 0px; border: 1px solid #0088CC;">
													<table style=" margin-left:30px;width:90%">
														<tr>
															<td><input id="payments_proportion1_2"
																class="right_align" disabled
																value="<%=order2.getPayments_proportion1()%>"
																type="text"
																style="width: 45px; margin-bottom: 0; ime-mode: disabled">
																:&nbsp;&nbsp;
															<td><input id="payments_proportion2_2"
																class="right_align" disabled
																value="<%=order2.getPayments_proportion2()%>"
																type="text"
																style="width: 45px; margin-bottom: 0; ime-mode: disabled">
																:&nbsp;
															<td><input id="payments_proportion3_2"
																class="right_align" disabled
																value="<%=order2.getPayments_proportion3()%>"
																type="text"
																style="width: 45px; margin-bottom: 0; ime-mode: disabled">
																:&nbsp;&nbsp;
															<td><input id="payments_proportion4_2"
																class="right_align" disabled
																value="<%=order2.getPayments_proportion4()%>"
																type="text"
																style="width: 45px; margin-bottom: 0; ime-mode: disabled">
																:&nbsp;&nbsp;
															<td><input id="payments_proportion5_2"
																class="right_align" disabled
																value="<%=order2.getPayments_proportion5()%>"
																type="text"
																style="width: 45px; margin-bottom: 0; ime-mode: disabled">
																:&nbsp;&nbsp;
															<td><input id="payments_proportion6_2"
																class="right_align" disabled
																value="<%=order2.getPayments_proportion6()%>"
																type="text"
																style="width: 45px; margin-bottom: 0; ime-mode: disabled">
														</tr>
														<tr>
															<td><input id="expected_payments_date1_2" class=""
																type="text" disabled
																value="<%=order2.getExpected_payments_date1()%>"
																style="margin-bottom: 0; width: 70px; ime-mode: disabled">
															<td><input id="expected_payments_date2_2" class=""
																type="text" disabled
																value="<%=order2.getExpected_payments_date2()%>"
																style="margin-bottom: 0; width: 70px; ime-mode: disabled">
															<td><input id="expected_payments_date3_2" class=""
																type="text" disabled
																value="<%=order2.getExpected_payments_date3()%>"
																style="margin-bottom: 0; width: 70px; ime-mode: disabled">
															<td><input id="expected_payments_date4_2" class=""
																type="text" disabled
																value="<%=order2.getExpected_payments_date4()%>"
																style="margin-bottom: 0; width: 70px; ime-mode: disabled">
															<td><input id="expected_payments_date5_2" class=""
																type="text" disabled
																value="<%=order2.getExpected_payments_date5()%>"
																style="margin-bottom: 0; width: 70px; ime-mode: disabled">
															<td><input id="expected_payments_date6_2" class=""
																type="text" disabled
																value="<%=order2.getExpected_payments_date6()%>"
																style="margin-bottom: 0; width: 70px; ime-mode: disabled">
														</tr>
														<tr>
															<td><input id="expected_payments_sum1_2"
																class="right_align" disabled
																value="<%=order2.getExpected_payments_sum1()%>"
																type="text" style="width: 90px; ime-mode: disabled">
															<td><input id="expected_payments_sum2_2"
																class="right_align" disabled
																value="<%=order2.getExpected_payments_sum2()%>"
																type="text" style="width: 90px; ime-mode: disabled">
															<td><input id="expected_payments_sum3_2"
																class="right_align" disabled
																value="<%=order2.getExpected_payments_sum3()%>"
																type="text" style="width: 90px; ime-mode: disabled">
															<td><input id="expected_payments_sum4_2"
																class="right_align" disabled
																value="<%=order2.getExpected_payments_sum4()%>"
																type="text" style="width: 90px; ime-mode: disabled">
															<td><input id="expected_payments_sum5_2"
																class="right_align" disabled
																value="<%=order2.getExpected_payments_sum5()%>"
																type="text" style="width: 90px; ime-mode: disabled">
															<td><input id="expected_payments_sum6_2"
																class="right_align" disabled
																value="<%=order2.getExpected_payments_sum6()%>"
																type="text" style="width: 90px; ime-mode: disabled">
														</tr>
													</table>
												</div>
											</div>
										</td>
									</tr>
								</table>
							</div>
							<div class="product-tab" style="margin-top:10px;">
								<ul class="nav nav-tabs"
									style="width:914px; margin-bottom: 0px;">
									<li class="active"><a id="li_1" href="#div_list_3"
										data-toggle="tab">电缆</a></li>
									<li class=""><a id="li_2" href="#div_list_4"
										data-toggle="tab">附件</a></li>
								</ul>
							</div>

							<div class="tab-content">
								<div class="div_list tab-pane active" id="div_list_3">
									<div class="" style="margin:auto;width:860px;">
										<div class="" style="width: 855px;">
											<table class="table table-striped table-bordered table-title"
												style="background-color:#E4F4CB;margin-bottom:0px;">
												<thead>
													<tr>
														<th style="width:5%;height:21px">序号</th>
														<th style="width:12%;">规格型号</th>
														<th style="width:10%">电压等级</th>
														<th style="width:10%;">合同数量</th>
														<th style="width:5%">单位</th>
														<th style="width:10%;">合同单价</th>
														<th style="width:20%;">金额</th>
														<th style="">备注</th>
													</tr>
												</thead>
											</table>
										</div>
										<div
											style="overflow-y:auto; padding-right: 5px;height:165px;width:870px;">
											<div style="width:855px;">
												<table id="product_list_table"
													class="table table-striped table-bordered table-body"
													style="background-color:#E4F4CB;">
													<tbody>
														<%
															for (OrderDetailBean orderDetailBean : order2.getOrder_detail_list()) {
																if (orderDetailBean.getProduct_category().equals("1")) {
														%>
														<tr>
															<td style="width: 5%;"><%=orderDetailBean.getOrder_detail_id()%></td>
															<td style="width: 12%;"><%=orderDetailBean.getSpecification_type()%></td>
															<td style="width: 10%;"><%=orderDetailBean.getVoltage()%></td>
															<td style="width: 10%;" class="right_align"><%=orderDetailBean.getContract_quantity()%></td>
															<td style="width: 5%; text-align: center;" class="">项</td>
															<td style="width: 10%;" class="right_align"><%=orderDetailBean.getContract_unit_price()%></td>
															<td style="width: 20%;" class="right_align"><%=orderDetailBean.getContract_price()%></td>
															<td style=""><%=orderDetailBean.getRemark()%></td>
														</tr>
														<%
															}
															}
														%>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
								<div class="div_list tab-pane" id="div_list_4">
									<div class="" style="margin:auto;width:860px;">
										<div class="" style="width: 855px;">
											<table class="table table-striped table-bordered table-title"
												style="background-color:#E4F4CB;margin-bottom: 0px;">
												<thead>
													<tr>
														<th style="width:5%;height:21px">序号</th>
														<th style="width:12%;">规格型号</th>
														<th style="width:10%">电压等级</th>
														<th style="width:10%;">合同数量</th>
														<th style="width:5%;">单位</th>
														<th style="width:10%;">合同单价</th>
														<th style="width:20%;">金额</th>
														<th style="">备注</th>
													</tr>
												</thead>
											</table>
										</div>
										<div
											style="overflow-y:auto; padding-right: 5px;height:165px;width:870px;">
											<div style="width:855px;">
												<table id="product_list_table"
													class="table table-striped table-bordered table-body"
													style="background-color:#E4F4CB;">
													<tbody>
														<%
															for (OrderDetailBean orderDetailBean : order2.getOrder_detail_list()) {
																if (orderDetailBean.getProduct_category().equals("2")) {
														%>
														<tr>
															<td style="width: 5%;"><%=orderDetailBean.getOrder_detail_id()%></td>
															<td style="width: 12%;"><%=orderDetailBean.getSpecification_type()%></td>
															<td style="width: 10%;"><%=orderDetailBean.getVoltage()%></td>
															<td style="width: 10%;" class="right_align"><%=orderDetailBean.getContract_quantity()%></td>
															<td style="width: 5%; text-align: center;" class="">项</td>
															<td style="width: 10%;" class="right_align"><%=orderDetailBean.getContract_unit_price()%></td>
															<td style="width: 20%;" class="right_align"><%=orderDetailBean.getContract_price()%></td>
															<td style=""><%=orderDetailBean.getRemark()%></td>
														</tr>
														<%
															}
															}
														%>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div style="clear:both;"></div>
		</div>
		<div class="bottom_block">
			<a class="btn btn-info btn-middle-aft" style=""
				href="javascript:window.history.back(-1);">返回</a>
		</div>
	</div>

</body>
</html>
