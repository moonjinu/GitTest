<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>WebContent/JSP6/deletePro.jsp</h1>
	<%
		request.setCharacterEncoding("UTF-8");
	// 세션값(로그인 체크)
		String id = (String) session.getAttribute("id");

		if (id == null) {
			response.sendRedirect("loginForm.jsp");
		}
	// ID,PW 정보 전달받아서 저장
		// id = request.getParameter("id");
		String pw = request.getParameter("pw");
	// DB연결 -> ID, PW에 해당하는 정보가 있는 경우 삭제처리
		final String DRIVER = "com.mysql.jdbc.Driver";
		final String DBURL = "jdbc:mysql://localhost:3306/jspdb";
		final String DBID = "root";
		final String DBPW = "1234";
		
	// 드라이버 로드
		Class.forName(DRIVER);
		System.out.println("드라이버 로드 성공");
	// DB연결
		Connection con = DriverManager.getConnection(DBURL, DBID, DBPW);
		
		System.out.println("DB연결 성공");
	// SQL 구문 & pstmt객체 생성
		String sql = "select pw from itwill_member where id =?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, id);
		System.out.println("pstmt객체 생성 완료");
		
	// rs저장
		ResultSet rs = pstmt.executeQuery();
	
	// 삭제 완료시 main.jsp 페이지 이동
		if (rs.next()){
			if(pw.equals(rs.getString("pw"))){
				sql = "delete from itwill_member where id = ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, id);

				pstmt.executeUpdate();
				
				System.out.println("정보수정 완료");
				
				// 삭제시 세션의 정보도 삭제(로그인 정보)
				session.invalidate();
				
				// 페이지 이동
				response.sendRedirect("main.jsp");
				
			}else{
				// 비밀번호 다른경우
				%>
				<script type="text/javascript">
				alert("입력하신 비밀번호 오류입니다.");
				history.back();
				</script>
				<%
			}
		}else{
			// 아이디 없음
			%>
			<script type="text/javascript">
			alert("입력하신 아이디 오류입니다.");
			history.back();
			</script>
			<%
		}
	
	
	%>
</body>
</html>