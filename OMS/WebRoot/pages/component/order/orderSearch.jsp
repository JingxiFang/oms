<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="sym.common.dto.SessionDto"%>
<%@page import="sym.common.bean.AdminUserBean"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	SessionDto dto = (SessionDto) session.getAttribute("dto");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<script type="text/javascript"
	src="../../../js/lib/jquery/jquery.min.js"></script>
<script type="text/javascript"
	src="../../../js/lib/jquery_plugin/bs/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="../../../js/lib/jquery_plugin/placeholder/jquery.placeholder.js"></script>
<script type="text/javascript"
	src="../../../js/lib/jquery_plugin/ui/jquery-ui.js"></script>
<script type="text/javascript" src="../../../js/common/popup.js"></script>
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
<link href="../../../js/lib/jquery_plugin/ui/jquery-ui.css"
	rel="stylesheet" type="text/css">
<link href="../../../css/common/bootstrap_setup.css" rel="stylesheet"
	type="text/css">
<link href="../../../css/common/common.css" rel="stylesheet"
	type="text/css">
<link href="../../../css/common/popup.css" rel="stylesheet"
	type="text/css">
<link href="../../../js/lib/jquery_alert/jquery.alerts.css"
	rel="stylesheet" type="text/css">
<script type="text/javascript">
	var flag = true; //升序
	var submitS = '确定';
	var cancelC = '取消';
	var showCount = 10; //当前页显示数--前端
	var fromCount = 1; //当前开始记录数--后台
	var totalNumber = 0; //记录总条数--后台
	var totalPage = 0; //总页数--后台
	var nums = 0; //总记录数--后台
	var currentPage = 1; //当前页--前端
	var order = "default";
	var orderBy = "default";
	$(function() {
		submit();
		/* 点击当前页码 */
		$(document).on('click', '.page_num', function(e) {
			var text = $(this).text();
			$(this).parent().parent().children().removeClass("active");
			if (text == "«" && currentPage != 1) {
				currentPage--;
			} else if (text == "»" && currentPage != totalPage) {
				currentPage++;
			} else if (text != "«" && text != "»") {
				currentPage = text;
			}
			submit();
		});
		//重置当前页
		function resetCurrentPage() {
		}
		/* 点击显示条目 */
		$(document).on('click', '.num', function(e) {
			$('.caret').remove();
			$(this).parent().parent().children().removeClass("active");
			$(this).parent().addClass('active');
			currentPage = 1;
			showCount = $(this).text();
			submit();
		});
		/* 点击排序 */
		$(document).on('click', '.sort', function(e) {
			if ($(this).find('span')[0] == null) {
				flag = false;
			}
			order = "up";
			if (!flag) {
				order = "down";
			}
			orderBy = $(this).attr("id");
			currentPage = 1;
			submit();
			$('.caret').remove();
			var sor = $('<span class="' + (flag ? 'caret up' : 'caret') + '"></span>')
			$(this).append(sor);
			flag = !flag;
		});

		$('#clear_input').bind('click', function(e) {
			$('#search_table').find('.is-search').val('');
			$('#person').val('1');
		});
		$('#search_result td').on('dblclick', function(e) {
			window.location = "orderUpdate.html";
		});
		$('#search_result td').on('click', function(e) {
			$('.row-select').removeClass('row-select');
			$(this).parent().addClass('row-select');
		});

		/**
		 * 客户类别“全选”选中时，其余项设定选中
		 *
		 * @private
		 */
		$(document).on("click", "#type_all", function() {
			var check = this.checked;
			$("input[name = 'item_type_list']").each(function() {
				this.checked = check;
				if (check) {
					$(this).parent().parent().addClass('table-row-selected')
				} else {
					$(this).parent().parent().removeClass('table-row-selected');
				}
			});
		});

		/**
		 * 客户类别“全选”外其余项选中全部选中时，设定“全选”为选中状态
		 *
		 * @private
		 */
		$(document).on("click", "input[name = 'item_type_list']", function() {
			if (this.checked) {
				$(this).parent().parent().addClass('table-row-selected');
			} else {
				$(this).parent().parent().removeClass('table-row-selected');
			}
			var $subBox = $("input[name = 'item_type_list']");
			var length = $("input[name = 'item_type_list']:checked").length;
			$("#type_all")[0].checked = ($subBox.length == length) ? true : false;
		});

		/**
		 * 回款状态“全选”选中时，其余项设定选中
		 *
		 * @private
		 */
		$(document).on("click", "#back_section_end_all", function() {
			var check = this.checked;
			$("input[name = 'back_section_end']").each(function() {
				this.checked = check;
				if (check) {
					$(this).parent().parent().addClass('table-row-selected')
				} else {
					$(this).parent().parent().removeClass('table-row-selected');
				}
			});
		});

		/**
		 * 回款状态“全选”外其余项选中全部选中时，设定“全选”为选中状态
		 *
		 * @private
		 */
		$(document).on("click", "input[name = 'back_section_end']", function() {
			if (this.checked) {
				$(this).parent().parent().addClass('table-row-selected');
			} else {
				$(this).parent().parent().removeClass('table-row-selected');
			}
			var $subBox = $("input[name = 'back_section_end']");
			var length = $("input[name = 'back_section_end']:checked").length;
			$("#back_section_end_all")[0].checked = ($subBox.length == length) ? true : false;
		});


		$(document).on("click", "#search", function() {
			currentPage = 1;
			submit();
		});

		$(document).on("dblclick", ".order", function() {
			var order_received_payments_flg = $(this).children().eq(4).text();
			var orders_id = $(this).children().eq(0).children().first().val()
			if (order_received_payments_flg == "结束") {
				window.location.href = 'orderInfo.jsp?orders_id=' + orders_id;
			} else {
				window.location.href = 'orderUpdate.jsp?orders_id=' + orders_id;
			}

		});

		function submit() {
			var dataObj;
			var contract_no = $("#contract_no").val();
			var agency_user_nm = $("#agency_user_nm").val();
			var customer_nm = $("#customer_nm").val();
			var project_nm = $("#project_nm").val();
			var type_1 = $("#type_1").is(':checked');
			var type_2 = $("#type_2").is(':checked');
			var type_3 = $("#type_3").is(':checked');
			var type_4 = $("#type_4").is(':checked');
			var back_section_end_F = $("#back_section_end_F").is(':checked');
			var back_section_end_T = $("#back_section_end_T").is(':checked');
			var types = new Array();
			var back_sections = new Array();
			if (type_1) {
				types.push("type_1");
			}
			if (type_2) {
				types.push("type_2");
			}
			if (type_3) {
				types.push("type_3");
			}
			if (type_4) {
				types.push("type_4");
			}
			if (back_section_end_F) {
				back_sections.push("back_section_end_F");
			}
			if (back_section_end_T) {
				back_sections.push("back_section_end_T");
			}
			$.ajax({
				type : "get", //数据发送的方式（post 或者 get）
				url : "<%=path%>/orderAction?method=getOrders", //要发送的后台地址
				transition : true,
				data : {
					"showCount" : showCount, //每页条数
					"currentPage" : currentPage, //当前页数
					"orderBy" : orderBy,
					"order" : order,
					"contract_no" : contract_no,
					"agency_user_nm" : agency_user_nm,
					"customer_nm" : customer_nm,
					"project_nm" : project_nm,
					"types" : JSON.stringify(types),
					"back_sections" : JSON.stringify(back_sections)
				}, //要发送的数据参数
				dataType : "text", //后台处理后返回的数据格式
				success : function(data) { //ajax请求成功后触发的方法
					dataObj = JSON.parse(data);
					getTbody(dataObj);
				},
				error : function(msg) { //ajax请求失败后触发的方法
					alert("服务器请求失败!"); //弹出错误信息
				}
			});

		}
		function getTbody(dataObj) {
			fromCount = dataObj.fromCount;
			totalNumber = dataObj.totalNumber;
			totalPage = dataObj.totalPage;
			showCount = dataObj.showCount;
			toCount = fromCount + showCount - 1;
			(toCount > totalNumber) ? toCount = totalNumber : toCount;
			var now = 0;
			var pages = new Array();
			if (currentPage == 1 || currentPage == 2 || currentPage == 3) {
				for (var i = 1; i <= 5; i++) {
					pages.push(i);
					if (i <= currentPage)
						now++;
					if (i == totalPage)
						break;
				}
			} else {
				if (totalPage >= currentPage + 2) {
					for (var i = currentPage - 2; i <= currentPage + 2; i++) {
						pages.push(i);
						if (i <= currentPage)
							now++;
						if (i == totalPage)
							break;
					}
				} else {
					var start = totalPage - 4 > 0 ? totalPage - 4 : 1;
					for (var i = start; i <= totalPage; i++) {
						pages.push(i);
						if (i <= currentPage)
							now++;
					}
				}
			}

			if (totalNumber != 0) {
				$("#search-result").css("display", "inline");
				$("#search-result-none").css("display", "none");
			} else {
				$("#search-result").css("display", "none");
				$("#search-result-none").css("display", "inline");
			}
			$("#search-result-pages").text(fromCount + "-" + toCount + "/" + totalNumber);


			//页码导航	
			$("#page_index").empty();
			$("#page_index").append("<li id=\"pre\"><a class=\"page_num\" href=\"#\">«</a></li>");
			for (i = 0; i < pages.length; i++) {
				$("#page_index").append("<li><a class=\"page_num\" href=\"#\">" + pages[i] + "</a></li>");

			}
			$("#page_index").append("<li id=\"next\"><a class=\"page_num\" href=\"#\">»</a></li>");
			$("#page_index").children("li:eq(" + now + ")").addClass('active');

			//下一页按钮
			if (currentPage == totalPage) {
				$("#next").removeClass("disabled");
				$("#next").addClass('disabled');
			} else {
				$("#next").removeClass("disabled");
			}
			//上一页按钮
			if (currentPage == 1) {
				$("#pre").removeClass("disabled");
				$("#pre").addClass('disabled');
			} else {
				$("#pre").removeClass("disabled");
			}
			var search_tbody = $("#search_tbody");
			var orders = dataObj.list;
			search_tbody.empty();
			for (var i = 0; i < orders.length; i++) {
				var order = orders[i];
				var flg;

				if (order.received_payments_flg == "F") {
					flg = "未结束";
				} else {
					flg = "结束";
				}
				var str = "<tr class='order'><td><input type='hidden' value='" + order.orders_id + "'/>" + order.agency_user_nm + "</td>" +
					"<td><a onclick=\"window.location='orderInfo.jsp?order_id="
					+ order.orders_id + "'\">" + order.contract_no + "</a></td>"
					+ "<td>" + order.customer_nm + "</td><td>" + order.project_nm + "</td>"
					+ "<td class=\"center_td\">" + flg + "</td>"
					+ "<td><a class=\"icon icon-record\""
					+ "onclick=\"window.location='orderVersion.jsp?contract_no="+ order.contract_no +"'\">履历</a>"
					+ "&nbsp;&nbsp;&nbsp; <a class=\"icon icon-edit\""
					+ "onclick=\"window.location='orderUpdate.jsp?orders_id=" + order.orders_id + "'\">编辑</a>"
					+ "&nbsp;&nbsp;&nbsp; <a class=\"icon icon-remove\""
					+ "onclick=\"deleteContract(this);\">删除</a></td></tr>";

				search_tbody.append(str);
			}
		}
	});
	function deleteContract(el) {
		
		jConfirm('确认删除吗？', '确认对话框', function(r) {
			if (r == true) {
				var tr = $(el).parent().parent();
				var orders_id = tr.children().eq(0).children().eq(0).val();
				//jWarning('该订单登记了回款或发票信息，不能删除', '', '错误对话框', function(r) {});
				$.ajax({
					type : "get", //数据发送的方式（post 或者 get）
					url : "<%=path%>/orderAction?method=deleteOrder", //要发送的后台地址
					transition : true,
					data : {
						"orders_id" : orders_id
					}, //要发送的数据参数
					dataType : "text", //后台处理后返回的数据格式
					success : function(data) { //ajax请求成功后触发的方法
						if(data==0){
							alert("删除失败!");
						}else{
							alert("删除成功!");
							location.reload(); 
						}
					}
				});
			}
		});
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
			<span>订单查询/变更</span>
		</div>
		<div class="content">
			<div class="search-table" id="search_table">
				<span
					style="background-color: #FFFFFF; font-size: 14px; left: 10px; position: relative; top: 9px;">&nbsp;查询条件&nbsp;</span>
				<div
					style="padding: 10px; border-width: 1px 0; border-style: solid; border-color: #0088CC;">
					<table class="table-edit" style="width: 90%; margin: 0 auto;">
						<tr>
							<td style="width: 100px" class="right_align">合同号&nbsp;:</td>
							<td style="width: 260px"><input
								class="input-xlarge is-search" id="contract_no" type="text"
								style="width: 160px; text-align: left; ime-mode: disabled"
								value=""></td>
							<td style="width: 100px" class="right_align">业务员&nbsp;:</td>
							<td style="width: 260px">
								<%
									if (dto.getUser_owner_flg().equals("S")) {
								%> <input class="input-xlarge" id="agency_user_nm" type="text"
								readonly="readonly" style="width: 160px; text-align: left;"
								value="${dto.user_nm}"> <%
 	} else if (dto.getUser_owner_flg().equals("M")) {
 %> <input class="input-xlarge is-search" id="agency_user_nm"
								type="text" style="width: 160px; text-align: left;" value="">
								<%
									}
								%>
							</td>
						</tr>
						<tr>
							<td class="right_align">客户名称&nbsp;:</td>
							<td><input class="input-xlarge is-search" type="text"
								id="customer_nm" style="width: 220px; text-align: left;"
								value=""></td>
							<td class="right_align">项目名称&nbsp;:</td>
							<td style="width: 260px"><input
								class="input-xlarge is-search" id="project_nm" type="text"
								style="width: 220px; text-align: left;" value=""></td>
						</tr>
						<tr>
							<td class="right_align">客户类别&nbsp;:</td>
							<td><label class="checkbox inline"> <input
									id="type_all" type="checkbox" id="type_all" name="type_all"
									value="type_all" checked> <span class="input-label">全部</span>
							</label> <label class="checkbox inline"> <input id="type_1"
									type="checkbox" id="type_1" name="item_type_list"
									value="type_1" checked> <span class="input-label">国网</span>
							</label> <label class="checkbox inline"> <input id="type_2"
									type="checkbox" id="type_2" name="item_type_list"
									value="type_2" checked> <span class="input-label">南网</span>
							</label> <label class="checkbox inline"> <input id="type_3"
									type="checkbox" id="type_3" name="item_type_list"
									value="type_3" checked> <span class="input-label">地方</span>
							</label> <label class="checkbox inline"> <input id="type_4"
									type="checkbox" id="type_4" name="item_type_list"
									value="type_4" checked> <span class="input-label">海外</span>
							</label></td>
							<td class="right_align">回款状态&nbsp;:</td>
							<td><label class="checkbox inline"> <input
									id="back_section_end_all" type="checkbox"
									id="back_section_end_all" name="back_section_end_all"
									value="ALL"> <span class="input-label">全部</span>
							</label> <label class="checkbox inline"> <input
									id="back_section_end_F" type="checkbox" id="back_section_end_F"
									name="back_section_end" value="F" checked> <span
									class="input-label">未结束</span>
							</label> <label class="checkbox inline"> <input
									id="back_section_end_T" type="checkbox" id="back_section_end_T"
									name="back_section_end" value="T"> <span
									class="input-label">结束</span>
							</label></td>
						</tr>
					</table>
					<div class="search-foot-btn">
						<a class="btn btn-warning btn-small" id="clear_input">重置</a> <a
							class="btn btn-success btn-small-aft" id="search">查询</a>
					</div>
				</div>
			</div>
			<div id="search-result-none"
				style="display:none;font-size:20px;margin:20px;">
				<div style="padding:10px">sorry,I didn't find the result
					according to your condition!</div>
			</div>
			<div class="search-result" id="search-result" style="display: none">
				<div id="search_result" style="padding: 10px;">
					<table class="table table-striped table-bordered"
						style="background-color: #E4F4CB;">
						<thead>
							<tr>
								<th style="width: 8%; height: 25px;"><a class="sort"
									id="agency_user_nm">业务员</a></th>
								<th style="width: 13%"><a class="sort" id="contract_no">合同号</a></th>
								<th style="width: 24%"><a class="sort" id="customer_nm">客户名称</a></th>
								<th style="width: 25%"><a class="sort" id="project_nm">项目名称</a></th>
								<th style="width: 8%"><a class="sort"
									id="received_payments_flg">回款状态</a></th>
								<th style="width: 22%"></th>
							</tr>
						</thead>
						<tbody id="search_tbody">
							<tr>
								
							</tr>
						</tbody>
					</table>
				</div>
				<div id="pagination" style="align: center;">
					<div id='project_pagination' class="pagination pagination-centered">
						<div class="pagination">
							<ul id="page_index">
								<li id="pre" class="disabled"><a class="page_num" href="#">«</a></li>
								<li class="active"><a class="page_num" href="#">1</a></li>
								<li><a class="page_num" href="#">2</a></li>
								<li><a class="page_num" href="#">3</a></li>
								<li><a class="page_num" href="#">4</a></li>
								<li><a class="page_num" href="#">5</a></li>
								<li id="next"><a class="page_num" href="#">»</a></li>
							</ul>
							<ul>
								<li><span id="search-result-pages">(1-10/38)</span></li>
								<li><span>显示条数：</span></li>
							</ul>
							<ul>
								<li class="active"><a href="#" class="num">10</a></li>
								<li class=""><a href="#" class="num">30</a></li>
								<li class=""><a href="#" class="num">50</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="bottom_block">
			<a class="btn btn-info btn-middle" style=""
				href="<%=basePath%>loginAction?method=main">返回主菜单</a>
		</div>
	</div>

</body>
</html>
