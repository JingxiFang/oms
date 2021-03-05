var submitS='确定';
var cancelC='取消';
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
	$(document).on('focus','.Wdate',function(e){
		WdatePicker({lang:'CN',skin:'whyGreen',dateFmt:'yyyy/MM'});
	})
	$(document).on('click','#agency_clear',function(e){
		agencyClear();
	});
	$('#agency_search').on('click',function(e){

			var param = {
					width : 600,
					height : 500,
					title : "选择代理商",
					modal : true,
					buttons : [{
							text : '选择',
							width: '74px',
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
							'class': 'btn btn-inverse btn-middle btn-aft-middle'
					}
					]
			};
			openPop('agency_dialog',param);
	});

	$('#user_search').on('click',function(e){
		var param = {
						width : 620,
						height : 520,
						title : "选择负责人",
						modal : true,
						buttons : [{
								text : '选择',
								width: '74px',
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
								'class': 'btn btn-inverse btn-middle btn-aft-middle'
						}
						]
		};
		openPop('user_dialog',param);
	});

	$('#customer_search').on('click',function(e){
			var param = {
					width : 620,
					height : 520,
					title : "选择客户",
					modal : true,
					buttons : [{
						text : '选择',
						width: '74px',
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
									'class': 'btn btn-inverse btn-middle btn-aft-middle'
					}
					]
			};
			openPop('customer_dialog',param);
	});
	//双击代理商pop
	$('#pop_table td').on('dblclick',function(e){
		chooseAgency();
	});
	//点击选中代理商
	$('#pop_table td').on('click',function(e){
		$('.row-select').removeClass('row-select');
		$(this).parent().addClass('row-select');
	});
	//双击用户pop
	$('#pop_table_user td').on('dblclick',function(e){
			chooseUser();
	});
	//点击选中用户
	$('#pop_table_user td').on('click',function(e){
			$('.row-select').removeClass('row-select');
			$(this).parent().addClass('row-select');
	});

	//双击顾客pop
	$('#pop_table_customer td').on('dblclick',function(e){
				chooseCustomer();
	});
	//点击选中顾客
	$('#pop_table_customer td').on('click',function(e){
					$('.row-select').removeClass('row-select');
					$(this).parent().addClass('row-select');
	});
	$('#addProduct').on('click',function(e){
		openAddProductDialog('米');
	});
	/** 双击电缆或附件 编辑
	 *
	 */
	$(document).on('dblclick','#product_list_table td',function(e){
			var tr = $(this).parent();
			var num = tr.find('td').eq(4).html();
			openEditProductDialog(num);
	});
	$(document).on('click','#product_list_table td',function(e) {
		$('.row-select').removeClass('row-select');
		$(this).parent().addClass('row-select');
	});
	/** 输入金额数量计算单价
	 *
	 */
	$('#contract_sum,#contract_number').on('change',function(e){
		var sum = $('#contract_sum').val();
		var number = $('#contract_number').val();
		if(sum !='' && sum != null && number != null && number != '') {
			$('#contract_price').val((parseFloat(sum)/parseFloat(number)).toFixed(2));
		}
	});
});

$(document).ready(function(){
	$("#order").val('');
	$("#goods_name").val('');
	$("#contract_number").val('');
	$("#contract_price").val('');
	$("#contract_sum").val('');
});

function updateContract() {
	$("#order").val('1');
	$("#goods_name").val('商品名称');
	$("#contract_number").val('5645.00');
	$("#contract_price").val('54364.00');
	$("#contract_sum").val('122666000.00');

}
function clearContract() {
	$("#order").val('');
	$("#goods_name").val('');
	$("#contract_number").val('');
	$("#contract_price").val('');
	$("#contract_sum").val('');
}
function deleteContract(el){
	jConfirm('确认删除吗？', '确认对话框', function(r) {
		if (r == true) {
			$(el).parent().parent().remove();
		}
	});
}

function chooseAgency(){
	$('#agency_dialog').dialog('close');
	$('#agency_id').val('0001');
	$('#agency_name').html('某市总代理');
}
function chooseUser(){
	$('#user_dialog').dialog('close');
	$('#user_id').val('0001');
	$('#user_name').val('李四');
}
function chooseCustomer(){
	$('#customer_dialog').dialog('close');
	$('#customer_name').val('某市国家电网');
}
/** 增加电缆 附件
 *
 * @param {} num
 */
function addProduct(num) {
	var array = ["<tr>",
	'<td style="width:5%;">1</td>',
	'<td style="width:12%;">127/220-2500</td>',
	'<td style="width:8%;">20KV</td>',
	'<td style="width:10%;" class="right_align">5,645.00</td>',
	'<td style="width:5%;text-align:center;" class="">'+num+'</td>',
	'<td style="width:10%;" class="right_align">54,364.00</td>',
	'<td style="width:15%;" class="right_align">122,666,000.00</td>',
	'<td style="width:20%;">XX</td>',
	'<td style="width:15%;" class="center_td"><a class="icon icon-edit link-hand-dialog" id="update_btn_row" onclick="openEditProductDialog(\''+num+'\')">编辑</a>&nbsp;&nbsp;&nbsp;<a class="icon icon-remove" onclick="deleteContract(this)">删除</a></td>',
	"</tr>"
	];
	var tr = array.join();
	var tr_obj = $(tr);
	tr_obj.appendTo(num=='米'?$('#product_list_table tbody').eq(0):$('#product_list_table tbody').eq(1));
}
/** 打开增加电缆附件pop
 *
 * @param {} num
 */
function openAddProductDialog(num) {
	var param = {
			height:400,
			width:600,
			title : "增加",
			modal:true,
			buttons : [{
				text : '增加',
				click : function() {
						addProduct(num);
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
	$('#num').html(num);
	clearContract();
	openPop('product_dialog',param);
}
/** 打开编辑电缆附件pop
 *
 * @param {} num
 */
function openEditProductDialog(num) {

	var param = {
			height:400,
			width:600,
			title : "编辑 ",
			modal:true,
			buttons : [{
				text : '编辑 ',
				click : function() {
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
	$('#num').html(num);
	updateContract();
}

function agencyClear(){
	$('#agency_id').val('');
	$('#agency_name').html('');
}