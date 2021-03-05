package sym.component.bean;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class OrderBean {
	private int orders_id;// ����ID
	private String contract_no;// ��ͬ��
	private String orders_version;// ��ͬ_�İ�
	private String agency_user_cd;// ҵ��Աcd
	private String agency_user_nm;// ҵ��Աnm
	private String agency_cd;// ������cd
	private String agency_nm;// ������nm
	private String customer_type;// �ͻ�����
	private String customer_cd;// �ͻ�cd
	private String customer_nm;// �ͻ�nm
	private String project_nm;// ��Ŀ��
	private String expected_send_month;// Ԥ�Ʒ�����
	private String expected_energize_month;// Ԥ���͵���
	private int shelf_months;// ͨ���֤����
	private String energize_date;// �͵�����
	private String currency_cd;// ����cd
	private String currency_nm;// Ͷ��_����
	private double bid_cu_price;// Ͷ��_ͭ��
	private double bid_sum_money;// Ͷ��_���
	private BigDecimal contract_sum_money;// ��ͬ�ܼ�
	private double proportion;// Ӷ����
	private BigDecimal commission;// Ӷ����
	private double payments_proportion1;// ���ձ���1
	private double payments_proportion2;// ���ձ���2
	private double payments_proportion3;// ���ձ���3
	private double payments_proportion4;// ���ձ���4
	private double payments_proportion5;// ���ձ���5
	private double payments_proportion6;// ���ձ���6
	private String expected_payments_date1;// ����Ԥ����1
	private String expected_payments_date2;// ����Ԥ����2
	private String expected_payments_date3;// ����Ԥ����3
	private String expected_payments_date4;// ����Ԥ����4
	private String expected_payments_date5;// ����Ԥ����5
	private String expected_payments_date6;// ����Ԥ����6
	private double expected_payments_sum1;// ����Ԥ�����1
	private double expected_payments_sum2;// ����Ԥ�����2
	private double expected_payments_sum3;// ����Ԥ�����3
	private double expected_payments_sum4;// ����Ԥ�����4
	private double expected_payments_sum5;// ����Ԥ�����5
	private double expected_payments_sum6;// ����Ԥ�����6
	private String received_payments_flg;// �ؿ���ϱ�־
	private Date update_date;// ����ʱ��
	private String update_user_id;// ������
	private String update_user_nm;// ������
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
