<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="com.mysql.jdbc.PreparedStatement.ParseInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>WebContent/JSP6/insertPro.jsp</h1>
	
	<%
	
	// 회원정보 전달받아서 회원가입 처리
	
	// 한글처리
	request.setCharacterEncoding("UTF-8");
	// 전달된 정보를 저장(파라미터)
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	int age = Integer.parseInt(request.getParameter("age"));
	String gender = request.getParameter("gender");
	String email = request.getParameter("email");
	
	// 파라미터 -> DB 저장
	final String DRIVER = "com.mysql.jdbc.Driver";
	final String DBURL = "jdbc:mysql://localhost:3306/jspdb";
	final String DBID = "root";
	final String DBPW = "1234";
	
	// 1. 드라이버 로드
		Class.forName(DRIVER);
	
		System.out.println("드라이버 로드 성공");
		
	// 2. DB연결
		Connection con = DriverManager.getConnection(DBURL, DBID, DBPW);
	
		System.out.println("DB연결 성공");
		
	// 3. SQL작성 & pstmt 객체 생성
		String sql = "insert into itwill_member values(?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		pstmt.setString(3, name);
		pstmt.setInt(4, age);
		pstmt.setString(5, gender);
		pstmt.setString(6, email);
		// 시간정보는 직접 객체를 생성해서 시스템의 시간정보를 저장
		pstmt.setTimestamp(7, new Timestamp(System.currentTimeMillis()));
	// 4. 실행
	pstmt.executeUpdate();
	System.out.println("DB저장 완료");
	// 정상적으로 회원가입 시 로그인 페이지로 이동
	// "loginForm.jsp"
	%>
	<script type="text/javascript">
	alert("회원 가입 성공");
	location.href="loginForm.jsp";
	</script>

	
	<%
	%>
	아이디 <%=id %> <br>
	비밀번호<%=pw %> <br>
	이름<%=name %> <br>
	나이<%=age %> <br>
	성별<%=gender %> <br>
	이메일<%=email %> <br>
</body>
</html>