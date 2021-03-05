package sym.admin.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sym.admin.service.impl.AdminAgencyServiceImpl;
import sym.admin.service.impl.AdminCurrencyServiceImpl;
import sym.common.action.PageListBaseServlet;

public class AdminAgencyPageListAction extends PageListBaseServlet {

	@Override
	public void initPageInforBean(HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("AdminAgencyPageListAction+++++++++++++");
				//��ȡ�����д�������
				String agency_nm=request.getParameter("agency_nm"); 
				//��ȡҵ��Ա��
				String agency_user_nm = request.getParameter("agency_user_nm");
				//��ȡ������״̬
				String is_valid=request.getParameter("is_valid_all");
				
				//�ж�"ȫѡ"�Ƿ�ѡ�У�ѡ�еĻ�����ƥ�����У�δѡ�еĻ����ȡ������е�ֵ
				if("ALL".equals(is_valid))
				{
					is_valid="%";  //���ݵ����ݿ��н���ģ����ѯ��ƥ������״̬	
				}else
				{
					is_valid=request.getParameter("is_valid");
				}
				
				//�����������ŵ�hm��
				HashMap<String ,String> hm=new HashMap<String,String>();
				hm.put("agency_nm", agency_nm);
				hm.put("agency_user_nm", agency_user_nm);
				hm.put("is_valid",is_valid);
				super.getPageInforBean().setHm(hm);
				super.setPageInforService(new AdminAgencyServiceImpl());
				super.setForward("/pages/component/admin/agencyMaster.jsp");
		
	}

}
