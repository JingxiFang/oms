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
 * ��Action����ר�Ŵ����ҳ��ѯ����
 * 
 * @author ������ �̳��Է�ҳʵ�ֹ���Servlet��PageListBaseServlet
 *         ����д�����initPageInforBean����ȡ�ö���һ����Ϣ
 * 
 */

public class OrderPageListAction extends PageListBaseServlet {

	/**
	 * ��ȡҳ�洫�ݵĲ�������ʼ�������listBean��forward����
	 * �޸ģ�
	 * 		��  2018-6-14:���ݲ�����ͬ��ת����ͬ�Ľ��� �޸��ߣ�FJXxx
	 * 		��  2018-6-16:���ݵ�½��Ȩ�ް��ղ�ͬ�ķ�ʽ��ѯ������
	 * 		��  2018-6-17:����ѯ�������뵽session�� ������ΪorderBean���÷��������ǣ�������Ҫ�Ľ��� 	
	 */
	@Override
	public void initPageInforBean(HttpServletRequest request,
			HttpServletResponse response) {
		//FJX
		// �������ŵ�hm_order��
		HashMap<String, String> hm = new HashMap<String, String>();	
		HttpSession session=request.getSession();

		String action=request.getParameter("action");
		
	    //�����ҵ��Ա����Ҫͨ����Ų��Ҷ��� ����ֹ������
		SessionDto user=(SessionDto)session.getAttribute("dto");
		String flg=user.getUser_owner_flg();
		hm.put("flg", flg);
	    if("S".equals(flg)){
	    	String salesman_cd=((SessionDto)session.getAttribute("dto")).getUser_cd();
	    	hm.put("salesman_cd", salesman_cd);
	    }
	    
	    // ��ȡ������ҵ��Ա 
	    String salesman_nm = request.getParameter("salesman_nm");
	  
	    // ��ȡ�����к�ͬ��
	 	String contract_num = request.getParameter("contract_num");
	
		// ��ȡ�����пͻ���
		String customer_nm = request.getParameter("customer_nm");

		// ��ȡ��������Ŀ��
		String project_nm = request.getParameter("projecct_nm");
	
		// ��ȡ�ͻ�����
		String category_list = request.getParameter("type_all");
		
		String[] item_lists = null;

	
		// ��ȡ�ؿ����
		String is_back = request.getParameter("back_section_end_all");

		// �ж�"ȫѡ"�Ƿ�ѡ�У�ѡ�еĻ�����ƥ�����У�δѡ�еĻ����ȡ������е�ֵ
		if ("type_all".equals(category_list)) {
			category_list = "%"; // ���ݵ����ݿ��н���ģ����ѯ��ƥ������״̬
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
		
		
		// �ж�"ȫѡ"�Ƿ�ѡ�У�ѡ�еĻ�����ƥ�����У�δѡ�еĻ����ȡ������е�ֵ,
		//�޸�FJX 2018/06/16 is_backΪ��ʱ��Ĭ������ΪF
		if(is_back==null){
			is_back="F";
		}
		else if ("ALL".equals(is_back)) {
			is_back = ""; // ���ݵ����ݿ��н���ģ����ѯ��ƥ������״̬
		} else {
			is_back = request.getParameter("back_section_end");
		}

		
		//��ȡ��������
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
		
		//��ȡ����˳��
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
		 * �޸��ߣ�FJX 2018/6/15
		 */
		if("invoiceInsert".equals(action)){
			//��Ʊ¼��ҳ��
			super.setForward("/pages/component/invoice/invoiceSearch.jsp");
		}
		else if("orderInsert".equals(action)){
			//������ѯ���ҳ��
			super.setForward("/pages/component/order/orderSearch.jsp");
		}
		
	}


}
