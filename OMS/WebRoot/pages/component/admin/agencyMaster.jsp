<%@page import="sym.common.dto.SessionDto"%>
<%@page import="sym.admin.bean.AdminAgencyBean"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="sym.common.bean.PageInforBean,sym.admin.bean.AdminCurrencyBean"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
<script type="text/javascript"
	src="../../../js/lib/jquery/jquery.min.js"></script>
<script type="text/javascript"
	src="../../../js/lib/jquery_plugin/bs/js/bootstrap.min.js"></script>
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
<link href="../../../css/common/bootstrap_setup.css" rel="stylesheet"
	type="text/css">
<link href="../../../js/lib/jquery_plugin/ui/jquery-ui.css"
	rel="stylesheet" type="text/css">
<link href="../../../css/common/popup.css" rel="stylesheet"
	type="text/css">
<link href="../../../css/common/common.css" rel="stylesheet"
	type="text/css">
<link href="../../../css/component/admin/master.css" rel="stylesheet"
	type="text/css">
<link href="../../../js/lib/jquery_alert/jquery.alerts.css"
	rel="stylesheet" type="text/css">

<script type="text/javascript">
	var submitS = '确定';
	var cancelC = '取消';
	var cp_agency_users = 1; //user当前页码
	var tp_agency_users = 1; //user总页数
	var agency_user_condition = "";
	var select_user_id;
	var select_user_nm;
	var flag1 = false; //新增标识
	var flag2 = false;
	var flag3 = false;
	var state = false;

	function inputLabel(agency_cd, agency_name, agency_user_name, is_valid) {
		$('#agency_cd').val(agency_cd);
		$('#agency_name').val(agency_name);
		$('#agency_user_name').val(agency_user_name);

		if (is_valid == "有效") {
			$("input:radio[name='sex'][value='F']").removeAttr('checked');
			$("input:radio[name='sex'][value='T']").prop('checked', 'true');
		} else if (is_valid == "无效") {
			$("input:radio[name='sex'][value='T']").removeAttr('checked');
			$("input:radio[name='sex'][value='F']").prop('checked', 'true');
		}
	}

	function clearLabel() {
		$('#agency_cd').val('');
		$('#agency_name').val('');
		$('#agency_user_name').val('');
	}

	$(function() {
		getAgencyUsersTbody();
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
	});

	function chooseUser() {
		$('#user_dialog').dialog('close');
		$('#agency_user_id').val(select_user_id);
		$('#agency_user_name').val(select_user_nm);
		flag3 = true;
		check();
	}

	function search_agency_user() {
		agency_user_condition = $("#keyword_user").val();
		cp_agency_users = 1;
		getAgencyUsersTbody();
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

	function openNewDialog() {
		clear(false,false,false);
		
		state = true;
		var param = {
			width : 600,
			height : 300,
			title : "新增代理商",
			modal : true,
			buttons : [ {
				text : '保存',
				id : 'sub',
				click : function() {
					var get_agency_cd = document.getElementById("agency_cd").value;
					if (get_agency_cd == "") {
					} else {
						insertAgency();
					}
					$(this).dialog('close');
				},
				'class' : 'btn btn-primary btn-middle',
				disabled : "disabled"
			},
				{
					text : '取消',
					click : function() {
						$(this).dialog('close');
					},
					'class' : 'btn btn-inverse btn-middle btn-aft-middle'
				} ]
		};
		clearLabel();
		openPop('customer_dialog', param);
	}
	//新增
	$(document).on('click', '.icon-add', function(e) {
		//$('#tonewuser').on('click',function(e){
		var agency_cd = document.getElementById("agency_cd");
		agency_cd.removeAttribute("readOnly"); //编号可编辑		
		/* document.getElementById("msg").innerHTML = ""; */
		openNewDialog();
	});

	//代理商编辑
	var flag = true;
	$(document).ready(function() {
		$(document).on('click', '.sort', function(e) {
			if ($(this).find('span')[0] == null) {
				flag = false;
			}
			$('#search_result').find('.caret').remove();
			var sor = $('<span class="' + (flag ? 'caret up' : 'caret') + '"></span>');
			$(this).append(sor);
			flag = !flag;
		});
		//双击行编辑
		$(document).on('dblclick', '#search_result tr', function(e) {
			var agency_cd = document.getElementById("agency_cd");
			agency_cd.readOnly = true; //编号不可编辑	
			/* document.getElementById("msg").innerHTML = ""; */
			var $tr = $(this); //定位到当前行
			var $td = $tr.find("td"); //定位到当前行的列
			var agency_cd = $td.eq(0).text(); //返回本行第一列的值
			var agency_name = $td.eq(1).text(); //返回本行第二列的值
			var agency_user_name = $td.eq(2).text(); //返回本行第三列的值
			var is_valid = $td.eq(3).text().trim(); //返回本行第四列的值

			openEditDialog(agency_cd, agency_name, agency_user_name, is_valid);
		});
		//单击超链接编辑
		$(document).on('click', '.link-hand-dialog', function(e) {

			var agency_cd = document.getElementById("agency_cd");
			agency_cd.readOnly = true; //编号不可编辑	
			/*document.getElementById("msg").innerHTML = "";*/
			var $tr = $(this).parent().parent(); //通过当前this对象（a）定位到tr
			var $td = $tr.find("td"); //定位到当前行的列
			var agency_cd = $td.eq(0).text(); //返回本行第一列的值
			var agency_name = $td.eq(1).text(); //返回本行第二列的值
			var agency_user_name = $td.eq(2).text(); //返回本行第三列的值
			var is_valid = $td.eq(3).text().trim(); //返回本行第四列的值
			openEditDialog(agency_cd, agency_name, agency_user_name, is_valid);
		});
	});

	function openEditDialog(agency_cd, agency_name, agency_user_name, is_valid) {
		clear(true,false,true);
		state = false;
		var param = {
			width : 600,
			height : 300,
			title : "代理商编辑",
			modal : true,
			buttons : [ {
				id : "sub",
				text : '保存',
				click : function() {
					updateAgency();
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
		inputLabel(agency_cd, agency_name, agency_user_name, is_valid);
		openPop('customer_dialog', param);
	}

	/**
	 * 状态“全选”选中时，其余项设定选中
	 *
	 * @private
	 */
	$(document).on("click", "#is_valid_all", function() {
		var check = this.checked;
		$("input[name = 'is_valid']").each(function() {
			this.checked = check;
			if (check) {
				$(this).parent().parent().addClass('table-row-selected');
			} else {
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
		if (this.checked) {
			$(this).parent().parent().addClass('table-row-selected');
		} else {
			$(this).parent().parent().removeClass('table-row-selected');
		}
		var $subBox = $("input[name = 'is_valid']");
		var length = $("input[name = 'is_valid']:checked").length;
		$("#is_valid_all")[0].checked = ($subBox.length == length) ? true : false;
	});

	function deleteContract(el) {
		jConfirm('确认删除吗？', '确认对话框', function(r) {
			if (r == true) {
				$(el).parent().parent().remove();
			}
		});
	}

	//重置	
	function showRe() {
		$('#agency_nm').val('');
		$('#user_name').val('');
		var unsele1 = document.getElementById('is_valid_all');
		var unsele2 = document.getElementById('is_valid_t');
		var unsele3 = document.getElementById('is_valid_f');

		unsele1.checked = false;
		unsele2.checked = false;
		unsele3.checked = false;
	}

	/* 	function add() {
			document.forms[0].action = "${pageContext.request.contextPath}/adminAgencyPageListAction?method=firstPage";
			document.forms[0].submit();
		} */
	/** 
	  *显示首页功能
	  *@author guojl   
	 */
	function showFirstPage() {
		document.forms[0].action = "${pageContext.request.contextPath}/adminAgencyPageListAction?method=firstPage";
		document.forms[0].submit();
	}

	/**
	  * 根据页码和显示行数进行换页
	  *@author guojl
	  */
	function query(pageNo, display_rows) {
		if (pageNo < 1) {
			alert("已经是第一页!");
			return false;
		}
		if (pageNo > '${pageInforBean.totalPage}') {
			alert("已经是最后一页!");
			return false;
		}

		document.forms[0].action = "${pageContext.request.contextPath}/adminAgencyPageListAction?method=showPage&pageNo=" + pageNo + "&showCount=" + display_rows;
		document.forms[0].submit();

	}

	//插入
	function insertAgency() {
		document.forms[1].action = "<%=path %>/adminAgencyAction?method=insertAgency";
		document.forms[1].submit();
		return true;
	}

	//更新
	function updateAgency() {
		document.forms[1].action = "<%=path %>/adminAgencyAction?method=updateAgency";
		document.forms[1].submit();
		return true;
	}

	function check1() {
		if (state) {
			var agency_cd = $("#agency_cd").val();
			var explain1 = $("#explain1");
			if (agency_cd == "") {
				explain1.text("编号不能为空");
				flag1 = false;
			} else if (agency_cd.length > 15) {
				explain1.text("编号不得超过15位");
				flag1 = false;
			} else {
				explain1.text("");
				checkInsert(agency_cd);
			}
			check();
		}

	}
	function check2() {
			var agency_nm = $("#agency_name").val();
			var explain2 = $("#explain2");
			if (agency_nm == "") {
				explain2.text("名称不能为空");
				flag2 = false;
			} else if (agency_nm.length > 15) {
				explain2.text("名称不得超过15位");
				flag2 = false;
			} else {
				explain2.text("");
				flag2 = true;
			}
			check();
	}
	function check() {
		if (flag1 && flag2 && flag3) {
			$("#sub").removeAttr("disabled");
			$("#sub").attr("class", "btn btn-primary btn-middle");
		} else {
			$("#sub").attr("disabled", "disabled");
		}
	}

	function checkInsert(agency_cd) {
		var explain1 = $("#explain1");
		$.ajax({
			type : "get",
			url : "<%=path %>/adminAgencyAction?method=checkInsert",
			data : {
				"agency_cd" : agency_cd
			}, //要发送的数据参数
			dataType : "text",
			success : function(data) {
				if (data == 0) {
					explain1.text("编号已存在");
					flag1 = false;
				} else {
					explain1.text("");
					flag1 = true;
				}
				check();
			},
			error : function(msg) {
				explain1.text("请检查网络连接");
			}
		});
	}
	function clear(f1, f2, f3){
		flag1 = f1;
		flag2 = f2;
		flag3 = f3;
		$("#explain1").text("");
		$("#explain2").text("");
		$("#explain3").text("");
	}
</script>
</head>
<body>
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
			<span> 代理商管理</span>
		</div>
		<div class="content">
			<form method="post">
				<!-- search-table -->
				<div class="search-table" id="search_table">
					<span
						style="background-color: #FFFFFF;font-size: 14px;left: 10px;position: relative;top: 9px;">&nbsp;查询条件&nbsp;</span>
					<div
						style="padding:10px;border-width:1px 0;border-style:solid;border-color:#0088CC;">
						<table class="table-edit" style="width: 90%; margin: 0 auto;">
							<tr>
								<td style="width: 100px" class="right_align">代理商名称&nbsp;:</td>
								<td style="width: 260px"><input class="input-xlarge"
									type="text" style="width: 160px; text-align: left;"
									id="agency_nm" name="agency_nm"
									value="${pageInforBean.hm.agency_nm}"></td>
								<td style="width: 100px" class="right_align">业务员&nbsp;:</td>
								<td style="width: 260px"><input class="input-xlarge"
									type="text" style="width: 160px; text-align: left;"
									id="agency_user_nm" name="agency_user_nm"
									value="${pageInforBean.hm.user_name}"></td>
							</tr>
							<tr>
								<td class="right_align">状态&nbsp;:</td>
								<td><label class="checkbox inline"> <input
										id="is_valid_all" type="checkbox" name="is_valid_all"
										value="ALL" ${pageInforBean.hm.is_valid eq '%'?'checked':''}>
										<span class="input-label">全部</span>
								</label> <label class="checkbox inline"> <input id="is_valid_t"
										type="checkbox" name="is_valid" value="T"
										${(pageInforBean.hm.is_valid eq '%')||(pageInforBean.hm.is_valid eq 'T') ?'checked':''}>
										<span class="input-label">有效</span>
								</label> <label class="checkbox inline"> <input id="is_valid_f"
										type="checkbox" name="is_valid" value="F"
										${pageInforBean.hm.is_valid eq '%'||(pageInforBean.hm.is_valid eq 'F')?'checked':''}>
										<span class="input-label">无效</span>
								</label></td>
							</tr>
						</table>
						<div class="search-foot-btn">
							<a class="btn btn-warning btn-small" id="clear_input"
								href="javascript:showRe()">重置</a> <a
								class="btn btn-success btn-small-aft" id="search"
								href="javascript:showFirstPage()">查询</a>
						</div>
					</div>
				</div>
			</form>
			<!-- search-table -->
			<div class="search-result">
				<div id="" class="top-btn-bar">
					<a id="tonewuser" class="icon icon-add" href="javascript:void(0);"
						title="" style="margin-right: 10px">新增代理商</a>
				</div>

				<div id="search_result" class="search-result-content">
					<table class="table table-striped table-bordered" id="agency_table">
						<thead>
							<tr>
								<th style="width:15%;height:21px;"><a class="sort">代理商编号<span
										class="caret"></span></a></th>
								<th width="50%"><a class="sort">代理商名称</a></th>
								<th width="15%"><a class="sort">业务员</a></th>
								<th width="10%"><a class="sort">状态</a></th>
								<th width="10%"></th>
							</tr>
						</thead>
						<tbody id="list">
							<%
								PageInforBean listBean = (PageInforBean) session.getAttribute("pageInforBean");
								List agencyList = new ArrayList();
								int totalPage = 0; //总页数
								if (listBean != null) {
									agencyList = listBean.getList(); //获取当前页面显示列表集合
									totalPage = listBean.getTotalPage(); //获取总页数
								}
								for (int i = 0; i < agencyList.size(); i++) {
									AdminAgencyBean agency = (AdminAgencyBean) agencyList.get(i);
							%>
							<tr>
								<td><%=agency.getAgency_cd()%></td>
								<td><%=agency.getAgency_nm()%></td>
								<td><%=agency.getAgency_user_nm()%></td>
								<td class="center_td">
									<%
										if ("T".equals(agency.getIs_valid())) {
									%> <i class="icon icon-effective"></i>有效<%
 									} else {
 									%> <i class="icon icon-invalid"></i>无效 <%
 									}
									 %>
								</td>
								<td class="center_td"><a
									class="icon icon-edit link-hand-dialog" data-toggle="modal"
									data-target="#agency_edit_modal">编辑</a></td>
							</tr>
							<%
								}
							%>

						</tbody>
					</table>
				</div>
			</div>
			<div id="pagination" style="align: center; margin-top: -10px;">
				<div id='project_pagination' class="pagination pagination-centered">
					<div class="pagination">
						<ul>
							<li><a href="javascript:void(0)"
								onclick="query(${pageInforBean.currentPage-1},${pageInforBean.showCount })">«</a>
							</li>
							<%
								for (int i = 1; i <= totalPage; i++) {
							%>
							<li class='<%=(i == listBean.getCurrentPage() ? "active" : "")%>'>
								<a href="javascript:query(<%=i%>,${pageInforBean.showCount } )"><%=i%></a>
							</li>
							<%
								}
							%>
							<li><a href="javascript:void(0)"
								onclick="query(${pageInforBean.currentPage+1 },${pageInforBean.showCount })">»</a></li>
						</ul>
						<ul>
							<%-- <li><span>(${(listBean.currentPage-1)*10+1} - ${listBean.currentPage*10}/<%=totalNum %>)</span></li> --%>

							<li><span>(${pageInforBean.fromCount}-${pageInforBean.fromCount+pageInforBean.showCount-1}/${pageInforBean.totalNumber})</span>
							</li>


							<li><span>显示条数&nbsp;:&nbsp;</span></li>
						</ul>
						<ul>
							<li class="<%=(10 == listBean.getShowCount() ? "active" : "")%>">
								<a href="javascript:query(1,10)">10</a>
							</li>
							<li class="<%=(30 == listBean.getShowCount() ? "active" : "")%>">
								<a href="javascript:query(1,30)">30</a>
							</li>
							<li class="<%=(50 == listBean.getShowCount() ? "active" : "")%>">
								<a href="javascript:query(1,50)">50</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>

		<div class="bottom_block">
			<a class="btn btn-info btn-middle" style=""
				href="../../menu/mainMenuG.jsp">返回主菜单</a>
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
	<div id="customer_dialog" style="display:none;">
		<form method="post" action="" name="update_Agency_Form">
			<table class="table-edit table-bordered table-striped"
				style="width:100%;border-collapse:collapse;">
				<tbody>
					<tr>
						<td class="right_align" width="20%"><div>代理商编号&nbsp;:&nbsp;</div></td>
						<td><input style="width:250px;ime-mode: disabled"
							class="span3 jq-placeholder" type="text" name="agency_cd"
							id="agency_cd" size="20" value="" onpropertychange="check1()"
							oninput="check1()" onblur="check1()" readonly /> <span
							style="font-size:10px;color: red" id="explain1"></span></td>

					</tr>
					<tr>
						<td class="right_align"><div class="">代理商名称&nbsp;:&nbsp;</div></td>
						<td><input style="width:250px;" type="text"
							name="agency_name" size="30" class="span3 jq-placeholder must"
							id="agency_name" onpropertychange="check2()" onblur="check2()"
							oninput="check2()"> <span
							style="font-size:10px;color: red" id="explain2"></span></td>
					</tr>
					<tr>
						<td class="right_align"><div class="">业务员&nbsp;:&nbsp;</div></td>
						<td><i title="查询" onclick=""
							style="background-position: 0 0;padding-top: 0; height: 20px; width: 20px; padding-left: 0;"
							class="icon icon-search" id="user_search"></i> <input
							style="width:225px;" type="text" name="agency_user_name"
							size="30" class="span3 jq-placeholder must" id="agency_user_name"
							value="" readonly /> 
							<span style="font-size: 10px;color: red"
							id="explain3"></span></td>
					</tr>
					<tr>
						<td class="right_align"><div class="">状态&nbsp;:&nbsp;</div></td>
						<td><label class="radio inline"> <input type="radio"
								name="sex" value="T" checked></input>有效
						</label> <label class="radio inline"> <input type="radio"
								name="sex" value="F"></input>无效
						</label></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>


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
</body>
</html>

