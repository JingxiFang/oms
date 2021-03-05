package sym.admin.action;

import java.security.KeyStore.Builder;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sym.admin.service.impl.AdminCurrencyServiceImpl;
import sym.admin.service.impl.AdminUserServiceImpl;
import sym.common.action.PageListBaseServlet;

public class AdminUserPageListAction extends PageListBaseServlet {

	@Override
	public void initPageInforBean(HttpServletRequest request, HttpServletResponse response) {
		// TODO �Զ����ɵķ������
		StringBuilder builder = new StringBuilder();
		// ��ȡ�������û���

		String user_nm = request.getParameter("user_nm");

		// ��ȡ��ϵ�绰
		String user_phone = request.getParameter("user_phone");
		// ��ȡ�û�״̬
		String is_valid = request.getParameter("is_valid_all");
		// ��ȡ����
		String[] user_owner_flg = request.getParameterValues("owner_flg");
		String owner_flg_All = request.getParameter("owner_flg_All");

		String user_owner = "";

		if (owner_flg_All == "ALL") {
			builder.append("M,F,S");
		}
		if (user_owner_flg != null) {
			for (String S : user_owner_flg) {
				builder.append(S);
				builder.append(",");
			}
			builder.deleteCharAt(builder.length() - 1);

		} else {

			builder.append("M,F,S");
		}
		user_owner = builder.toString();
		// user_ownerF.matches(regex);
		// ����״̬
		// �ж�"ȫѡ"�Ƿ�ѡ�У�ѡ�еĻ�����ƥ�����У�δѡ�еĻ����ȡ������е�ֵ
		if ("ALL".equals(is_valid)) {
			is_valid = "%"; // ���ݵ����ݿ��н���ģ����ѯ��ƥ������״̬
		} else {

			is_valid = request.getParameter("is_valid");

		}
		// ���ĸ������ŵ�hm��
		HashMap<String, String> hm = new HashMap<String, String>();
		hm.put("user_nm", user_nm);
		hm.put("user_phone", user_phone);
		hm.put("user_owner", user_owner);

		hm.put("is_valid", is_valid);
		super.getPageInforBean().setHm(hm);
		super.setPageInforService(new AdminUserServiceImpl());
		super.setForward("/pages/component/admin/userMaster.jsp");
	}
}
