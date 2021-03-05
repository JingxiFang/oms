<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="sym.component.bean.OrderBean"%>
<%@page import="sym.component.bean.InvoiceBean"%>
<%@page import="sym.component.bean.OrderDetailBean"%>
<%@page import="sym.component.service.impl.InvoiceServiceImpl" %>
<%@page import="sym.component.service.InvoiceService" %>
<%@page import="sym.component.service.impl.OrderServiceImpl" %>
<%@page import="sym.component.service.OrderService" %>
<%@page import="sym.component.service.impl.OrderDetailServiceImpl" %>
<%@page import="sym.component.service.OrderDetailService" %>
<%
String path = request.getContextPath();

String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
<script type="text/javascript"
	src="../../../js/lib/jquery_plugin/ui/jquery-ui.js"></script>

<script type="text/javascript" src="../../../js/common/popup.js"></script>
<script src="../../../js/common/datepicker.js"></script>
<script type="text/javascript"
	src="../../../js/lib/jquery_alert/jquery.alerts.js"></script>
<script src="../../../js/MonthPicker/WdatePicker.js"></script>
<script type="text/javascript" src="../../../js/common/monthPicker.js"></script>
<script type="text/javascript"
	src="../../../js/component/invoiceInsert.js"></script>
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
<link href="../../../js/lib/jquery_alert/jquery.alerts.css"
	rel="stylesheet" type="text/css">
<link href="../../../css/common/common.css" rel="stylesheet"
	type="text/css">
<link href="../../../css/common/popup.css" rel="stylesheet"
	type="text/css">
<link href="../../../css/common/datepicker.css" rel="stylesheet">
<link href="../../../js/lib/jquery_alert/jquery.alerts.css"
	rel="stylesheet" type="text/css">
<link href="../../../css/common/monthPicker.css" rel="stylesheet"
	type="text/css">

<script type="text/javascript">
	function toInvoiceList(detailID){
		//alert(detailID);
		$.ajax({
				type : "post", 
				url : "<%=path%>/InvoiceAction", 
				transition : true,
				data : {
					"action":"getInvoiceList",
					"detailID":detailID
				}, 
				dataType : "text", 
				success : function(data) { 
					var json=JSON.parse(data);				
					 var tableBody = $("#invoiceListTab");
		             tableBody.empty();
		             $.each(json, function (index, item) {
		            	// alert(item.send_date);
		                  tableBody.append('<tr style="heght: 20px;" '+
		                  	'ondblclick="javascript:updateContract()"id="contract2">'+
							'<td width="25%" style="text-align: center">'+item.invoice_no+'</td>'+
							'<td width="13%" style="text-align: center;">'+item.send_date+'</td>'+
							'<td width="13%" style="text-align: center;">'+item.invoice_date+'</td>'+
							'<td width="10%" class="right_align">'+item.invoice_unit_price+'</td>'+
							'<td width="10%" class="right_align">'+item.invoice_quanitity+'</td>'+
							'<td width="15%" class="right_align">'+item.invoice_price+'</td>'+
							'<td width="14%" class="center_td">'+
							'<a class="icon icon-edit link-hand-dialog" '+
							'onclick="updateContract()">编辑</a>'+
							'&nbsp;&nbsp;&nbsp;'+
							'<a class="icon icon-remove" type="button" '+
							'onclick="deleteContract(this)">删除</a>'+
							'</td></tr>');
					              });
	    
				}
			});
	}
	function deleteContract(el){
		jConfirm('确认删除吗？', '确认对话框', function(r) {
			if (r == true) {
				var invoide_no=$(el).parent().parent().find("td").eq(0).text();
				//alert(invoide_no);
				$.ajax({
					type : "post", 
					url : "<%=path%>/InvoiceAction", 
					transition : true,
					data : {
						"action":"delete",
						"invoiceno":invoide_no
					}, 
					dataType : "text", 
					success : function(msg) { 
						//var json=JSON.parse(data);				
						//alert(msg);
						if(msg=="1"){
							$(el).parent().parent().remove();
						}
						else{
							alert("服务器请求失败!");
						}
					},
					error : function(msg) { //ajax请求失败后触发的方法
						alert("服务器请求失败!"); //弹出错误信息
					}
				}
				);
				
				
				
			}
		});
	}
	function updateContract(el) {
		$("#dialog_delivery_date").val($(el).parent().parent().find("td").eq(1).text());
		$("#dialog_invoice_date").val($(el).parent().parent().find("td").eq(2).text());
		$("#dialog_invoice_no").val($(el).parent().parent().find("td").eq(0).text());
		$("#dialog_invoice_sunprice").val($(el).parent().parent().find("td").eq(5).text());
		$("#dialog_invoice_quanitity").val($(el).parent().parent().find("td").eq(4).text());
		$("#dialog_invoice_unit_price").val($(el).parent().parent().find("td").eq(3).text());
		$("#invoiceID").val($(el).parent().parent().find("td").eq(7).find("input").val());
		openEditPop(el);
		
	}
	function openEditPop(el){
		
		var param = {
				height:340,
				width:600,
				title : "编辑 ",
				modal:true,
				focus:function() {
					$('#test03').DatePickerHide();
				},
				buttons : [{
					text : '编辑 ',
					click : function() {
						var dialog_invoice_no=$("#dialog_invoice_no").val();
						if(dialog_invoice_no.length == 0){
				 			alert("发票号不能为空");
				 			return ;
				 		}else if (!/^[\da-z]+$/i.test(dialog_invoice_no)) {
				 			alert("请输入半角英数字");
							return ;
						} else if (dialog_invoice_no.length > 20) {
							alert("发票号最最长为20");
							return ;
						}
						var dialog_delivery_date=$("#dialog_delivery_date").val();
						if(dialog_delivery_date.match(/^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/) == null){
							alert("请输入yyyy-MM-dd格式的日期");
							return;
						}
						var dialog_invoice_date=$("#dialog_invoice_date").val();
						if(dialog_invoice_date.match(/^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/) == null){
							alert("请输入yyyy-MM-dd格式的日期");
							return;
						}
						var dialog_invoice_sunprice =$("#dialog_invoice_sunprice").val();
						if (!/^\d{1,11}\.\d{1,2}?$/.test(dialog_invoice_sunprice)) {
							alert("请输入小数点前不超过11位数，后不超过2位数的数字");
							return ;
						}
						var dialog_invoice_unit_price=$("#dialog_invoice_unit_price").val();
						if (!/^\d{1,11}\.\d{1,2}?$/.test(dialog_invoice_unit_price)) {
							alert("请输入小数点前不超过11位数，后不超过2位数的数字");
							return ;
						}
						var dialog_invoice_quanitity=$("#dialog_invoice_quanitity").val();
						if (!/^\d{1,11}\.\d{1,2}?$/.test(dialog_invoice_quanitity)) {
							alert("请输入小数点前不超过11位数，后不超过2位数的数字");
							return ;
						}
						$.ajax({
							type : "post", 
							url : "<%=path%>/InvoiceAction?action=update", 
							transition : true,
							data : $('#dialog').serialize(),
							dataType : "text", 
							success : function(msg) { 
								if(msg=="1"){
									$(el).parent().parent().find("td").eq(1).text( $("#dialog_delivery_date").val());
									$(el).parent().parent().find("td").eq(2).text($("#dialog_invoice_date").val());
									$(el).parent().parent().find("td").eq(0).text($("#dialog_invoice_no").val());
									$(el).parent().parent().find("td").eq(5).text($("#dialog_invoice_sunprice").val());
									$(el).parent().parent().find("td").eq(4).text($("#dialog_invoice_quanitity").val());
									$(el).parent().parent().find("td").eq(3).text($("#dialog_invoice_unit_price").val());
									
									alert("修改成功");
									
								}
								else{
									alert("服务器请求失败!");
								}
							},
							error : function(msg) { //ajax请求失败后触发的方法
								alert("服务器请求失败!"); //弹出错误信息
							}
						}
					);
				$(this).dialog('close');
							
				},
				'class' : 'btn btn-primary btn-middle'
				},
				{
					text : '取消',
					click : function() {
							$(this).dialog('close');
					},
					'class': 'btn btn-inverse btn-middle-aft'
				}
			]
		}
		openPop('product_dialog',param);
	}
	
	function confirmInfo(){
		var date_power=$("#date_power").val();
		if(date_power.match(/^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/) == null){
			alert("请输入yyyy-MM-dd格式的日期");
			return;
		}
		var cno=$("#contract_no").val();
		var vno=$("#orders_version").val()
		$.ajax({
			type : "post", 
			url : '<%=path%>/InvoiceAction?action=save&contract_no='+cno+'&orders_version='+vno, 
			transition : true,
			data : $('#contentForm').serialize(),
			dataType : "text", 
			success : function(msg) { 
				if(msg=="1"){
					
					jAlert('保存成功', alertS, function(r) {});
					
				}
				else{
					alert("服务器请求失败!");
				}
			},
			error : function(msg) { //ajax请求失败后触发的方法
				alert("服务器请求失败!"); //弹出错误信息
			}
		});
		
		
	}
	//发票号是否已经存在
	function isExist(){
		var dialog_invoice_no=$("#dialog_invoice_no").val();
		if(dialog_invoice_no.length == 0){
 			alert("发票号不能为空");
 			return ;
 		}else if (!/^[\da-z]+$/i.test(dialog_invoice_no)) {
 			alert("请输入半角英数字");
			return ;
		} else if (dialog_invoice_no.length > 20) {
			alert("发票号最最长为20");
			return ;
		}
		$.ajax({
			type : "post", 
			url : '<%=path%>/InvoiceAction?action=isExist', 
			transition : true,
			data : {
				"invoiceNo":dialog_invoice_no
			},
			dataType : "text", 
			success : function(msg) { 
				if(msg=="1"){
					
					alert("发票编号已经存在");
					
				}
			},
			error : function(msg) { //ajax请求失败后触发的方法
				alert("服务器请求失败!"); //弹出错误信息
			}
		});
	}
</script>

</head>
<body>
	<!--▼▼▼header▼▼▼-->
	<header>
		<div class="navbar navbar-inverse">
			<div class="navbar-inner">
				<div class="container">
					<button data-target=".nav-collapse" data-toggle="collapse"
						class="btn btn-navbar" type="button">
						<span class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
					<!--logo-->
					<ul class="nav nav-pills logo">
						<li><a class="logo" href="../../menu/mainMenuG.html"
							style="padding: 0px;"> <img alt=""
								src="../../../images/logo.png"> <span
								style="padding-left: 10px; padding-top: 10px; padding-bottom: 5px; color: #EEEEEE; font-size: 23px; font-weight: bold; vertical-align: middle;">订单管理系统</span>
						</a></li>
					</ul>
					<!--navi-->
					<div class="nav-collapse collapse">
						<ul class="nav pull-right user">
							<li class="dropdown"><a data-toggle="dropdown"
								class="dropdown-toggle" href="#"> <i
									class="icon-user icon-white unit"></i>${dto.user_nm }<b class="caret"></b>
							</a>
								<ul class="dropdown-menu" style="z-index: 1000000;">
									<li><a href="../../common/resetPassword.jsp">修改密码</a></li>
									<li class="divider"></li>
									<li><a href="../../login.jsp">退出系统</a></li>
								</ul></li>
							<li class="" style="border-left-width: 0px;"><a class=""
								style="border-left-width: 0px;" data-toggle="dropdown" href="#">
							${ dto.user_owner_flg eq 'M' ?' <span class="label label-info" style="background:#4f81bd;padding: 3px 4px;width:30px;height: 14px;text-align:center;border-radius:10px;font-size: 13px;">管理</span>':(dto.user_owner_flg eq 'S' ?'<span class="label label-success" style="background:#9bbb59;padding: 3px 4px;width:30px;height: 14px;text-align:center;border-radius:10px;font-size: 13px;">业务</span>':'<span class="label label-warning" style="background:#f79646;padding: 3px 4px;width:30px;height: 14px;text-align:center;border-radius:10px;font-size: 13px;">财务</span>')}
					</a></li>
						</ul>
						<ul class="nav pull-right navi">
							<li class=""><a href="../../menu/mainMenuG.jsp">返回主菜单</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</header>
	<!--▼▼▼search▼▼▼-->
	<div class="container-fluid search disabled">
		<div class="row-fluid"></div>
	</div>
	<!--▼▼▼contents(field type)▼▼▼-->
	<div class="main">
		<div class="banner">
			<span>发票登记</span>
		</div>
		
		<%
			// 获取界面中合同号
	  		String contract_num = request.getParameter("contract_num");
			
			// 将参数放到hm_order中
			HashMap<String, String> hm = new HashMap<String, String>();
			hm.put("contract_num", contract_num);
			
			OrderService orderService=new OrderServiceImpl();
			List<OrderBean> orderList = orderService.getOrderInfoList(hm);
			OrderBean orderInfo=new OrderBean();
			if(orderList.size()>0){
				orderInfo=(OrderBean)orderList.get(0);
			}
			
		%>
		<div class="content">
			<div style="margin: 10px 0; padding: 5px 20px;">
			<form name="contentForm" id="contentForm">
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
														<input class="input-xlarge" type="text" disabled  id="contract_no" name="contract_no"
															style="margin-bottom: 0px; width: 120px;"
															value="<%=orderInfo.getContract_no()%>"> － 
															<input id="orders_version" name="orders_version"
															class="input-xlarge" type="text" disabled
															style="margin-bottom: 0px; width: 30px;" value="<%=orderInfo.getOrders_version()%>">
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
																value="<%=orderInfo.getAgency_user_nm()%>"></input></td>
															<td>&nbsp;&nbsp;&nbsp;&nbsp; <span>代理商&nbsp;:&nbsp;</span>
															</td>
															<td><input type="text" disabled
																style="margin-bottom: 5px; width: 200px"
																id="agency_name" value="<%=orderInfo.getAgency_nm()%>"></input></td>
														</tr>
													</table>
											</tr>
											<tr>
												<td class="right_align">客户类别&nbsp;:&nbsp;</td>
												<td colspan="3"><input 
													value="<%=orderInfo.getCustomer_type()=="1"?"国网":orderInfo.getCustomer_type()=="2"?"南网":orderInfo.getCustomer_type()=="3"?"海外":"地方" %>" 
													type="text" disabled
													style="width: 60px;"></input></td>
											</tr>
											<tr>
												<td class="right_align">客户名称&nbsp;:&nbsp;</td>
												<td colspan="3">
													<div style="display: inline;">
														<input type="text" disabled style="width: 300px;"
															id="customer_name" value="<%=orderInfo.getCustomer_nm()%>"></input>
													</div>
												</td>
											</tr>
											<tr>
												<td class="right_align">项目名称&nbsp;:&nbsp;</td>
												<td colspan="3"><input id="input01" disabled class=""
													type="text" style="margin-bottom: 5px; width: 300px;"
													value="<%=orderInfo.getProject_nm()%>"></td>
											</tr>
											<tr>
												<td class="right_align">预计发货月&nbsp;:&nbsp;</td>
												<td colspan="3"><input id="test01" disabled class=""
													type="text" value="<%=orderInfo.getExpected_send_month()%>"
													style="width: 70px; margin-bottom: 3px; ime-mode: disabled">
												</td>
											</tr>
											<tr>
												<td class="right_align">预计送电月&nbsp;:&nbsp;</td>
												<td><input id="test02" disabled value="<%=orderInfo.getExpected_energize_month() %>" class=""
													type="text"
													style="width: 70px; margin-bottom: 5px; ime-mode: disabled">
												</td>
												<td class="right_align">通电后保证月数&nbsp;:&nbsp;</td>
												<td><input type="text" disabled value="<%=orderInfo.getShelf_months()%>"
													style="text-align: right; margin-bottom: 0; width: 60px;"></input>
												</td>
											</tr>
											<tr>
												<td class="right_align">送电日期&nbsp;:&nbsp;</td>
												<td colspan="3"><input id="date_power" name="date_power" type="text" 
													style="width: 80px; margin-bottom: 3px"></td>
											</tr>
										</tbody>
									</table>
								</td>
								<td width="40%">
									<table style="margin-left: 30px;">
										<tbody>
											<tr>
												<td class="right_align">投标铜价&nbsp;:&nbsp;</td>
												<td><input type="text" disabled value="<%=orderInfo.getBid_cu_price()%>"
													style="margin-bottom: 5px; width: 150px; text-align: right;"></td>
											</tr>
											<tr>
												<td class="right_align">金额(货币)&nbsp;:&nbsp;</td>
												<td><input type="text" disabled value="<%=orderInfo.getBid_sum_money()%>"
													style="margin-bottom: 5px; width: 150px; text-align: right; ime-mode: disabled">
													<input type="text" disabled value="<%=orderInfo.getCurrency_cd()%>"
													style="margin-bottom: 5px; width: 60px;"></input></td>
											</tr>
											<tr>
												<td colspan="2"><span>&nbsp;</span></td>
											</tr>
											<tr>
												<td class="right_align">合同总价&nbsp;:&nbsp;</td>
												<td><input id="input01" class="" disabled
													value="<%=orderInfo.getContract_sum_money()%>" type="text"
													style="width: 150px; text-align: right; ime-mode: disabled">
												</td>
											</tr>
											<tr>
												<td class="right_align">佣金率&nbsp;:&nbsp;</td>
												<td><input type="text" disabled 
													value="<%=orderInfo.getProportion()%>"
													style="margin-bottom: 5px; width: 50px; text-align: right; ime-mode: disabled">&nbsp;<label
													style="display: inline;">%</label></td>
											</tr>
											<tr>
												<td class="right_align">佣金金额&nbsp;:&nbsp;</td>
												<td><input type="text" disabled 
													value="<%=orderInfo.getCommission()%>"
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
												<td><input id="payments_proportion1" name="payments_proportion1" class="right_align" disabled 
													value="<%=orderInfo.getPayments_proportion1()%>" type="text"
													style="width: 45px; margin-bottom: 0; ime-mode: disabled">
													:&nbsp;&nbsp;
												<td><input id="payments_proportion2" name="payments_proportion2" class="right_align" disabled
													value="<%=orderInfo.getPayments_proportion2()%>" type="text"
													style="width: 45px; margin-bottom: 0; ime-mode: disabled">
													:&nbsp;
												<td><input id="payments_proportion3" name="payments_proportion3" class="right_align" disabled
													value="<%=orderInfo.getPayments_proportion3()%>" type="text"
													style="width: 45px; margin-bottom: 0; ime-mode: disabled">
													:&nbsp;&nbsp;
												<td><input id="payments_proportion4" name="payments_proportion4" class="right_align" disabled
													value="<%=orderInfo.getPayments_proportion4()%>" type="text"
													style="width: 45px; margin-bottom: 0; ime-mode: disabled">
													:&nbsp;&nbsp;
												<td><input id="payments_proportion5" name="payments_proportion5" class="right_align" disabled
													value="<%=orderInfo.getPayments_proportion5()%>" type="text"
													style="width: 45px; margin-bottom: 0; ime-mode: disabled">
													:&nbsp;&nbsp;
												<td><input id="payments_proportion6" name="payments_proportion6" class="right_align" disabled
													value="<%=orderInfo.getPayments_proportion6()%>" type="text"
													style="width: 45px; margin-bottom: 0; ime-mode: disabled">
											</tr>
											<tr>
												<td><input id="expected_payments_date1" name="expected_payments_date1" class="" type="text" disabled
													value="<%=orderInfo.getExpected_payments_date1()%>"
													style="margin-bottom: 0; width: 70px; ime-mode: disabled">
												<td><input id="expected_payments_date2" name="expected_payments_date2"  class="" type="text" 
													value="<%=orderInfo.getExpected_payments_date2()%>"
													style="margin-bottom: 0; width: 70px;">
												<td><input  id="expected_payments_date3" name="expected_payments_date3"  class="" type="text"  
													value="<%=orderInfo.getExpected_payments_date3()%>"
													style="margin-bottom: 0; width: 70px;  ">
												<td><input  id="expected_payments_date4" name="expected_payments_date4"  class="" type="text"  
													value="<%=orderInfo.getExpected_payments_date4()%>"
													style="margin-bottom: 0; width: 70px;  ">
												<td><input  id="expected_payments_date5" name="expected_payments_date5" class="" type="text"  
													value="<%=orderInfo.getExpected_payments_date5()%>"
													style="margin-bottom: 0; width: 70px;  ">
												<td><input  id="expected_payments_date6" name="expected_payments_date6" class="" type="text"  
													value="<%=orderInfo.getExpected_payments_date6()%>"
													style="margin-bottom: 0; width: 70px;  ">
											</tr>
											<tr>
												<td><input id="expected_payments_sum1" name="expected_payments_sum1"  class="right_align" disabled
													value="<%=orderInfo.getExpected_payments_sum1()%>" type="text"
													style="width: 90px; ime-mode: disabled">
												<td><input id="expected_payments_sum2" name="expected_payments_sum2"  class="right_align"  
													value="<%=orderInfo.getExpected_payments_sum2()%>" type="text"
													style="width: 90px;  ">
												<td><input id="expected_payments_sum3" name="expected_payments_sum3"  class="right_align"  
													value="<%=orderInfo.getExpected_payments_sum3()%>" type="text"
													style="width: 90px;  ">
												<td><input id="expected_payments_sum4" name="expected_payments_sum4"  class="right_align"  
													value="<%=orderInfo.getExpected_payments_sum4()%>" type="text"
													style="width: 90px;  ">
												<td><input id="expected_payments_sum5" name="expected_payments_sum5"  class="right_align"  
													value="<%=orderInfo.getExpected_payments_sum5()%>" type="text"
													style="width: 90px;  ">
												<td><input id="expected_payments_sum6" name="expected_payments_sum6"  class="right_align" 
													value="<%=orderInfo.getExpected_payments_sum6()%>" type="text"
													style="width: 90px;  ">
											</tr>
										</table>
									</div>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</form>
				
				<div
					style="padding: 0px 10px 10px; width: 900px; margin: 20px auto 0;"
					class="div_table">
					<div class="" style="width: 870px;">
						<table class="table table-striped table-bordered table-title"
							style="background-color: #E4F4CB; margin-bottom: 0px;">
							<thead>
								<tr>
									<th width="10%">序号</th>
									<th width="10%">种类</th>
									<th width="20%">规格型号</th>
									<th width="20%">电压等级</th>
									<th width="10%">数量</th>
									<th width="5%">单位</th>
									<th width="10%">合同单价</th>
									<th width="15%">金额</th>
								</tr>
							</thead>
						</table>
					</div>
					<div
						style="overflow-y: auto; padding-right: 5px; height: 165px; width: 880px;">
						<div style="width: 870px;">
							<table id="product_table_1" class="table table-striped table-bordered table-body" 
							style="background-color: #E4F4CB;">
								<%
								OrderDetailService orderDetailService=new OrderDetailServiceImpl();
								List<OrderDetailBean> orderDetail=orderDetailService.getOrderDetailByContactNO(contract_num);
								if(orderDetail.size()>0)
								//1电线 2附件
								for(int i=0;i<orderDetail.size();i++){%>
									
									<tr onclick="javascript:toInvoiceList(<%=orderDetail.get(i).getOrder_detail_id() %>);" >
									<td width="10%"><%=i+1 %></td>
									<td width="10%"><%=(orderDetail.get(i).getProduct_category().equals("1")?"电线":"附件") %></td>
									<td width="20%"><%=orderDetail.get(i).getSpecification_type() %></td>
									<td width="20%"><%=orderDetail.get(i).getVoltage() %></td>
									<td width="10%" class="right_align"><%=orderDetail.get(i).getContract_quantity() %></td>
									<td width="5%" class="right_align"><%=(orderDetail.get(i).getProduct_category().equals("1")?"米":"项") %></td>
									<td width="10%" class="right_align"><%=orderDetail.get(i).getContract_unit_price()%></td>
									<td width="15%" class="right_align"><%=orderDetail.get(i).getContract_price()%></td>
								
									</tr>
									
							  <%}%>
							</table>
						</div>
					</div>
				</div>
				<!-- div-table -->
				<div id="product_manage"
					style="padding-top: 20px; border-top: 1px solid #0088CC;">
					<div class="div_table" style="width: 900px;; margin: 0 auto;">
						<div>
							<div id="" style="float: right;">
								<a id="addProduct" class="icon icon-add"
									href="javascript:void(0);" title="" style="margin-right: 30px">增加</a>
							</div>
							<div style="clear: both;"></div>
						</div>
						<div class="" style="width: 870px;">
							<table class="table table-striped table-bordered table-title"
								style="background-color: #E4F4CB; margin-bottom: 0px;">
								<thead>
									<tr>
										<th width="25%">发票 本/号</th>
										<th width="13%" style="height: 21px;">发货日期</th>
										<th width="13%">发票日期</th>
										<th width="10%">发票单价</th>
										<th width="10%">开票数量</th>
										<th width="15%">发票金额</th>
										<th width="14%"></th>
									</tr>
								</thead>
							</table>
						</div>
						<div
							style="overflow-y: auto; padding-right: 5px; height: 185px; width: 890px;">
							<div style="width: 870px;">
								<table id="product_table" 
									class="table table-striped table-bordered table-body">
									<tbody id="invoiceListTab">
									
									<%
									if(orderDetail.size()>0){
										int OrderDetail_ID=orderDetail.get(0).getOrder_detail_id() ;
										//System.out.print(OrderDetail_ID);
										InvoiceService invoiceService=new InvoiceServiceImpl();
										List<InvoiceBean> invoiceList= invoiceService.getInvoiceInfoByOrderDetailId(OrderDetail_ID);
										for(int i=0;i<invoiceList.size();i++){%>
											<tr style="heght: 20px;" ondblclick="updateContract(this)"
													id="contract1">
													
													<td width="25%" style="text-align: center"><%=invoiceList.get(i).getInvoice_no() %></td>
													<td width="13%" style="text-align: center;"><%=invoiceList.get(i).getSend_date() %></td>
													<td width="13%" style="text-align: center;"><%=invoiceList.get(i).getInvoice_date()%></td>
													<td width="10%" class="right_align"><%=invoiceList.get(i).getInvoice_unit_price()%></td>
													<td width="10%" class="right_align"><%=invoiceList.get(i).getInvoice_quanitity()%></td>
													<td width="15%" class="right_align"><%=invoiceList.get(i).getInvoice_price()%></td>
													
													
													
													<td width="14%" class="center_td"><a
														class="icon icon-edit link-hand-dialog" id="update_btn_row"
														onclick="updateContract(this)">编辑</a>&nbsp;&nbsp;&nbsp;<a
														class="icon icon-remove" type="button"
														onclick="deleteContract(this)">删除</a></td>
												
												<td width="0%" class="right_align"><input type="hidden" value="<%=invoiceList.get(i).getInvoice_id()%>"</td>
											</tr>	
										<% }}%>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
		<!-- content -->

		<div class="bottom_block">
			<a class="btn btn-primary btn-middle" style=""
				onclick="confirmInfo();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;保存&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
			<a class="btn btn-info btn-middle-aft" style=""
				href="#" onclick="javascript:history.back(-1);">返回</a>
		</div>
	</div>
	<div id="product_dialog" style="display: none;">
		<table class="table-edit table-striped table-bordered table-body"
			style="width: 870px; border-top-width: 1px;" >
			<form name="dialog" id="dialog">
			<tbody>
				<tr>
					<td class="right_align">发票 本/号&nbsp;:&nbsp;</td>
					<td><input type="text" class="must right_align" 
						style="width: 180px;" id="dialog_invoice_no" name="dialog_invoice_no"></td>
				</tr>
				<tr>
					<td width="20%" class="right_align">发货日期&nbsp;:&nbsp;</td>
					<td width="80%"><input type="text" class="must"
						style="width: 80px;" id="dialog_delivery_date" name="dialog_delivery_date"></td>
				</tr>
				<tr>
					<td class="right_align">发票日期&nbsp;:&nbsp;</td>
					<td><input type="text" class="must" style="width: 80px;"
						id="dialog_invoice_date" name="dialog_invoice_date"></td>
				</tr>
				<tr>
					<td class="right_align">发票单价&nbsp;:&nbsp;</td>
					<td><input type="text" class="must right_align"
						style="width: 180px;" id="dialog_invoice_unit_price"name="dialog_invoice_unit_price"></td>
				</tr>
				<tr>
					<td class="right_align">开票数量&nbsp;:&nbsp;</td>
					<td><input type="text" class="must right_align"
						style="width: 180px;" id="dialog_invoice_quanitity" name="dialog_invoice_quanitity"></td>
				</tr>
				<tr>
					<td class="right_align">发票金额&nbsp;:&nbsp;</td>
					<td><input type="text" class="must right_align"
						style="width: 180px;" id="dialog_invoice_sunprice"name="dialog_invoice_sunprice" ></td>
				</tr>
			</tbody>
			<input type="hidden" name="invoiceID" id="invoiceID" value=""/>
			</form>
		</table>
		
	</div>



	<div id="dateSelectPop" style="display: none">
		<div class="modal-body">
			<table
				style="background: none repeat scroll 0% 0% rgb(234, 247, 239); width: 100%;">
				<tr>
					<td>
						<div>
							<table style="width: 100%; text-align: center;"
								class="sel_table_year">
								<tr>
									<td id="year_back" style="cursor: pointer;"><span>&lt;</span></td>
									<td id="year_next" style="cursor: pointer;"><span>&gt;</span></td>
								</tr>
								<tr>
									<td><div id="sel_year1" class="p_sel_year"></div></td>
									<td><div id="sel_year6" class="p_sel_year"></div></td>
								</tr>
								<tr>
									<td><div id="sel_year2" class="p_sel_year"></div></td>
									<td><div id="sel_year7" class="p_sel_year"></div></td>
								</tr>
								<tr>
									<td><div id="sel_year3" class="p_sel_year"></div></td>
									<td><div id="sel_year8" class="p_sel_year"></div></td>
								</tr>
								<tr>
									<td><div id="sel_year4" class="p_sel_year"></div></td>
									<td><div id="sel_year9" class="p_sel_year"></div></td>
								</tr>
								<tr>
									<td><div id="sel_year5" class="p_sel_year"></div></td>
									<td><div id="sel_year10" class="p_sel_year"></div></td>
								</tr>
							</table>
						</div>
					</td>
					<td style="background-color: rgb(0, 143, 32); margin-right: 5px;">
					</td>
					<td>
						<div>
							<table style="width: 100%; text-align: center;"
								class="sel_table_month">
								<tr>
									<td><div id="sel_month1" class="p_sel_month">
											01<span class="sel_month_unit">月</span>
										</div></td>
									<td><div id="sel_month7" class="p_sel_month">
											07<span class="sel_month_unit">月</span>
										</div></td>
								</tr>
								<tr>
									<td><div id="sel_month2" class="p_sel_month">
											02<span class="sel_month_unit">月</span>
										</div></td>
									<td><div id="sel_month8" class="p_sel_month">
											08<span class="sel_month_unit">月</span>
										</div></td>
								</tr>
								<tr>
									<td><div id="sel_month3" class="p_sel_month">
											03<span class="sel_month_unit">月</span>
										</div></td>
									<td><div id="sel_month9" class="p_sel_month">
											09<span class="sel_month_unit">月</span>
										</div></td>
								</tr>
								<tr>
									<td><div id="sel_month4" class="p_sel_month">
											04<span class="sel_month_unit">月</span>
										</div></td>
									<td><div id="sel_month10" class="p_sel_month">
											10<span class="sel_month_unit">月</span>
										</div></td>
								</tr>
								<tr>
									<td><div id="sel_month5" class="p_sel_month">
											05<span class="sel_month_unit">月</span>
										</div></td>
									<td><div id="sel_month11" class="p_sel_month">
											11<span class="sel_month_unit">月</span>
										</div></td>
								</tr>
								<tr>
									<td><div id="sel_month6" class="p_sel_month">
											06<span class="sel_month_unit">月</span>
										</div></td>
									<td><div id="sel_month12" class="p_sel_month">
											12<span class="sel_month_unit">月</span>
										</div></td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>


</body>
</html>
