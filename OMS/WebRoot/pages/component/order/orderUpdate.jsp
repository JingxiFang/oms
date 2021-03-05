<%@page import="sym.admin.service.impl.AdminCurrencyServiceImpl"%>
<%@page import="sym.admin.service.AdminCurrencyService"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="sym.component.bean.OrderDetailBean"%>
<%@page import="sym.component.bean.OrderBean"%>
<%@page import="sym.component.service.impl.OrderServiceImpl"%>
<%@page import="sym.component.service.OrderService"%>
<%@page import="sym.common.dto.SessionDto"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	int orders_id = Integer.parseInt(request.getParameter("orders_id"));
	OrderService orderService = new OrderServiceImpl();
	OrderBean orderBean = orderService.showOrderById(orders_id);
	SessionDto dto = (SessionDto) session.getAttribute("dto");
	AdminCurrencyService adminCurrencyService = new AdminCurrencyServiceImpl();
	Map<String, String> currency_map = adminCurrencyService.getAllCurrencyValid();
	String user_owner_flg = dto.getUser_owner_flg();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!--[if lt IE 7]><html class="ie6 ie"><![endif]-->
<!--[if IE 7]><html class="ie7 ie"><![endif]-->
<!--[if IE 8]><html class="ie8 ie"><![endif]-->
<!--[if gt IE 8]><!-->
<html lang="ja" class="">
<!--<![endif]-->
<head>
<!--script frontend-->
<script type="text/javascript"
	src="../../../js/lib/jquery/jquery.min.js"></script>
<script type="text/javascript"
	src="../../../js/lib/jquery_plugin/bs/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="../../../js/lib/jquery_plugin/placeholder/jquery.placeholder.js"></script>
<script src="../../../js/MonthPicker/WdatePicker.js"></script>
<script type="text/javascript"
	src="../../../js/lib/jquery_plugin/ui/jquery-ui.js"></script>
<script type="text/javascript" src="../../../js/common/popup.js"></script>
<script type="text/javascript"
	src="../../../js/lib/jquery_alert/jquery.alerts.js"></script>
<script type="text/javascript" charset="utf-8"
	src="../../../js/common/monthPicker.js"></script>
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
<link href="../../../css/common/datepicker.css" rel="stylesheet">
<link href="../../../css/common/popup.css" rel="stylesheet"
	type="text/css">
<link href="../../../js/lib/jquery_alert/jquery.alerts.css"
	rel="stylesheet" type="text/css">
<link href="../../../css/common/monthPicker.css" rel="stylesheet"
	type="text/css">

<script type="text/javascript">
	var submitS = '确定';
	var cancelC = '取消';
	var cp_agency_users = 1; //user当前页码
	var tp_agency_users = 1; //user总页数
	var cp_agencys = 1; //agency当前页码
	var tp_agencys = 1; //agency总页数
	var cp_customers = 1; //customer当前页码
	var tp_customers = 1; //customer总页数

	var agency_user_condition = "";
	var customer_condition = "";
	var agency_condition = "";
	var select_user_id;
	var select_user_nm;
	var select_agency_id;
	var select_agency_nm;
	var select_customer_id;
	var select_customer_nm;
	var customer_type;
	var flag = true;
	var order_detail_flag1 = false;
	var order_detail_flag2 = false;
	var order_detail_flag_valid = false;
	function formatCurrency(num) {
		num = num.toString().replace(/\$|\,/g, '');
		if (isNaN(num))
			num = "0";
		sign = (num == (num = Math.abs(num)));
		num = Math.floor(num * 100 + 0.50000000001);
		cents = num % 100;
		num = Math.floor(num / 100).toString();
		if (cents < 10)
			cents = "0" + cents;
		for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
			num.substring(num.length - (4 * i + 3));
		return (((sign) ? '' : '-') + num + '.' + cents);
	}
	$(function() {
		select_user_id = $("#agency_user_cd").val();
		select_user_nm = $("#agency_user_nm").val();
		customer_type = "<%=orderBean.getCustomer_type()%>";
		var currency_cd = "<%=orderBean.getCurrency_cd()%>";
		getAgencysTbody();
		getAgencyUsersTbody();
		getCustomersTbody();
		$("#customer_type").val(customer_type);
		$("#currency").val(currency_cd);

		$(document).on('change', '#customer_type', function(e) {
			customer_type = $(this).val();
			$("#customer_nm").val("");
			$("#customer_cd").val("");
		});

		$(document).on('click', '.user_page_num', function(e) {
			var text = $(this).text();
			$(this).parent().parent().children().removeClass("active");
			if (text == "«" && cp_agency_users != 1) {
				cp_agency_users--;
			} else if (text == "»" && cp_agency_users != tp_agency_users) {
				cp_agency_users++;
			} else if (text != "«" && text != "»") {
				cp_agency_users = text;
			}
			getAgencyUsersTbody();
		});

		$(document).on('click', '.agency_page_num', function(e) {
			var text = $(this).text();
			$(this).parent().parent().children().removeClass("active");
			if (text == "«" && cp_agencys != 1) {
				cp_agencys--;
			} else if (text == "»" && cp_agencys != tp_agencys) {
				cp_agencys++;
			} else if (text != "«" && text != "»") {
				cp_agencys = text;
			}
			getAgencysTbody();
		});

		$(document).on('click', '.customer_page_num', function(e) {
			var text = $(this).text();
			$(this).parent().parent().children().removeClass("active");
			if (text == "«" && cp_customers != 1) {
				cp_customers--;
			} else if (text == "»" && cp_customers != tp_customers) {
				cp_customers++;
			} else if (text != "«" && text != "»") {
				cp_customers = text;
			}
			getCustomersTbody();
		});

		$(document).on('blur', '#proportion', function(e) {
			var proportion = $(this).val();
			var contract_sum_money = $("#contract_sum_money").val();
			$("#commission").val(formatCurrency(contract_sum_money * proportion / 100));
		});

		$(document).on('click', '.sort', function(e) {
			if ($(this).find('span')[0] == null) {
				flag = false;
			}
			$('.caret').remove();
			var sor = $('<span class="' + (flag ? 'caret up' : 'caret') + '"></span>')
			$(this).append(sor);
			flag = !flag;
		});
		$(document).on('focus', '.Wdate', function(e) {
			WdatePicker({
				lang : 'CN',
				skin : 'whyGreen',
				dateFmt : 'yyyy/MM'
			});
		});

		$(document).on('click', '#agency_clear', function(e) {
			clearAgency();
		});

		$('#agency_search').on('click', function(e) {
			if (select_user_nm == "") {
				alert("请先选择业务员!")
			} else {
				$("#agency_dialog_user_name").html(select_user_nm);
				var param = {
					width : 600,
					height : 500,
					title : "选择代理商",
					modal : true,
					buttons : [ {
						text : '选择',
						width : '74px',
						click : function() {
							chooseAgency();
							$(this).dialog('close');
						},
						'class' : 'btn btn-primary btn-middle'
					},
						{
							text : '取消',
							click : function() {
								$(this).dialog('close');
							},
							'class' : 'btn btn-inverse btn-middle btn-aft-middle'
						}
					]
				};
				openPop('agency_dialog', param);
				getAgencysTbody();
			}

		});

		$('#user_search').on('click', function(e) {
			var param = {
				width : 620,
				height : 520,
				title : "选择负责人",
				modal : true,
				buttons : [ {
					text : '选择',
					width : '74px',
					click : function() {
						chooseUser();
						$(this).dialog('close');
					},
					'class' : 'btn btn-primary btn-middle'
				},
					{
						text : '取消',
						click : function() {
							$(this).dialog('close');
						},
						'class' : 'btn btn-inverse btn-middle btn-aft-middle'
					}
				]
			};
			openPop('user_dialog', param);
		});

		$('#customer_search').on('click', function(e) {
			$("#dialog_customer_type").html(customer_type);
			var param = {
				width : 620,
				height : 520,
				title : "选择客户",
				modal : true,
				buttons : [ {
					text : '选择',
					width : '74px',
					click : function() {
						chooseCustomer();
						$(this).dialog('close');
					},
					'class' : 'btn btn-primary btn-middle'
				},
					{
						text : '取消',
						click : function() {
							$(this).dialog('close');
						},
						'class' : 'btn btn-inverse btn-middle btn-aft-middle'
					}
				]
			};
			getCustomersTbody();
			openPop('customer_dialog', param);
		});
		//双击代理商pop
		$(document).on('dblclick', '#pop_table_agency td', function(e) {
			select_agency_id = $(this).parent().children().eq(0).text();
			select_agency_nm = $(this).parent().children().eq(1).text();
			chooseAgency();
		});
		//点击选中代理商
		$(document).on('click', '#pop_table_agency td', function(e) {
			$('.row-select').removeClass('row-select');
			$(this).parent().addClass('row-select');
			select_agency_id = $(this).parent().children().eq(0).text();
			select_agency_nm = $(this).parent().children().eq(1).text();
		});
		//双击用户pop
		$(document).on('dblclick', '#pop_table_user td', function(e) {
			select_user_id = $(this).parent().children().eq(0).text();
			select_user_nm = $(this).parent().children().eq(1).text();
			chooseUser();
		});
		//点击选中用户
		$(document).on('click', '#pop_table_user td', function(e) {
			$('.row-select').removeClass('row-select');
			$(this).parent().addClass('row-select');
			select_user_id = $(this).parent().children().eq(0).text();
			select_user_nm = $(this).parent().children().eq(1).text();
		});

		//双击顾客pop
		$(document).on('dblclick', '#pop_table_customer td', function(e) {
			select_customer_id = $(this).parent().children().eq(0).text();
			select_customer_nm = $(this).parent().children().eq(1).text();
			chooseCustomer();
		});
		//点击选中顾客
		$(document).on('click', '#pop_table_customer td', function(e) {
			$('.row-select').removeClass('row-select');
			$(this).parent().addClass('row-select');
			select_customer_id = $(this).parent().children().eq(0).text();
			select_customer_nm = $(this).parent().children().eq(1).text();
		});

		$('#addProduct1').on('click', function(e) {
			openAddProductDialog('米');
		});
		$("#addProduct2").on('click', function(e) {
			openAddProductDialog('项');
		});
		/** 双击电缆或附件 编辑
		 *
		 */
		$(document).on('dblclick', '#product_list_table td', function(e) {
			var tr = $(this).parent();
			var tds = tr.children();
			getProductData(tds);
			openEditProductDialog(tds.eq(4).text());
		});
		$(document).on('click', '#product_list_table td', function(e) {
			var tr = $(this).parent();
			var tds = tr.children();
			$('.row-select').removeClass('row-select');
			tr.addClass('row-select');
			getProductData(tds);
		});
		function getProductData(tds){
			$("#order_detail_id").val(tds.eq(0).text());
			$("#specification_type").val(tds.eq(1).text());
			$("#voltage").val(tds.eq(2).text());
			$("#contract_quantity").val(tds.eq(3).text());
			$("#contract_unit_price").val(tds.eq(5).text());
			$("#contract_price").val(tds.eq(6).text());
			$("#remark").val(tds.eq(7).text());
		}
		/** 输入金额数量计算单价
		 *
		 */
		$('#contract_price,#contract_quantity').on('change', function(e) {
			var sum = $('#contract_price').val();
			var number = $('#contract_quantity').val();
			if (sum != '' && sum != null && number != null && number != '') {
				$('#contract_unit_price').val((parseFloat(sum) / parseFloat(number)).toFixed(2));
			}
		});
	});

	$(document).ready(function() {
		$("#order_detail_id").val("");
		$("#specification_type").val("");
		$("#voltage").val("");
		$("#contract_quantity").val("");
		$("#contract_unit_price").val("");
		$("#contract_price").val("");
		$("#remark").val("");
	});

	function clearContract() {
		$("#order_detail_id").val("");
		$("#specification_type").val("");
		$("#voltage").val("");
		$("#contract_quantity").val("");
		$("#contract_unit_price").val("");
		$("#contract_price").val("");
		$("#remark").val("");
	}
	function deleteContract(el) {
		jConfirm('确认删除吗？', '确认对话框', function(r) {
			if (r == true) {
				$(el).parent().parent().remove();
			}
		});
	}
	function clearAgency() {
		$('#agency_cd').val("");
		$('#agency_nm').html("");
	}
	function chooseAgency() {
		$('#agency_dialog').dialog('close');
		$('#agency_cd').val(select_agency_id);
		$('#agency_nm').html(select_agency_nm);
	}
	function chooseUser() {
		clearAgency();
		$('#user_dialog').dialog('close');
		$('#agency_user_cd').val(select_user_id);
		$('#agency_user_nm').val(select_user_nm);
	}
	function chooseCustomer() {
		$('#customer_dialog').dialog('close');
		$('#customer_cd').val(select_customer_id);
		$('#customer_nm').val(select_customer_nm);
	}

	/** 增加电缆 附件
	 *
	 */
	function addProduct(num) {
		var order_detail_id = $("#order_detail_id").val();
		var specification_type = $("#specification_type").val();
		var voltage = $("#voltage").val();
		var contract_quantity = $("#contract_quantity").val();
		var contract_price = $("#contract_price").val();
		var contract_unit_price = $("#contract_unit_price").val();
		var remark = $("#remark").val();
		var array = [ "<tr>",
			'<td style="width:5%;">' + order_detail_id + '</td>',
			'<td style="width:12%;">' + specification_type + '</td>',
			'<td style="width:8%;">' + voltage + '</td>',
			'<td style="width:10%;" class="right_align">' + contract_quantity + '</td>',
			'<td style="width:5%;text-align:center;" class="">' + num + '</td>',
			'<td style="width:10%;" class="right_align">' + contract_unit_price + '</td>',
			'<td style="width:15%;" class="right_align">' + contract_price + '</td>',
			'<td style="width:20%;">' + remark + '</td>',
			'<td style="width:15%;" class="center_td"><a class="icon icon-edit link-hand-dialog" id="update_btn_row" onclick="openEditProductDialog(\'' + num + '\', this)">编辑</a>&nbsp;&nbsp;&nbsp;<a class="icon icon-remove" onclick="deleteContract(this)">删除</a></td>',
			"</tr>"
		];
		var tr = array.join();
		var tr_obj = $(tr);
		tr_obj.appendTo(num == '米' ? $('#product_list_table tbody').eq(0) : $('#product_list_table tbody').eq(1));
	}
	/** 打开增加电缆附件pop
	 *
	 */
	function openAddProductDialog(num) {
		$("#explain1").html("");
		$("#order_detail_id").removeAttr("readonly");
		order_detail_flag_valid = true;
		var param = {
			height : 400,
			width : 600,
			title : "增加",
			modal : true,
			buttons : [ {
				id : "order_detail_add",
				text : '增加',
				click : function() {
					addProduct(num);
					$(this).dialog('close');
				},
				'class' : 'btn btn-primary btn-middle',
				'disabled' : "disabled",
			},
				{
					text : '取消',
					click : function() {
						$(this).dialog('close');
					},
					'class' : 'btn btn-inverse btn-middle-aft'
				}
			]
		}
		clearContract();
		$('#num').html(num);
		openPop('product_dialog', param);
	}
	/** 打开编辑电缆附件pop
	 *
	 */
	function openEditProductDialog(num, el) {
		$("#explain1").html("");
		$("#order_detail_id").attr("readonly", true);
		order_detail_flag_valid = false;
		var param = {
			height : 400,
			width : 600,
			title : "编辑 ",
			modal : true,
			buttons : [ {
				text : '编辑 ',
				click : function() {
					$(this).dialog('close');
					editProduct(el);
				},
				'class' : 'btn btn-primary btn-middle'
			},
				{
					text : '取消',
					click : function() {
						$(this).dialog('close');
					},
					'class' : 'btn btn-inverse btn-middle-aft'
				}
			]
		}
		openPop('product_dialog', param);
		$('#num').html(num);
	}
	
	function editProduct(el){
		var specification_type = $("#specification_type").val();
		var voltage = $("#voltage").val();
		var contract_quantity = $("#contract_quantity").val();
		var contract_price = $("#contract_price").val();
		var contract_unit_price = $("#contract_unit_price").val();
		var remark = $("#remark").val();
		var tr = $(el).parent().parent();
		var tds = tr.children();
		tds.eq(1).html(specification_type);
		tds.eq(2).html(voltage);
		tds.eq(3).html(contract_quantity);
		tds.eq(6).html(contract_price);
		tds.eq(5).html(contract_unit_price);
		tds.eq(7).html(remark);
	}
	
	function checkOrderDetail_id() {
		if (order_detail_flag_valid) {
			var order_detail_id = $("#order_detail_id").val();
			if (order_detail_id == "") {
				order_detail_flag1 = false;
			} else {
				$.ajax({
					type : "get", //数据发送的方式（post 或者 get）
					url : "<%=path%>/orderDetailAction?method=checkInsert", //要发送的后台地址
					transition : true,
					data : {
						"order_detail_id" : order_detail_id
					}, //要发送的数据参数
					dataType : "text", //后台处理后返回的数据格式
					success : function(data) { //ajax请求成功后触发的方法
						if (data != 0) {
							order_detail_flag1 = false;
							$("#explain1").html("该编号已存在!");
						} else {
							order_detail_flag1 = true;
							$("#explain1").html("");
						}

					}
				});
			}
			checkAdd();
		}	
	}
		
	function checkOrderDetailOthers() {
		if(order_detail_flag_valid){
			var specification_type = $("#specification_type").val();
			var voltage = $("#voltage").val();
			var contract_quantity = $("#contract_quantity").val();
			var contract_price = $("#contract_price").val();
			var contract_unit_price = $("#contract_unit_price").val();
			if (specification_type == "" || voltage == "" || contract_quantity == "" || contract_price == "" || contract_unit_price == "") {
				order_detail_flag2 = false;
			} else {
				order_detail_flag2 = true;
			}
			checkAdd();
		}
	}
	
	function checkAdd() {
		if (order_detail_flag1 && order_detail_flag2) {
			$("#order_detail_add").removeAttr("disabled");
			$("#order_detail_add").attr("class", "btn btn-primary btn-middle");
		} else {
			$("#order_detail_add").attr("disabled", "disabled");
		}
	}


	function agencyClear() {
		$('#agency_id').val('');
		$('#agency_name').html('');
	}
	function changeMonth(id) {
		dateSelect($('#' + id).val(), function(year, month) {
			$('#' + id).val(year + "" + month);
		});

	}
	function search_agency() {
		agency_condition = $("#keyword_agency").val();
		cp_agency_users = 1;
		getAgencysTbody();
	}

	function search_agency_user() {
		agency_user_condition = $("#keyword_user").val();
		cp_agency_users = 1;
		getAgencyUsersTbody();
	}

	function search_customer() {
		customer_condition = $("#keyword_customer").val();
		cp_customers = 1;
		getCustomersTbody();
	}

	function getAgencyUsersTbody() {
		var agency_user_tbody = $('#agency_user_tbody');
		$.ajax({
			type : "get", //数据发送的方式（post 或者 get）
			url : "<%=path%>/adminUserAction?method=getAgencyUsers", //要发送的后台地址
			transition : true,
			data : {
				"currentPage" : cp_agency_users, //当前页数
				"search" : agency_user_condition
			}, //要发送的数据参数
			dataType : "text", //后台处理后返回的数据格式
			success : function(data) { //ajax请求成功后触发的方法
				dataObj = JSON.parse(data);
				var fromCount = dataObj.fromCount;
				var totalNumber = dataObj.totalNumber;
				tp_agency_users = dataObj.totalPage;
				var showCount = dataObj.showCount;
				toCount = fromCount + showCount - 1;
				(toCount > totalNumber) ? toCount = totalNumber : toCount;
				var agency_users = dataObj.list;

				agency_user_tbody.empty();
				for (var i = 0; i < agency_users.length; i++) {
					var agency_user = agency_users[i];
					agency_user_tbody.append("<tr><td>" + agency_user.user_cd + "</td>"
						+ "<td>" + agency_user.user_nm + "</td>"
						+ "<td>" + agency_user.user_phone + "</td></tr>");
				}
				var now = 0;
				var pages = new Array();

				if (cp_agency_users == 1 || cp_agency_users == 2 || cp_agency_users == 3) {
					for (var i = 1; i <= 5; i++) {
						pages.push(i);
						if (i <= cp_agency_users)
							now++;
						if (i == tp_agency_users)
							break;
					}
				} else {
					if (tp_agency_users >= cp_agency_users + 2) {
						for (var i = cp_agency_users - 2; i <= cp_agency_users + 2; i++) {
							pages.push(i);
							if (i <= cp_agency_users)
								now++;
							if (i == tp_agency_users)
								break;
						}
					} else {
						var start = tp_agency_users - 4 > 0 ? tp_agency_users - 4 : 1;
						for (var i = start; i <= tp_agency_users; i++) {
							pages.push(i);
							if (i <= cp_agency_users)
								now++;
						}
					}
				}
				//更改导航
				$("#agency_user_index").empty();
				$("#agency_user_index").append("<li id=\"agency_user_pre\"><a class=\"user_page_num\" href=\"#\">«</a></li>");
				for (var i = 0; i < pages.length; i++) {
					$("#agency_user_index").append("<li><a class=\"user_page_num\" href=\"#\">" + pages[i] + "</a></li>");
				}
				$("#agency_user_index").append("<li id=\"agency_user_next\"><a class=\"user_page_num\" href=\"#\">»</a></li>");
				$("#agency_user_index").children("li:eq(" + now + ")").addClass('active');

				if (cp_agency_users == 1) {
					$('#agency_user_pre').removeClass("disabled");
					$('#agency_user_pre').addClass('disabled');
				} else {
					$('#agency_user_pre').removeClass("disabled");
				}
				if (cp_agency_users == tp_agency_users) {
					$('#agency_user_next').removeClass("disabled");
					$('#agency_user_next').addClass('disabled');
				} else {
					$('#agency_user_next').removeClass("disabled");
				}
				$("#agency_user_pages").text(fromCount + "-" + toCount + "/" + totalNumber);

			},
			error : function(msg) { //ajax请求失败后触发的方法
				alert("服务器请求失败!"); //弹出错误信息
			}
		});
	}

	function getAgencysTbody() {
		var agency_tbody = $('#agency_tbody');
		$.ajax({
			type : "get", //数据发送的方式（post 或者 get）
			url : "<%=path%>/adminAgencyAction?method=getAgencys", //要发送的后台地址
			transition : true,
			data : {
				"usercd" : select_user_id,
				"currentPage" : cp_agencys, //当前页数
				"search" : agency_condition
			}, //要发送的数据参数
			dataType : "text", //后台处理后返回的数据格式
			success : function(data) { //ajax请求成功后触发的方法
				dataObj = JSON.parse(data);
				var fromCount = dataObj.fromCount;
				var totalNumber = dataObj.totalNumber;
				tp_agencys = dataObj.totalPage;
				var showCount = dataObj.showCount;
				toCount = fromCount + showCount - 1;
				(toCount > totalNumber) ? toCount = totalNumber : toCount;
				var agencys = dataObj.list;

				agency_tbody.empty();
				for (var i = 0; i < agencys.length; i++) {
					var agency = agencys[i];
					agency_tbody.append("<tr><td>" + agency.agency_cd + "</td>"
						+ "<td>" + agency.agency_nm + "</td>"
						+ "<td>" + agency.agency_user_nm + "</td></tr>");
				}
				var now = 0;
				var pages = new Array();

				if (cp_agencys == 1 || cp_agencys == 2 || cp_agencys == 3) {
					for (var i = 1; i <= 5; i++) {
						pages.push(i);
						if (i <= cp_agencys)
							now++;
						if (i == tp_agencys)
							break;
					}
				} else {
					if (tp_agencys >= cp_agencys + 2) {
						for (var i = cp_agencys - 2; i <= cp_agencys + 2; i++) {
							pages.push(i);
							if (i <= cp_agencys)
								now++;
							if (i == tp_agencys)
								break;
						}
					} else {
						var start = tp_agencys - 4 > 0 ? tp_agencys - 4 : 1;
						for (var i = start; i <= tp_agencys; i++) {
							pages.push(i);
							if (i <= cp_agencys)
								now++;
						}
					}
				}
				//更改导航
				$("#agency_index").empty();
				$("#agency_index").append("<li id=\"agency_pre\"><a class=\"agency_page_num\" href=\"#\">«</a></li>");
				for (var i = 0; i < pages.length; i++) {
					$("#agency_index").append("<li><a class=\"agency_page_num\" href=\"#\">" + pages[i] + "</a></li>");
				}
				$("#agency_index").append("<li id=\"agency_next\"><a class=\"agency_page_num\" href=\"#\">»</a></li>");
				$("#agency_index").children("li:eq(" + now + ")").addClass('active');

				if (cp_agencys == 1) {
					$('#agency_pre').removeClass("disabled");
					$('#agency_pre').addClass('disabled');
				} else {
					$('#agency_pre').removeClass("disabled");
				}
				if (cp_agencys == tp_agencys) {
					$('#agency_next').removeClass("disabled");
					$('#agency_next').addClass('disabled');
				} else {
					$('#agency_next').removeClass("disabled");
				}
				$("#agency_pages").text(fromCount + "-" + toCount + "/" + totalNumber);

			},
			error : function(msg) { //ajax请求失败后触发的方法
				alert("服务器请求失败!"); //弹出错误信息
			}
		});
	}

	function getCustomersTbody() {
		var customer_tbody = $('#customer_tbody');
		$.ajax({
			type : "get", //数据发送的方式（post 或者 get）
			url : "<%=path%>/adminCustomerAction?method=getCustomers", //要发送的后台地址
			transition : true,
			data : {
				"customerType" : customer_type,
				"currentPage" : cp_customers, //当前页数
				"search" : customer_condition
			}, //要发送的数据参数
			dataType : "text", //后台处理后返回的数据格式
			success : function(data) { //ajax请求成功后触发的方法
				dataObj = JSON.parse(data);
				var fromCount = dataObj.fromCount;
				var totalNumber = dataObj.totalNumber;
				tp_customers = dataObj.totalPage;
				var showCount = dataObj.showCount;
				toCount = fromCount + showCount - 1;
				(toCount > totalNumber) ? toCount = totalNumber : toCount;
				var customers = dataObj.list;

				customer_tbody.empty();
				for (var i = 0; i < customers.length; i++) {
					var customer = customers[i];
					customer_tbody.append("<tr><td>" + customer.customer_cd + "</td>"
						+ "<td>" + customer.customer_nm + "</td>"
						+ "<td>" + customer.connect_kind + "</td></tr>");
				}
				var now = 0;
				var pages = new Array();

				if (cp_customers == 1 || cp_customers == 2 || cp_customers == 3) {
					for (var i = 1; i <= 5; i++) {
						pages.push(i);
						if (i <= cp_customers)
							now++;
						if (i == tp_customers)
							break;
					}
				} else {
					if (tp_customers >= cp_customers + 2) {
						for (var i = cp_customers - 2; i <= cp_customers + 2; i++) {
							pages.push(i);
							if (i <= cp_customers)
								now++;
							if (i == tp_customers)
								break;
						}
					} else {
						var start = tp_customers - 4 > 0 ? tp_customers - 4 : 1;
						for (var i = start; i <= tp_customers; i++) {
							pages.push(i);
							if (i <= cp_customers)
								now++;
						}
					}
				}
				//更改导航
				$("#customer_index").empty();
				$("#customer_index").append("<li id=\"customer_pre\"><a class=\"customer_page_num\" href=\"#\">«</a></li>");
				for (var i = 0; i < pages.length; i++) {
					$("#customer_index").append("<li><a class=\"customer_page_num\" href=\"#\">" + pages[i] + "</a></li>");
				}
				$("#customer_index").append("<li id=\"customer_next\"><a class=\"customer_page_num\" href=\"#\">»</a></li>");
				$("#customer_index").children("li:eq(" + now + ")").addClass('active');

				if (cp_customers == 1) {
					$('#customer_pre').removeClass("disabled");
					$('#customer_pre').addClass('disabled');
				} else {
					$('#customer_pre').removeClass("disabled");
				}
				if (cp_customers == tp_customers) {
					$('#customer_next').removeClass("disabled");
					$('#customer_next').addClass('disabled');
				} else {
					$('#customer_next').removeClass("disabled");
				}
				$("#customer_pages").text(fromCount + "-" + toCount + "/" + totalNumber);

			},
			error : function(msg) { //ajax请求失败后触发的方法
				alert("服务器请求失败!"); //弹出错误信息
			}
		});
	}
	
	function submit(){
		var obj = new Object();
		
		var contract_no = $("#contract_no").val();
		var orders_version = $("#orders_version").val();
		var agency_user_cd = $("#agency_user_cd").val();
		var agency_user_nm = $("#agency_user_nm").val();
		var agency_cd = $("#agency_cd").val();
		var agency_nm = $("#agency_nm").text();
		var customer_type = $("#customer_type").val();
		var customer_cd = $("#customer_cd").val();
		var customer_nm = $("#customer_nm").val();
		var project_nm = $("#project_nm").val();
		var expected_send_month = $("#expected_send_month").val();
		var expected_energize_month = $("#expected_energize_month").val();
		var shelf_months = $("#shelf_months").val();
		var energize_date = $("#energize_date").val();
		var currency_cd = $("#currency").val();
		var currency_nm = $("#currency").find("option:selected").text();
		var bid_cu_price = $("#bid_cu_price").val();
		var bid_sum_money = $("#bid_sum_money").val();
		var currency = $("#currency").val();
		var contract_sum_money = $("#contract_sum_money").val();
		var proportion = $("#proportion").val();
		var commission = $("#commission").val();
		var payments_proportion1 = $("#payments_proportion1").val();
		var payments_proportion2 = $("#payments_proportion2").val();
		var payments_proportion3 = $("#payments_proportion3").val();
		var payments_proportion4 = $("#payments_proportion4").val();
		var payments_proportion5 = $("#payments_proportion5").val();
		var payments_proportion6 = $("#payments_proportion6").val();
		var expected_payments_date1 = $("#expected_payments_date1").val();
		var expected_payments_date2 = $("#expected_payments_date2").val();
		var expected_payments_date3 = $("#expected_payments_date3").val();
		var expected_payments_date4 = $("#expected_payments_date4").val();
		var expected_payments_date5 = $("#expected_payments_date5").val();
		var expected_payments_date6 = $("#expected_payments_date6").val();
		var expected_payments_sum1 = $("#expected_payments_sum1").val();
		var expected_payments_sum2 = $("#expected_payments_sum2").val();
		var expected_payments_sum3 = $("#expected_payments_sum3").val();
		var expected_payments_sum4 = $("#expected_payments_sum4").val();
		var expected_payments_sum5 = $("#expected_payments_sum5").val();
		var expected_payments_sum6 = $("#expected_payments_sum6").val();
		var product_list_tbody1 = $("#product_list_tbody1");
		var product_list_tbody2 = $("#product_list_tbody2");
		var product_list_trs1 = product_list_tbody1.children();
		var product_list_trs2 = product_list_tbody2.children();
		var product_list = new Array();
		$.each(product_list_trs1, function(){
			var order_detail = new Object();
			var tds =  $(this).children();
			order_detail.order_detail_id = tds.eq(0).html();
			order_detail.orders_id = "<%=orders_id%>";
			order_detail.product_category = "1";
			order_detail.specification_type = tds.eq(1).html();
			order_detail.voltage = tds.eq(2).html();
			order_detail.contract_quantity = tds.eq(3).html();
			order_detail.contract_unit_price = tds.eq(5).html();
			order_detail.contract_price = tds.eq(6).html();
			order_detail.remark = tds.eq(7).html();
			product_list.push(order_detail);
 		});
 		$.each(product_list_trs2, function(){
			var order_detail = new Object();
			var tds =  $(this).children();
			order_detail.order_detail_id = tds.eq(0).html();
			order_detail.orders_id = "<%=orders_id%>";
			order_detail.product_category = "2";
			order_detail.specification_type = tds.eq(1).html();
			order_detail.voltage = tds.eq(2).html();
			order_detail.contract_quantity = tds.eq(3).html();
			order_detail.contract_unit_price = tds.eq(5).html();
			order_detail.contract_price = tds.eq(6).html();
			order_detail.remark = tds.eq(7).html();
			product_list.push(order_detail);
 		});
 		obj.orders_id = "<%=orders_id%>";
 		obj.contract_no = contract_no;
		obj.orders_version = orders_version;
		obj.agency_user_cd = agency_user_cd;
		obj.agency_user_nm = agency_user_nm;
		obj.agency_cd = agency_cd;
		obj.agency_nm = agency_nm;
		obj.customer_type = customer_type;
		obj.customer_cd = customer_cd;
		obj.customer_nm = customer_nm;
		obj.project_nm = project_nm;
		obj.expected_send_month = expected_send_month;
		obj.expected_energize_month = expected_energize_month;
		obj.shelf_months = shelf_months;
		obj.energize_date = energize_date;
		obj.currency_cd = currency_cd;
		obj.currency_nm = currency_nm;
		obj.bid_cu_price = bid_cu_price;
		obj.bid_sum_money = bid_sum_money;
		obj.currency = currency;
		obj.contract_sum_money = contract_sum_money;
		obj.proportion = proportion;
		obj.commission = commission;
		obj.payments_proportion1 = payments_proportion1;
		obj.payments_proportion2 = payments_proportion2;
		obj.payments_proportion3 = payments_proportion3;
		obj.payments_proportion4 = payments_proportion4;
		obj.payments_proportion5 = payments_proportion5;
		obj.payments_proportion6 = payments_proportion6;
		obj.expected_payments_date1 = expected_payments_date1;
		obj.expected_payments_date2 = expected_payments_date2;
		obj.expected_payments_date3 = expected_payments_date3;
		obj.expected_payments_date4 = expected_payments_date4;
		obj.expected_payments_date5 = expected_payments_date5;
		obj.expected_payments_date6 = expected_payments_date6;
		obj.expected_payments_sum1 = expected_payments_sum1;
		obj.expected_payments_sum2 = expected_payments_sum2;
		obj.expected_payments_sum3 = expected_payments_sum3;
		obj.expected_payments_sum4 = expected_payments_sum4;
		obj.expected_payments_sum5 = expected_payments_sum5;
		obj.expected_payments_sum6 = expected_payments_sum6;
		obj.order_detail_list = product_list;
		
  		var jsonStr = JSON.stringify(obj);
 		$("#order_json").val(jsonStr);
 		$("#order_form").submit();
	}
</script>
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
			<span>订单信息编辑</span>
		</div>
		<div class="content">
			<div style="margin:10px 0;padding:5px 20px;">
				<div class="edit-content"
					style="margin-bottom: 0px;border-top:1px solid #0088CC;padding-top:10px;">
					<!-- 		<table class="edit-table" style="margin: 0 auto;"> -->
					<table class="edit-table" style="width:95%">
						<tbody>
							<tr>
								<td width="60%">
									<table>
										<tbody>
											<tr>
												<td class="right_align">合同号&nbsp;:&nbsp;</td>
												<td colspan="3"><input class="input-xlarge" type="text"
													style="width: 120px;ime-mode: disabled" id="contract_no"
													value="<%=orderBean.getContract_no()%>">－<input
													class="input-xlarge" type="text" disabled
													style="width: 30px;;ime-mode: disabled" id="orders_version"
													value="<%=orderBean.getOrders_version()%>"></td>
											</tr>
											<tr>
												<td class="right_align">业务员&nbsp;:&nbsp;</td>
												<td colspan="3">
													<table>
														<tr>
															<%
																if (user_owner_flg.equals("M")) {
															%>
															<td><i id="user_search" class="icon icon-search"
																style="background-position:0 0;padding-top:0;height:20px;width:20px;padding-left:0;"
																title="查询"></i></td>
															<%
																}
															%>
															<td><input type="hidden" id="agency_user_cd" name="agency_user_cd"
																value="<%=orderBean.getAgency_user_cd()%>" /> <input
																type="text" disabled style="width:80px;" id="agency_user_nm"
																name="agency_user_nm"
																value="<%=orderBean.getAgency_user_nm()%>"></input></td>

															<td>&nbsp;&nbsp;&nbsp;&nbsp;<span>代理商&nbsp;:&nbsp;</span>
															</td>
															<td><i id="agency_search" class="icon icon-search"
																style="background-position: 0 0;padding-top: 0; height: 20px; width: 20px; padding-left: 0;"
																title="查询"></i> <i id="agency_clear"
																class="icon icon-clear"
																style="background-position: 0 0;padding-top: 0; height: 20px; width: 20px; margin-left: 2px; padding-left: 3px;"
																title="清除"></i></td>
															<td>
																<div
																	style="display: inline; margin-left: 3px;width:100px;">
																	<input type="text" disabled style="width: 40px;"
																		value="<%=orderBean.getAgency_cd()%>" id="agency_cd"></input>
																	<label style="display: inline; margin-left: 3px;"
																		id="agency_nm"><%=orderBean.getAgency_nm()%></label>
																</div>
															</td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td class="right_align">客户类别&nbsp;:&nbsp;</td>
												<td colspan="3"><select id="customer_type"
													style="width:80px;">
														<option value="国网">国网</option>
														<option value="南网">南网</option>
														<option value="海外">海外</option>
														<option value="地方">地方</option>
												</select></td>
											</tr>
											<tr>
												<td class="right_align">客户名称&nbsp;:&nbsp;</td>
												<td colspan="3"><i id="customer_search"
													class="icon icon-search"
													style="background-position: 0 0; margin-top: -5px; padding-top: 0; height: 20px; width: 20px; padding-left: 0;"
													title="查询"></i>
													<div style="display: inline; margin-left: 3px;">
														<input type="hidden" id="customer_cd" value="<%=orderBean.getCustomer_cd()%>"/>
														<input type="text" id="customer_nm" disabled style="width: 300px;"
															value="<%=orderBean.getCustomer_nm()%>"/>
													</div></td>
											</tr>
											<tr>
												<td class="right_align">项目名称&nbsp;:&nbsp;</td>
												<td colspan="3"><input id="project_nm" class=""
													value="<%=orderBean.getProject_nm()%>" type="text"
													style="margin-bottom:5px;width: 300px;"></td>
											</tr>
											<tr>
												<td class="right_align">预计发货月&nbsp;:&nbsp;</td>
												<td colspan="3"><input id="expected_send_month" type="text"
													value="<%=orderBean.getExpected_send_month()%>"
													style="width: 70px; margin-bottom: 3px; ime-mode: disabled"><img
													src="../../../images/cal.gif" id="imgs"
													onclick="changeMonth('expected_send_month')" /></td>
											</tr>
											<tr>
												<td class="right_align">预计送电月&nbsp;:&nbsp;</td>
												<td><input id="expected_energize_month" type="text"
													value="<%=orderBean.getExpected_energize_month()%>"
													style="width: 70px; margin-bottom: 5px; ime-mode: disabled"><img
													src="../../../images/cal.gif" id="imgs"
													onclick="changeMonth('expected_energize_month')" /></td>
												<td class="right_align">通电后保证月数&nbsp;:&nbsp;</td>
												<td><input type="text" id="shelf_months"
													value="<%=orderBean.getShelf_months()%>"
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
												<td><input type="text" id="bid_cu_price"
													value="<%=orderBean.getBid_cu_price()%>"
													style="margin-bottom: 5px; width: 150px; text-align: right;"></td>
											</tr>
											<tr>
												<td class="right_align">金额(货币)&nbsp;:&nbsp;</td>
												<td><input type="text" id="bid_sum_money"
													value="<%=orderBean.getBid_sum_money()%>"
													style="margin-bottom: 5px; width: 150px; text-align: right; ime-mode: disabled">
													<select id="currency" name="currency" style="width: 90px;">
														<%
															for (Map.Entry<String, String> currency : currency_map.entrySet()) {
														%>
														<option value="<%=currency.getKey()%>"><%=currency.getValue()%></option>
														<%
															}
														%>
												</select></td>
											</tr>
											<tr>
												<td colspan="2"><span>&nbsp;</span></td>
											</tr>
											<tr>
												<td class="right_align">合同总价&nbsp;:&nbsp;</td>
												<td><input id="contract_sum_money" class="" disabled
													type="text" value="<%=orderBean.getContract_sum_money()%>"
													style="width: 150px; text-align: right; ime-mode: disabled">
												</td>
											</tr>
											<tr>
												<td class="right_align">佣金率&nbsp;:&nbsp;</td>
												<td><input type="text" id="proportion"
													value="<%=orderBean.getProportion() * 100%>"
													style="margin-bottom: 5px; width: 50px; text-align: right; ime-mode: disabled">&nbsp;<label
													style="display:inline;">%</label></td>
											</tr>
											<tr>
												<td class="right_align">佣金金额&nbsp;:&nbsp;</td>
												<td><input type="text" id="commission" disabled
													value="<%=orderBean.getCommission()%>"
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
												<td><input id="payments_proportion1" class="right_align" type="text"
													value="<%=orderBean.getPayments_proportion1()%>"
													style="width: 45px; margin-bottom: 0; ime-mode: disabled">
													:&nbsp;&nbsp;
												<td><input id="payments_proportion2" class="right_align" type="text"
													value="<%=orderBean.getPayments_proportion2()%>"
													style="width: 45px; margin-bottom: 0; ime-mode: disabled">
													:&nbsp;
												<td><input id="payments_proportion3" class="right_align" type="text"
													value="<%=orderBean.getPayments_proportion3()%>"
													style="width: 45px; margin-bottom: 0; ime-mode: disabled">
													:&nbsp;&nbsp;
												<td><input id="payments_proportion4" class="right_align" type="text"
													value="<%=orderBean.getPayments_proportion4()%>"
													style="width: 45px; margin-bottom: 0; ime-mode: disabled">
													:&nbsp;&nbsp;
												<td><input id="payments_proportion5" class="right_align" type="text"
													value="<%=orderBean.getPayments_proportion5()%>"
													style="width: 45px; margin-bottom: 0; ime-mode: disabled">
													:&nbsp;&nbsp;
												<td><input id="payments_proportion6" class="right_align" type="text"
													value="<%=orderBean.getPayments_proportion6()%>"
													style="width: 45px; margin-bottom: 0; ime-mode: disabled">
											</tr>

											<tr>
												<td><input id="expected_payments_date1" type="text"
													value="<%=orderBean.getExpected_payments_date1()%>"
													style="margin-bottom: 0; width: 70px; ime-mode: disabled"><img
													src="../../../images/cal.gif" id="imgs"
													onclick="changeMonth('expected_payments_date1')" />
												<td><input id="expected_payments_date2" type="text"
													value="<%=orderBean.getExpected_payments_date2()%>"
													style="margin-bottom: 0; width: 70px; ime-mode: disabled"><img
													src="../../../images/cal.gif" id="imgs"
													onclick="changeMonth('expected_payments_date2')" />
												<td><input id="expected_payments_date3" type="text"
													value="<%=orderBean.getExpected_payments_date3()%>"
													style="margin-bottom: 0; width: 70px; ime-mode: disabled"><img
													src="../../../images/cal.gif" id="imgs"
													onclick="changeMonth('expected_payments_date3')" />
												<td><input id="expected_payments_date4" type="text"
													value="<%=orderBean.getExpected_payments_date4()%>"
													style="margin-bottom: 0; width: 70px; ime-mode: disabled"><img
													src="../../../images/cal.gif" id="imgs"
													onclick="changeMonth('expected_payments_date4')" />
												<td><input id="expected_payments_date5" type="text"
													value="<%=orderBean.getExpected_payments_date5()%>"
													style="margin-bottom: 0; width: 70px; ime-mode: disabled"><img
													src="../../../images/cal.gif" id="imgs"
													onclick="changeMonth('expected_payments_date5')" />
												<td><input id="expected_payments_date6" type="text"
													value="<%=orderBean.getExpected_payments_date6()%>"
													style="margin-bottom: 0; width: 70px; ime-mode: disabled"><img
													src="../../../images/cal.gif" id="imgs"
													onclick="changeMonth('expected_payments_date6')" />
											</tr>
											<tr>
												<td><input id="expected_payments_sum1" class="right_align"
													value="<%=orderBean.getExpected_payments_sum1()%>"
													type="text" style="width: 90px; ime-mode: disabled">
												<td><input id="expected_payments_sum2" class="right_align"
													value="<%=orderBean.getExpected_payments_sum2()%>"
													type="text" style="width: 90px; ime-mode: disabled">
												<td><input id="expected_payments_sum3" class="right_align"
													value="<%=orderBean.getExpected_payments_sum3()%>"
													type="text" style="width: 90px; ime-mode: disabled">
												<td><input id="expected_payments_sum4" class="right_align"
													value="<%=orderBean.getExpected_payments_sum4()%>"
													type="text" style="width: 90px; ime-mode: disabled">
												<td><input id="expected_payments_sum5" class="right_align"
													value="<%=orderBean.getExpected_payments_sum5()%>"
													type="text" style="width: 90px; ime-mode: disabled">
												<td><input id="expected_payments_sum6" class="right_align"
													value="<%=orderBean.getExpected_payments_sum6()%>"
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
					<ul class="nav nav-tabs" style="width:914px; margin-bottom: 0px;">
						<li class="active"><a id="li_1" href="#div_list_0"
							data-toggle="tab">电缆</a></li>
						<li class=""><a id="li_2" href="#div_list_1"
							data-toggle="tab">附件</a></li>
					</ul>
				</div>
				<div class="tab-content">
					<div class="div_list tab-pane active" id="div_list_0">
						<div class="" style="margin:auto;width:860px;">
							<div>
								<div id="" style="float: right;">
									<a id="addProduct1" class="icon icon-add"
										href="javascript:void(0);" title="" style="margin-right: 10px">增加</a>
								</div>
								<div style="clear:both;"></div>
							</div>
							<div class="" style="width: 855px;">
								<table class="table table-striped table-bordered table-title"
									style="background-color:#E4F4CB;margin-bottom: 0px;">
									<thead>
										<tr>
											<th style="width:5%;height:21px">序号</th>
											<th style="width:10%;">规格型号</th>
											<th style="width:10%">电压等级</th>
											<th style="width:10%;">合同数量</th>
											<th style="width:5%">单位</th>
											<th style="width:10%;">合同单价</th>
											<th style="width:15%;">金额</th>
											<th style="width:15%">备注</th>
											<th style="width:15%;"></th>
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
										<tbody id="product_list_tbody1">
											<%
												for (OrderDetailBean orderDetailBean : orderBean.getOrder_detail_list()) {
											%>
											<%
												if (orderDetailBean.getProduct_category().equals("1")) {
											%>
											<tr>
												<td style="width: 5%;"><%=orderDetailBean.getOrder_detail_id()%></td>
												<td style="width: 10%;"><%=orderDetailBean.getSpecification_type()%></td>
												<td style="width: 10%;"><%=orderDetailBean.getVoltage()%></td>
												<td style="width: 10%;" class="right_align"><%=orderDetailBean.getContract_quantity()%></td>
												<td style="width: 5%; text-align: center;" class="">米</td>
												<td style="width: 10%;" class="right_align"><%=orderDetailBean.getContract_unit_price()%></td>
												<td style="width: 15%;" class="right_align"><%=orderDetailBean.getContract_price()%></td>
												<td style="width: 15%;"><%=orderDetailBean.getRemark()%></td>
												<td style="width: 15%;" class="center_td"><a
													class="icon icon-edit link-hand-dialog" id="update_btn_row"
													onclick="openEditProductDialog('米',this)">编辑</a>
													&nbsp;&nbsp;&nbsp;<a class="icon icon-remove"
													onclick="deleteContract(this)">删除</a></td>
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
							<div>
								<div id="" style="float: right;">
									<a id="addProduct2" class="icon icon-add"
										href="javascript:void(0);" title="" style="margin-right: 10px">增加</a>
								</div>
								<div style="clear:both;"></div>
							</div>
							<div class="" style="width: 855px;">
								<table class="table table-striped table-bordered table-title"
									style="background-color:#E4F4CB;margin-bottom: 0px;">
									<thead>
										<tr>
											<th style="width:5%;height:21px">序号</th>
											<th style="width:10%;">规格型号</th>
											<th style="width:10%">电压等级</th>
											<th style="width:10%;">合同数量</th>
											<th style="width:5%">单位</th>
											<th style="width:10%;">合同单价</th>
											<th style="width:15%;">金额</th>
											<th style="width:15%">备注</th>
											<th style="width:15%;"></th>
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
										<tbody id="product_list_tbody2">
											<%
												for (OrderDetailBean orderDetailBean : orderBean.getOrder_detail_list()) {
												if (orderDetailBean.getProduct_category().equals("2")) {
											%>
											<tr>
												<td style="width: 5%;"><%=orderDetailBean.getOrder_detail_id()%></td>
												<td style="width: 10%;"><%=orderDetailBean.getSpecification_type()%></td>
												<td style="width: 10%;"><%=orderDetailBean.getVoltage()%></td>
												<td style="width: 10%;" class="right_align"><%=orderDetailBean.getContract_quantity()%></td>
												<td style="width: 5%; text-align: center;" class="">项</td>
												<td style="width: 10%;" class="right_align"><%=orderDetailBean.getContract_unit_price()%></td>
												<td style="width: 15%;" class="right_align"><%=orderDetailBean.getContract_price()%></td>
												<td style="width: 15%;"><%=orderDetailBean.getRemark()%></td>
												<td style="width: 15%;" class="center_td"><a
													class="icon icon-edit link-hand-dialog" id="update_btn_row"
													onclick="openEditProductDialog('项',this)">编辑</a>
													&nbsp;&nbsp;&nbsp;<a class="icon icon-remove"
													onclick="deleteContract(this)">删除</a></td>
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
		<form id="order_form" method="post" action="orderConfirm.jsp">
			<input type="hidden" id="order_json" name="order_json" value=""/>
		</form>
		<div class="bottom_block">
			<a class="btn btn-primary btn-middle" style=""
				href="javascript:submit()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;确认&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
			<a class="btn btn-info btn-middle-aft" href="orderSearch.jsp">返回</a>
		</div>
	</div>

	<!-- 代理商dialog -->
	<div id="agency_dialog" style="display:none;">
		<div style="width:100%;border-bottom: 1px solid #0088CC;">

			<div style="color:#0060A4;display:inline;font-size:14px;">
				业务员&nbsp;:&nbsp;<span id="agency_dialog_user_name"
					style="margin-left:3px;"></span>
			</div>
			<span style="float:right"> <input id="keyword_agency" class=""
				type="text" value="" title="" style="width: 180px;">
				<button class="btn search-btn-easy btn-mini" type="button"
					onclick="search_agency()">
					<i class="icon-search_mini"></i>
				</button>
			</span>
			<div style="clear:both;"></div>
		</div>

		<div class="search-result">
			<div id="pop_table_agency" style="padding:10px;margin-top:-10px;">
				<table class="table table-striped table-bordered"
					style="background-color: #E4F4CB;">
					<thead>
						<tr>
							<th style="width:25%;height:25px;"><a class="sort"
								style="color:#0060A4">代理商编号<span class="caret"></span></a></th>
							<th width="50%"><a class="sort" style="color:#0060A4">代理商名称</a></th>
							<th width="25%"><a class="sort" style="color:#0060A4">业务员</a></th>
						</tr>
					</thead>

					<tbody id="agency_tbody">
						<tr>
							<td>0002</td>
							<td>某市某某代理商</td>
							<td>张三</td>
						</tr>

					</tbody>
				</table>
			</div>
		</div>

		<div id="pagination" style="align: center; margin-top: -10px;">
			<div id='project_pagination' class="pagination pagination-centered">
				<div class="pagination">
					<ul id="agency_index">
						<li id="agency_pre" class="disabled"><a href="#">«</a></li>
						<li class="active"><a href="#">1</a></li>
						<li><a href="#" style="color: #0060A4">2</a></li>
						<li><a href="#" style="color: #0060A4">3</a></li>
						<li><a href="#" style="color: #0060A4">4</a></li>
						<li id="agency_next"><a href="#" style="color: #0060A4">»</a></li>
					</ul>
					<ul>
						<li><span id="agency_pages">(1-10/38)</span></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div id="product_dialog" style="display:none">
		<div class="">
			<div style="padding:10px 0;">
				<div style="width:100%;">
					<table class="table-edit table-bordered table-striped">
						<tr>
							<td width="20%" class="right_align">序号&nbsp;:&nbsp;</td>
							<td width="80%"><input type="text" class="must"
								style="width:60px;ime-mode: disabled" id="order_detail_id"
								value="" onpropertychange="checkOrderDetail_id()"
								onblur="checkOrderDetail_id()" oninput="checkOrderDetail_id()" />
								<span id="explain1" style="color:red;font-size:10px"></span></td>
						</tr>
						<tr>
							<td class="right_align">规格型号&nbsp;:&nbsp;</td>
							<td><input type="text" class="must" style="width:180px;"
								id="specification_type" value=""
								onpropertychange="checkOrderDetailOthers()"
								onblur="checkOrderDetailOthers()"
								oninput="checkOrderDetailOthers()" /> <span id="explain2"
								style="color:red;font-size:10px"></span></td>
						</tr>
						<tr>
							<td class="right_align">电压等级&nbsp;:&nbsp;</td>
							<td><input type="text" class="must" style="width:180px;"
								id="voltage" value=""
								onpropertychange="checkOrderDetailOthers()"
								onblur="checkOrderDetailOthers()"
								oninput="checkOrderDetailOthers()"></td>
						</tr>
						<tr>
							<td class="right_align">合同数量&nbsp;:&nbsp;</td>
							<td><input type="text" class="must right_align"
								style="width:100px;ime-mode: disabled" id="contract_quantity"
								value="" onpropertychange="checkOrderDetailOthers()"
								onblur="checkOrderDetailOthers()"
								oninput="checkOrderDetailOthers()" />&nbsp;<span id="num">米</span></td>
						</tr>
						<tr>
							<td class="right_align">金额&nbsp;:&nbsp;</td>
							<td><input type="text" class="must right_align"
								style="width:180px;ime-mode: disabled" id="contract_price"
								value="" onpropertychange="checkOrderDetailOthers()"
								onblur="checkOrderDetailOthers()"
								oninput="checkOrderDetailOthers()" /></td>
						</tr>
						<tr>
							<td class="right_align">合同单价&nbsp;:&nbsp;</td>
							<td><input type="text" class="right_align" disabled
								style="width:180px;ime-mode: disabled" id="contract_unit_price"
								value="" onpropertychange="checkOrderDetailOthers()"
								onblur="checkOrderDetailOthers()"
								oninput="checkOrderDetailOthers()" /></td>
						</tr>
						<tr>
							<td class="right_align">备注&nbsp;:&nbsp;</td>
							<td><input type="text" class="" style="width:400px;"
								id="remark" value=""></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>

	<!-- 业务员选择pop -->
	<div id="user_dialog" style="display: none;">
		<div style="width: 100%; border-bottom: 1px solid #0088CC;">
			<span style="float: right"> <input id="keyword_user" class=""
				type="text" value="" title="" style="width: 180px;">
				<button class="btn search-btn-easy btn-mini" type="button"
					onclick="search_agency_user()">
					<i class="icon-search_mini"></i>
				</button>
			</span>
			<div style="clear: both;"></div>
		</div>

		<div class="search-result">
			<div id="pop_table_user" style="padding: 10px; margin-top: -10px;">
				<table class="table table-striped table-bordered"
					style="background-color: #E4F4CB;">
					<thead>
						<tr>
							<th style="width: 15%; height: 25px;"><a class="sort"
								style="color: #0060A4">编号<span class="caret"></span></a></th>
							<th><a class="sort" style="color: #0060A4">业务员</a></th>
							<th width="25%"><a class="sort" style="color: #0060A4">联系电话</a></th>
						</tr>
					</thead>
					<tbody id="agency_user_tbody">
					</tbody>
				</table>
			</div>
		</div>

		<div id="pagination" style="align: center; margin-top: -10px;">
			<div id='project_pagination' class="pagination pagination-centered">
				<div class="pagination">
					<ul id="agency_user_index">
						<li id="agency_user_pre" class="disabled"><a href="#">«</a></li>
						<li class="active"><a href="#">1</a></li>
						<li><a href="#" style="color: #0060A4">2</a></li>
						<li><a href="#" style="color: #0060A4">3</a></li>
						<li><a href="#" style="color: #0060A4">4</a></li>
						<li id="agency_user_next"><a href="#" style="color: #0060A4">»</a></li>
					</ul>
					<ul>
						<li><span id="agency_user_pages">(1-10/38)</span></li>
					</ul>
				</div>
			</div>
		</div>
	</div>


	<!-- 业务员选择pop -->
	<div id="customer_dialog" style="display: none;">
		<div style="width: 100%; border-bottom: 1px solid #0088CC;">
			<div style="color:#0060A4;display:inline;font-size:14px;">
				客户类别&nbsp;:&nbsp;<span style="margin-left:3px;"
					id="dialog_customer_type"></span>
			</div>
			<span style="float: right"> <input id="keyword_customer"
				class="" type="text" value="" title="" style="width: 180px;">
				<button class="btn search-btn-easy btn-mini" type="button"
					onclick="search_customer()">
					<i class="icon-search_mini"></i>
				</button>
			</span>
			<div style="clear: both;"></div>
		</div>

		<div class="search-result">
			<div id="pop_table_customer"
				style="padding: 10px; margin-top: -10px;">
				<table class="table table-striped table-bordered"
					style="background-color: #E4F4CB;">
					<thead>
						<tr>
							<th style="width: 15%; height: 25px;"><a class="sort"
								style="color: #0060A4">客户编号<span class="caret"></span></a></th>
							<th width="40%"><a class="sort" style="color: #0060A4">客户名称</a></th>
							<th style="width: 32%;"><a class="sort"
								style="color: #0060A4">联系方式</a></th>
						</tr>
					</thead>

					<tbody id="customer_tbody">
						<tr>
							<td>0002</td>
							<td>某市国家电网</td>
							<td>123456</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<div id="pagination" style="align: center; margin-top: -10px;">
			<div id='project_pagination' class="pagination pagination-centered">
				<div class="pagination">
					<ul id="customer_index">
						<li id="customer_pre" class="disabled"><a href="#">«</a></li>
						<li class="active"><a href="#">1</a></li>
						<li><a href="#" style="color: #0060A4">2</a></li>
						<li><a href="#" style="color: #0060A4">3</a></li>
						<li><a href="#" style="color: #0060A4">4</a></li>
						<li id="customer_next"><a href="#" style="color: #0060A4">»</a></li>
					</ul>
					<ul>
						<li><span id="customer_pages">(1-10/38)</span></li>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<div id="dateSelectPop" style="display:none">
		<div class="modal-body">
			<table
				style="background: none repeat scroll 0% 0% rgb(234, 247, 239); width: 100%;">
				<tr>
					<td>
						<div>
							<table style="width: 100%;text-align: center;"
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
					<td style="background-color: rgb(0, 143, 32); margin-right: 5px;"></td>
					<td>
						<div>
							<table style="width: 100%;text-align: center;"
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

