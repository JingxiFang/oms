package sym.component.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

import sym.common.bean.PageInforBean;
import sym.common.service.PageInforService;
import sym.component.bean.OrderBean;
import sym.component.bean.OrderForm;
import sym.component.bean.SimpleOrderBean;
import sym.component.dao.OrderDao;
import sym.component.dao.impl.OrderDaoImpl;
import sym.component.service.OrderService;

public class OrderServiceImpl extends PageInforService implements OrderService {
	private OrderDao orderDao = new OrderDaoImpl();
	@Override
	public PageInforBean<SimpleOrderBean> getPageInforSimpleOrderBean(int showCount, int currentPage, String orderBy,
			String order, String contract_no, String agency_user_nm, String customer_nm, String project_nm,
			List<String> types, List<String> back_sections) {
		String sql = "";
		String condition = "";

		String arrayConditon1 = arrayConditon1(types);
		String arrayConditon2 = arrayConditon2(back_sections);

		if (!contract_no.equals("")) {
			condition += " AND CONTRACT_NO = '" + contract_no + "'";
		}
		if (!agency_user_nm.equals("")) {
			condition += " AND a.AGENCY_USER_CD = b.USER_CD AND b.USER_NM LIKE '%" + agency_user_nm + "%' ";
		}
		if (!customer_nm.equals("")) {
			condition += " AND a.CUSTOMER_CD = c.CUSTOMER_CD AND c.CUSTOMER_NM LIKE '%" + customer_nm + "%'";
		}
		if (!project_nm.equals("")) {
			condition += " AND PROJECT_NM LIKE '%" + project_nm + "%'";
		}
		if (!arrayConditon1.equals("")) {
			condition += " AND" + arrayConditon1;
		}
		if (!arrayConditon2.equals("")) {
			condition += " AND" + arrayConditon2;
		}
		if (orderBy.equals("defalut")) {

		} else if (orderBy.equals("agency_user_nm") && order.equals("up")) {
			condition += " ORDER BY USER_NM ASC";
		} else if (orderBy.equals("agency_user_nm") && order.equals("down")) {
			condition += " ORDER BY USER_NM DESC";
		} else if (orderBy.equals("contract_no") && order.equals("up")) {
			condition += " ORDER BY CONTRACT_NO ASC";
		} else if (orderBy.equals("contract_no") && order.equals("down")) {
			condition += " ORDER BY CONTRACT_NO DESC";
		} else if (orderBy.equals("customer_nm") && order.equals("up")) {
			condition += " ORDER BY CUSTOMER_NM ASC";
		} else if (orderBy.equals("customer_nm") && order.equals("down")) {
			condition += " ORDER BY CUSTOMER_NM DESC";
		} else if (orderBy.equals("project_nm") && order.equals("up")) {
			condition += " ORDER BY PROJECT_NM ASC";
		} else if (orderBy.equals("project_nm") && order.equals("down")) {
			condition += " ORDER BY PROJECT_NM DESC";
		} else if (orderBy.equals("received_payments_flg") && order.equals("up")) {
			condition += " ORDER BY RECEIVED_PAYMENTS_FLG ASC";
		} else if (orderBy.equals("received_payments_flg") && order.equals("down")) {
			condition += " ORDER BY RECEIVED_PAYMENTS_FLG DESC";
		}

		sql = "SELECT ORDERS_ID, USER_NM, CONTRACT_NO, CUSTOMER_NM, PROJECT_NM, RECEIVED_PAYMENTS_FLG "
				+ "FROM S_ORDERS a , M_USER b, M_CUSTOMER c WHERE a.AGENCY_USER_CD =b.USER_CD AND a.CUSTOMER_CD = c.CUSTOMER_CD"
				+ condition;
		PageInforBean<SimpleOrderBean> PageInforSimpleOrderBean = orderDao.getPageInforSimpleOrderBean(showCount,
				currentPage, sql);
		return PageInforSimpleOrderBean;
	}

	/**
	 * 数组1参数构建sql语句
	 * 
	 * @param condition
	 * @param types
	 * @param back_sections
	 * @return
	 */
	private String arrayConditon1(List<String> types) {
		boolean isList1First = true;
		String condition = "";
		for (String type : types) {

			if (type.equals("type_1")) {
				condition += " (a.CUSTOMER_TYPE='1'";
				isList1First = false;
			} else if (type.equals("type_2")) {
				if (!isList1First) {
					condition += " OR a.CUSTOMER_TYPE='2'";
				} else {
					condition += " (a.CUSTOMER_TYPE='2'";
				}
				isList1First = false;
			} else if (type.equals("type_3")) {
				if (!isList1First) {
					condition += " OR a.CUSTOMER_TYPE='3'";
				} else {
					condition += " (a.CUSTOMER_TYPE='3'";
				}
				isList1First = false;
			} else if (type.equals("type_4")) {
				if (!isList1First) {
					condition += " OR a.CUSTOMER_TYPE='4'";
				} else {
					condition += " (a.CUSTOMER_TYPE='4'";
				}
				isList1First = false;
			}
		}
		if (!isList1First)
			condition += ")";
		return condition;
	}

	/**
	 * 数组1参数构建sql语句
	 * 
	 * @param condition
	 * @param types
	 * @param back_sections
	 * @return
	 */
	private String arrayConditon2(List<String> back_sections) {
		boolean isList2First = true;
		String condition = "";
		for (String back_secyion : back_sections) {

			if (back_secyion.equals("back_section_end_F")) {
				condition += " (RECEIVED_PAYMENTS_FLG = 'F'";
				isList2First = false;
			} else if (back_secyion.equals("back_section_end_T")) {
				if (isList2First) {
					condition += "(RECEIVED_PAYMENTS_FLG = 'T'";
				} else {
					condition += "OR RECEIVED_PAYMENTS_FLG = 'T'";
				}
				isList2First = false;
			}
		}
		if (!isList2First) {
			condition += ")";
		}
		return condition;
	}

	@Override
	public OrderBean showOrderById(int orders_id) {
		return orderDao.showOrderById(orders_id);
	}

	@Override
	public int updateOrder(OrderBean orderBean) {
		int r = orderDao.updateOrder(orderBean);
		if(r > 0)
			r = 1;
		return r;
	}

	
	@Override
	public int insertOrder(OrderBean orderBean) {
		int r = orderDao.insertOrder(orderBean);
		return r;
	}

	@Override
	public int deleteOrder(int orders_id) {
		int r = orderDao.deleteOrder(orders_id);
		return r;
	}
	
	@Override
	public List<OrderBean> findOrderVersionList(String contract_no) {
		OrderDao orderDao=new OrderDaoImpl();
		return orderDao.findOrderVersionList(contract_no);
	}
	/**
	 * 根据检索条件，获取满足条件的记录总数
	 */
	@Override
	public int getTotalRecordNumber(HashMap queryInforMap) {
		// TODO Auto-generated method stub
		OrderDao  orderDao = new  OrderDaoImpl();
		return orderDao.getTotalNumber(queryInforMap);
	}

	
	/**
	 * 根据起始记录数、结束记录数以及检索条件，获取当前页的数据列表
	 */
	@Override
	public List getComponentPageList(int fromCount, int endCount,
			HashMap queryInforMap) {
		// TODO Auto-generated method stub
		OrderDao  orderDao = new  OrderDaoImpl();
		return orderDao.getComponentPageList(fromCount, endCount, queryInforMap);
	}

	/**
	 * 根据合同号取得该订单所有的订单ID
 		list = orderDao.findOrderIDList（orderForm.contract_no）
		循环list 删除订单明细
		删除前验证
	 * 是否开具发票
		orderDao.findInvoiceCnt(orderForm.contract_no)
	 * 是否回款结束
		orderDao.findReceivedPaymentsFlg(list[i].订单ID)
	 * 删除订单明细
		orderDetailDao.deleteOrderDetail(list[i].订单ID)
	 * 删除订单
		orderDao.deleteOrder（orderForm.contract_no）
	 *
	 */
	@Override
	public Map<?, ?> deleteOrder(OrderBean orderForm) {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * 是否开具发票
		orderDao.findInvoiceCnt(orderForm.contract_no)
	 */
	@Override
	public Map<?, ?> orderSearchIndex(OrderBean orderForm) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List getOrderInfoList(HashMap queryInforMap) {
		// TODO Auto-generated method stub
		OrderDao  orderDao = new  OrderDaoImpl();
		return orderDao.getOrderInfoList(queryInforMap);
	}

	@Override
	public Map<?, ?> validate(OrderForm orderForm) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<?, ?> validateOrderDetail(OrderForm orderForm) {
		// TODO Auto-generated method stub
		return null;
	}
	/***
	 * 取得订单一览信息
	 * @author FJXxx
	 * @param hm
	 * @return
	 */
	public List<OrderBean>	getCurrentPageList(HashMap<String,String> hm){
		return null;
		
	}			
	/***
	 * 取得订单总数
	 * @author FJXxx		
	 * @param hm
	 * @return
	 */
	public	String	getTotalRecoredNumber(HashMap<String,String> hm){
		return null;
		
	}

	@Override
	public boolean updateOrderPro(OrderBean order) {
		// TODO Auto-generated method stub
		OrderDao  orderDao = new  OrderDaoImpl();
		return orderDao.updateOrderPro(order);
	}
	
	
	
}
