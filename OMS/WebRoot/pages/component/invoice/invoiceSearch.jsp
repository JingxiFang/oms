<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="sym.component.bean.OrderBean"%>
<%@page import="sym.common.bean.PageInforBean"%>
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
	<script type="text/javascript" src="../../../js/lib/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="../../../js/lib/jquery_plugin/bs/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="../../../js/lib/jquery_plugin/placeholder/jquery.placeholder.js"></script>
	<script type="text/javascript" src="../../../js/lib/jquery_plugin/ui/jquery-ui.js"></script>
	<script type="text/javascript" src="../../../js/common/popup.js"></script>
	<link id="icon" href="../../../images/s.ico" rel="icon">
	<!--script 〓system-->

	<!--styles common-->
	<link href="../../../js/lib/jquery_plugin/bs/css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<link href="../../../js/lib/jquery_plugin/bs/css/bootstrap-responsive.css" rel="stylesheet" type="text/css">
	<link href="../../../js/lib/jquery_plugin/ui/jquery-ui.css" rel="stylesheet" type="text/css">
	<link href="../../../css/common/bootstrap_setup.css" rel="stylesheet" type="text/css">
	<link href="../../../css/common/common.css" rel="stylesheet" type="text/css">
	<link href="../../../css/common/popup.css" rel="stylesheet" type="text/css">

	<script type="text/javascript">
		var flag = true;
		$(function(){

			$(document).on('click','.sort',function(e){
				if($(this).find('span')[0] == null) {
						flag = false;
				}
				$('.caret').remove();
				var sor = $('<span class="'+ (flag? 'caret up':'caret') +'"></span>')
				$(this).append(sor);
				flag = !flag;
			});

			$('#clear_input').bind('click',function(e){
				$('#search_table').find('input').val('');
				$('#person').val('1');
			});

			//双击某一行
			$('#search_result td').on('dblclick',function(e){
				var Contract_no=$(this).parent().find("td").eq(1).text();			
			    window.location = "invoiceInsert.jsp?contract_num="+Contract_no;
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
						$(this).parent().parent().addClass('table-row-selected')
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
			/**
			 * 回款状态“全选”选中时，其余项设定选中
			 *
			 * @private
			 */
			$(document).on("click", "#back_section_end_all", function() {
				var check = this.checked;
				$("input[name = 'back_section_end']").each(function() {
					this.checked = check;
					if (check){
						$(this).parent().parent().addClass('table-row-selected')
					}else{
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
				if (this.checked){
					$(this).parent().parent().addClass('table-row-selected');
				}else{
					$(this).parent().parent().removeClass('table-row-selected');
				}
				var $subBox = $("input[name = 'back_section_end']");
				var length = $("input[name = 'back_section_end']:checked").length;
				$("#back_section_end_all")[0].checked = ($subBox.length == length) ? true : false;
			});
		});
		
		function chooseUser(){
			$('#user_dialog').dialog('close');
			$('#user_id').val('0001');
			$('#user_name').val('李四');
		}
		
		
		/** 
		  *显示首页功能
		  *@author guojl   
		 */
		function showFirstPage()
		{
			document.forms[0].action="${pageContext.request.contextPath}/OrderPageListAction?method=firstPage&action=invoiceInsert";
			document.forms[0].submit();
		}
		/**
		  * 根据页码和显示行数进行换页
		  *@author guojl
		  */
		function query(pageNo,display_rows,orderBy,sc)
		{
		    if(pageNo<1){
		    	alert("已经是第一页!");
		    	return false;
		    }
		    if(pageNo > '${pageInforBean.totalPage}'){
		    	alert("已经是最后一页!");
		    	return false;
		    }
		    <%PageInforBean bean = (PageInforBean) request.getSession().getAttribute("pageInforBean");
				String orderBy = bean.getHm().get("orderBy").toString();
				String oldSc = bean.getHm().get("sc").toString();
				String newSc = "asc".equals(oldSc) ? "desc" : "asc";%>
			if(orderBy == ""||orderBy == "undefined"){
				 orderBy = "<%=orderBy%>";
			}
			if(sc == null){
				sc = "<%=newSc%>";
			}
		  
			document.forms[0].action="${pageContext.request.contextPath}/OrderPageListAction?action=invoiceSearch&method=showPage&pageNo="+pageNo+"&showCount="+display_rows+"&orderBy="+orderBy+"&sc="+sc;
			document.forms[0].submit();
		
		}
		function sub(){
			document.forms[0].action="${pageContext.request.contextPath}/OrderPageListAction?action=invoiceSearch&method=firstPage";
			document.forms[0].submit();
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
	<div class="row-fluid">
	</div>
</div>
<!--▼▼▼contents(field type)▼▼▼-->

<div class="main">
	<div class="banner">
			<span>发票录入</span>
	</div>
	<div class="content">
		<!-- search-table -->
		<div class="search-table" id="search_table">
			<span style="background-color: #FFFFFF;font-size: 14px;left: 10px;position: relative;top: 9px;">&nbsp;查询条件&nbsp;</span>
			<form method="post">
			<div style="padding:10px;border-width:1px 0;border-style:solid;border-color:#0088CC;">
					<table class="table-edit" style="width: 90%; margin: 0 auto;">
						<tr>
							<td style="width: 100px" class="right_align">
								合同号&nbsp;:
							</td>
							<td style="width: 260px">
								<input name="contract_num" class="input-xlarge" type="text"
									style="width: 160px; text-align: left; ime-mode: disabled"
									value='${pageInforBean.hm.contract_num==""?"":pageInforBean.hm.contract_num}'>
							</td>
							<td style="width: 100px" class="right_align">
								业务员&nbsp;:
							</td>
							<td style="width: 260px">
								<input name="salesman_nm" class="input-xlarge" type="text" 
									style="width: 160px; text-align: left;"
									value="${dto.user_owner_flg=='S'?dto.user_nm:(pageInforBean.hm.salesman_nm==''?'':pageInforBean.hm.salesman_nm) }"
									${dto.user_owner_flg=='S'?"disabled":""}
									>
							</td>
						</tr>
						<tr>
							<td class="right_align">
								客户名称&nbsp;:
							</td>
							<td>
								<input name="customer_nm" class="input-xlarge" type="text"
									style="width: 220px; text-align: left;"
									value='${pageInforBean.hm.customer_nm==""?"":pageInforBean.hm.customer_nm}'>
							</td>
							<td class="right_align">
								项目名称&nbsp;:
							</td>
							<td style="width: 260px">
								<input name="projecct_nm"class="input-xlarge" type="text"
									style="width: 220px; text-align: left;"
									value='${pageInforBean.hm.project_nm==""?"":pageInforBean.hm.project_nm}'>
							</td>
						</tr>
						<tr>
							<td style="" class="right_align">
								客户类别&nbsp;:
							</td>
							<td>
								<label class="checkbox inline">
									<input id="type_all" type="checkbox" id="type_all" name="type_all" value="type_all" ${pageInforBean.hm.category eq '%'?'checked':''}>
									<span class="input-label">全部</span>
								</label>
								<label class="checkbox inline">
									<input id="type_1" type="checkbox" id="type_1" name="item_type_list" value="1" ${(pageInforBean.hm.category eq '%')||(pageInforBean.hm.category1 eq '1')?'checked':''}>
									<span class="input-label">国网</span>
								</label>
								<label class="checkbox inline">
									<input id="type_2" type="checkbox" id="type_2" name="item_type_list" value="2" ${(pageInforBean.hm.category eq '%')||(pageInforBean.hm.category2 eq '2')?'checked':''}>
									<span class="input-label">南网</span>
								</label>
								<label class="checkbox inline">
									<input id="type_3" type="checkbox" id="type_3" name="item_type_list" value="4" ${(pageInforBean.hm.category eq '%')||(pageInforBean.hm.category4 eq '4')?'checked':''}>
									<span class="input-label">地方</span>
								</label>
								<label class="checkbox inline">
									<input id="type_4" type="checkbox" id="type_4" name="item_type_list" value="3" ${(pageInforBean.hm.category eq '%')||(pageInforBean.hm.category3 eq '3')?'checked':''}>
									<span class="input-label">海外</span>
								</label>
							</td>
							<td class="right_align">
								回款状态&nbsp;:
							</td>
							<td>
								<label class="checkbox inline">
									<input id="back_section_end_all" type="checkbox" id="back_section_end_all" name="back_section_end_all" 
										value="ALL" ${pageInforBean.hm.is_back eq ''?'checked':''}>
									<span class="input-label">全部</span>
								</label>
								<label class="checkbox inline">
									<input id="back_section_end_F" type="checkbox" id="back_section_end_F" name="back_section_end"  checked
										value="F" ${(pageInforBean.hm.is_back eq '')||(pageInforBean.hm.is_back eq 'F') ?'checked':''}>
									<span class="input-label">未结束</span>
								</label>
								<label class="checkbox inline">
									<input id="back_section_end_T" type="checkbox" id="back_section_end_T" name="back_section_end" 
										value="T" ${(pageInforBean.hm.is_back eq '')||(pageInforBean.hm.is_back eq 'T') ?'checked':''}>
									<span class="input-label">结束</span>
								</label>
							</td>
						</tr>
					</table>
				<div class="search-foot-btn">
					<a class="btn btn-warning btn-small" id="clear_input" href="#">重置</a>
					<a class="btn btn-success btn-small-aft" id="search" href="javascript:sub();">查询</a>
				</div>
			</div>
			</form>
		</div>
		<!-- search-table -->
		<!-- search-result -->
		<div class = "search-result">
			<div id="search_result" style="padding:10px;">
				<table class="table table-striped table-bordered" style="background-color: #E4F4CB;">
					<thead>
							<tr>
								<th width="10%"><a class="sort "
									href="javascript:query(${pageInforBean.currentPage},${pageInforBean.showCount } ,'USER_NM','<%=newSc%>')">业务员<%
									if ("USER_NM".equals(orderBy)) {
								%><span class="<%="asc".equals(newSc) ? "caret up" : "caret"%>"></span>
										<%
											}
										%></a></th>
								<th width="15%"><a class="sort "
									href="javascript:query(${pageInforBean.currentPage},${pageInforBean.showCount } ,'CONTRACT_NO','<%=newSc%>')">合同号<%
									if ("CONTRACT_NO".equals(orderBy)) {
								%><span class="<%="asc".equals(newSc) ? "caret up" : "caret"%>"></span>
										<%
											}
										%></a></th>
								<th width="36%"><a class="sort "
									href="javascript:query(${pageInforBean.currentPage},${pageInforBean.showCount } ,'customer_nm','<%=newSc%>')">客户名称<%
									if ("customer_nm".equals(orderBy)) {
								%><span class="<%="asc".equals(newSc) ? "caret up" : "caret"%>"></span>
										<%
											}
										%></a></th>
								<th width="15%"><a class="sort "
									href="javascript:query(${pageInforBean.currentPage},${pageInforBean.showCount } ,'PROJECT_NM','<%=newSc%>')">项目名称<%
									if ("PROJECT_NM".equals(orderBy)) {
								%><span class="<%="asc".equals(newSc) ? "caret up" : "caret"%>"></span>
										<%
											}
										%></a></th>
								<th width="8%"><a class="sort " href="javascript:void(0);">
								<a class="sort" href="javascript:query(${pageInforBean.currentPage},${pageInforBean.showCount } ,'RECEIVED_PAYMENTS_FLG','<%=newSc%>')">
								回款状态<%if ("RECEIVED_PAYMENTS_FLG".equals(orderBy)) {%>
								<span class="<%="asc".equals(newSc) ? "caret up" : "caret"%>"></span>
											<%
												}
											%></a></a></th>
								
								<th width="8%"></th>
							</tr>
						</thead>
						<tbody id="list">
								<%
									
									PageInforBean listBean = (PageInforBean)session.getAttribute("pageInforBean");
								    List orderList = new ArrayList();
								    int totalPage = 0; //总页数
									if (listBean != null) {
										orderList = listBean.getList(); //获取当前页面显示列表集合
										totalPage = listBean.getTotalPage(); //获取总页数
									}
									
									for (int i = 0; i < orderList.size(); i++) {
										OrderBean order = (OrderBean) orderList.get(i);
									
								%>

								<tr >
									<td><%=order.getAgency_user_nm()%></td>
									<td><%=order.getContract_no()%></td>
									<td><%=order.getCustomer_nm()%></td>
									<td><%=order.getProject_nm()%></td>
									<td class="center_td">
										<i class="icon icon-effective"></i><%="T".equals(order.getReceived_payments_flg())?"结束":"未结束"%>
									</td>
									<td class="center_td"><a href="invoiceInsert.jsp?contract_num=<%=order.getContract_no() %>"
									class="icon icon-edit  link-hand-dialog" data-toggle="modal"
									data-target="#currency_edit_modal"></a></td>
								</tr>
								<%
									}
								%>
								
							</tbody>

				</table>
				
			</div>
			
			<div id="pagination" style="align: center; margin-top: -10px;">
					<div id='project_pagination' class="pagination pagination-centered">
						<div class="pagination">
							<ul>
							<li class="disabled"><a href="javascript:void(0)"
								onclick="query(${pageInforBean.currentPage-1},${pageInforBean.showCount })">«</a></li>
							<%
								for (int i = 1; i <= totalPage; i++) {
							%>
							<li class='<%=(i == listBean.getCurrentPage() ? "active" : "")%>'><a
								href="javascript:query(<%=i%>,${pageInforBean.showCount },'','<%=oldSc%>')"><%=i%></a></li>
							<%
								}
							%>
							<li><a href="javascript:void(0)"
								onclick="query(${pageInforBean.currentPage+1 },${pageInforBean.showCount })">»</a></li>
						</ul>
							<ul>
									<li>
										<span>(${pageInforBean.fromCount}-${pageInforBean.fromCount+pageInforBean.showCount-1}/${pageInforBean.totalNumber})</span>
									</li>
					

								<li>
									<span>显示条数&nbsp;:&nbsp;</span>
								</li>
							</ul>
							<ul>
								<li class="<%=(10==listBean.getShowCount()?"active":"")%>">
									<a href="javascript:query(1,10,'','desc')">10</a>
								</li>
								<li class="<%=(30==listBean.getShowCount()?"active":"")%>">
									<a href="javascript:query(1,30,'','desc')">30</a>
								</li>
								<li class="<%=(50==listBean.getShowCount()?"active":"")%>">
									<a href="javascript:query(1,50,'','desc')">50</a>
								</li>
							</ul>
						</div>
					</div>
				</div> 
		</div>
	</div>
	<div class="bottom_block">
		<div style="padding:8px;text-align: center;">
			<a class="btn btn-info btn-middle" style="" href="../../menu/mainMenuG.jsp">返回主菜单</a>
		</div>
	</div>
</div>

</body>
</html>
