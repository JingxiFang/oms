package sym.component.bean;

import java.util.Date;

public class OrderDetailBean {
	private int order_detail_id;// ������ϸID
	private int orders_id;// ����ID
	private String product_category;// ��Ʒ����(1�����ߡ�2������)
	private String specification_type;// ����ͺ�
	private String voltage;// ��ѹ�ȼ�
	private double contract_quantity;// ��ͬ����
	private double contract_unit_price;// ��ͬ����
	private double contract_price;// ��ͬ�۸�
	private String remark;// ��ע
	private Date update_date;// ����ʱ��
	private String update_user_id;// ������

	public int getOrder_detail_id() {
		return order_detail_id;
	}

	public void setOrder_detail_id(int order_detail_id) {
		this.order_detail_id = order_detail_id;
	}

	public int getOrders_id() {
		return orders_id;
	}

	public void setOrders_id(int orders_id) {
		this.orders_id = orders_id;
	}

	public String getProduct_category() {
		return product_category;
	}

	public void setProduct_category(String product_category) {
		this.product_category = product_category;
	}

	public String getSpecification_type() {
		return specification_type;
	}

	public void setSpecification_type(String specification_type) {
		this.specification_type = specification_type;
	}

	public String getVoltage() {
		return voltage;
	}

	public void setVoltage(String voltage) {
		this.voltage = voltage;
	}

	public double getContract_quantity() {
		return contract_quantity;
	}

	public void setContract_quantity(double contract_quantity) {
		this.contract_quantity = contract_quantity;
	}

	public double getContract_unit_price() {
		return contract_unit_price;
	}

	public void setContract_unit_price(double contract_unit_price) {
		this.contract_unit_price = contract_unit_price;
	}

	public double getContract_price() {
		return contract_price;
	}

	public void setContract_price(double contract_price) {
		this.contract_price = contract_price;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
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

	@Override
	public String toString() {
		return "OrderDetailBean [order_detail_id=" + order_detail_id + ", orders_id=" + orders_id
				+ ", product_category=" + product_category + ", specification_type=" + specification_type + ", voltage="
				+ voltage + ", contract_quantity=" + contract_quantity + ", contract_unit_price=" + contract_unit_price
				+ ", contract_price=" + contract_price + ", remark=" + remark + ", update_date=" + update_date
				+ ", update_user_id=" + update_user_id + "]";
	}
	
}
