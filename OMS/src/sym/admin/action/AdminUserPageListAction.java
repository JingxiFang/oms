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
		// TODO 自动生成的方法存根
		StringBuilder builder = new StringBuilder();
		// 获取界面中用户名

		String user_nm = request.getParameter("user_nm");

		// 获取联系电话
		String user_phone = request.getParameter("user_phone");
		// 获取用户状态
		String is_valid = request.getParameter("is_valid_all");
		// 获取部门
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
		// 部门状态
		// 判断"全选"是否选中，选中的话，则匹配所有，未选中的话则获取后面框中的值
		if ("ALL".equals(is_valid)) {
			is_valid = "%"; // 传递到数据库中进行模糊查询，匹配所有状态
		} else {

			is_valid = request.getParameter("is_valid");

		}
		// 将四个参数放到hm中
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
