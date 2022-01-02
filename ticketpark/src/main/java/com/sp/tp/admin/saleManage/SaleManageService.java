package com.sp.tp.admin.saleManage;

import java.util.List;
import java.util.Map;

public interface SaleManageService {
	public int perfMonthCount();
	public List<Sale> monthSale(int perfMonthCount);
	public List<Sale> performSale(int perfMonthCount);
	public int categoryDataCount(Map<String, Object> map);
	public List<Sale> categorySale(Map<String, Object> map);
	public int categoryAllCount();
	public List<Sale> categoryAll(int categoryAllCount);
}
