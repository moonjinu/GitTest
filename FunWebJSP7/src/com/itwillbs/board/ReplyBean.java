package com.itwillbs.board;

import java.sql.Date;

public class ReplyBean {
	private int bno;
	private String name;
	private String pass;
	private String content;
	private int re_ref;
	private int re_lev;
	private int re_seq;
	private Date date;
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getRe_ref() {
		return re_ref;
	}
	public void setRe_ref(int re_ref) {
		this.re_ref = re_ref;
	}
	public int getRe_lev() {
		return re_lev;
	}
	public void setRe_lev(int re_lev) {
		this.re_lev = re_lev;
	}
	public int getRe_seq() {
		return re_seq;
	}
	public void setRe_seq(int re_seq) {
		this.re_seq = re_seq;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	@Override
	public String toString() {
		return "ReplyBean [bno=" + bno + ", name=" + name + ", pass=" + pass + ", content=" + content + ", re_ref="
				+ re_ref + ", re_lev=" + re_lev + ", re_seq=" + re_seq + ", date=" + date + "]";
	}


	
}
