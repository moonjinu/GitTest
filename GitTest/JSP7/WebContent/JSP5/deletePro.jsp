<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>WebContent/JSP5/deletePro.jsp</h1>
	
	<%
		String name = request.getParameter("name");
		String jumin1 = request.getParameter("jumin1");
		String jumin2 = request.getParameter("jumin2");
		String jumin = jumin1+"-"+jumin2;
	
		// 한글처리
		request.setCharacterEncoding("UTF-8");
		
		// 상수설정
			final String DRIVER = "com.mysql.jdbc.Driver";
			final String DBURL = "jdbc:mysql://localhost:3306/jspdb";
			final String DBID = "root";
			final String DBPW = "1234";
			
		// 1. 드라이버 로드
			Class.forName(DRIVER);
			System.out.println("드라이버 로드 성공");
			
		// 2. DB연결
			Connection con = DriverManager.getConnection(DBURL, DBID, DBPW);
			System.out.println("DB연결성공");
		// 3. SQL작성, pstmt 객체 생성
			String sql = "delete from itwill_member "+
						 "where name = ? and jumin = ?";
		
			PreparedStatement pstmt = con.prepareStatement(sql);
			System.out.println("pstmt 객체 생성완료");
		// 3-1 ?값 추가
			pstmt.setString(1,name);
			pstmt.setString(2,jumin);
			System.out.println("?값 추가완료");
		// 4. 실행	
			pstmt.executeUpdate();
			System.out.println("실행완료");
		
			
	%>
	
	
	
	
</body>
</html>