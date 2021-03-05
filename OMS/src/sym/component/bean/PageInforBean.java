package sym.component.bean;

import java.util.HashMap;
import java.util.List;

public class PageInforBean {
	private int showCount;//当前页显示记录数,默认为每页显示10条						
	private int fromCount;//当前页开始记录数						
	private int totalNumber;//记录总条数						
	private List list;//当前页数据的列表						
	private int totalPage;//总页数						
	private int currentPage;//当前页页码						
	private HashMap hm;	//存储检索条件						
	public int getShowCount() {
		return showCount;
	}
	public void setShowCount(int showCount) {
		this.showCount = showCount;
	}
	public int getFromCount() {
		return fromCount;
	}
	public void setFromCount(int fromCount) {
		this.fromCount = fromCount;
	}
	public int getTotalNumber() {
		return totalNumber;
	}
	public void setTotalNumber(int totalNumber) {
		this.totalNumber = totalNumber;
	}
	public List getList() {
		return list;
	}
	public void setList(List list) {
		this.list = list;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public HashMap getHm() {
		return hm;
	}
	public void setHm(HashMap hm) {
		this.hm = hm;
	}

}

