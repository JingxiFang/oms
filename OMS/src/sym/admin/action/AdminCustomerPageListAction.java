package sym.admin.action;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sym.admin.service.impl.AdminCustomerServiceImpl;
import sym.common.action.PageListBaseServlet;

public class AdminCustomerPageListAction extends PageListBaseServlet{

	@Override
	public void initPageInforBean(HttpServletRequest request,
			HttpServletResponse response) {
		// TODO �Զ����ɵķ������
		StringBuilder builder = new StringBuilder();
		//��ȡ�����пͻ���
		
		String customer_nm=request.getParameter("customer_nm"); 
	
		//��ȡ��ϵ�绰
		String connect_kind=request.getParameter("connect_kind");
		//��ȡ�ͻ�״̬
		String is_valid=request.getParameter("is_valid_all");
		//��ȡ�ͻ����
		System.out.println(customer_nm+","+connect_kind+","+is_valid);
		String[] customer_type_list = request.getParameterValues("customer_type_list");
		String customer_type_all = request.getParameter("customer_type_all");
		String customer_owner="";
		
		if(customer_type_all=="ALL"){
			builder.append("1,2,3,4");
		}
		if(customer_type_list!=null)
		{
			for(String S:customer_type_list){
				builder.append(S);
				builder.append(",");
			}
			builder.deleteCharAt(builder.length()-1);
			
		}else{
			builder.append("1,2,3,4");
		}
		
		customer_owner = builder.toString();
		
		//user_ownerF.matches(regex);
		//����״̬
	
	
		//�ж�"ȫѡ"�Ƿ�ѡ�У�ѡ�еĻ�����ƥ�����У�δѡ�еĻ����ȡ������е�ֵ
		if("ALL".equals(is_valid))
		{
			is_valid="%";  //���ݵ����ݿ��н���ģ����ѯ��ƥ������״̬	
		}else 
		{
			
				is_valid=request.getParameter("is_valid");
			
		}
		//���ĸ������ŵ�hm��
		HashMap<String ,String> hm=new HashMap<String,String>();
		hm.put("customer_nm", customer_nm);
		hm.put("connect_kind", connect_kind);
		hm.put("customer_owner", customer_owner);
		
		hm.put("is_valid",is_valid);
		super.getPageInforBean().setHm(hm);
		super.setPageInforService(new AdminCustomerServiceImpl());
		super.setForward("/pages/component/admin/customerMaster.jsp");
	}
	}

