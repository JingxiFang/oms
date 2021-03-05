package sym.component.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import sym.component.service.OrderDetailService;
import sym.component.service.impl.OrderDetailServiceImpl;

public class OrderDetailAction extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String method = request.getParameter("method");
		if (method.equals("checkInsert")) {
			checkInsert(request, response);
		}
	}

	private void checkInsert(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		BigDecimal orderDetail_id = new BigDecimal(request.getParameter("order_detail_id"));
		OrderDetailService orderDetailService = new OrderDetailServiceImpl();
		
		out.print(orderDetailService.orderDetailExistCheck(orderDetail_id));
		out.flush();
		out.close();
	}

}
