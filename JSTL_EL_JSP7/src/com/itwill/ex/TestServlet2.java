package com.itwill.ex;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TestServlet2 extends HttpServlet {
	
	//http://localhost:8088/JSTL_EL_JSP7/test2.com
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("TestServlet2_doGet() 호출");
		
		// BeanTest.jsp 페이지 생성(forwarding)
		
		// 객체를 저장해서 전달 BeanTest.jsp에서 출력
		// ItwillBean 객체 생성 후 정보 저장
		ItwillBean bean = new ItwillBean();
		bean.setId("itwill");
		bean.setName("사용자1");
		bean.setPw("1234");
		bean.setAge(20);
		bean.setTel("010-1234-5678");
		
		// request 영역에 저장
		request.setAttribute("itwillBean", bean);
		
		// ItwillUser 사용자 객체 생성
		ItwillUser kim = new ItwillUser("김학생", 22, new Phone("노트20", "010-5432-9876"));
		
		request.setAttribute("kim", kim);
		
		RequestDispatcher dis = request.getRequestDispatcher("./EL/BeanTest.jsp");
		dis.forward(request, response);
	}
	
}
