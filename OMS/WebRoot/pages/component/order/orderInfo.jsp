<%@page import="sym.component.bean.OrderDetailBean"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="sym.component.bean.OrderBean"%>
<%@page import="sym.component.service.impl.OrderServiceImpl"%>
<%@page import="sym.component.service.OrderService"%>
<%@page import="sym.common.dto.SessionDto"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
int orders_id = Integer.parseInt(request.getParameter("orders_id"));
OrderService orderService = new OrderServiceImpl();
OrderBean orderBean = orderService.showOrderById(orders_id);
SessionDto dto = (SessionDto)session.getAttribute("dto");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
<link href="../../../js/lib/jquery_alert/jquery.alerts.css"
	rel="stylesheet" type="text/css">
<script type="text/javascript">
	var submitS = '确定';
	var cancelC = '取消';
	var alertS = '确定';
	function confirmInfo() {
		jAlert('保存成功', alertS, function(r) {
			window.location.href = "<%=basePath%>/loginAction?method=main";
		});
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
		<%@ include file="../../common/header" %>
	</header>
	<!--▼▼▼search▼▼▼-->
	<div class="container-fluid search disabled">
		<div class="row-fluid"></div>
	</div>
	<!--▼▼▼contents(field type)▼▼▼-->
	<div class="main">
		<div class="banner">
			<span>订单信息</span>
		</div>
		<div class="content">
			<div style="margin: 10px 0; padding: 5px 20px;">
				<div class="edit-content"
					style="margin-bottom: 0px; border-top: 1px solid #0088CC; padding-top: 10px;">

					<table class="edit-table" style="width: 95%">
						<tbody>
							<tr>
								<td width="60%">
									<table>
										<tbody>
											<tr>
												<td class="right_align">合同号&nbsp;:&nbsp;</td>
												<td>
													<div style="margin-bottom: 8px;">
														<input class="input-xlarge" type="text" disabled
															style="margin-bottom: 0px; width: 120px;"
															value="<%=orderBean.getContract_no()%>"> － <input
															class="input-xlarge" type="text" disabled
															style="margin-bottom: 0px; width: 30px;" value="<%=orderBean.getOrders_version()%>">
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
																style="margin-bottom: 5px; width: 120px;" id="user_name"
																value="<%=orderBean.getAgency_user_nm()%>"></input></td>
															<td>&nbsp;&nbsp;&nbsp;&nbsp; <span>代理商&nbsp;:&nbsp;</span>
															</td>
															<td><input type="text" disabled
																style="margin-bottom: 5px; width: 200px"
																id="agency_name" value="<%=orderBean.getAgency_nm()%>"></input></td>
														</tr>
													</table>
											</tr>
											<tr>
												<td class="right_align">客户类别&nbsp;:&nbsp;</td>
												<td colspan="3"><input value="<%=orderBean.getCustomer_type() %>" type="text" disabled
													style="width: 60px;"></input></td>
											</tr>
											<tr>
												<td class="right_align">客户名称&nbsp;:&nbsp;</td>
												<td colspan="3">
													<div style="display: inline;">
														<input type="text" disabled style="width: 300px;"
															id="customer_name" value="<%=orderBean.getCustomer_nm() %>"></input>
													</div>
												</td>
											</tr>
											<tr>
												<td class="right_align">项目名称&nbsp;:&nbsp;</td>
												<td colspan="3"><input id="input01" disabled class=""
													type="text" style="margin-bottom: 5px; width: 300px;"
													value="<%=orderBean.getProject_nm() %>"></td>
											</tr>
											<tr>
												<td class="right_align">预计发货月&nbsp;:&nbsp;</td>
												<td colspan="3"><input id="test01" disabled class=""
													type="text" value="<%=orderBean.getExpected_send_month() %>"
													style="width: 70px; margin-bottom: 3px; ime-mode: disabled">
												</td>
											</tr>
											<tr>
												<td class="right_align">预计送电月&nbsp;:&nbsp;</td>
												<td><input id="test02" disabled class="" type="text"
													value="<%=orderBean.getExpected_energize_month() %>" 
													style="width: 70px; margin-bottom: 5px; ime-mode: disabled">
												</td>
												<td class="right_align">通电后保证月数&nbsp;:&nbsp;</td>
												<td><input type="text" disabled value="<%=orderBean.getShelf_months() %>"
													style="text-align: right; margin-bottom: 0; width: 60px;"></input>
												</td>
											</tr>
											<tr>

											</tr>
										</tbody>
									</table>
								</td>
								<td width="40%">
									<table style="margin-left: 30px;">
										<tbody>
											<tr>
												<td class="right_align">投标铜价&nbsp;:&nbsp;</td>
												<td><input type="text" disabled value="<%=orderBean.getBid_cu_price() %>"
													style="margin-bottom: 5px; width: 150px; text-align: right;"></td>
											</tr>
											<tr>
												<td class="right_align">金额(货币)&nbsp;:&nbsp;</td>
												<td><input type="text" disabled value="<%=orderBean.getBid_sum_money() %>"
													style="margin-bottom: 5px; width: 150px; text-align: right; ime-mode: disabled">
													<input type="text" disabled value="<%=orderBean.getCurrency_nm() %>"
													style="margin-bottom: 5px; width: 60px;"></input></td>
											</tr>
											<tr>
												<td colspan="2"><span>&nbsp;</span></td>
											</tr>
											<tr>
												<td class="right_align">合同总价&nbsp;:&nbsp;</td>
												<td><input id="input01" class="" disabled
													value="<%=orderBean.getContract_sum_money() %>" type="text"
													style="width: 150px; text-align: right; ime-mode: disabled">
												</td>
											</tr>
											<tr>
												<td class="right_align">佣金率&nbsp;:&nbsp;</td>
												<td><input type="text" disabled value="<%=orderBean.getProportion()*100 %>"
													style="margin-bottom: 5px; width: 50px; text-align: right; ime-mode: disabled">&nbsp;<label
													style="display: inline;">%</label></td>
											</tr>
											<tr>
												<td class="right_align">佣金金额&nbsp;:&nbsp;</td>
												<td><input type="text" disabled value="<%=orderBean.getCommission() %>"
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
					<table style="width: 70%">
						<tr>
							<td>
								<div>
									<span
										style="position: relative; left: 10px; top: 8px; font-size: 14px; background-color: #FFFFFF;">
										回款比例/预计回款月/预计回款金额&nbsp;:&nbsp; </span>
									<div
										style="padding: 20px 10px; height: 83px; margin-top: 0px; border: 1px solid #0088CC;">
										<table style="margin-left: 30px; width: 90%">
											<tr>
												<td><input id="input01" class="right_align" disabled
													value="<%=orderBean.getPayments_proportion1() %>" type="text"
													style="width: 45px; margin-bottom: 0; ime-mode: disabled">
													:&nbsp;&nbsp;
												<td><input id="input01" class="right_align" disabled
													value="<%=orderBean.getPayments_proportion2() %>" type="text"
													style="width: 45px; margin-bottom: 0; ime-mode: disabled">
													:&nbsp;
												<td><input id="input01" class="right_align" disabled
													value="<%=orderBean.getPayments_proportion3() %>" type="text"
													style="width: 45px; margin-bottom: 0; ime-mode: disabled">
													:&nbsp;&nbsp;
												<td><input id="input01" class="right_align" disabled
													value="<%=orderBean.getPayments_proportion4() %>" type="text"
													style="width: 45px; margin-bottom: 0; ime-mode: disabled">
													:&nbsp;&nbsp;
												<td><input id="input01" class="right_align" disabled
													value="<%=orderBean.getPayments_proportion5() %>" type="text"
													style="width: 45px; margin-bottom: 0; ime-mode: disabled">
													:&nbsp;&nbsp;
												<td><input id="input01" class="right_align" disabled
													value="<%=orderBean.getPayments_proportion6() %>" type="text"
													style="width: 45px; margin-bottom: 0; ime-mode: disabled">
											</tr>
											<tr>
												<td><input id="input01" class="" type="text" disabled
													value="<%=orderBean.getExpected_payments_date1() %>"
													style="margin-bottom: 0; width: 70px; ime-mode: disabled">
												<td><input id="input01" class="" type="text" disabled
													value="<%=orderBean.getExpected_payments_date2() %>"
													style="margin-bottom: 0; width: 70px; ime-mode: disabled">
												<td><input id="input01" class="" type="text" disabled
													value="<%=orderBean.getExpected_payments_date3() %>"
													style="margin-bottom: 0; width: 70px; ime-mode: disabled">
												<td><input id="input01" class="" type="text" disabled
													value="<%=orderBean.getExpected_payments_date4() %>"
													style="margin-bottom: 0; width: 70px; ime-mode: disabled">
												<td><input id="input01" class="" type="text" disabled
													value="<%=orderBean.getExpected_payments_date5() %>"
													style="margin-bottom: 0; width: 70px; ime-mode: disabled">
												<td><input id="input01" class="" type="text" disabled
													value="<%=orderBean.getExpected_payments_date6() %>"
													style="margin-bottom: 0; width: 70px; ime-mode: disabled">
											</tr>
											<tr>
												<td><input id="input01" class="right_align" disabled
													value="<%=orderBean.getExpected_payments_sum1() %>" type="text"
													style="width: 90px; ime-mode: disabled">
												<td><input id="input01" class="right_align" disabled
													value="<%=orderBean.getExpected_payments_sum2() %>" type="text"
													style="width: 90px; ime-mode: disabled">
												<td><input id="input01" class="right_align" disabled
													value="<%=orderBean.getExpected_payments_sum3() %>" type="text"
													style="width: 90px; ime-mode: disabled">
												<td><input id="input01" class="right_align" disabled
													value="<%=orderBean.getExpected_payments_sum4() %>" type="text"
													style="width: 90px; ime-mode: disabled">
												<td><input id="input01" class="right_align" disabled
													value="<%=orderBean.getExpected_payments_sum5() %>" type="text"
													style="width: 90px; ime-mode: disabled">
												<td><input id="input01" class="right_align" disabled
													value="<%=orderBean.getExpected_payments_sum6() %>" type="text"
													style="width: 90px; ime-mode: disabled">
											</tr>
										</table>
									</div>
								</div>
							</td>
						</tr>
					</table>
				</div>
				<div class="product-tab" style="margin-top: 10px;">
					<ul class="nav nav-tabs" style="width: 914px; margin-bottom: 0px;">
						<li class="active"><a id="li_1" href="#div_list_0"
							data-toggle="tab">电缆</a></li>
						<li class=""><a id="li_2" href="#div_list_1"
							data-toggle="tab">附件</a></li>
					</ul>
				</div>

				<div class="tab-content">
					<div class="div_list tab-pane active" id="div_list_0">
						<div class="" style="margin: auto; width: 860px;">
							<div class="" style="width: 855px;">
								<table class="table table-striped table-bordered table-title"
									style="background-color: #E4F4CB; margin-bottom: 0px;">
									<thead>
										<tr>
											<th style="width: 5%; height: 21px">序号</th>
											<th style="width: 12%;">规格型号</th>
											<th style="width: 10%">电压等级</th>
											<th style="width: 10%;">合同数量</th>
											<th style="width: 5%">单位</th>
											<th style="width: 10%;">合同单价</th>
											<th style="width: 20%;">金额</th>
											<th style="width: 30%">备注</th>
										</tr>
									</thead>
								</table>
							</div>
							<div
								style="overflow-y: auto; padding-right: 5px; height: 165px; width: 870px;">
								<div style="width: 855px;">
									<table id="product_list_table"
										class="table table-striped table-bordered table-body"
										style="background-color: #E4F4CB;">
										<tbody>
											<%int i1 = 1;
											for(OrderDetailBean orderDetailBean : orderBean.getOrder_detail_list()){ %>
											<%if(orderDetailBean.getProduct_category().equals("1")){ %>
											<tr>
												<td style="width: 5%;"><%=i1 %></td>
												<td style="width: 12%;"><%=orderDetailBean.getSpecification_type() %></td>
												<td style="width: 10%;"><%=orderDetailBean.getVoltage() %></td>
												<td style="width: 10%;" class="right_align"><%=orderDetailBean.getContract_quantity() %></td>
												<td style="width: 5%; text-align: center;" class="">米</td>
												<td style="width: 10%;" class="right_align"><%=orderDetailBean.getContract_unit_price() %></td>
												<td style="width: 20%;" class="right_align"><%=orderDetailBean.getContract_price() %></td>
												<td style="width: 30%;"><%=orderDetailBean.getRemark() %></td>
											</tr>
											<%i1++;}} %>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					<div class="div_list tab-pane" id="div_list_1">
						<div class="" style="margin: auto; width: 860px;">
							<div class="" style="width: 855px;">
								<table class="table table-striped table-bordered table-title"
									style="background-color: #E4F4CB; margin-bottom: 0px;">
									<thead>
										<tr>
											<th style="width: 5%; height: 21px">序号</th>
											<th style="width: 12%;">规格型号</th>
											<th style="width: 10%">电压等级</th>
											<th style="width: 10%;">合同数量</th>
											<th style="width: 5%;">单位</th>
											<th style="width: 10%;">合同单价</th>
											<th style="width: 20%;">金额</th>
											<th style="width: 30%">备注</th>
										</tr>
									</thead>
								</table>
							</div>
							<div
								style="overflow-y: auto; padding-right: 5px; height: 165px; width: 870px;">
								<div style="width: 855px;">
									<table id="product_list_table"
										class="table table-striped table-bordered table-body"
										style="background-color: #E4F4CB;">
										<tbody>
											<%int i2 = 1;
											for(OrderDetailBean orderDetailBean : orderBean.getOrder_detail_list()){ %>
											<%if(orderDetailBean.getProduct_category().equals("2")){ %>
											<tr>
												<td style="width: 5%;"><%=i2 %></td>
												<td style="width: 12%;"><%=orderDetailBean.getSpecification_type() %></td>
												<td style="width: 10%;"><%=orderDetailBean.getVoltage() %></td>
												<td style="width: 10%;" class="right_align"><%=orderDetailBean.getContract_quantity() %></td>
												<td style="width: 5%; text-align: center;" class="">项</td>
												<td style="width: 10%;" class="right_align"><%=orderDetailBean.getContract_unit_price() %></td>
												<td style="width: 20%;" class="right_align"><%=orderDetailBean.getContract_price() %></td>
												<td style="width: 30%;"><%=orderDetailBean.getRemark() %></td>
											</tr>
											<%i2++;}} %>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="bottom_block">
			<a class="btn btn-info btn-middle-aft" style=""
				href="orderSearch.jsp">返回</a>
		</div>
	</div>

</body>
</html>
