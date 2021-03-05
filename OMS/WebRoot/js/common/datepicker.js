/**
 *
 * Date picker Author: Stefan Petre www.eyecon.ro
 *
 * Dual licensed under the MIT and GPL licenses
 *
 */
(function($) {
	var DatePicker = function() {
		var ids = {}, views = {
			years : 'datepickerViewYears',
			moths : 'datepickerViewMonths',
			days : 'datepickerViewDays'
		}, weekDays = [ "sunday", "monday", "tuesday", "wednesday", "thursday",
				"friday", "saturday" ], language = {
			EN : {
				days : [ "Sunday", "Monday", "Tuesday", "Wednesday",
						"Thursday", "Friday", "Saturday", "Sunday" ],
				daysShort : [ "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat",
						"Sun" ],
				daysMin : [ "Su", "Mo", "Tu", "We", "Th", "Fr", "Sa", "Su" ],
				months : [ "January", "February", "March", "April", "May",
						"June", "July", "August", "September", "October",
						"November", "December" ],
				monthsShort : [ "Jan", "Feb", "Mar", "Apr", "May", "Jun",
						"Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ],
				weekMin : 'wk'
			},
			JP : {
				days : [ "\u65e5\u66dc\u65e5", "\u6708\u66dc\u65e5",
						"\u706b\u66dc\u65e5", "\u6c34\u66dc\u65e5",
						"\u6728\u66dc\u65e5", "\u91d1\u66dc\u65e5",
						"\u571f\u66dc\u65e5", "\u65e5\u66dc\u65e5" ],
				daysShort : [ "\u65e5", "\u6708", "\u706b", "\u6c34", "\u6728",
						"\u91d1", "\u571f", "\u65e5" ],
				daysMin : [ "\u65e5", "\u6708", "\u706b", "\u6c34", "\u6728",
						"\u91d1", "\u571f", "\u65e5" ],
				months : [ "\u4e00\u6708", "\u4e8c\u6708", "\u4e09\u6708",
						"\u56db\u6708", "\u4e94\u6708", "\u516d\u6708",
						"\u4e03\u6708", "\u516b\u6708", "\u4e5d\u6708",
						"\u5341\u6708", "\u5341\u4e00\u6708",
						"\u5341\u4e8c\u6708" ],
				monthsShort : [ "\u4e00", "\u4e8c", "\u4e09", "\u56db",
						"\u4e94", "\u516d", "\u4e03", "\u516b", "\u4e5d",
						"\u5341", "\u5341\u4e00", "\u5341\u4e8c" ],
				weekMin : 'wk'
			},
			CN : {
				days : [ "\u661f\u671f\u65e5", "\u661f\u671f\u4e00",
						"\u661f\u671f\u4e8c", "\u661f\u671f\u4e09",
						"\u661f\u671f\u56db", "\u661f\u671f\u4e94",
						"\u661f\u671f\u516d", "\u661f\u671f\u65e5" ],
				daysShort : [ "\u65e5", "\u4e00", "\u4e8c", "\u4e09", "\u56db",
						"\u4e94", "\u516d", "\u65e5" ],
				daysMin : [ "\u65e5", "\u4e00", "\u4e8c", "\u4e09", "\u56db",
						"\u4e94", "\u516d", "\u65e5" ],
				months : [ "\u4e00\u6708", "\u4e8c\u6708", "\u4e09\u6708",
						"\u56db\u6708", "\u4e94\u6708", "\u516d\u6708",
						"\u4e03\u6708", "\u516b\u6708", "\u4e5d\u6708",
						"\u5341\u6708", "\u5341\u4e00\u6708",
						"\u5341\u4e8c\u6708" ],
				monthsShort : [ "\u4e00", "\u4e8c", "\u4e09", "\u56db",
						"\u4e94", "\u516d", "\u4e03", "\u516b", "\u4e5d",
						"\u5341", "\u5341\u4e00", "\u5341\u4e8c" ],
				weekMin : 'wk'
			}
		}, date_format = {
			EN : "Y-m-d",
			JP : "Y-m-d",
			CN : "Y-m-d"
		}, tpl = {
			wrapper : '<div class="datepicker ui-widget-content" align="center"><div class="datepickerBorderT" /><div class="datepickerBorderB" /><div class="datepickerBorderL" /><div class="datepickerBorderR" /><div class="datepickerBorderTL" /><div class="datepickerBorderTR" /><div class="datepickerBorderBL" /><div class="datepickerBorderBR" /><div class="datepickerContainer"><table cellspacing="0" cellpadding="0"><tbody><tr></tr></tbody></table></div></div>',
			head : [
					'<td>',
					'<table cellspacing="0" cellpadding="0">',
					'<thead>',
					'<tr>',
					'<th class="datepickerGoPrev"><a href="#"><span><%=prev%></span></a></th>',
					'<th colspan="5" class="datepickerMonth ui-datepicker-title calendar-widget-header"><a href="#"><span></span></a></th>',
					'<th class="datepickerGoNext"><a href="#"><span><%=next%></span></a></th>',
					'</tr>', '<tr class="datepickerDoW">',
					'<th><span><%=day1%></span></th>',
					'<th><span><%=day2%></span></th>',
					'<th><span><%=day3%></span></th>',
					'<th><span><%=day4%></span></th>',
					'<th><span><%=day5%></span></th>',
					'<th><span><%=day6%></span></th>',
					'<th><span><%=day7%></span></th>', '</tr>', '</thead>',
					'</table></td>' ],
			space : '<td class="datepickerSpace"><div></div></td>',
			days : [
					'<tbody class="datepickerDays">',
					'<tr>',
					'<td class="<%=weeks[0].days[0].classname%>" title="<%=weeks[0].days[0].title%>"><a href="#"><span style="<%=weeks[0].days[0].color%>"><%=weeks[0].days[0].text%></span></a></td>',
					'<td class="<%=weeks[0].days[1].classname%>" title="<%=weeks[0].days[1].title%>"><a href="#"><span style="<%=weeks[0].days[1].color%>"><%=weeks[0].days[1].text%></span></a></td>',
					'<td class="<%=weeks[0].days[2].classname%>" title="<%=weeks[0].days[2].title%>"><a href="#"><span style="<%=weeks[0].days[2].color%>"><%=weeks[0].days[2].text%></span></a></td>',
					'<td class="<%=weeks[0].days[3].classname%>" title="<%=weeks[0].days[3].title%>"><a href="#"><span style="<%=weeks[0].days[3].color%>"><%=weeks[0].days[3].text%></span></a></td>',
					'<td class="<%=weeks[0].days[4].classname%>" title="<%=weeks[0].days[4].title%>"><a href="#"><span style="<%=weeks[0].days[4].color%>"><%=weeks[0].days[4].text%></span></a></td>',
					'<td class="<%=weeks[0].days[5].classname%>" title="<%=weeks[0].days[5].title%>"><a href="#"><span style="<%=weeks[0].days[5].color%>"><%=weeks[0].days[5].text%></span></a></td>',
					'<td class="<%=weeks[0].days[6].classname%>" title="<%=weeks[0].days[6].title%>"><a href="#"><span style="<%=weeks[0].days[6].color%>"><%=weeks[0].days[6].text%></span></a></td>',
					'</tr>',
					'<tr>',
					'<td class="<%=weeks[1].days[0].classname%>" title="<%=weeks[1].days[0].title%>"><a href="#"><span style="<%=weeks[1].days[0].color%>"><%=weeks[1].days[0].text%></span></a></td>',
					'<td class="<%=weeks[1].days[1].classname%>" title="<%=weeks[1].days[1].title%>"><a href="#"><span style="<%=weeks[1].days[1].color%>"><%=weeks[1].days[1].text%></span></a></td>',
					'<td class="<%=weeks[1].days[2].classname%>" title="<%=weeks[1].days[2].title%>"><a href="#"><span style="<%=weeks[1].days[2].color%>"><%=weeks[1].days[2].text%></span></a></td>',
					'<td class="<%=weeks[1].days[3].classname%>" title="<%=weeks[1].days[3].title%>"><a href="#"><span style="<%=weeks[1].days[3].color%>"><%=weeks[1].days[3].text%></span></a></td>',
					'<td class="<%=weeks[1].days[4].classname%>" title="<%=weeks[1].days[4].title%>"><a href="#"><span style="<%=weeks[1].days[4].color%>"><%=weeks[1].days[4].text%></span></a></td>',
					'<td class="<%=weeks[1].days[5].classname%>" title="<%=weeks[1].days[5].title%>"><a href="#"><span style="<%=weeks[1].days[5].color%>"><%=weeks[1].days[5].text%></span></a></td>',
					'<td class="<%=weeks[1].days[6].classname%>" title="<%=weeks[1].days[6].title%>"><a href="#"><span style="<%=weeks[1].days[6].color%>"><%=weeks[1].days[6].text%></span></a></td>',
					'</tr>',
					'<tr>',
					'<td class="<%=weeks[2].days[0].classname%>" title="<%=weeks[2].days[0].title%>"><a href="#"><span style="<%=weeks[2].days[0].color%>"><%=weeks[2].days[0].text%></span></a></td>',
					'<td class="<%=weeks[2].days[1].classname%>" title="<%=weeks[2].days[1].title%>"><a href="#"><span style="<%=weeks[2].days[1].color%>"><%=weeks[2].days[1].text%></span></a></td>',
					'<td class="<%=weeks[2].days[2].classname%>" title="<%=weeks[2].days[2].title%>"><a href="#"><span style="<%=weeks[2].days[2].color%>"><%=weeks[2].days[2].text%></span></a></td>',
					'<td class="<%=weeks[2].days[3].classname%>" title="<%=weeks[2].days[3].title%>"><a href="#"><span style="<%=weeks[2].days[3].color%>"><%=weeks[2].days[3].text%></span></a></td>',
					'<td class="<%=weeks[2].days[4].classname%>" title="<%=weeks[2].days[4].title%>"><a href="#"><span style="<%=weeks[2].days[4].color%>"><%=weeks[2].days[4].text%></span></a></td>',
					'<td class="<%=weeks[2].days[5].classname%>" title="<%=weeks[2].days[5].title%>"><a href="#"><span style="<%=weeks[2].days[5].color%>"><%=weeks[2].days[5].text%></span></a></td>',
					'<td class="<%=weeks[2].days[6].classname%>" title="<%=weeks[2].days[6].title%>"><a href="#"><span style="<%=weeks[2].days[6].color%>"><%=weeks[2].days[6].text%></span></a></td>',
					'</tr>',
					'<tr>',
					'<td class="<%=weeks[3].days[0].classname%>" title="<%=weeks[3].days[0].title%>"><a href="#"><span style="<%=weeks[3].days[0].color%>"><%=weeks[3].days[0].text%></span></a></td>',
					'<td class="<%=weeks[3].days[1].classname%>" title="<%=weeks[3].days[1].title%>"><a href="#"><span style="<%=weeks[3].days[1].color%>"><%=weeks[3].days[1].text%></span></a></td>',
					'<td class="<%=weeks[3].days[2].classname%>" title="<%=weeks[3].days[2].title%>"><a href="#"><span style="<%=weeks[3].days[2].color%>"><%=weeks[3].days[2].text%></span></a></td>',
					'<td class="<%=weeks[3].days[3].classname%>" title="<%=weeks[3].days[3].title%>"><a href="#"><span style="<%=weeks[3].days[3].color%>"><%=weeks[3].days[3].text%></span></a></td>',
					'<td class="<%=weeks[3].days[4].classname%>" title="<%=weeks[3].days[4].title%>"><a href="#"><span style="<%=weeks[3].days[4].color%>"><%=weeks[3].days[4].text%></span></a></td>',
					'<td class="<%=weeks[3].days[5].classname%>" title="<%=weeks[3].days[5].title%>"><a href="#"><span style="<%=weeks[3].days[5].color%>"><%=weeks[3].days[5].text%></span></a></td>',
					'<td class="<%=weeks[3].days[6].classname%>" title="<%=weeks[3].days[6].title%>"><a href="#"><span style="<%=weeks[3].days[6].color%>"><%=weeks[3].days[6].text%></span></a></td>',
					'</tr>',
					'<tr>',
					'<td class="<%=weeks[4].days[0].classname%>" title="<%=weeks[4].days[0].title%>"><a href="#"><span style="<%=weeks[4].days[0].color%>"><%=weeks[4].days[0].text%></span></a></td>',
					'<td class="<%=weeks[4].days[1].classname%>" title="<%=weeks[4].days[1].title%>"><a href="#"><span style="<%=weeks[4].days[1].color%>"><%=weeks[4].days[1].text%></span></a></td>',
					'<td class="<%=weeks[4].days[2].classname%>" title="<%=weeks[4].days[2].title%>"><a href="#"><span style="<%=weeks[4].days[2].color%>"><%=weeks[4].days[2].text%></span></a></td>',
					'<td class="<%=weeks[4].days[3].classname%>" title="<%=weeks[4].days[3].title%>"><a href="#"><span style="<%=weeks[4].days[3].color%>"><%=weeks[4].days[3].text%></span></a></td>',
					'<td class="<%=weeks[4].days[4].classname%>" title="<%=weeks[4].days[4].title%>"><a href="#"><span style="<%=weeks[4].days[4].color%>"><%=weeks[4].days[4].text%></span></a></td>',
					'<td class="<%=weeks[4].days[5].classname%>" title="<%=weeks[4].days[5].title%>"><a href="#"><span style="<%=weeks[4].days[5].color%>"><%=weeks[4].days[5].text%></span></a></td>',
					'<td class="<%=weeks[4].days[6].classname%>" title="<%=weeks[4].days[6].title%>"><a href="#"><span style="<%=weeks[4].days[6].color%>"><%=weeks[4].days[6].text%></span></a></td>',
					'</tr>',
					'<tr>',
					'<td class="<%=weeks[5].days[0].classname%>" title="<%=weeks[5].days[0].title%>"><a href="#"><span style="<%=weeks[5].days[0].color%>"><%=weeks[5].days[0].text%></span></a></td>',
					'<td class="<%=weeks[5].days[1].classname%>" title="<%=weeks[5].days[1].title%>"><a href="#"><span style="<%=weeks[5].days[1].color%>"><%=weeks[5].days[1].text%></span></a></td>',
					'<td class="<%=weeks[5].days[2].classname%>" title="<%=weeks[5].days[2].title%>"><a href="#"><span style="<%=weeks[5].days[2].color%>"><%=weeks[5].days[2].text%></span></a></td>',
					'<td class="<%=weeks[5].days[3].classname%>" title="<%=weeks[5].days[3].title%>"><a href="#"><span style="<%=weeks[5].days[3].color%>"><%=weeks[5].days[3].text%></span></a></td>',
					'<td class="<%=weeks[5].days[4].classname%>" title="<%=weeks[5].days[4].title%>"><a href="#"><span style="<%=weeks[5].days[4].color%>"><%=weeks[5].days[4].text%></span></a></td>',
					'<td class="<%=weeks[5].days[5].classname%>" title="<%=weeks[5].days[5].title%>"><a href="#"><span style="<%=weeks[5].days[5].color%>"><%=weeks[5].days[5].text%></span></a></td>',
					'<td class="<%=weeks[5].days[6].classname%>" title="<%=weeks[5].days[6].title%>"><a href="#"><span style="<%=weeks[5].days[6].color%>"><%=weeks[5].days[6].text%></span></a></td>',
					'</tr>', '</tbody>' ],
			months : [
					'<tbody class="<%=className%>">',
					'<tr>',
					'<td colspan="2"><a href="#"><span><%=data[0]%></span></a></td>',
					'<td colspan="2"><a href="#"><span><%=data[1]%></span></a></td>',
					'<td colspan="2"><a href="#"><span><%=data[2]%></span></a></td>',
					'<td colspan="2"><a href="#"><span><%=data[3]%></span></a></td>',
					'</tr>',
					'<tr>',
					'<td colspan="2"><a href="#"><span><%=data[4]%></span></a></td>',
					'<td colspan="2"><a href="#"><span><%=data[5]%></span></a></td>',
					'<td colspan="2"><a href="#"><span><%=data[6]%></span></a></td>',
					'<td colspan="2"><a href="#"><span><%=data[7]%></span></a></td>',
					'</tr>',
					'<tr>',
					'<td colspan="2"><a href="#"><span><%=data[8]%></span></a></td>',
					'<td colspan="2"><a href="#"><span><%=data[9]%></span></a></td>',
					'<td colspan="2"><a href="#"><span><%=data[10]%></span></a></td>',
					'<td colspan="2"><a href="#"><span><%=data[11]%></span></a></td>',
					'</tr>', '</tbody>' ]
		}, defaults = {
			flat : false,
			starts : 0,
			prev : '&#9664;',
			next : '&#9654;',
			lastSel : false,
			mode : 'single',
			inputId : '',
			view : 'days',
			calendars : 1,
			format : 'Y-m-d',
			date : new Date(),
			current : new Date(),
			position : 'bottom', //right
			eventName : 'focus',
			rowsnum : 4,
			holidayData : {},
			setCalendarName: function(){},
			calendarId:'',
			lunarCalendar: ['鍒濅竴','鍒濅簩','鍒濅笁','鍒濆洓','鍒濅簲','鍒濆叚','鍒濅竷','鍒濆叓','鍒濅節','鍒濆崄','鍗佷竴','鍗佷簩','鍗佷笁','鍗佸洓','鍗佷簲','鍗佸叚','鍗佷竷','鍗佸叓','鍗佷節','浜屽崄','寤夸竴','寤夸簩','寤夸笁','寤垮洓','寤夸簲','寤垮叚','寤夸竷','寤垮叓','寤夸節','涓夊崄'],
			lunarCalendar_month: ['涓�湀','浜屾湀','涓夋湀','鍥涙湀','浜旀湀','鍏湀','涓冩湀','鍏湀','涔濇湀','鍒濆崄','鍐湀','鑵婃湀'],
			onRender : function() {
				return {};
			},
			onChange : function(formated, dates) {
				var options = $(this).data('datepicker');
				$('#' + options.inputId).val(formated);
				$('#' + options.inputId).DatePickerHide();
			},
			onShow : function() {
				return true;
			},
			onBeforeShow : function(el) {
				var options = $(el).data('datepicker');
				var inputValue = $('#' + options.inputId).val();
				if (inputValue != "") {
					var parts = inputValue.split(/\W+/);
					if (parts.length == 3 && /^\d+$/.test(parts[0])
							&& /^\d+$/.test(parts[1]) && /^\d+$/.test(parts[2])) {
						$('#' + options.inputId).DatePickerSetDate(inputValue,
								true);
					}
				}
			},
			onHide : function() {
				return true;
			},
			getHoliday : function(selDate, dates) {
				var lunarCalendar = "";
				if(dates.locale_language == "CN") {
					lunarCalendar = 'true';
				}
			},
			isHoliday : function(drawDate, weekday, dates) {
				var backDate = {flag:'', holiday_nm:'', lunar:''};
				if (typeof dates == "undefined") {
					backDate.flag = 'false';
					return backDate;
				}
				if(typeof dates.dataList == "undefined"){
					backDate.flag = 'false';
					return backDate;
				}
				var dataList = dates.dataList;
				var lunarList = dates.lunarList;
				if(lunarList) {
					var solar_date = drawDate.replace(/\//g, '');
					for(var j = 0, jl = lunarList.length; j < jl; j++) {
						if(lunarList[j].solar_date == solar_date) {
							backDate.lunar = lunarList[j].lunar_date;
							lunarList.splice(j, 1);
							break;
						}
					}
				}
				for ( var i = 0, l = dataList.length; i < l; i++) {
					var holiday_flg = "";
					if(dataList[i].calendar_date == drawDate){
						holiday_flg = dataList[i].holiday_type;
						if (holiday_flg == 'H') {
							backDate.flag = 'SH';
							backDate.holiday_nm = dataList[i].holiday_nm;
							return backDate;
						}
						if (holiday_flg == "W") {
							backDate.flag = 'SW';
							backDate.holiday_nm = dataList[i].holiday_nm;
							return backDate;
						}
					}
				}
				if (dates[weekday + '_flag'] == 'H') {
					backDate.flag = 'H';
					return backDate;
				}
				backDate.flag = 'W';
				return backDate;
			},
			locale_language : 'CN',
			locale : language.CN
		}, fill = function(el) {
			var options = $(el).data('datepicker');
			var cal = $(el);
			var currentCal = 0, date, data, dow, month, cnt = 0, week, days, indic, indic2, html, tblCal;
			cal.find('td>table tbody').remove();
			var now = new Date();
			for ( var i = 0; i < options.calendars; i++) {
				date = new Date(options.current);
				date.addMonths(-currentCal + i);
				tblCal = cal.find('table').eq(i + 1);
				switch (tblCal[0].className) {
				case 'datepickerViewDays':
					dow = formatDate(date, 'B, Y');
					break;
				case 'datepickerViewMonths':
					dow = date.getFullYear();
					break;
				case 'datepickerViewYears':
					dow = (date.getFullYear() - 6) + ' - '
							+ (date.getFullYear() + 5);
					break;
				}
				tblCal.find('thead tr:first th:eq(1) span').text(dow);
				dow = date.getFullYear() - 6;
				data = {
					data : [],
					className : 'datepickerYears'
				}
				for ( var j = 0; j < 12; j++) {
					data.data.push(dow + j);
				}
				html = tmpl(tpl.months.join(''), data);
				date.setDate(1);
				data = {
					weeks : [],
					test : 10
				};
				month = date.getMonth();
				var dow = (date.getDay() - options.starts) % 7;
				date.addDays(-(dow + (dow < 0 ? 7 : 0)));
				week = -1;
				cnt = 0;
				while (cnt < 42) {
					indic = parseInt(cnt / 7, 10);
					indic2 = cnt % 7;
					if (!data.weeks[indic]) {
						week = date.getWeekNumber();
						data.weeks[indic] = {
							week : week,
							days : []
						};
					}
					data.weeks[indic].days[indic2] = {
						text : date.getDate(),
						classname : [],
						title: '',
						color: ''
					};
					var fromUser = options.onRender(date);
					var val = date.valueOf();
					data.weeks[indic].days[indic2].classname
							.push('calendarDefault');
					var flg = options.isHoliday(formatDate(date, options.format),
							weekDays[date.getDay()], options.holidayData);
					if(flg.lunar.length > 0){
						data.weeks[indic].days[indic2].title = (options.lunarCalendar_month[Number(flg.lunar.substr(4, 2)) - 1] + options.lunarCalendar[Number(flg.lunar.substr(6)) - 1])
					}
					if(flg.holiday_nm != '') {
						data.weeks[indic].days[indic2].title += "\n" + flg.holiday_nm.replace(/;/g, "\n");
					}
					if(flg.flag != 'false') {
						if (flg.flag == 'H') {
							var index = data.weeks[indic].days[indic2].classname.indexOf("calendarDefault");
							if(index >= 0){
								data.weeks[indic].days[indic2].classname.splice(
										index, 1);
							}
							data.weeks[indic].days[indic2].classname
									.push('calendarHoliday');
						} else
							if (flg.flag == 'SH') {
								var index = data.weeks[indic].days[indic2].classname.indexOf("calendarDefault");
								if(index >= 0){
									data.weeks[indic].days[indic2].classname.splice(
											index, 1);
								}
								data.weeks[indic].days[indic2].classname
										.push('setHoliday');
							} else
								if (flg.flag == 'SW') {
									var index = data.weeks[indic].days[indic2].classname.indexOf("calendarDefault");
									if(index >= 0){
										data.weeks[indic].days[indic2].classname.splice(
												index, 1);
									}
									data.weeks[indic].days[indic2].classname
											.push('setWeekDay');
								}
					}
					if (fromUser.selected
							|| options.date == val
							|| $.inArray(val, options.date) > -1
							|| (options.mode == 'range'
									&& val >= options.date[0] && val <= options.date[1])) {
						data.weeks[indic].days[indic2].classname = [];
						data.weeks[indic].days[indic2].classname
								.push('calendarSelectDay');
					}

					if(date.getFullYear() == now.getFullYear() && date.getMonth() == now.getMonth() && date.getDate() == now.getDate()) {
						data.weeks[indic].days[indic2].color = "color:red";
					}

					if (month != date.getMonth()) {
						data.weeks[indic].days[indic2].classname = [];
						data.weeks[indic].days[indic2].classname
								.push('datepickerNotInMonth');
					}
					if (fromUser.disabled) {
						data.weeks[indic].days[indic2].classname
								.push('datepickerDisabled');
					}
					if (fromUser.className) {
						data.weeks[indic].days[indic2].classname
								.push(fromUser.className);
					}
					data.weeks[indic].days[indic2].classname = data.weeks[indic].days[indic2].classname
							.join(' ');
					cnt++;
					date.addDays(1);
				}
				html = tmpl(tpl.days.join(''), data) + html;
				data = {
					data : options.locale.monthsShort,
					className : 'datepickerMonths'
				};
				html = tmpl(tpl.months.join(''), data) + html;
				tblCal.append(html);
			}
		}, parseDate = function(date, format) {
			if (date.constructor == Date) {
				return new Date(date);
			}
			var parts = date.split(/\W+/);
			var against = format.split(/\W+/), d, m, y, h, min, now = new Date();
			for ( var i = 0; i < parts.length; i++) {
				switch (against[i]) {
				case 'd':
				case 'e':
					d = parseInt(parts[i], 10);
					break;
				case 'm':
					m = parseInt(parts[i], 10) - 1;
					break;
				case 'Y':
				case 'y':
					y = parseInt(parts[i], 10);
					y += y > 100 ? 0 : (y < 29 ? 2000 : 1900);
					break;
				case 'H':
				case 'I':
				case 'k':
				case 'l':
					h = parseInt(parts[i], 10);
					break;
				case 'P':
				case 'p':
					if (/pm/i.test(parts[i]) && h < 12) {
						h += 12;
					} else if (/am/i.test(parts[i]) && h >= 12) {
						h -= 12;
					}
					break;
				case 'M':
					min = parseInt(parts[i], 10);
					break;
				}
			}
			return new Date(y === undefined ? now.getFullYear() : y,
					m === undefined ? now.getMonth() : m, d === undefined ? now
							.getDate() : d, h === undefined ? now.getHours()
							: h, min === undefined ? now.getMinutes() : min, 0);
		}, formatDate = function(date, format) {
			var m = date.getMonth();
			var d = date.getDate();
			var y = date.getFullYear();
			var wn = date.getWeekNumber();
			var w = date.getDay();
			var s = {};
			var hr = date.getHours();
			var pm = (hr >= 12);
			var ir = (pm) ? (hr - 12) : hr;
			var dy = date.getDayOfYear();
			if (ir == 0) {
				ir = 12;
			}
			var min = date.getMinutes();
			var sec = date.getSeconds();
			var parts = format.split(''), part;
			for ( var i = 0; i < parts.length; i++) {
				part = parts[i];
				switch (parts[i]) {
				case 'a':
					part = date.getDayName();
					break;
				case 'A':
					part = date.getDayName(true);
					break;
				case 'b':
					part = date.getMonthName();
					break;
				case 'B':
					part = date.getMonthName(true);
					break;
				case 'C':
					part = 1 + Math.floor(y / 100);
					break;
				case 'd':
					part = (d < 10) ? ("0" + d) : d;
					break;
				case 'e':
					part = d;
					break;
				case 'H':
					part = (hr < 10) ? ("0" + hr) : hr;
					break;
				case 'I':
					part = (ir < 10) ? ("0" + ir) : ir;
					break;
				case 'j':
					part = (dy < 100) ? ((dy < 10) ? ("00" + dy) : ("0" + dy))
							: dy;
					break;
				case 'k':
					part = hr;
					break;
				case 'l':
					part = ir;
					break;
				case 'm':
					part = (m < 9) ? ("0" + (1 + m)) : (1 + m);
					break;
				case 'M':
					part = (min < 10) ? ("0" + min) : min;
					break;
				case 'p':
				case 'P':
					part = pm ? "PM" : "AM";
					break;
				case 's':
					part = Math.floor(date.getTime() / 1000);
					break;
				case 'S':
					part = (sec < 10) ? ("0" + sec) : sec;
					break;
				case 'u':
					part = w + 1;
					break;
				case 'w':
					part = w;
					break;
				case 'y':
					part = ('' + y).substr(2, 2);
					break;
				case 'Y':
					part = y;
					break;
				}
				parts[i] = part;
			}
			return parts.join('');
		}, extendDate = function(options) {
			if (Date.prototype.tempDate) {
				return;
			}
			Date.prototype.tempDate = null;
			Date.prototype.months = options.months;
			Date.prototype.monthsShort = options.monthsShort;
			Date.prototype.days = options.days;
			Date.prototype.daysShort = options.daysShort;
			Date.prototype.getMonthName = function(fullName) {
				return this[fullName ? 'months' : 'monthsShort'][this
						.getMonth()];
			};
			Date.prototype.getDayName = function(fullName) {
				return this[fullName ? 'days' : 'daysShort'][this.getDay()];
			};
			Date.prototype.addDays = function(n) {
				this.setDate(this.getDate() + n);
				this.tempDate = this.getDate();
			};
			Date.prototype.addMonths = function(n) {
				if (this.tempDate == null) {
					this.tempDate = this.getDate();
				}
				this.setDate(1);
				this.setMonth(this.getMonth() + n);
				this.setDate(Math.min(this.tempDate, this.getMaxDays()));
			};
			Date.prototype.addYears = function(n) {
				if (this.tempDate == null) {
					this.tempDate = this.getDate();
				}
				this.setDate(1);
				this.setFullYear(this.getFullYear() + n);
				this.setDate(Math.min(this.tempDate, this.getMaxDays()));
			};
			Date.prototype.getMaxDays = function() {
				var tmpDate = new Date(Date.parse(this)), d = 28, m;
				m = tmpDate.getMonth();
				d = 28;
				while (tmpDate.getMonth() == m) {
					d++;
					tmpDate.setDate(d);
				}
				return d - 1;
			};
			Date.prototype.getFirstDay = function() {
				var tmpDate = new Date(Date.parse(this));
				tmpDate.setDate(1);
				return tmpDate.getDay();
			};
			Date.prototype.getWeekNumber = function() {
				var tempDate = new Date(this);
				tempDate.setDate(tempDate.getDate() - (tempDate.getDay() + 6)
						% 7 + 3);
				var dms = tempDate.valueOf();
				tempDate.setMonth(0);
				tempDate.setDate(4);
				return Math.round((dms - tempDate.valueOf()) / (604800000)) + 1;
			};
			Date.prototype.getDayOfYear = function() {
				var now = new Date(this.getFullYear(), this.getMonth(), this
						.getDate(), 0, 0, 0);
				var then = new Date(this.getFullYear(), 0, 0, 0, 0, 0);
				var time = now - then;
				return Math.floor(time / 24 * 60 * 60 * 1000);
			};
		}, layout = function(el) {
			var options = $(el).data('datepicker');
			var cal = $('#' + options.id);
			if (!options.extraHeight) {
				var divs = $(el).find('div');
				options.extraHeight = divs.get(0).offsetHeight
						+ divs.get(1).offsetHeight;
				options.extraWidth = divs.get(2).offsetWidth
						+ divs.get(3).offsetWidth;
			}
			var tbl = cal.find('table:first').get(0);
			var width = tbl.offsetWidth + 20;
			var height = tbl.offsetHeight + 10;
			cal.css({
//				width : width + options.extraWidth + 'px',
//				height : height + options.extraHeight + 'px'
				width : width + 2 + 'px',
				height : height + 2 + 'px'
			}).find('div.datepickerContainer').css({
				width : width + 'px',
				height : height + 'px'
			});
		}, click = function(ev) {
			if ($(ev.target).is('span')) {
				ev.target = ev.target.parentNode;
			}
			var el = $(ev.target);
			if (el.is('a')) {
				ev.target.blur();
				if (el.hasClass('datepickerDisabled')) {
					return false;
				}
				var options = $(this).data('datepicker');
				var parentEl = el.parent();
				var tblEl = parentEl.parent().parent().parent();
				var tblIndex = $('table', this).index(tblEl.get(0)) - 1;
				var tmp = new Date(options.current);
				var changed = false;
				var fillIt = false;
				if (parentEl.is('th')) {
					if (parentEl.hasClass('datepickerWeek')
							&& options.mode == 'range'
							&& !parentEl.next().hasClass('datepickerDisabled')) {
						var val = parseInt(parentEl.next().text(), 10);
						tmp.addMonths(tblIndex
								- Math.floor(options.calendars / 2));
						if (parentEl.next().hasClass('datepickerNotInMonth')) {
							tmp.addMonths(val > 15 ? -1 : 1);
						}
						tmp.setDate(val);
						options.date[0] = (tmp.setHours(0, 0, 0, 0)).valueOf();
						tmp.setHours(23, 59, 59, 0);
						tmp.addDays(6);
						options.date[1] = tmp.valueOf();
						fillIt = true;
						changed = true;
						options.lastSel = false;
					} else if (parentEl.hasClass('datepickerMonth')) {
						// tmp.addMonths(tblIndex -
						// Math.floor(options.calendars/2));
						switch (tblEl.get(0).className) {
						case 'datepickerViewDays':
							tblEl.get(0).className = 'datepickerViewMonths';
							el.find('span').text(tmp.getFullYear());
							break;
						case 'datepickerViewMonths':
							tblEl.get(0).className = 'datepickerViewYears';
							el.find('span').text(
									(tmp.getFullYear() - 6) + ' - '
											+ (tmp.getFullYear() + 5));
							break;
						case 'datepickerViewYears':
							tblEl.get(0).className = 'datepickerViewDays';
							el.find('span').text(formatDate(tmp, 'B, Y'));
							break;
						}
					} else if (parentEl.parent().parent().is('thead')) {
						switch (tblEl.get(0).className) {
						case 'datepickerViewDays':
							options.current.addMonths(parentEl
									.hasClass('datepickerGoPrev') ? -1 : 1);
							break;
						case 'datepickerViewMonths':
							options.current.addYears(parentEl
									.hasClass('datepickerGoPrev') ? -1 : 1);
							break;
						case 'datepickerViewYears':
							options.current.addYears(parentEl
									.hasClass('datepickerGoPrev') ? -12 : 12);
							break;
						}
						options.getHoliday(options.current, options);
						fillIt = true;
					}
				} else if (parentEl.is('td')
						&& !parentEl.hasClass('datepickerDisabled')
						/*&& !parentEl.hasClass('datepickerNotInMonth')*/) {
					changed = true;
					switch (tblEl.get(0).className) {
					case 'datepickerViewMonths':
						options.current.setMonth(tblEl.find(
								'tbody.datepickerMonths td').index(parentEl));
						options.current.setFullYear(parseInt(tblEl.find(
								'thead th.datepickerMonth span').text(), 10));
						options.current.addMonths(-tblIndex);
						tblEl.get(0).className = 'datepickerViewDays';
						changed = false;
						options.getHoliday(options.current, options);
						break;
					case 'datepickerViewYears':
						options.current.setFullYear(parseInt(el.text(), 10));
						tblEl.get(0).className = 'datepickerViewMonths';
						changed = false;
						options.getHoliday(options.current, options);
						break;
					default:
						var val = parseInt(el.text(), 10);
						tmp.addMonths(tblIndex
								- Math.floor(options.calendars / 2));
						if (parentEl.hasClass('datepickerNotInMonth')) {
							tmp.addMonths(val > 15 ? -1 : 1);
						}
						tmp.setDate(val);
						switch (options.mode) {
						case 'multiple':
							val = (tmp.setHours(0, 0, 0, 0)).valueOf();
							if ($.inArray(val, options.date) > -1) {
								$.each(options.date, function(nr, dat) {
									if (dat == val) {
										options.date.splice(nr, 1);
										return false;
									}
								});
							} else {
								options.date.push(val);
							}
							break;
						case 'range':
							if (!options.lastSel) {
								options.date[0] = (tmp.setHours(0, 0, 0, 0))
										.valueOf();
							}
							val = (tmp.setHours(23, 59, 59, 0)).valueOf();
							if (val < options.date[0]) {
								options.date[1] = options.date[0] + 86399000;
								options.date[0] = val - 86399000;
							} else {
								options.date[1] = val;
							}
							options.lastSel = !options.lastSel;
							return false;
						default:
							options.date = tmp.valueOf();
							if(options.model == 'view'){
								return;
							} else if(options.model == 'ico') {
								options.onChange.apply(this, prepareDate(options));
								$(this).hide();
								return;
							}
							break;
						}
						break;
					}
					fillIt = true;
				}
				if (fillIt) {
					fill(this);
				}
				if (changed) {
					options.onChange.apply(this, prepareDate(options));
				}
			}
			return false;
		}, prepareDate = function(options) {
			var tmp;
			if (options.mode == 'single') {
				tmp = new Date(options.date);
				return [ formatDate(tmp, options.format), tmp, options.el ];
			} else {
				tmp = [ [], [], options.el ];
				$.each(options.date, function(nr, val) {
					var date = new Date(val);
					tmp[0].push(formatDate(date, options.format));
					tmp[1].push(date);
				});
				return tmp;
			}
		}, getViewport = function() {
			var m = document.compatMode == 'CSS1Compat';
			return {
				l : window.pageXOffset
						|| (m ? document.documentElement.scrollLeft
								: document.body.scrollLeft),
				t : window.pageYOffset
						|| (m ? document.documentElement.scrollTop
								: document.body.scrollTop),
				w : window.innerWidth
						|| (m ? document.documentElement.clientWidth
								: document.body.clientWidth),
				h : window.innerHeight
						|| (m ? document.documentElement.clientHeight
								: document.body.clientHeight)
			};
		}, isChildOf = function(parentEl, el, container) {
			if (parentEl == el) {
				return true;
			}
			if (parentEl.contains) {
				return parentEl.contains(el);
			}
			if (parentEl.compareDocumentPosition) {
				return !!(parentEl.compareDocumentPosition(el) & 16);
			}
			var prEl = el.parentNode;
			while (prEl && prEl != container) {
				if (prEl == parentEl)
					return true;
				prEl = prEl.parentNode;
			}
			return false;
		}, show = function(ev) {
			var cal = $('#' + $(this).data('datepickerId'));
			if (!cal.is(':visible')) {
				var options = cal.data('datepicker');
				options.getHoliday(options.current, options);
				var calEl = cal.get(0);
				fill(calEl);
				options.onBeforeShow.apply(this, [ cal.get(0) ]);
				var pos = $(this).offset();
				var viewPort = getViewport();
				var top = pos.top;
				var left = pos.left;
				cal.css({
					visibility : 'hidden',
					display : 'block'
				});
				layout(calEl);
				switch (options.position) {
				case 'top':
					top -= calEl.offsetHeight;
					break;
				case 'left':
					left -= calEl.offsetWidth;
					break;
				case 'right':
					left += this.offsetWidth;
					break;
				case 'bottom':
					top += this.offsetHeight;
					break;
				}
				if (top + calEl.offsetHeight > viewPort.t + viewPort.h) {
					top = pos.top - calEl.offsetHeight;
				}
				if (top < viewPort.t) {
					top = pos.top + this.offsetHeight + calEl.offsetHeight;
				}
				if (left + calEl.offsetWidth > viewPort.l + viewPort.w) {
					left = pos.left - calEl.offsetWidth;
				}
				if (left < viewPort.l) {
					left = pos.left + this.offsetWidth
				}
				cal.css({
					visibility : 'visible',
					display : 'block',
					top : top + 'px',
					left : left + 'px'
				});
				if(options.model == "view"){
					cal.css({
						top : 0 + 'px',
						left : 0 + 'px'
					});
				} else {
					cal.css({
						"box-shadow" : "3px 3px 2px #A1836F"
					});
				}
				if (options.onShow.apply(this, [ cal.get(0) ]) != false) {
					cal.show(1000);
				}
				if(options.model == "view"){
					return;
				}
				$(document).bind('mousedown', {
					cal : cal,
					trigger : this
				}, hide);
			}
			return false;
		}, hide = function(ev) {
			if (ev.target != ev.data.trigger
					&& !isChildOf(ev.data.cal.get(0), ev.target, ev.data.cal
							.get(0))) {
				if (ev.data.cal.data('datepicker').onHide.apply(this,
						[ ev.data.cal.get(0) ]) != false) {
					ev.data.cal.hide();
				}
				$(document).unbind('mousedown', hide);
			}
		};
		return {
			init : function(options) {
				options = $.extend({}, defaults, options || {});
				options.locale_language = 'CN';
				if (options.locale_language) {
					options.locale = language[options.locale_language];
					options.format = date_format[options.locale_language];
				}
				options.calendarId = '';
				options.inputId = this[0].id;
				if(options.model != "view" &&  options.model != 'ico'){
					$('<a href="javascript:void(0)" style="margin-left:3px" onclick="javaScript:$(\'#'
							+ options.inputId + '\').focus()"><img src="'
							+ '../../../images/cal.gif"/></a>')
					.insertAfter(this);
				}
				extendDate(options.locale);
				options.calendars = Math.max(1,
						parseInt(options.calendars, 10) || 1);
				options.mode = /single|multiple|range/.test(options.mode) ? options.mode
						: 'single';
				return this.each(function() {
					if (!$(this).data('datepicker')) {
						options.el = this;
						if (options.date.constructor == String) {
							options.date = parseDate(options.date,
									options.format);
							options.date.setHours(0, 0, 0, 0);
						}
						if (options.mode != 'single') {
							if (options.date.constructor != Array) {
								options.date = [ options.date.valueOf() ];
								if (options.mode == 'range') {
									options.date.push(((new Date(
											options.date[0])).setHours(23, 59,
											59, 0)).valueOf());
								}
							} else {
								for ( var i = 0; i < options.date.length; i++) {
									options.date[i] = (parseDate(
											options.date[i], options.format)
											.setHours(0, 0, 0, 0)).valueOf();
								}
								if (options.mode == 'range') {
									options.date[1] = ((new Date(
											options.date[1])).setHours(23, 59,
											59, 0)).valueOf();
								}
							}
						} else {
							options.date = options.date.valueOf();
						}
						if (!options.current) {
							options.current = new Date();
						} else {
							options.current = parseDate(options.current,
									options.format);
						}
						options.current.setDate(1);
						options.current.setHours(0, 0, 0, 0);
						var id = this.id + '_datepicker', cnt;
						options.id = id;
						$(this).data('datepickerId', options.id);
						var cal = $(tpl.wrapper).attr('id', id).bind('click',
								click).data('datepicker', options);
						if (options.className) {
							cal.addClass(options.className);
						}
						var html = '<tr>';
						for ( var i = 0; i < options.calendars; i++) {
							cnt = options.starts;
							if (i != 0 && i % options.rowsnum == 0
									&& i != options.calendars - 1) {
								html += "</tr><tr>";
							} else if (i > 0) {
								html += tpl.space;
							}
							html += tmpl(tpl.head.join(''), {
								week : options.locale.weekMin,
								prev : options.prev,
								next : options.next,
								day1 : options.locale.daysMin[(cnt++) % 7],
								day2 : options.locale.daysMin[(cnt++) % 7],
								day3 : options.locale.daysMin[(cnt++) % 7],
								day4 : options.locale.daysMin[(cnt++) % 7],
								day5 : options.locale.daysMin[(cnt++) % 7],
								day6 : options.locale.daysMin[(cnt++) % 7],
								day7 : options.locale.daysMin[(cnt++) % 7]
							});
						}
						html += "</tr>";
						cal.find('tbody:first').append(html).find('table')
								.addClass(views[options.view]);
						//fill(cal.get(0));
						if(options.model == "view"){
							//options.getHoliday(options.current, options);
							cal.appendTo(this).css('position', 'relative');
							show.apply(this);
							cal.show();
							layout(cal.get(0));
							return;
						}
						if (options.flat) {
							cal.appendTo(this).show().css('position', 'relative');
							layout(cal.get(0));
						} else {
							cal.appendTo(document.body);
							$(this).bind(options.eventName, show);
						}
					}
				});
			},
			changeCalendar: function(calendar_seq){
				return this.each(function() {
					if ($(this).data('datepickerId')) {
						var cal = $('#' + $(this).data('datepickerId'));
						var options = cal.data('datepicker');
						if(calendar_seq == options.calendarId) {
							return;
						}
						options.calendarId = calendar_seq;
						cal.hide();
						show.apply(this);
					}
				});
			},
			showPicker : function() {
				return this.each(function() {
					if ($(this).data('datepickerId')) {
						show.apply(this);
					}
				});
			},
			hidePicker : function() {
				return this.each(function() {
					if ($(this).data('datepickerId')) {
						$('#' + $(this).data('datepickerId')).hide();
					}
				});
			},
			setDate : function(date, shiftTo) {
				return this.each(function() {
					if ($(this).data('datepickerId')) {
						var cal = $('#' + $(this).data('datepickerId'));
						var options = cal.data('datepicker');
						options.date = date;
						if (options.date.constructor == String) {
							options.date = parseDate(options.date,
									options.format);
							options.date.setHours(0, 0, 0, 0);
						}
						if (options.mode != 'single') {
							if (options.date.constructor != Array) {
								options.date = [ options.date.valueOf() ];
								if (options.mode == 'range') {
									options.date.push(((new Date(
											options.date[0])).setHours(23, 59,
											59, 0)).valueOf());
								}
							} else {
								for ( var i = 0; i < options.date.length; i++) {
									options.date[i] = (parseDate(
											options.date[i], options.format)
											.setHours(0, 0, 0, 0)).valueOf();
								}
								if (options.mode == 'range') {
									options.date[1] = ((new Date(
											options.date[1])).setHours(23, 59,
											59, 0)).valueOf();
								}
							}
						} else {
							options.date = options.date.valueOf();
						}
						if (shiftTo) {
							options.current = new Date(
									options.mode != 'single' ? options.date[0]
											: options.date);
						}
						fill(cal.get(0));
					}
				});
			},
			getDate : function(formated) {
				if (this.size() > 0) {
					return prepareDate($('#' + $(this).data('datepickerId'))
							.data('datepicker'))[formated ? 0 : 1];
				}
			},
			clear : function() {
				return this.each(function() {
					if ($(this).data('datepickerId')) {
						var cal = $('#' + $(this).data('datepickerId'));
						var options = cal.data('datepicker');
						if (options.mode != 'single') {
							options.date = [];
							fill(cal.get(0));
						}
					}
				});
			},
			flush : function(holiday) {
				return this.each(function() {
					if ($(this).data('datepickerId')) {
						var cal = $('#' + $(this).data('datepickerId'));
						alert(holiday);
						fill(cal.get(0));
					}
				});
			},
			fixLayout : function() {
				return this.each(function() {
					if ($(this).data('datepickerId')) {
						var cal = $('#' + $(this).data('datepickerId'));
						var options = cal.data('datepicker');
						if (options.flat) {
							layout(cal.get(0));
						}
					}
				});
			}
		};
	}();
	$.fn.extend({
		DatePicker : DatePicker.init,
		changeCalendar : DatePicker.changeCalendar,
		DatePickerHide : DatePicker.hidePicker,
		DatePickerShow : DatePicker.showPicker,
		DatePickerSetDate : DatePicker.setDate,
		DatePickerGetDate : DatePicker.getDate,
		DatePickerClear : DatePicker.clear,
		DatePickerLayout : DatePicker.fixLayout,
		DatePickerFlush : DatePicker.flush
	});
})(jQuery);


(function() {
	var cache = {};

	this.tmpl = function tmpl(str, data) {
		// Figure out if we're getting a template, or if we need to
		// load the template - and be sure to cache the result.
		var fn = !/\W/.test(str) ? cache[str] = cache[str]
				|| tmpl(document.getElementById(str).innerHTML) :

		// Generate a reusable function that will serve as a template
		// generator (and which will be cached).
		new Function("obj",
				"var p=[],print=function(){p.push.apply(p,arguments);};"
						+

						// Introduce the data as local variables using with(){}
						"with(obj){p.push('"
						+

						// Convert the template into pure JavaScript
						str.replace(/[\r\t\n]/g, " ").split("<%").join("\t")
								.replace(/((^|%>)[^\t]*)'/g, "$1\r").replace(
										/\t=(.*?)%>/g, "',$1,'").split("\t")
								.join("');").split("%>").join("p.push('")
								.split("\r").join("\\'")
						+ "');}return p.join('');");

		// Provide some basic currying to the user
		return data ? fn(data) : fn;
	};
})();
/**
 *
 * Zoomimage Author: Stefan Petre www.eyecon.ro
 *
 */
(function($) {
	var EYE = window.EYE = function() {
		var _registered = {
			init : []
		};
		return {
			init : function() {
				$.each(_registered.init, function(nr, fn) {
					fn.call();
				});
			},
			extend : function(prop) {
				for ( var i in prop) {
					if (prop[i] != undefined) {
						this[i] = prop[i];
					}
				}
			},
			register : function(fn, type) {
				if (!_registered[type]) {
					_registered[type] = [];
				}
				_registered[type].push(fn);
			}
		};
	}();
	$(EYE.init);
})(jQuery);
/**
 *
 * Utilities Author: Stefan Petre www.eyecon.ro
 *
 */
(function($) {
	EYE.extend({
		getPosition : function(e, forceIt) {
			var x = 0;
			var y = 0;
			var es = e.style;
			var restoreStyles = false;
			if (forceIt && jQuery.curCSS(e, 'display') == 'none') {
				var oldVisibility = es.visibility;
				var oldPosition = es.position;
				restoreStyles = true;
				es.visibility = 'hidden';
				es.display = 'block';
				es.position = 'absolute';
			}
			var el = e;
			if (el.getBoundingClientRect) { // IE
				var box = el.getBoundingClientRect();
				x = box.left
						+ Math.max(document.documentElement.scrollLeft,
								document.body.scrollLeft) - 2;
				y = box.top
						+ Math.max(document.documentElement.scrollTop,
								document.body.scrollTop) - 2;
			} else {
				x = el.offsetLeft;
				y = el.offsetTop;
				el = el.offsetParent;
				if (e != el) {
					while (el) {
						x += el.offsetLeft;
						y += el.offsetTop;
						el = el.offsetParent;
					}
				}
				if (jQuery.browser.safari
						&& jQuery.curCSS(e, 'position') == 'absolute') {
					x -= document.body.offsetLeft;
					y -= document.body.offsetTop;
				}
				el = e.parentNode;
				while (el && el.tagName.toUpperCase() != 'BODY'
						&& el.tagName.toUpperCase() != 'HTML') {
					if (jQuery.curCSS(el, 'display') != 'inline') {
						x -= el.scrollLeft;
						y -= el.scrollTop;
					}
					el = el.parentNode;
				}
			}
			if (restoreStyles == true) {
				es.display = 'none';
				es.position = oldPosition;
				es.visibility = oldVisibility;
			}
			return {
				x : x,
				y : y
			};
		},
		getSize : function(e) {
			var w = parseInt(jQuery.curCSS(e, 'width'), 10);
			var h = parseInt(jQuery.curCSS(e, 'height'), 10);
			var wb = 0;
			var hb = 0;
			if (jQuery.curCSS(e, 'display') != 'none') {
				wb = e.offsetWidth;
				hb = e.offsetHeight;
			} else {
				var es = e.style;
				var oldVisibility = es.visibility;
				var oldPosition = es.position;
				es.visibility = 'hidden';
				es.display = 'block';
				es.position = 'absolute';
				wb = e.offsetWidth;
				hb = e.offsetHeight;
				es.display = 'none';
				es.position = oldPosition;
				es.visibility = oldVisibility;
			}
			return {
				w : w,
				h : h,
				wb : wb,
				hb : hb
			};
		},
		getClient : function(e) {
			var h, w;
			if (e) {
				w = e.clientWidth;
				h = e.clientHeight;
			} else {
				var de = document.documentElement;
				w = window.innerWidth || self.innerWidth
						|| (de && de.clientWidth) || document.body.clientWidth;
				h = window.innerHeight || self.innerHeight
						|| (de && de.clientHeight)
						|| document.body.clientHeight;
			}
			return {
				w : w,
				h : h
			};
		},
		getScroll : function(e) {
			var t = 0, l = 0, w = 0, h = 0, iw = 0, ih = 0;
			if (e && e.nodeName.toLowerCase() != 'body') {
				t = e.scrollTop;
				l = e.scrollLeft;
				w = e.scrollWidth;
				h = e.scrollHeight;
			} else {
				if (document.documentElement) {
					t = document.documentElement.scrollTop;
					l = document.documentElement.scrollLeft;
					w = document.documentElement.scrollWidth;
					h = document.documentElement.scrollHeight;
				} else if (document.body) {
					t = document.body.scrollTop;
					l = document.body.scrollLeft;
					w = document.body.scrollWidth;
					h = document.body.scrollHeight;
				}
				if (typeof pageYOffset != 'undefined') {
					t = pageYOffset;
					l = pageXOffset;
				}
				iw = self.innerWidth || document.documentElement.clientWidth
						|| document.body.clientWidth || 0;
				ih = self.innerHeight || document.documentElement.clientHeight
						|| document.body.clientHeight || 0;
			}
			return {
				t : t,
				l : l,
				w : w,
				h : h,
				iw : iw,
				ih : ih
			};
		},
		getMargins : function(e, toInteger) {
			var t = jQuery.curCSS(e, 'marginTop') || '';
			var r = jQuery.curCSS(e, 'marginRight') || '';
			var b = jQuery.curCSS(e, 'marginBottom') || '';
			var l = jQuery.curCSS(e, 'marginLeft') || '';
			if (toInteger)
				return {
					t : parseInt(t, 10) || 0,
					r : parseInt(r, 10) || 0,
					b : parseInt(b, 10) || 0,
					l : parseInt(l, 10)
				};
			else
				return {
					t : t,
					r : r,
					b : b,
					l : l
				};
		},
		getPadding : function(e, toInteger) {
			var t = jQuery.curCSS(e, 'paddingTop') || '';
			var r = jQuery.curCSS(e, 'paddingRight') || '';
			var b = jQuery.curCSS(e, 'paddingBottom') || '';
			var l = jQuery.curCSS(e, 'paddingLeft') || '';
			if (toInteger)
				return {
					t : parseInt(t, 10) || 0,
					r : parseInt(r, 10) || 0,
					b : parseInt(b, 10) || 0,
					l : parseInt(l, 10)
				};
			else
				return {
					t : t,
					r : r,
					b : b,
					l : l
				};
		},
		getBorder : function(e, toInteger) {
			var t = jQuery.curCSS(e, 'borderTopWidth') || '';
			var r = jQuery.curCSS(e, 'borderRightWidth') || '';
			var b = jQuery.curCSS(e, 'borderBottomWidth') || '';
			var l = jQuery.curCSS(e, 'borderLeftWidth') || '';
			if (toInteger)
				return {
					t : parseInt(t, 10) || 0,
					r : parseInt(r, 10) || 0,
					b : parseInt(b, 10) || 0,
					l : parseInt(l, 10) || 0
				};
			else
				return {
					t : t,
					r : r,
					b : b,
					l : l
				};
		},
		traverseDOM : function(nodeEl, func) {
			func(nodeEl);
			nodeEl = nodeEl.firstChild;
			while (nodeEl) {
				EYE.traverseDOM(nodeEl, func);
				nodeEl = nodeEl.nextSibling;
			}
		},
		getInnerWidth : function(el, scroll) {
			var offsetW = el.offsetWidth;
			return scroll ? Math.max(el.scrollWidth, offsetW) - offsetW
					+ el.clientWidth : el.clientWidth;
		},
		getInnerHeight : function(el, scroll) {
			var offsetH = el.offsetHeight;
			return scroll ? Math.max(el.scrollHeight, offsetH) - offsetH
					+ el.clientHeight : el.clientHeight;
		},
		getExtraWidth : function(el) {
			if ($.boxModel)
				return (parseInt($.curCSS(el, 'paddingLeft')) || 0)
						+ (parseInt($.curCSS(el, 'paddingRight')) || 0)
						+ (parseInt($.curCSS(el, 'borderLeftWidth')) || 0)
						+ (parseInt($.curCSS(el, 'borderRightWidth')) || 0);
			return 0;
		},
		getExtraHeight : function(el) {
			if ($.boxModel)
				return (parseInt($.curCSS(el, 'paddingTop')) || 0)
						+ (parseInt($.curCSS(el, 'paddingBottom')) || 0)
						+ (parseInt($.curCSS(el, 'borderTopWidth')) || 0)
						+ (parseInt($.curCSS(el, 'borderBottomWidth')) || 0);
			return 0;
		},
		isChildOf : function(parentEl, el, container) {
			if (parentEl == el) {
				return true;
			}
			if (!el || !el.nodeType || el.nodeType != 1) {
				return false;
			}
			if (parentEl.contains && !$.browser.safari) {
				return parentEl.contains(el);
			}
			if (parentEl.compareDocumentPosition) {
				return !!(parentEl.compareDocumentPosition(el) & 16);
			}
			var prEl = el.parentNode;
			while (prEl && prEl != container) {
				if (prEl == parentEl)
					return true;
				prEl = prEl.parentNode;
			}
			return false;
		},
		centerEl : function(el, axis) {
			var clientScroll = EYE.getScroll();
			var size = EYE.getSize(el);
			if (!axis || axis == 'vertically')
				$(el).css(
						{
							top : clientScroll.t
									+ ((Math.min(clientScroll.h,
											clientScroll.ih) - size.hb) / 2)
									+ 'px'
						});
			if (!axis || axis == 'horizontally')
				$(el).css(
						{
							left : clientScroll.l
									+ ((Math.min(clientScroll.w,
											clientScroll.iw) - size.wb) / 2)
									+ 'px'
						});
		}
	});
	if (!$.easing.easeout) {
		$.easing.easeout = function(p, n, firstNum, delta, duration) {
			return -delta * ((n = n / duration - 1) * n * n * n - 1) + firstNum;
		};
	}

})(jQuery);