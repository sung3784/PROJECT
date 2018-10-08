package com.my.cleaner.vo;



public class wantedCustomer {
	private int seqwc;
	private int clientNumber;
	private String name;
	private String phone;
	private String address;
	private String address2;
	private String wantedTime;
	private int specificTime;
	private String details;
	public wantedCustomer(int seqwc, int clientNumber, String name, String phone, String address, String address2,
			String wantedTime, int specificTime, String details) {
		super();
		this.seqwc = seqwc;
		this.clientNumber = clientNumber;
		this.name = name;
		this.phone = phone;
		this.address = address;
		this.address2 = address2;
		this.wantedTime = wantedTime;
		this.specificTime = specificTime;
		this.details = details;
	}
	public wantedCustomer() {
		super();
	}
	public int getSeqwc() {
		return seqwc;
	}
	public void setSeqwc(int seqwc) {
		this.seqwc = seqwc;
	}
	public int getClientNumber() {
		return clientNumber;
	}
	public void setClientNumber(int clientNumber) {
		this.clientNumber = clientNumber;
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
	public String getWantedTime() {
		return wantedTime;
	}
	public void setWantedTime(String wantedTime) {
		this.wantedTime = wantedTime;
	}
	public int getSpecificTime() {
		return specificTime;
	}
	public void setSpecificTime(int specificTime) {
		this.specificTime = specificTime;
	}
	public String getDetails() {
		return details;
	}
	public void setDetails(String details) {
		this.details = details;
	}
	@Override
	public String toString() {
		return "wantedCustomer [seqwc=" + seqwc + ", clientNumber=" + clientNumber + ", name=" + name + ", phone="
				+ phone + ", address=" + address + ", address2=" + address2 + ", wantedTime=" + wantedTime
				+ ", specificTime=" + specificTime + ", details=" + details + "]";
	}


	
	
}
