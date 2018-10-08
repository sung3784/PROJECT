package com.my.cleaner.vo;

public class Cleaner {
	private int cleanerNumber;
	private String name;
	private String phone;
	private String id;
	private String password;
	private String address;
	private String address2;
	public Cleaner(int cleanerNumber, String name, String phone, String id, String password, String address,
			String address2) {
		super();
		this.cleanerNumber = cleanerNumber;
		this.name = name;
		this.phone = phone;
		this.id = id;
		this.password = password;
		this.address = address;
		this.address2 = address2;
	}
	public Cleaner() {
		super();
	}
	public int getCleanerNumber() {
		return cleanerNumber;
	}
	public void setCleanerNumber(int cleanerNumber) {
		this.cleanerNumber = cleanerNumber;
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
	@Override
	public String toString() {
		return "Cleaner [cleanerNumber=" + cleanerNumber + ", name=" + name + ", phone=" + phone + ", id=" + id
				+ ", password=" + password + ", address=" + address + ", address2=" + address2 + ", getCleanerNumber()="
				+ getCleanerNumber() + ", getName()=" + getName() + ", getPhone()=" + getPhone() + ", getId()="
				+ getId() + ", getPassword()=" + getPassword() + ", getAddress()=" + getAddress() + ", getAddress2()="
				+ getAddress2() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()="
				+ super.toString() + "]";
	}
	
	
}
