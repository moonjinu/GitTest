package com.itwill.ex;

public class Phone {
	private String model;
	private String tel;
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getNumber() {
		return tel;
	}
	public void setNumber(String tel) {
		this.tel = tel;
	}
	public Phone(String model, String tel) {
		this.model = model;
		this.tel = tel;
	}
	
}
