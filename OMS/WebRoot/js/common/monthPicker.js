/**
 *
 * Date picker Author: Stefan Petre www.eyecon.ro
 *
 * Dual licensed under the MIT and GPL licenses
 *
 */
function dateSelect(curMonth, fun){
		var year = 0;
		var month = 0;
		if(curMonth) {
			if(curMonth.indexOf("/") > 0) {
				year = Number(curMonth.substr(0, 4));
				month = Number(curMonth.substr(5,7));
			} else
			if(curMonth.length >= 5) {
				year = Number(curMonth.substr(0, 4));
				month = Number(curMonth.substr(4,curMonth.length));
			}
		}
		if(year == 0) {
			var now = new Date();
			year = now.getFullYear();
			month = now.getMonth() + 1;
		}
		var startYear = year;
		while(true) {
			if(startYear % 10 == 0) {
				break;
			} else {
				startYear -- ;
			}
		}
		var viewYear = function(){
			for(var i = 0;i < 10;i ++) {
				var $selYear = $('#sel_year' + (i + 1));
				$selYear.html(startYear + i);
				if(startYear + i == year) {
					$selYear.attr("class", "sel_year");
				} else {
					$selYear.attr("class", "p_sel_year");
				}
			}
		};
		viewYear(startYear);
		$('#year_back').bind('click', function(){
			startYear -= 10;
			viewYear(startYear);
		});
		$('#year_next').bind('click', function(){
			startYear += 10;
			viewYear(startYear);
		});
		$('.sel_table_year div').bind('click', function(){
			year = Number(this.innerHTML);
			$('.sel_year').attr("class", "p_sel_year");
			$(this).attr("class", "sel_year");
		});
		$('.sel_table_month div').bind('click', function(){
			month = Number(this.id.substr(9));
			$('.sel_month').attr("class", "p_sel_month");
			$(this).attr("class", "sel_month");
		});
		$('.sel_month').attr("class", "p_sel_month");
		$('#sel_month' + parseInt(month)).attr("class", "sel_month");
		openPop("dateSelectPop", {
			title:'选择月份',
			resizable: false,
			height:'auto',
			width:300,
			modal: true,
			buttons: [{
				text:'确定',
				click: function(){
					fun(year, month > 9 ? month : "0" + month);
					$(this).dialog("close");
				},
				'class' : 'btn btn-primary btn-middle'
			},{
				text:'取消',
				'class' : 'btn btn-inverse btn-middle btn-aft-middle',
				click:function(){
					$(this).dialog("close");
				}
			}]
		});
	}