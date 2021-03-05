var submitS='确定';
var cancelC='取消';
var alertS='确定';

var down;
var up;
$(document).ready(function(){
	+$("#date_power").DatePicker();
	$("#dialog_delivery_date").DatePicker();
	$("#dialog_invoice_date").DatePicker();

	$("#dialog_delivery_date").val('');
	$("#dialog_invoice_date").val('');
	$("#test05").val('');
	$("#test06").val('');
	$("#test07").val('');
	$("#test08").val('');
	toInvoiceList('tr1');

	$(document).on('mousedown','#product_table td',function(e){
		console.log('down');
		down=$(this);
		down.parent().css('opacity','0.5');
	});
	$(document).on('mouseup','#product_table td',function(e){
		console.log('up');
		up=$(this);
		if(down.parent().attr('id') == up.parent().attr('id')) {
			console.log('yes');
			down.parent().css('opacity','1');
		} else {
			console.log('no');
			down.parent().css('opacity','1');
		}
	});
	$(document).on('click','#product_table td',function(e){
		$('#product_table').children().find('tr.row-select').removeClass('row-select');
		$(this).parent().addClass('row-select');
	});
	$(document).on('click','#product_table_1 td',function(e){
		$('#product_table_1').children().find('tr.row-select').removeClass('row-select');
		$(this).parent().addClass('row-select');
	});
});
function insertInput() {
	$("#dialog_delivery_date").val('2014/01/10');
	$("#dialog_invoice_date").val('2014/01/10');
	$("dialog_invoice_no").val('0123456789');
	$("#dialog_invoice_sunprice").val('100.00');
	$("#dialog_invoice_quanitity").val('100');
	$("#dialog_invoice_unit_price").val('10000.00');
}
function clearInput() {
	$("#dialog_delivery_date").val('');
	$("#dialog_invoice_date").val('');
	$("#test05").val('');
	$("#test06").val('');
	$("#test07").val('');
	$("#test08").val('');
}

$(function(){
	$(document).on('focus','.Wdate',function(e){
		WdatePicker({lang:'CN',skin:'whyGreen',dateFmt:'yyyy/MM'});
	})
	$(document).on('click','#addProduct',function(e){
		clearInput();
		openAddPop();
	});
});


function openAddPop(){
	var param = {
			height:340,
			width:600,
			title : "增加 ",
			modal:true,
			focus:function() {
				$('#dialog_delivery_date').DatePickerHide();
			},
			buttons : [{
				text : '增加 ',
				click : function() {
						addPop();
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
			$('#test05')[0].autofocus=true;
			$('#date_hidden').show();
			openPop('product_dialog',param);
			$('#date_hidden').hide();
}
function addPop() {
	var array = [
		'<tr style="heght:20px;" ondblclick="updateContract()">',
		'<td width="25%" style="text-align:center">0123456789</td>',
		'<td width="13%" style="text-align:center;">2014/01/10</td>',
		'<td width="13%" style="text-align:center;">2014/01/10</td>',
		'<td width="10%" class="right_align">100.00</td>',
		'<td width="10%" class="right_align">100.00</td>',
		'<td width="15%" class="right_align">10000.00</td>',
		'<td width="14%" class="center_td"><a class="icon icon-edit link-hand-dialog" id="update_btn_row" onclick="updateContract()">编辑</a>&nbsp;&nbsp;&nbsp;<a class="icon icon-remove" type="button">删除</a></td></tr>'
	];
	var tr = array.join();
	var tr_obj = $(tr);
	tr_obj.appendTo($('#product_table'));
}


function toInvoiceList(tr){
	if(tr=='tr1'){
		$("#contract1").hide();
		$("#contract2").show();
		$("#contract3").show();
		$("#contract4").show();
		$("#contract5").show();
		$("#contract6").show();
	}else if(tr=='tr2'){
		$("#contract1").show();
		$("#contract2").hide();
		$("#contract3").hide();
		$("#contract4").hide();
		$("#contract5").show();
		$("#contract6").show();
	}else if(tr=='tr3'){
		$("#contract1").show();
		$("#contract2").show();
		$("#contract3").show();
		$("#contract4").hide();
		$("#contract5").hide();
		$("#contract6").hide();
	}else if(tr=='tr4'){
		$("#contract1").hide();
		$("#contract2").show();
		$("#contract3").hide();
		$("#contract4").hide();
		$("#contract5").hide();
		$("#contract6").show();
	}else if(tr=='tr5'){
		$("#contract1").show();
		$("#contract2").show();
		$("#contract3").hide();
		$("#contract4").hide();
		$("#contract5").show();
		$("#contract6").show();
	}else if(tr=='tr6'){
		$("#contract1").show();
		$("#contract2").hide();
		$("#contract3").hide();
		$("#contract4").hide();
		$("#contract5").show();
		$("#contract6").hide();
	}

}

function changeMonth(id) {
	dateSelect($('#'+id).val(), function(year, month){
		$('#'+id).val(year + month);
	});
}

