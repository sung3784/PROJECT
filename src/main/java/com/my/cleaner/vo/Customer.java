package com.my.cleaner.vo;



public class Customer {
	private int customerNumber;
	private String name;
	private String phone;
	private String address;
	private String address2;
	private String totalAddress;
	private String id;
	private String password;
	public Customer(int customerNumber, String name, String phone, String address, String address2, String totalAddress,
			String id, String password) {
		super();
		this.customerNumber = customerNumber;
		this.name = name;
		this.phone = phone;
		this.address = address;
		this.address2 = address2;
		this.totalAddress = totalAddress;
		this.id = id;
		this.password = password;
	}
	public Customer() {
		super();
	}
	public int getCustomerNumber() {
		return customerNumber;
	}
	public void setCustomerNumber(int customerNumber) {
		this.customerNumber = customerNumber;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getTotalAddress() {
		return totalAddress;
	}
	public void setTotalAddress(String totalAddress) {
		this.totalAddress = totalAddress;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	@Override
	public String toString() {
		return "Customer [customerNumber=" + customerNumber + ", name=" + name + ", phone=" + phone + ", address="
				+ address + ", address2=" + address2 + ", totalAddress=" + totalAddress + ", id=" + id + ", password="
				+ password + "]";
	}
	
	
	
	
}
