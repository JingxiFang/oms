package sym.admin.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sym.admin.bean.AdminCurrencyBean;
import sym.admin.service.impl.AdminCurrencyServiceImpl;
import sym.common.dto.SessionDto;

public class AdminCurrencyAction extends HttpServlet {

	/**
	 * doPost方法
	 */
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String method = request.getParameter("method");
		if ("insertCurrency".equals(method)) {
			insertCurrency(request, response);
		} else if ("updateCurrency".equals(method)) {
			updateCurrency(request, response);
		} else if("checkInsert".equals(method)){
			checkInsert(request,response);
		}
	}
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * 插入货币检查是否存在
	 * 
	 * @param request
	 * @param response
	 */
	public void checkInsert(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String currency_cd = request.getParameter("currency_cd");
		boolean result = new AdminCurrencyServiceImpl().checkInsert(currency_cd);
		if(result){
			out.print(1);
		}else{
			out.print(0);
		}
		
	}

	/**
	 * 新增货币信息
	 * 
	 * @param request
	 * @param response
	 */
	public void insertCurrency(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		AdminCurrencyBean adminCurrencyBean = new AdminCurrencyBean();
		String currency_cd = request.getParameter("currency_cd");
		String currency_name = request.getParameter("currency_name");
		String is_vaild = request.getParameter("sex");

		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
		String update_date = date.format(new Date());
		SessionDto dto = (SessionDto) request.getSession().getAttribute("dto");
		String update_user_id = dto.getUser_cd();

		adminCurrencyBean.setCurrency_cd(currency_cd);
		adminCurrencyBean.setCurrency_nm(currency_name);
		adminCurrencyBean.setIs_valid(is_vaild);
		adminCurrencyBean.setUpdate_user_id(update_user_id);
		adminCurrencyBean.setUpdate_date(update_date);
			
		new AdminCurrencyServiceImpl().insertCurrency(adminCurrencyBean);
		
		request.getRequestDispatcher("/adminCurrencyPageListAction?method=firstPage").forward(request, response);
	}

	/**
	 * 编辑货币信息
	 * 
	 * @param request
	 * @param response
	 */
	private void updateCurrency(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		AdminCurrencyBean adminCurrencyBean = new AdminCurrencyBean();
		String currency_cd = request.getParameter("currency_cd");
		String currency_name = request.getParameter("currency_name");
		String is_vaild = request.getParameter("sex");

		System.out.println("currency_cd:" + currency_cd);
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
		String update_date = date.format(new Date());
		SessionDto dto = (SessionDto) request.getSession().getAttribute("dto");
		String update_user_id = dto.getUser_cd();

		adminCurrencyBean.setCurrency_cd(currency_cd);
		adminCurrencyBean.setCurrency_nm(currency_name);
		adminCurrencyBean.setIs_valid(is_vaild);
		adminCurrencyBean.setUpdate_user_id(update_user_id);
		adminCurrencyBean.setUpdate_date(update_date);

		int rt = new AdminCurrencyServiceImpl().updateCurrency(adminCurrencyBean);
		if (rt == 1) {
			request.getSession().setAttribute("rt_msg", "正在被使用，无法更新修改");

		}
		request.getRequestDispatcher("/adminCurrencyPageListAction?method=firstPage").forward(request, response);
	}
}
