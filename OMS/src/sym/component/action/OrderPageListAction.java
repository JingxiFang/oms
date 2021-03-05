package sym.component.action;


import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sym.common.action.PageListBaseServlet;
import sym.common.dto.SessionDto;

import sym.admin.bean.AdminUserBean;
import sym.component.bean.OrderBean;
import sym.component.service.impl.OrderServiceImpl;

/**
 * 此Action类是专门处理分页查询请求
 * 
 * @author 拯救者 继承自分页实现公共Servlet类PageListBaseServlet
 *         并重写父类的initPageInforBean方法取得订单一览信息
 * 
 */

public class OrderPageListAction extends PageListBaseServlet {

	/**
	 * 获取页面传递的参数，初始化父类的listBean和forward属性
	 * 修改：
	 * 		①  2018-6-14:根据参数不同跳转到不同的界面 修改者：FJXxx
	 * 		②  2018-6-16:根据登陆者权限按照不同的方式查询订单集
	 * 		③  2018-6-17:将查询条件存入到session中 属性名为orderBean（该方法较弱智，后续需要改进） 	
	 */
	@Override
	public void initPageInforBean(HttpServletRequest request,
			HttpServletResponse response) {
		//FJX
		// 将参数放到hm_order中
		HashMap<String, String> hm = new HashMap<String, String>();	
		HttpSession session=request.getSession();

		String action=request.getParameter("action");
		
	    //如果是业务员，需要通过编号查找订单 ，防止重名。
		SessionDto user=(SessionDto)session.getAttribute("dto");
		String flg=user.getUser_owner_flg();
		hm.put("flg", flg);
	    if("S".equals(flg)){
	    	String salesman_cd=((SessionDto)session.getAttribute("dto")).getUser_cd();
	    	hm.put("salesman_cd", salesman_cd);
	    }
	    
	    // 获取界面中业务员 
	    String salesman_nm = request.getParameter("salesman_nm");
	  
	    // 获取界面中合同号
	 	String contract_num = request.getParameter("contract_num");
	
		// 获取界面中客户名
		String customer_nm = request.getParameter("customer_nm");

		// 获取界面中项目名
		String project_nm = request.getParameter("projecct_nm");
	
		// 获取客户种类
		String category_list = request.getParameter("type_all");
		
		String[] item_lists = null;

	
		// 获取回款情况
		String is_back = request.getParameter("back_section_end_all");

		// 判断"全选"是否选中，选中的话，则匹配所有，未选中的话则获取后面框中的值
		if ("type_all".equals(category_list)) {
			category_list = "%"; // 传递到数据库中进行模糊查询，匹配所有状态
		} else {
			item_lists = request.getParameterValues("item_type_list");
			category_list="";
			if(item_lists==null){
				category_list = "%";
			}else{
				for (String item_list : item_lists) {
					category_list += item_list + ",";
					//fjx
					hm.put("category"+item_list,item_list);
				}
				category_list = category_list.substring(0,
						category_list.length() - 1);
			}
		}
		
		
		// 判断"全选"是否选中，选中的话，则匹配所有，未选中的话则获取后面框中的值,
		//修改FJX 2018/06/16 is_back为空时，默认设置为F
		if(is_back==null){
			is_back="F";
		}
		else if ("ALL".equals(is_back)) {
			is_back = ""; // 传递到数据库中进行模糊查询，匹配所有状态
		} else {
			is_back = request.getParameter("back_section_end");
		}

		
		//获取排序依据
		String orderBy = request.getParameter("orderBy");
		String caret = "caret up";
		if(orderBy == null){
			orderBy = "user_cd";
		}else{
			String oldOrderBy = (String) session.getAttribute("oldOrderBy");
			if(!orderBy.equals(oldOrderBy)){
				caret = "caret";
			}
		}
		session.setAttribute("oldOrderBy", orderBy);
		
		//获取排序顺序
		String sc = request.getParameter("sc");
		if(sc == null || "caret".equals(caret)){
			sc = "asc";
		}
		
		hm.put("contract_num", contract_num);
		hm.put("customer_nm", customer_nm);
		hm.put("project_nm", project_nm);
		hm.put("category", category_list);
		hm.put("is_back", is_back);
		hm.put("salesman_nm", salesman_nm);
		
		hm.put("orderBy", orderBy);
		hm.put("sc", sc);
		
		super.getPageInforBean().setHm(hm);
		super.setPageInforService(new OrderServiceImpl());
		
		/**
		 * 修改者：FJX 2018/6/15
		 */
		if("invoiceInsert".equals(action)){
			//发票录入页面
			super.setForward("/pages/component/invoice/invoiceSearch.jsp");
		}
		else if("orderInsert".equals(action)){
			//订单查询变更页面
			super.setForward("/pages/component/order/orderSearch.jsp");
		}
		
	}


}
