<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="sym.common.dto.SessionDto"%>
<%@page import="sym.common.bean.PageInforBean,sym.common.bean.AdminUserBean" %>
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
		<!--script frontend-->
		<script type="text/javascript" src="../../../js/lib/jquery/jquery.min.js"></script>
		<script type="text/javascript" src="../../../js/lib/jquery_plugin/bs/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="../../../js/lib/jquery_plugin/placeholder/jquery.placeholder.js"></script>
	<script src="../../../js/common/datepicker.js"></script>
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
	<link href="../../../css/common/datepicker.css" rel="stylesheet">
	<link href="../../../js/lib/jquery_alert/jquery.alerts.css" rel="stylesheet" type="text/css">

	<script type="text/javascript">
		var submitS='确定';
		var cancelC='取消';
		function inputLabel (get_user_cd,get_user_name,get_user_phone,get_user_flg,get_is_valid) {
			$('#user_cd').val(get_user_cd);
			$('#user_name').val(get_user_name);
			$('#user_telephone').val(get_user_phone);
			if(get_user_flg=="M"){
				$("input:radio[name='flg'][value='M']").removeAttr("checked");
				$("input:radio[name='flg'][value='S']").removeAttr("checked");
				$("input:radio[name='flg'][value='F']").removeAttr("checked");
				$("input:radio[name='flg'][value='M']").prop('checked', 'checked');
				
			}else if(get_user_flg=="S"){
				$("input:radio[name='flg'][value='M']").removeAttr("checked");
				$("input:radio[name='flg'][value='S']").removeAttr("checked");
				$("input:radio[name='flg'][value='F']").removeAttr("checked");
				$("input:radio[name='flg'][value='S']").prop('checked', 'checked');
				
			}else if(get_user_flg=="F"){
				$("input:radio[name='flg'][value='M']").removeAttr("checked");
				$("input:radio[name='flg'][value='S']").removeAttr("checked");
				$("input:radio[name='flg'][value='F']").removeAttr("checked");
				$("input:radio[name='flg'][value='F']").prop('checked', 'checked');
				
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
			$('#user_cd').val('');
			$('#user_name').val('');
			$('#user_telephone').val('');
		}
		
		var flag = true;
		
		function openEditDialog(get_user_cd,get_user_name,get_user_phone,get_user_flg,get_is_valid) {
			$("#explain1").text("");
			$("#explain2").text("");
			$("#explain3").text("");
			$("#user_cd").attr("readonly","true");
			$("input[name='user_cd']").removeAttr("onblur");
			var param = {
					width : 600,
					height : 320,
					title : "用户编辑",
					modal : true,
					buttons : [{
						text : '保存',
						click : function() {
							updateUser();
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
				inputLabel(get_user_cd,get_user_name,get_user_phone,get_user_flg,get_is_valid);
				openPop('customer_dialog',param);
		}

		function openNewDialog() {
			$("#explain1").text("");
			$("#explain2").text("");
			$("#explain3").text("");
			$("#user_cd").removeAttr("readonly");
			$("input[name='user_cd']").attr("onblur","check1()");
			var param = {
					width : 600,
					height : 320,
					title : "新增用户",
					modal : true,
					buttons : [{
						id : "add_sub",
						text : '保存',
						click : function() {
							var get_User_cd=document.getElementById("user_cd").value;
							if(get_User_cd == ""){
								
							}else{
								insertUser();
							}
							$(this).dialog('close');
						},
						disabled : 'disabled',
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
			}
			/* function addUser() {
				var td = $('#search_result tr');
				if(td.length != 10) {
					var tr = ['<tr>',
						'<td>1234</td>',
						'<td>张三</td>',
						'<td>0531-88881234</td>',
						'<td>管理</td>',
						'<td class="center_td"><i class="icon icon-effective"></i>有效</td>',
						'<td class="center_td"><a class="icon icon-edit link-hand-dialog">编辑</a></td>',
						'</tr>'
					];
					var tr_obj = $(tr.join());
					tr_obj.appendTo('#search_result tbody');
				}
			} */

	

			$(document).ready(function(){

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
					var $tr=$(this);  //定位到当前行
					var $td=$tr.find("td");  //定位到当前行的列
					var get_user_cd = $td.eq(0).text();
					var get_user_name = $td.eq(1).text();
					var get_user_phone = $td.eq(2).text();
					var get_user_flg = $td.eq(3).text();
					var get_is_valid = $td.eq(4).text();
					openEditDialog(get_user_cd,get_user_name,get_user_phone,get_user_flg,get_is_valid);
				});
				$(document).on('click','.link-hand-dialog',function(e){
					var get_user_cd = $(this).parent().parent().children().eq(0).text();
					var get_user_name = $(this).parent().parent().children().eq(1).text();
					var get_user_phone = $(this).parent().parent().children().eq(2).text();
					var get_user_flg = $(this).parent().parent().children().eq(3).text();
					var get_is_valid = $(this).parent().parent().children().eq(4).text();
					openEditDialog(get_user_cd,get_user_name,get_user_phone,get_user_flg,get_is_valid);
				});
				$('#tonewuser').on('click',function(e){
					openNewDialog();
				});
				//点击选中行
				$(document).on('click','#user_table tr',function(e){
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
				 * 所属部门“全选”选中时，其余项设定选中
				 *
				 * @private
				 */
				$(document).on("click", "#owner_flg_all", function() {
					var check = this.checked;
					$("input[name = 'owner_flg']").each(function() {
						this.checked = check;
						if (check){
							$(this).parent().parent().addClass('table-row-selected');
						}else{
							$(this).parent().parent().removeClass('table-row-selected');
						}
					});
				});

				/**
				 * 所属部门“全选”外其余项选中全部选中时，设定“全选”为选中状态
				 *
				 * @private
				 */
				$(document).on("click", "input[name = 'owner_flg']", function() {
					if (this.checked){
						$(this).parent().parent().addClass('table-row-selected');
					}else{
						$(this).parent().parent().removeClass('table-row-selected');
					}
					var $subBox = $("input[name = 'owner_flg']");
					var length = $("input[name = 'owner_flg']:checked").length;
					$("#owner_flg_all")[0].checked = ($subBox.length == length) ? true : false;
				});
			});

			function deleteContract(el){
				jConfirm('确认删除吗？', '确认对话框', function(r) {
					if (r == true) {
						$(el).parent().parent().remove();
					}
				});
			}

			
			/** 
			  *显示首页功能
			  *@author guojl   
			 */
			function showFirstPage()
			{
				document.forms[0].action="${pageContext.request.contextPath}/adminUserPageListAction?method=firstPage";
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
			   
				document.forms[0].action="${pageContext.request.contextPath}/adminUserPageListAction?method=showPage&pageNo="+pageNo+"&showCount="+display_rows;
				document.forms[0].submit();
			
			}
			
			function insertUser()
			{ 
				//alert("login test");
				/* document.getElementById("currency_cd").value="";
				document.getElementById("currency_name").value=""; */
			  	document.forms[1].action="<%=path %>/adminUserAction?method=insertUser";
			  	document.forms[1].submit();
			  	return true;
			} 
			
			function updateUser()
			{ //alert("login test");
				
			  	document.forms[1].action="<%=path %>/adminUserAction?method=updateUser";
			  	document.forms[1].submit();
			  	return true;
			}
			
			var flag1 = false;//新增标识
			var flag2 = false;
			var flag3 = false;
			
			function check1() {
				var user_cd = $("#user_cd").val();
				var explain1 = $("#explain1");
				if (user_cd == "") {
					explain1.text("用户编号空，请输入");
					flag1 = false;
				} else if (user_cd.length > 15) {
					explain1.text("用户编号不得超过15位");
					flag1 = false;
				} else {
					checkInsert(user_cd);
				}
				check();
			}
			
			function check2() {
				var user_name = $("#user_name").val();
				var explain2 = $("#explain2");
				if (user_name == "") {
					explain2.text("用户名空，请输入");
					flag2 = false;
				} else if (user_name.length > 15) {
					explain2.text("用户名不得超过15位");
					flag2 = false;
				} else {
					explain2.text("");
					flag2 = true;
				}
				check();
			}
			function check3() {
				var user_phone = $("#user_telephone").val();
				var explain3 = $("#explain3");
				if (user_phone == "") {
					explain3.text("联系电话空，请输入");
					flag3 = false;
				} else if (user_phone.length > 15) {
					explain3.text("联系电话不得超过15位");
					flag3 = false;
				} else {
					explain3.text("");
					flag3 = true;
				}
				check();
			}
			
			function checkInsert(user_cd){
				var explain1 = $("#explain1");
				$.ajax({
					type : "get",
					url : "<%=path %>/adminUserAction?method=checkInsert",
					data : {
						"user_cd" : user_cd
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
				if(flag1 && flag2 && flag3){
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
						<a class="logo" href="<%=basePath%>/loginAction?method=main" style="padding: 0px;">
						<img alt="" src="../../../images/logo.png"><span style="padding-left: 10px;padding-top:10px;padding-bottom:5px;color:#EEEEEE;font-size: 23px;font-weight: bold;vertical-align:middle;">订单管理系统</span>
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
								<li><a href="../../common/resetPassword.jsp">修改密码</a></li>
								<li class="divider"></li>
								<li><a href="../../login.jsp">退出系统</a></li>
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
					<ul class="nav pull-right navi">
						<li class=""><a href="<%=basePath%>/loginAction?method=main">返回主菜单</a></li>
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
			<span>用户管理</span>
		</div>
		<div class="content">
			<!-- search-table -->
			<form method="post">
			<div class="search-table" id="search_table">
				<span style="background-color: #FFFFFF;font-size: 14px;left: 10px;position: relative;top: 9px;">&nbsp;查询条件&nbsp;</span>
				<div style="padding:10px;border-width:1px 0;border-style:solid;border-color:#0088CC;">
						<table class="table-edit" style="width: 90%; margin: 0 auto;">
							<tr>
								<td style="width: 100px" class="right_align" value="${pageInforBean.hm.user_nm}">
									用户名&nbsp;:
								</td>
								<td style="width: 260px">
									<input class="input-xlarge" type="text"
										style="width: 160px; text-align: left;"
										value="" name = "user_nm">
								</td>
								<td style="width: 100px" class="right_align" value="${pageInforBean.hm.user_phone}">
									联系电话&nbsp;:
								</td>
								<td style="width: 260px">
									<input class="input-xlarge" type="text"
										style="width: 160px; text-align: left; ime-mode: disabled"
										value="" name="user_phone">
								</td>
							</tr>
							<tr>
								<td class="right_align" >
									所属部门&nbsp;:
								</td>
								<td>
									<label class="checkbox inline">
										<input id="owner_flg_all" type="checkbox" id="owner_flg_all" name="owner_flg_All" value="ALL" checked>
										<span class="input-label">全部</span>
									</label>
									<label class="checkbox inline">
										<input id="owner_flg_M" type="checkbox" id="owner_flg_M" name="owner_flg" value="M" checked>
										<span class="input-label">管理</span>
									</label>
									<label class="checkbox inline">
										<input id="owner_flg_S" type="checkbox" id="owner_flg_S" name="owner_flg" value="S" checked>
										<span class="input-label">业务</span>
									</label>
									<label class="checkbox inline">
										<input id="owner_flg_F" type="checkbox" id="owner_flg_F" name="owner_flg" value="F" checked>
										<span class="input-label">财务</span>
									</label>
								</td>
								<td class="right_align">
									状态&nbsp;:
								</td>
								<td>
									<label class="checkbox inline">
										<input id="is_valid_all" type="checkbox"  name="is_valid_all" value="ALL" ${pageInforBean.hm.is_valid eq '%'?'checked':''}>
										<span class="input-label">全部</span>
									</label>
									<label class="checkbox inline">
										<input id="is_valid_t" type="checkbox" name="is_valid" value="T"   ${(pageInforBean.hm.is_valid eq '%')||(pageInforBean.hm.is_valid eq 'T') ?'checked':''}>
										<span class="input-label">有效</span>
									</label>
									<label class="checkbox inline">
										<input id="is_valid_f" type="checkbox" name="is_valid" value="F" ${pageInforBean.hm.is_valid eq '%'||(pageInforBean.hm.is_valid eq 'F')?'checked':''}>
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
			</div></form>
			<!-- search-table -->
			<div id="" style="float: right;margin-top:20px;">
				<a id="tonewuser" class="icon icon-add" href="javascript:void(0);" title=""
					style="margin-right: 10px">新增用户</a>
				<div style="clear:both;"></div>
			</div>

			<div class = "search-result">
				<div id="search_result" style="padding:10px;margin-top:-10px;">
				<table class="table table-striped table-bordered" style="background-color:#E4F4CB;" id="user_table">
					<thead>
						<tr>
							<th style="width:15%;height:25px;"><a class="sort">用户编号<span class="caret"></span></a></th>
							<th style="width:25%;"><a class="sort">用户名</a></th>
							<th style="width:25%;"><a class="sort">联系电话</a></th>
							<th style="width:15%;"><a class="sort">所属部门</a></th>
							<th style="width:10%;"><a class="sort">状态</a></th>
							<th style="width:10%;"></th>
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
										AdminUserBean curr = (AdminUserBean)currList.get(i);
								%>

								<tr>
								<td><%=curr.getUser_cd()%></td>
									
									<td><%=curr.getUser_nm()%></td>
									<td><%=curr.getUser_phone()%></td>
									<td><%=curr.getUser_owner_flg()%></td>
									<td class="center_td"><i class="<%="T".equals(curr.getIs_valid()) ? "icon icon-effective" : "icon icon-invalid"%>"></i><%if("T".equals(curr.getIs_valid())){%>有效<%}else{ %>无效<%} %></td>
									<td class="center_td">
										<a class="icon icon-edit  link-hand-dialog"
											data-toggle="modal" data-target="#currency_edit_modal">编辑</a>
									</td>
								</tr>
								<%
									}
								%>
						
					</tbody>
				</table>
			</div>
					</div>

	<div id="pagination" style="align:center;margin-top:-10px;">
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

<!--新規 -->
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
<div id="customer_dialog" style="display:none;">
<form action="" name="update_User_Form" method="post">
	<table class="table-edit table-bordered table-striped" style="width:100%;border-collapse:collapse;">
		<tbody>
			<tr>
				<td class="right_align" style="width: 120px"><div class="  ">用户编号&nbsp;:&nbsp;</div></td> 
				<td> <input style="ime-mode: disabled" class="span3 jq-placeholder" type="text"  id="user_cd" name="user_cd" size="10" onBlur="check1()"  onpropertychange="check1()" oninput="check1()" /> 
					<span style="font-size: 10px;color: red"   id="explain1" ></span> 				
				</td>
			</tr>
			<tr>
				<td class="right_align"><div class="">用户名&nbsp;:&nbsp;</div></td>
				<td><input style="" type='text' size="10"  class="span3 jq-placeholder must" id="user_name" name="user_name" onBlur="check2()"  onpropertychange="check2()" oninput="check2()" >
					<span style="font-size: 10px;color: red"   id="explain2" ></span> 
				</td>
			</tr>
			<tr>
				<td class="right_align"><div class="">联系电话&nbsp;:&nbsp;</div></td>
				<td><input style="ime-mode: disabled" type='text' size="10"  class="span3 jq-placeholder must" id="user_telephone" onBlur="check3()" onpropertychange="check3()" oninput="check3()" name="user_telephone" value="">
				<span style="font-size: 10px;color: red"  id="explain3" ></span> 
				</td>
			</tr>
			<tr>
				<td class="right_align"><div class="">所属部门&nbsp;:&nbsp;</div></td>
				<td>
					<label class="radio inline">
						<input type="radio" name="flg" value="M" checked="checked"></input>管理
					</label>
					<label class="radio inline">
						<input type="radio" name="flg" value="S"></input>业务
					</label>
					<label class="radio inline">
						<input type="radio" name="flg" value="F"></input>财务
					</label>
				</td>
			</tr>
			<tr>
				<td class="right_align"><div class="">状态&nbsp;:&nbsp;</div></td>
				<td>
					<label class="radio inline">
						<input type="radio" name="sex" value="T" checked="true"></input>有效
					</label>
					<label class="radio inline">
						<input type="radio" name="sex" value="F"></input>无效
					</label>
				</td>
			</tr>
		</tbody>
	</table>
	</form>
</div>

	</body>
</html>

