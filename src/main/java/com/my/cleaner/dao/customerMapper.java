package com.my.cleaner.dao;

import com.my.cleaner.vo.Customer;

public interface customerMapper {
	public int insertCustomer(Customer cust);
	public Customer selectOneCustomer(Customer cust);
	public Customer CustomerDetail(int Custnum);
	public int updateCustomer(Customer cust);
}
