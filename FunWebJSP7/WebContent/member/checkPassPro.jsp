<%@page import="java.sql.ResultSet"%>
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

<%
	// 비밀번호 일치 -> updateForm.jsp
	// 비밀번호 일치x -> alert, main.jsp
		// 로그인 여부 체크 (로그인x -> 로그인페이지 이동)
			String id = (String) session.getAttribute("id");
	
			if(id==null){
				response.sendRedirect("loginForm.jsp");
			}
		// 한글 처리
			request.setCharacterEncoding("UTF-8");
		
		// 전달받은 비밀번호 변수 저장
			String pass = request.getParameter("pass");

		// DB연결 -> 수정
		
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
		// 3. SQL구문  & pstmt 객체 생성 (수정하고자 하는 사람의 정보 유무 판단)
			String sql = "select pass from fun_member "
						+ "where id = ?";
		
			PreparedStatement pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
		// 4. 실행 -> rs저장
			ResultSet rs = pstmt.executeQuery();
		// 5. 데이터 처리 -> 본인(아이디, 비밀번호 동일) => 정보 수정(이름, 나이, 성별, 이메일)
		// 				 본인x(아이디, 비밀번호 오류) => 에러메세지 처리
				if (rs.next()){
					// 아이디 있음
					if(pass.equals(rs.getString("pass"))){
						// 비밀번호 같은경우

						response.sendRedirect("updateForm.jsp");
						
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