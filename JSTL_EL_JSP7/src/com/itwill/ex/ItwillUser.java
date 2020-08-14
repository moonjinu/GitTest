package com.itwill.ex;

public class ItwillUser {
	// 사용자 정보 저장 객체
	// 이름
	private String name;
	// 나이
	private int age;
	// 휴대폰 -(기종, 전화번호)
	private Phone note20;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public Phone getNote20() {
		return note20;
	}
	public void setNote20(Phone note20) {
		this.note20 = note20;
	}
	public ItwillUser(String name, int age, Phone note20) {
		this.name = name;
		this.age = age;
		this.note20 = note20;
	}
	@Override
	public String toString() {
		return "ItwillUser [name=" + name + ", age=" + age + ", note20=" + note20 + "]";
	}
	
}
