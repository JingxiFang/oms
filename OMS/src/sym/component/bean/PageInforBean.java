package sym.component.bean;

import java.util.HashMap;
import java.util.List;

public class PageInforBean {
	private int showCount;//��ǰҳ��ʾ��¼��,Ĭ��Ϊÿҳ��ʾ10��						
	private int fromCount;//��ǰҳ��ʼ��¼��						
	private int totalNumber;//��¼������						
	private List list;//��ǰҳ���ݵ��б�						
	private int totalPage;//��ҳ��						
	private int currentPage;//��ǰҳҳ��						
	private HashMap hm;	//�洢��������						
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

