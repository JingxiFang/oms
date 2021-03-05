package sym.admin.bean;

public class SimpleAdminCustomerBean {
	public String customer_cd;// 客户CD
	public String customer_nm; // 客户名
	public String connect_kind; // 联系方式

	public String getCustomer_cd() {
		return customer_cd;
	}

	public void setCustomer_cd(String customer_cd) {
		this.customer_cd = customer_cd;
	}

	public String getCustomer_nm() {
		return customer_nm;
	}

	public void setCustomer_nm(String customer_nm) {
		this.customer_nm = customer_nm;
	}

	public String getConnect_kind() {
		return connect_kind;
	}

	public void setConnect_kind(String connect_kind) {
		this.connect_kind = connect_kind;
	}

}
