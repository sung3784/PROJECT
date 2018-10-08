package com.my.cleaner.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.my.cleaner.vo.wantedCustomer;



public interface wantedCustomerMapper {
	public int insertWantedCustomer(wantedCustomer wc);
	public List<wantedCustomer> selectAllWC();
	public List<wantedCustomer> selectOneWC(int customerNumber);
	public int deleteWantedCustomer(int customerNumber);
	public int getTotal(String text);
	public List<wantedCustomer> SelectAllwcwc(RowBounds rb,String search);
	public List<wantedCustomer> SelectAllforMap(String search);
	public wantedCustomer boardDetail(int seqwc);
}
