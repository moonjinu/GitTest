<%@page import="com.itwillbs.member.MemberBean"%>
<%@page import="com.itwillbs.db.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>WebContent/member/memberInfo.jsp</h1>
	
	<%
		// 로그인이 없이 접근할 경우 -> 로그인페이지로 이동
		String id = (String) session.getAttribute("id");
		
		if (id == null){
			response.sendRedirect("loginForm.jsp");
		}
	
		// 회원의 정보를 DB에서 가져와서 페이지에 출력
		
		// MemberDAO 객체 생성
		MemberDAO mdao = new MemberDAO();
		
		// 회원 정보를 가져오는 메서드 생성(getMember(id))
		MemberBean mb = mdao.getMember(id);
		// -> 회원정보 전부(자바빈객체) 리턴 => 테이블에 추가
		if (mb != null){	
	%>
	<h2>회원정보 출력</h2>
	<table border="1">
		<tr>
			<td>아이디</td>
			<td><%=mb.getId() %></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><%=mb.getPw() %></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><%=mb.getName() %></td>
		</tr>
		<tr>
			<td>나이</td>
			<td><%=mb.getAge() %></td>
		</tr>
		<tr>
			<td>성별</td>
			<td><%=mb.getGender() %></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><%=mb.getEmail() %></td>
		</tr>
		<tr>
			<td>날짜</td>
			<td><%=mb.getReg_date() %></td>
		</tr>

	</table>
	
		<%} %>
	<h2><a href="main.jsp">메인페이지 이동</a></h2>
</body>
</html>