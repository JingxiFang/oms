package sym.component.bean;

public class SimpleOrderBean {
	private int orders_id;// ����ID
	private String agency_user_nm;// ҵ��Ա
	private String contract_no;// ��ͬ��
	private String customer_nm;// �ͻ�
	private String project_nm;// ��Ŀ
	private String received_payments_flg;// �ؿ���ϱ�־

	public int getOrders_id() {
		return orders_id;
	}

	public void setOrders_id(int orders_id) {
		this.orders_id = orders_id;
	}

	public String getAgency_user_nm() {
		return agency_user_nm;
	}

	public void setAgency_user_nm(String agency_user_nm) {
		this.agency_user_nm = agency_user_nm;
	}

	public String getContract_no() {
		return contract_no;
	}

	public void setContract_no(String contract_no) {
		this.contract_no = contract_no;
	}

	public String getCustomer_nm() {
		return customer_nm;
	}

	public void setCustomer_nm(String customer_nm) {
		this.customer_nm = customer_nm;
	}

	public String getProject_nm() {
		return project_nm;
	}

	public void setProject_nm(String project_nm) {
		this.project_nm = project_nm;
	}

	public String getReceived_payments_flg() {
		return received_payments_flg;
	}

	public void setReceived_payments_flg(String received_payments_flg) {
		this.received_payments_flg = received_payments_flg;
	}

}
