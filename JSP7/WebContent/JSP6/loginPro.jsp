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
	<h1>WebContent/JSP6/loginPro.jsp</h1>
	
	<%
		// 한글처리
		request.setCharacterEncoding("UTF-8");
		// 전달된 ID, PW정보 저장
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		System.out.println("id : "+id+"pw : "+pw);
		
		// DB로 이동해서 해당 정보의 회원이 있는지 판단
		final String DRIVER = "com.mysql.jdbc.Driver";
		final String DBURL = "jdbc:mysql://localhost:3306/jspdb";
		final String DBID = "root";
		final String DBPW = "1234";
	
		// 1. 드라이버 로드
		Class.forName(DRIVER);
		
		System.out.println("드라이버 로드 성공");
		
		// 2. DB 연결
		Connection con = DriverManager.getConnection(DBURL, DBID, DBPW);
		
		System.out.println("DB연결 성공");
		
		// 3. SQL구문(select) & pstmt 객체 생성
		// 회원정보가 있는지 없는지 판단
		// 회원 고유정보가 있으면 -> 회원
		// 		"    없으면 -> 비회원
		String sql = "select pw from itwill_member "
					+"where id = ?";
		
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, id);
		
		// 4. 실행 -> rs 저장
		ResultSet rs = pstmt.executeQuery();
		
		System.out.println("DB저장 완료");
	
		
		// 5. 데이터 처리
		
		// 회원인가
		// -> 비밀번호 체크 O => 로그인, main페이지 이동, id값으로 세션객체 생성
		//        "    X => 에러("비밀번호 오류입니다.") , 페이지 뒤로이동
		// 회원아닌가 => 에러("가입되지 않은 아이디입니다."), 페이지 뒤로이동
		
		if(rs.next()){
			// 회원인 경우 (아이디에 해당하는 비밀번호가 있을 경우)
			if(pw.equals(rs.getString("pw"))){
				// 아이디가 있으면서, 비밀번호도 같음
				// 세션 ID값 생성
				session.setAttribute("id",id);
				
				// 페이지 이동
				response.sendRedirect("main.jsp");
				System.out.println("로그인 성공");
				
			}else{
				// 아이디는 같지만, 비밀번호가 다름
				%>
				<script type="text/javascript">
				alert("비밀번호 오류");
				history.back(); // 아이디 남아있음 -> 사용자 편의
				// location.href="loginForm.jsp"; // 아이디 남아있지 않음
				</script>
				<%
			}
		}else{
			// 회원아닌 경우 (아이디에 해당하는 비밀번호가 없는 경우)
			%>
			<script type="text/javascript">
			// 비회원인 경우 -> "비회원 입니다. 회원가입 하시겠습니까?"
			// Yes -> 회원가입페이지로 이동(insertForm.jsp)\
			// No -> 페이지 뒤로가기
			
			var tmp = confirm("비회원입니다. 회원가입 하시겠습니까?")
			if (tmp){
				location.href="insertForm.jsp";
			}else{
				history.back();
			}
			</script>
			<%
		}
	
	
	
	%>
</body>
</html>