package sym.component.bean;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class OrderBean {
	private int orders_id;// 订单ID
	private String contract_no;// 合同号
	private String orders_version;// 合同_改版
	private String agency_user_cd;// 业务员cd
	private String agency_user_nm;// 业务员nm
	private String agency_cd;// 代理商cd
	private String agency_nm;// 代理商nm
	private String customer_type;// 客户类型
	private String customer_cd;// 客户cd
	private String customer_nm;// 客户nm
	private String project_nm;// 项目名
	private String expected_send_month;// 预计发货月
	private String expected_energize_month;// 预计送电月
	private int shelf_months;// 通电后保证月数
	private String energize_date;// 送电日期
	private String currency_cd;// 货币cd
	private String currency_nm;// 投标_币种
	private double bid_cu_price;// 投标_铜价
	private double bid_sum_money;// 投标_金额
	private BigDecimal contract_sum_money;// 合同总价
	private double proportion;// 佣金率
	private BigDecimal commission;// 佣金金额
	private double payments_proportion1;// 回收比率1
	private double payments_proportion2;// 回收比率2
	private double payments_proportion3;// 回收比率3
	private double payments_proportion4;// 回收比率4
	private double payments_proportion5;// 回收比率5
	private double payments_proportion6;// 回收比率6
	private String expected_payments_date1;// 回收预定月1
	private String expected_payments_date2;// 回收预定月2
	private String expected_payments_date3;// 回收预定月3
	private String expected_payments_date4;// 回收预定月4
	private String expected_payments_date5;// 回收预定月5
	private String expected_payments_date6;// 回收预定月6
	private double expected_payments_sum1;// 回收预定金额1
	private double expected_payments_sum2;// 回收预定金额2
	private double expected_payments_sum3;// 回收预定金额3
	private double expected_payments_sum4;// 回收预定金额4
	private double expected_payments_sum5;// 回收预定金额5
	private double expected_payments_sum6;// 回收预定金额6
	private String received_payments_flg;// 回款完毕标志
	private Date update_date;// 更新时间
	private String update_user_id;// 更新者
	private String update_user_nm;// 更新者
	private List<OrderDetailBean> order_detail_list;

	public String getAgency_user_cd() {
		return agency_user_cd;
	}

	public void setAgency_user_cd(String agency_user_cd) {
		this.agency_user_cd = agency_user_cd;
	}

	public String getCustomer_cd() {
		return customer_cd;
	}

	public void setCustomer_cd(String customer_cd) {
		this.customer_cd = customer_cd;
	}

	public String getCurrency_cd() {
		return currency_cd;
	}

	public void setCurrency_cd(String currency_cd) {
		this.currency_cd = currency_cd;
	}

	public int getOrders_id() {
		return orders_id;
	}

	public void setOrders_id(int orders_id) {
		this.orders_id = orders_id;
	}

	public String getContract_no() {
		return contract_no;
	}

	public void setContract_no(String contract_no) {
		this.contract_no = contract_no;
	}

	public String getOrders_version() {
		return orders_version;
	}

	public void setOrders_version(String orders_version) {
		this.orders_version = orders_version;
	}

	public String getCustomer_type() {
		return customer_type;
	}

	public void setCustomer_type(String customer_type) {
		this.customer_type = customer_type;
	}

	public String getProject_nm() {
		return project_nm;
	}

	public void setProject_nm(String project_nm) {
		this.project_nm = project_nm;
	}

	public String getExpected_send_month() {
		return expected_send_month;
	}

	public void setExpected_send_month(String expected_send_month) {
		this.expected_send_month = expected_send_month;
	}

	public String getExpected_energize_month() {
		return expected_energize_month;
	}

	public void setExpected_energize_month(String expected_energize_month) {
		this.expected_energize_month = expected_energize_month;
	}

	public int getShelf_months() {
		return shelf_months;
	}

	public void setShelf_months(int shelf_months) {
		this.shelf_months = shelf_months;
	}

	public String getEnergize_date() {
		return energize_date;
	}

	public void setEnergize_date(String date) {
		this.energize_date = date;
	}

	public String getAgency_user_nm() {
		return agency_user_nm;
	}

	public void setAgency_user_nm(String agency_user_nm) {
		this.agency_user_nm = agency_user_nm;
	}

	public String getAgency_nm() {
		return agency_nm;
	}

	public void setAgency_nm(String agency_nm) {
		this.agency_nm = agency_nm;
	}

	public String getCustomer_nm() {
		return customer_nm;
	}

	public void setCustomer_nm(String customer_nm) {
		this.customer_nm = customer_nm;
	}

	public String getCurrency_nm() {
		return currency_nm;
	}

	public void setCurrency_nm(String currency_nm) {
		this.currency_nm = currency_nm;
	}

	public double getBid_cu_price() {
		return bid_cu_price;
	}

	public void setBid_cu_price(double bid_cu_price) {
		this.bid_cu_price = bid_cu_price;
	}

	public double getBid_sum_money() {
		return bid_sum_money;
	}

	public void setBid_sum_money(double bid_sum_money) {
		this.bid_sum_money = bid_sum_money;
	}

	public BigDecimal getContract_sum_money() {
		return contract_sum_money;
	}

	public void setContract_sum_money(BigDecimal contract_sum_money) {
		this.contract_sum_money = contract_sum_money;
	}

	public double getProportion() {
		return proportion;
	}

	public void setProportion(double proportion) {
		this.proportion = proportion;
	}

	public BigDecimal getCommission() {
		return commission;
	}

	public void setCommission(BigDecimal commission) {
		this.commission = commission;
	}

	public double getPayments_proportion1() {
		return payments_proportion1;
	}

	public void setPayments_proportion1(double payments_proportion1) {
		this.payments_proportion1 = payments_proportion1;
	}

	public double getPayments_proportion2() {
		return payments_proportion2;
	}

	public void setPayments_proportion2(double payments_proportion2) {
		this.payments_proportion2 = payments_proportion2;
	}

	public double getPayments_proportion3() {
		return payments_proportion3;
	}

	public void setPayments_proportion3(double payments_proportion3) {
		this.payments_proportion3 = payments_proportion3;
	}

	public double getPayments_proportion4() {
		return payments_proportion4;
	}

	public void setPayments_proportion4(double payments_proportion4) {
		this.payments_proportion4 = payments_proportion4;
	}

	public double getPayments_proportion5() {
		return payments_proportion5;
	}

	public void setPayments_proportion5(double payments_proportion5) {
		this.payments_proportion5 = payments_proportion5;
	}

	public double getPayments_proportion6() {
		return payments_proportion6;
	}

	public void setPayments_proportion6(double payments_proportion6) {
		this.payments_proportion6 = payments_proportion6;
	}

	public String getExpected_payments_date1() {
		return expected_payments_date1;
	}

	public void setExpected_payments_date1(String expected_payments_date1) {
		this.expected_payments_date1 = expected_payments_date1;
	}

	public String getExpected_payments_date2() {
		return expected_payments_date2;
	}

	public void setExpected_payments_date2(String expected_payments_date2) {
		this.expected_payments_date2 = expected_payments_date2;
	}

	public String getExpected_payments_date3() {
		return expected_payments_date3;
	}

	public void setExpected_payments_date3(String expected_payments_date3) {
		this.expected_payments_date3 = expected_payments_date3;
	}

	public String getExpected_payments_date4() {
		return expected_payments_date4;
	}

	public void setExpected_payments_date4(String expected_payments_date4) {
		this.expected_payments_date4 = expected_payments_date4;
	}

	public String getExpected_payments_date5() {
		return expected_payments_date5;
	}

	public void setExpected_payments_date5(String expected_payments_date5) {
		this.expected_payments_date5 = expected_payments_date5;
	}

	public String getExpected_payments_date6() {
		return expected_payments_date6;
	}

	public void setExpected_payments_date6(String expected_payments_date6) {
		this.expected_payments_date6 = expected_payments_date6;
	}

	public double getExpected_payments_sum1() {
		return expected_payments_sum1;
	}

	public void setExpected_payments_sum1(double expected_payments_sum1) {
		this.expected_payments_sum1 = expected_payments_sum1;
	}

	public double getExpected_payments_sum2() {
		return expected_payments_sum2;
	}

	public void setExpected_payments_sum2(double expected_payments_sum2) {
		this.expected_payments_sum2 = expected_payments_sum2;
	}

	public double getExpected_payments_sum3() {
		return expected_payments_sum3;
	}

	public void setExpected_payments_sum3(double expected_payments_sum3) {
		this.expected_payments_sum3 = expected_payments_sum3;
	}

	public double getExpected_payments_sum4() {
		return expected_payments_sum4;
	}

	public void setExpected_payments_sum4(double expected_payments_sum4) {
		this.expected_payments_sum4 = expected_payments_sum4;
	}

	public double getExpected_payments_sum5() {
		return expected_payments_sum5;
	}

	public void setExpected_payments_sum5(double expected_payments_sum5) {
		this.expected_payments_sum5 = expected_payments_sum5;
	}

	public double getExpected_payments_sum6() {
		return expected_payments_sum6;
	}

	public void setExpected_payments_sum6(double expected_payments_sum6) {
		this.expected_payments_sum6 = expected_payments_sum6;
	}

	public String getReceived_payments_flg() {
		return received_payments_flg;
	}

	public void setReceived_payments_flg(String received_payments_flg) {
		this.received_payments_flg = received_payments_flg;
	}

	public Date getUpdate_date() {
		return update_date;
	}

	public void setUpdate_date(Date update_date) {
		this.update_date = update_date;
	}

	public String getUpdate_user_id() {
		return update_user_id;
	}

	public void setUpdate_user_id(String update_user_id) {
		this.update_user_id = update_user_id;
	}

	public List<OrderDetailBean> getOrder_detail_list() {
		return order_detail_list;
	}

	public void setOrder_detail_list(List<OrderDetailBean> order_detail_list) {
		this.order_detail_list = order_detail_list;
	}

	public String getAgency_cd() {
		return agency_cd;
	}

	public void setAgency_cd(String agency_cd) {
		this.agency_cd = agency_cd;
	}

	public String getUpdate_user_nm() {
		return update_user_nm;
	}

	public void setUpdate_user_nm(String update_user_nm) {
		this.update_user_nm = update_user_nm;
	}

	@Override
	public String toString() {
		return "OrderBean [orders_id=" + orders_id + ", contract_no=" + contract_no + ", orders_version="
				+ orders_version + ", agency_user_cd=" + agency_user_cd + ", agency_user_nm=" + agency_user_nm
				+ ", agency_cd=" + agency_cd + ", agency_nm=" + agency_nm + ", customer_type=" + customer_type
				+ ", customer_cd=" + customer_cd + ", customer_nm=" + customer_nm + ", project_nm=" + project_nm
				+ ", expected_send_month=" + expected_send_month + ", expected_energize_month="
				+ expected_energize_month + ", shelf_months=" + shelf_months + ", energize_date=" + energize_date
				+ ", currency_cd=" + currency_cd + ", currency_nm=" + currency_nm + ", bid_cu_price=" + bid_cu_price
				+ ", bid_sum_money=" + bid_sum_money + ", contract_sum_money=" + contract_sum_money + ", proportion="
				+ proportion + ", commission=" + commission + ", payments_proportion1=" + payments_proportion1
				+ ", payments_proportion2=" + payments_proportion2 + ", payments_proportion3=" + payments_proportion3
				+ ", payments_proportion4=" + payments_proportion4 + ", payments_proportion5=" + payments_proportion5
				+ ", payments_proportion6=" + payments_proportion6 + ", expected_payments_date1="
				+ expected_payments_date1 + ", expected_payments_date2=" + expected_payments_date2
				+ ", expected_payments_date3=" + expected_payments_date3 + ", expected_payments_date4="
				+ expected_payments_date4 + ", expected_payments_date5=" + expected_payments_date5
				+ ", expected_payments_date6=" + expected_payments_date6 + ", expected_payments_sum1="
				+ expected_payments_sum1 + ", expected_payments_sum2=" + expected_payments_sum2
				+ ", expected_payments_sum3=" + expected_payments_sum3 + ", expected_payments_sum4="
				+ expected_payments_sum4 + ", expected_payments_sum5=" + expected_payments_sum5
				+ ", expected_payments_sum6=" + expected_payments_sum6 + ", received_payments_flg="
				+ received_payments_flg + ", update_date=" + update_date + ", update_user_id=" + update_user_id
				+ ", order_detail_list=" + order_detail_list + "]";
	}

}
