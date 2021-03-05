<%@page import="sym.common.dto.SessionDto"%>
<%@page import="sym.common.bean.PageInforBean"%>
<%@page import="sym.admin.bean.AdminCustomerBean"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
	<script type="text/javascript" src="../../../js/lib/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="../../../js/lib/jquery_plugin/bs/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="../../../js/lib/jquery_plugin/ui/jquery-ui.js"></script>
	<script type="text/javascript" src="../../../js/common/popup.js"></script>
	<script type="text/javascript" src="../../../js/lib/jquery_alert/jquery.alerts.js"></script>
	<link id="icon" href="../../../images/s.ico" rel="icon">
	<!--script 〓system-->

	<!--styles common-->
	<link href="../../../js/lib/jquery_plugin/bs/css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<link href="../../../js/lib/jquery_plugin/bs/css/bootstrap-responsive.css" rel="stylesheet" type="text/css">
	<link href="../../../css/common/bootstrap_setup.css" rel="stylesheet" type="text/css">
	<link href="../../../js/lib/jquery_plugin/ui/jquery-ui.css" rel="stylesheet" type="text/css">
	<link href="../../../css/common/popup.css" rel="stylesheet" type="text/css">
	<link href="../../../css/common/common.css" rel="stylesheet" type="text/css">
	<link href="../../../css/component/admin/master.css" rel="stylesheet" type="text/css">
	<link href="../../../js/lib/jquery_alert/jquery.alerts.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		var submitS='确定';
		var cancelC='取消';
		function inputLabel (get_customer_cd,get_customer_name,get_address,get_connect_kind,get_customer_type,get_is_valid) {
			$('#customer_cd').val(get_customer_cd);
			$('#customer_nm').val(get_customer_name);
			$('#address').val(get_address);
			$('#connect_kind').val(get_connect_kind);
			if(get_customer_type=="国网"){
				$("input:radio[name='customer_type'][value='1']").removeAttr("checked");
				$("input:radio[name='customer_type'][value='2']").removeAttr("checked");
				$("input:radio[name='customer_type'][value='3']").removeAttr("checked");
				$("input:radio[name='customer_type'][value='4']").removeAttr("checked");
				$("input:radio[name='customer_type'][value='1']").prop('checked', 'true');
				
			}if(get_customer_type=="南网"){
				$("input:radio[name='customer_type'][value='1']").removeAttr("checked");
				$("input:radio[name='customer_type'][value='2']").removeAttr("checked");
				$("input:radio[name='customer_type'][value='3']").removeAttr("checked");
				$("input:radio[name='customer_type'][value='4']").removeAttr("checked");
				$("input:radio[name='customer_type'][value='2']").prop('checked', 'true');
				
			}if(get_customer_type=="地方"){
				$("input:radio[name='customer_type'][value='1']").removeAttr("checked");
				$("input:radio[name='customer_type'][value='2']").removeAttr("checked");
				$("input:radio[name='customer_type'][value='3']").removeAttr("checked");
				$("input:radio[name='customer_type'][value='4']").removeAttr("checked");
				$("input:radio[name='customer_type'][value='3']").prop('checked', 'true');
				
			}if(get_customer_type=="海外"){
				$("input:radio[name='customer_type'][value='1']").removeAttr("checked");
				$("input:radio[name='customer_type'][value='2']").removeAttr("checked");
				$("input:radio[name='customer_type'][value='3']").removeAttr("checked");
				$("input:radio[name='customer_type'][value='4']").removeAttr("checked");
				$("input:radio[name='customer_type'][value='4']").prop('checked', 'true');
			}
			
			if(get_is_valid=="有效"){
				$("input:radio[name='sex'][value='F']").removeAttr('checked');
				$("input:radio[name='sex'][value='T']").prop('checked', 'true');
			}else if(get_is_valid=="无效"){
				$("input:radio[name='sex'][value='T']").removeAttr('checked');
				$("input:radio[name='sex'][value='F']").prop('checked', 'true');
			}
		}
		function clearLabel() {
			$('#customer_cd').val('');
			$('#customer_nm').val('');
			$('#address').val('');
			$('#connect_kind').val('');
		}

		var flag = true;

		$(function(){

			$(document).on('click','.sort',function(e){
				if($(this).find('span')[0] == null) {
					flag = false;
				}
				$('#search_result').find('.caret').remove();
				var sor = $('<span class="'+ (flag? 'caret up':'caret') +'"></span>');
				$(this).append(sor);
				flag = !flag;
			});

			$(document).on('dblclick','#search_result tr',function(e){
				$("#explain1").text("");
				$("#explain2").text("");
				$("#explain3").text("");
				$("#explain4").text("");
				var $tr=$(this);  //定位到当前行
				var $td=$tr.find("td");  //定位到当前行的列
				var get_customer_cd = $td.eq(0).text();
				var get_customer_name = $td.eq(1).text();
				var get_address = $td.eq(2).text();
				var get_connect_kind = $td.eq(3).text();
				var get_customer_type=$td.eq(4).text().trim();
				var get_is_valid = $td.eq(5).text();
				$("#customer_cd").attr("readonly","true");
				var param = {
						width : 800,
						height : 350,
						title : "客户编辑",
						modal : true,
						buttons : [{
							text : '保存',
							click : function() {
								updateCustomer();
								$(this).dialog('close');
							},
							'class' : 'btn btn-primary btn-middle'
						},
						{
							text : '取消',
							click : function() {
								$(this).dialog('close');
							},
							'class': 'btn btn-inverse btn-middle btn-aft-middle'
						}
						]
					};
					inputLabel(get_customer_cd,get_customer_name,get_address,get_connect_kind,get_customer_type,get_is_valid);
					openPop('customer_dialog',param);
			});
			$(document).on('click','.link-hand-dialog',function(e){
				$("#explain1").text("");
				$("#explain2").text("");
				$("#explain3").text("");
				$("#explain4").text("");
				var get_customer_cd = $(this).parent().parent().children().eq(0).text();
				var get_customer_name = $(this).parent().parent().children().eq(1).text();
				var get_address = $(this).parent().parent().children().eq(2).text();
				var get_connect_kind = $(this).parent().parent().children().eq(3).text();
				var get_customer_type = $(this).parent().parent().children().eq(4).text().trim();
				var get_is_valid = $(this).parent().parent().children().eq(5).text();
				$("#customer_cd").attr("readonly","true");
				$("input[name='customer_cd']").removeAttr("onblur");
				var param = {
					width : 800,
					height : 350,
					title : "客户编辑",
					modal : true,
					buttons : [{
						text : '保存',
						click : function() {
							updateCustomer();
							$(this).dialog('close');
						},
						'class' : 'btn btn-primary btn-middle'
					},
					{
						text : '取消',
						click : function() {
							$(this).dialog('close');
						},
						'class': 'btn btn-inverse btn-middle btn-aft-middle'
					}
					]
				};
				inputLabel(get_customer_cd,get_customer_name,get_address,get_connect_kind,get_customer_type,get_is_valid);
				openPop('customer_dialog',param);
			});
			$('#tonewuser').on('click',function(e){
				$("#explain1").text("");
				$("#explain2").text("");
				$("#explain3").text("");
				$("#explain4").text("");
				$("#customer_cd").removeAttr("readonly");
				$("input[name='customer_cd']").attr("onblur","check1()");
				var param = {
						width : 800,
						height : 350,
						title : "新增客户",
						modal : true,
						buttons : [{
							id:"add_sub",
							text : '保存',
							click : function() {
								var get_Customer_cd=document.getElementById("customer_cd").value;
								if(get_Customer_cd == ""){
									
								}else{
									insertCustomer();
								}
								$(this).dialog('close');
							},
							'class' : 'btn btn-primary btn-middle'
						},
						{
							text : '取消',
							click : function() {
								$(this).dialog('close');
							},
							'class': 'btn btn-inverse btn-middle btn-aft-middle'
						}
						]
					};
					clearLabel();
					openPop('customer_dialog',param);
			});

			//点击选中行
			$(document).on('click','#customer_table td',function(e){
				$('.row-select').removeClass('row-select');
				$(this).addClass('row-select');
			});


			/**
			 * 状态“全选”选中时，其余项设定选中
			 *
			 * @private
			 */
			$(document).on("click", "#is_valid_all", function() {
				var check = this.checked;
				$("input[name = 'is_valid']").each(function() {
					this.checked = check;
					if (check){
						$(this).parent().parent().addClass('table-row-selected');
					}else{
						$(this).parent().parent().removeClass('table-row-selected');
					}
				});
			});

			/**
			 * 状态“全选”外其余项选中全部选中时，设定“全选”为选中状态
			 *
			 * @private
			 */
			$(document).on("click", "input[name = 'is_valid']", function() {
				if (this.checked){
					$(this).parent().parent().addClass('table-row-selected');
				}else{
					$(this).parent().parent().removeClass('table-row-selected');
				}
				var $subBox = $("input[name = 'is_valid']");
				var length = $("input[name = 'is_valid']:checked").length;
				$("#is_valid_all")[0].checked = ($subBox.length == length) ? true : false;
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
					if (check){
						$(this).parent().parent().addClass('table-row-selected');
					}else{
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
				if (this.checked){
					$(this).parent().parent().addClass('table-row-selected');
				}else{
					$(this).parent().parent().removeClass('table-row-selected');
				}
				var $subBox = $("input[name = 'item_type_list']");
				var length = $("input[name = 'item_type_list']:checked").length;
				$("#type_all")[0].checked = ($subBox.length == length) ? true : false;
			});

		});

		function deleteContract(el){
			jConfirm('确认删除吗？', '确认对话框', function(r) {
				if (r == true) {
					$(el).parent().parent().remove();
				}
			});
		}
		/* function addCustomer() {
			var tr = [
					'<tr>',
					'<td>201402</td>',
					'<td>某市国家电网</td>',
					'<td>某市</td>',
					'<td>010-88881234</td>',
					'<td>国网</td>',
					'<td class="center_td"><i class="icon icon-effective"></i>有效</td>',
					'<td class="center_td"><a class="icon icon-edit link-hand-dialog">编辑</a></td>',
					'</tr>'
			];
			var tr_obj = $(tr.join());
			tr_obj.appendTo('#search_result tbody');
		} */
		
		
		/** 
		  *显示首页功能
		  *@author guojl   
		 */
		function showFirstPage()
		{
			document.forms[0].action="${pageContext.request.contextPath}/adminCustomerPageListAction?method=firstPage";
			document.forms[0].submit();
		}
		
		/**
		  * 根据页码和显示行数进行换页
		  *@author guojl
		  */
		function query(pageNo,display_rows)
		{
		    if(pageNo<1){
		    	alert("已经是第一页!");
		    	return false;
		    }
		    if(pageNo > '${pageInforBean.totalPage}'){
		    	alert("已经是最后一页!");
		    	return false;
		    }
		   
			document.forms[0].action="${pageContext.request.contextPath}/adminCustomerPageListAction?method=showPage&pageNo="+pageNo+"&showCount="+display_rows;
			document.forms[0].submit();
		
		}
		
		function insertCustomer()
		{ 
			//alert("login test");
			/* document.getElementById("currency_cd").value="";
			document.getElementById("currency_name").value=""; */
		  	document.forms[1].action="<%=path %>/adminCustomerAction?method=insertCustomer";
		  	document.forms[1].submit();
		  	return true;
		} 
		
		function updateCustomer()
		{ //alert("login test");
			
		  	document.forms[1].action="<%=path %>/adminCustomerAction?method=updateCustomer";
		  	document.forms[1].submit();
		  	return true;
		}
		
		var flag1 = false;//新增标识
		var flag2 = false;
		var flag3 = false;
		var flag4 = false;
		
		function check1() {
			var customer_cd = $("#customer_cd").val();
			var explain1 = $("#explain1");
			if (customer_cd == "") {
				explain1.text("客户编号空，请输入");
				flag1 = false;
			} else if (customer_cd.length > 15) {
				explain1.text("客户编号不得超过15位");
				flag1 = false;
			} else {
				checkInsert(customer_cd);
			}
			check();
		}
		
		function check2() {
			var customer_nm = $("#customer_nm").val();
			var explain2 = $("#explain2");
			if (customer_nm == "") {
				explain2.text("客户名空，请输入");
				flag2 = false;
			} else if (customer_nm.length > 15) {
				explain2.text("客户名不得超过15位");
				flag2 = false;
			} else {
				explain2.text("");
				flag2 = true;
			}
			check();
		}
		function check3() {
			var address = $("#address").val();
			var explain3 = $("#explain3");
			if (address == "") {
				explain3.text("联系地址空，请输入");
				flag3 = false;
			} else if (address.length > 100) {
				explain3.text("地址超过了字数(100)的限制");
				flag3 = false;
			} else {
				explain3.text("");
				flag3 = true;
			}
			check();
		}
		
		function check4() {
			var connect_kind = $("#connect_kind").val();
			var explain4 = $("#explain4");
			if (connect_kind == "") {
				explain4.text("联系方式空，请输入");
				flag4 = false;
			} else if (connect_kind.length > 15) {
				explain4.text("联系方式超过了字数(100)的限制");
				flag4 = false;
			} else {
				explain4.text("");
				flag4 = true;
			}
			check();
		}
		function checkInsert(customer_cd){
			var explain1 = $("#explain1");
			$.ajax({
				type : "get",
				url : "<%=path %>/adminCustomerAction?method=checkInsert",
				data : {
					"customer_cd" : customer_cd
				}, //要发送的数据参数
				dataType : "text",
				success : function(data) {
					if(data==0){
						explain1.text("编号已存在");
						flag1 = false;
					}else{
						explain1.text("");
						flag1 = true;
					}
					check();
					
				},
				error : function(msg){
					explain1.text("请检查网络连接");
				}
			});
		}
		function check(){
			if(flag1 && flag2 && flag3 && flag4){
				$("#add_sub").removeAttr("disabled");
				$("#add_sub").attr("class","btn btn-primary btn-middle");
			}else{
				$("#add_sub").attr("disabled","disabled");
			}
		}
	</script>
</head>
<body>
<!--▼▼▼header▼▼▼-->
<header> 
	<%@ include file="../../common/header"%>
</header>
<!--▼▼▼search▼▼▼-->
<div class="container-fluid search disabled">
	<div class="row-fluid">
	</div>
</div>
<!--▼▼▼contents(field type)▼▼▼-->
<div class="main">
	<div class="banner" >
		<span>客户管理</span>
	</div>
	<div class="content">
		<!-- search-table -->
		<form method="post">
		<div class="search-table" id="search_table">
			<span style="background-color: #FFFFFF;font-size: 14px;left: 10px;position: relative;top: 9px;">&nbsp;查询条件&nbsp;</span>
			<div style="padding:10px;border-width:1px 0;border-style:solid;border-color:#0088CC;">
					<table class="table-edit" style="width: 90%; margin: 0 auto;">
						<tr>
							<td style="width: 100px" class="right_align" value="${pageInforBean.hm.customer_nm}">
								客户名称&nbsp;:
							</td>
							<td style="width: 260px">
								<input class="input-xlarge" type="text"
									style="width: 160px; text-align: left;"
									value="" name="customer_nm">
							</td>
							<td style="width: 100px" class="right_align" value="${pageInforBean.hm.connect_kind}">
								联系方式&nbsp;:
							</td>
							<td style="width: 260px">
								<input class="input-xlarge" type="text"
									style="width: 160px; text-align: left;"
									value="" name="connect_kind">
							</td>
						</tr>
						<tr>
							<td style="" class="right_align">
								客户类别&nbsp;:
							</td>
							<td>
								<label class="checkbox inline">
									<input id="type_all" type="checkbox" id="type_all" name="customer_type_all" value="ALL" checked>
									<span class="input-label">全部</span>
								</label>
								<label class="checkbox inline">
									<input id="type_1" type="checkbox" id="type_1" name="customer_type_list" value="1" checked>
									<span class="input-label">国网</span>
								</label>
								<label class="checkbox inline">
									<input id="type_2" type="checkbox" id="type_2" name="customer_type_list" value="2" checked>
									<span class="input-label">南网</span>
								</label>
								<label class="checkbox inline">
									<input id="type_3" type="checkbox" id="type_3" name="customer_type_list" value="3" checked>
									<span class="input-label">地方</span>
								</label>
								<label class="checkbox inline">
									<input id="type_4" type="checkbox" id="type_4" name="customer_type_list" value="4" checked>
									<span class="input-label">海外</span>
								</label>
							</td>
							<td class="right_align">
								状态&nbsp;:
							</td>
							<td>
								<label class="checkbox inline">
									<input id="is_valid_all" type="checkbox" id="is_valid_all" name="is_valid_all" value="ALL" ${pageInforBean.hm.is_valid eq '%'?'checked':''}>
									<span class="input-label">全部</span>
								</label>
								<label class="checkbox inline">
									<input id="is_valid_t" type="checkbox" id="is_valid_t" name="is_valid" value="T" ${(pageInforBean.hm.is_valid eq '%')||(pageInforBean.hm.is_valid eq 'T') ?'checked':''}>
									<span class="input-label">有效</span>
								</label>
								<label class="checkbox inline">
									<input id="is_valid_f" type="checkbox" id="is_valid_f" name="is_valid" value="F" ${pageInforBean.hm.is_valid eq '%'||(pageInforBean.hm.is_valid eq 'F')?'checked':''}>
									<span class="input-label">无效</span>
								</label>
							</td>
						</tr>
					</table>
				<div class="search-foot-btn">
					<a class="btn btn-warning btn-small" id="clear_input">重置</a>
					<a class="btn btn-success btn-small-aft" id="search" href="javascript:showFirstPage()">查询</a>
				</div>
			</div>
		</div>
		</form>
		<!-- search-table -->
		<div class = "search-result">
			<div id="" class="top-btn-bar">
				<a id="tonewuser" class="icon icon-add" href="javascript:void(0);" title="">
				新增客户</a>
			</div>
			<div id="search_result" class="search-result-content" >
			<table class="table table-striped table-bordered" id="customer_table">
				<thead>
					<tr>
						<th width="10%"><a class="sort " href="javascript:void(0);" >客户编号<span class="caret"></span></a></th>
						<th width="15%"><a class="sort " href="javascript:void(0);" >客户名称</a></th>
						<th width="36%">地址</th>
						<th width="15%">联系方式</th>
						<th width="8%"><a class="sort " href="javascript:void(0);" >类别</a></th>
						<th width="8%"><a class="sort " href="javascript:void(0);" >状态</a></th>
						<th width="8%"></th>
					</tr>
				</thead>
				<tbody id="list">
				<%
									
									PageInforBean listBean = (PageInforBean)session.getAttribute("pageInforBean");
								    List currList = new ArrayList();
								    int totalPage = 0; //总页数
									if (listBean != null) {
										currList = listBean.getList(); //获取当前页面显示列表集合
										totalPage = listBean.getTotalPage(); //获取总页数
									}
									for (int i = 0; i < currList.size(); i++) {
										AdminCustomerBean curr = (AdminCustomerBean)currList.get(i);
								%>
					<tr>
						<td><%=curr.getCustomer_cd()%></td>
						<td><%=curr.getCustomer_nm() %></td>
						<td><%=curr.getAddress() %></td>
						<td><%=curr.connect_kind %></td>
						<td><%if (curr.getCustomer_type().equals("1")){
							%>国网<%}%><%if (curr.getCustomer_type().equals("2")){
							%>南网<%}%><%if (curr.getCustomer_type().equals("3")){
 							%>地方<%}%><%if (curr.getCustomer_type().equals("4")){
							%>海外<%}%>
						</td>
						<td class="center_td"><i class="<%="T".equals(curr.getIs_valid()) ? "icon icon-effective" : "icon icon-invalid"%>"></i><%if("T".equals(curr.getIs_valid())){%>有效<%}else{ %>无效<%} %></td>
						<td class="center_td"><a class="icon icon-edit link-hand-dialog">编辑</a></td>
					</tr>
								<%
									}
								%>
				</tbody>
		</table>
	</div>
</div>

	<div id="pagination" >
		<div id='project_pagination' class="pagination pagination-centered">
			<div class="pagination">
				<ul>
								<li>
									<a href="javascript:void(0)" onclick="query(${pageInforBean.currentPage-1},${pageInforBean.showCount })">«</a>
								</li>
								<%
									for (int i = 1; i <= totalPage; i++) {
								%>
								<li class='<%=(i==listBean.getCurrentPage()?"active":"")%>'>
									<a href="javascript:query(<%=i%>,${pageInforBean.showCount } )"><%=i%></a>
								</li>
								<%
									}
								%>
								<li><a href="javascript:void(0)" onclick="query(${pageInforBean.currentPage+1 },${pageInforBean.showCount })">»</a></li>
							</ul>
				<ul>
								<%-- <li><span>(${(listBean.currentPage-1)*10+1} - ${listBean.currentPage*10}/<%=totalNum %>)</span></li> --%>
								
									<li>
										<span>(${pageInforBean.fromCount}-${pageInforBean.fromCount+pageInforBean.showCount-1}/${pageInforBean.totalNumber})</span>
									</li>
					

								<li>
									<span>显示条数&nbsp;:&nbsp;</span>
								</li>
							</ul>
							<ul>
								<li class="<%=(10==listBean.getShowCount()?"active":"")%>">
									<a href="javascript:query(1,10)">10</a>
								</li>
								<li class="<%=(30==listBean.getShowCount()?"active":"")%>">
									<a href="javascript:query(1,30)">30</a>
								</li>
								<li class="<%=(50==listBean.getShowCount()?"active":"")%>">
									<a href="javascript:query(1,50)">50</a>
								</li>
							</ul>
			</div>
		</div>
	</div>

</div>
	<div class="bottom_block">
		<a class="btn btn-info btn-middle" style="" href="../../menu/mainMenuG.jsp">返回主菜单</a>
	</div>
</div>



<%
	String rt_msg=(String)session.getAttribute("rt_msg");
	session.removeAttribute("rt_msg");
	if(rt_msg==null){
		rt_msg="";
	}else{
	%>
<script type="text/javascript" language="javascript">
	alert("<%=rt_msg%>");       
	// 弹出错误信息  
</script>
	<% }%>
<div class="pop-dialog" id="customer_dialog">
<form action="" name="update_Customer_Form" method="post">
	<table class="table-edit table-bordered table-striped">
		<tr>
			<td class="right_align" style="width: 150px"><div class="">客户编号&nbsp;:&nbsp;</div></td>
			<td colspan="3"><input id="customer_cd" type="text" style="width:120px;ime-mode: disabled"  name="customer_cd" onpropertychange="check1()" oninput="check1()"></input>
				<span style="font-size: 10px;color: red"   id="explain1" ></span> 				
			</td>
		</tr>
		<tr>
			<td class="right_align"><div class="">客户名称&nbsp;:&nbsp;</div></td>
			<td colspan="3"><input id="customer_nm" type="text" class="must" style="width:300px;" name="customer_name" onBlur="check2()" onpropertychange="check2()" oninput="check2()"></input>
			<span style="font-size: 10px;color: red"   id="explain2" ></span> 
			</td>
		</tr>
		<tr>
			<td class="right_align"><div class="">地址&nbsp;:&nbsp;</div></td>
			<td colspan="3"><input id="address" type="text" style="width:400px;"name="address" onBlur="check3()" onpropertychange="check3()" oninput="check3()"></input>
			<span style="font-size: 10px;color: red"   id="explain3" ></span> 
			</td>
		</tr>
		<tr>
			<td class="right_align"><div class="">联系方式&nbsp;:&nbsp;</div></td>
			<td colspan="3"><input id="connect_kind" type="text" class="must" style="width:400px;" name="connected_kind" onBlur="check4()" onpropertychange="check4()" oninput="check4()"></input>
			<span style="font-size: 10px;color: red"   id="explain4" ></span> 
			</td>
		</tr>
		<tr>
		<td class="right_align"><div class="">类别&nbsp;:&nbsp;</div></td>
		<td colspan="3">
				<label class="radio inline">
						<input type="radio" name="customer_type" value="1" id="customer_type_1" checked="checked"></input>国网
				</label>
				<label class="radio inline">
						<input type="radio" name="customer_type" value="2" id="customer_type_2"></input>南网
				</label>
				<label class="radio inline">
						<input type="radio" name="customer_type" value="3" id="customer_type_3"></input>地方
				</label>
				<label class="radio inline">
						<input type="radio" name="customer_type" value="4" id="customer_type_4"></input>海外
				</label>
		</td>
		</tr>
		<tr>
			<td class="right_align"><div class="">状态&nbsp;:&nbsp;</div></td>
			<td colspan="3">
			<label class="radio inline">
				<input type="radio" name="sex" value="T" checked></input>有效
					</label>
					<label class="radio inline">
				<input type="radio" name="sex" value="F"></input>无效
				</label>
			</td>
		</tr>
	</table>
	</form>
</div>

</body>
</html>
