package sym.component.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.junit.runner.Request;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import sym.common.bean.PageInforBean;
import sym.common.dto.SessionDto;
import sym.component.bean.OrderBean;
import sym.component.bean.SimpleOrderBean;
import sym.component.service.OrderService;
import sym.component.service.impl.OrderServiceImpl;

public class OrderAction extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String method = request.getParameter("method");
		if(method.equals("getOrders")){
			getOrders(request, response);
		} else if(method.equals("updateOrder")){
			updateOrder(request, response);
		} else if(method.equals("insertOrder")){
			insertOrder(request, response);
		} else if(method.equals("deleteOrder")){
			deleteOrder(request, response);
		}
		
		
	}
	private void deleteOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		OrderService orderService = new OrderServiceImpl();
		int orders_id = Integer.parseInt(request.getParameter("orders_id"));
		
		int result = orderService.deleteOrder(orders_id);
		out.print(result);
		out.flush();
		out.close();
	}

	private void insertOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		OrderService orderService = new OrderServiceImpl();
		String orderJsonStr = request.getParameter("order");
		Gson gson = new Gson();
		OrderBean orderBean = gson.fromJson(orderJsonStr, OrderBean.class);
		SessionDto dto = (SessionDto) request.getSession().getAttribute("dto");
		
		orderBean.setUpdate_user_id(dto.getUser_cd());
		orderBean.setUpdate_date(new Date());
		int result = orderService.insertOrder(orderBean);
		out.print(result);
		out.flush();
		out.close();
	}
	
	private void updateOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		OrderService orderService = new OrderServiceImpl();
		String orderJsonStr = request.getParameter("order");
		Gson gson = new Gson();
		OrderBean orderBean = gson.fromJson(orderJsonStr, OrderBean.class);
		SessionDto dto = (SessionDto) request.getSession().getAttribute("dto");
		
		orderBean.setUpdate_user_id(dto.getUser_cd());
		orderBean.setUpdate_date(new Date());
		
		int result = orderService.updateOrder(orderBean);
		out.print(result);
		out.flush();
		out.close();
	}

	private void getOrders(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String jsonStr = "";
		Gson gson = new Gson();
		OrderService orderService = new OrderServiceImpl();
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		int showCount = Integer.parseInt(request.getParameter("showCount"));// 每页显示数
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));// 当前页码
		String orderBy = request.getParameter("orderBy");
		String order = request.getParameter("order");
		String contract_no = request.getParameter("contract_no");
		String agency_user_nm = request.getParameter("agency_user_nm");
		String customer_nm = request.getParameter("customer_nm");
		String project_nm = request.getParameter("project_nm");
		List<String> types = gson.fromJson(request.getParameter("types"), new TypeToken<List<String>>() {
		}.getType());
		List<String> back_sections = gson.fromJson(request.getParameter("back_sections"),
				new TypeToken<List<String>>() {
				}.getType());

		PageInforBean<SimpleOrderBean> PageInforSimpleOrderBean = orderService.getPageInforSimpleOrderBean(showCount,
				currentPage, orderBy, order, contract_no, agency_user_nm, customer_nm, project_nm, types,
				back_sections);

		jsonStr = gson.toJson(PageInforSimpleOrderBean, PageInforBean.class);
		out.print(jsonStr);
		out.flush();
		out.close();
	}

}
