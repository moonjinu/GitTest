<%@page import="com.itwillbs.bean.Javabean2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>WebContent/javabean/beanPro2.jsp</h1>
	
	<%
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		int num = Integer.parseInt(request.getParameter("num"));
	
	%>
	<h2> 파라미터 값</h2>
	아이디 : <%=id %> <br>
	비밀번호 : <%=pw %> <br>
	좋아하는 숫자 <%=num %> <br>
	<hr>
	
	<%
		// 2. 자바빈 객체 사용 값 저장
		Javabean2 jb2 = new Javabean2();
		
		jb2.setId(id);
		jb2.setPw(pw);
		jb2.setNum(num);
	
		out.print(jb2.getId()+"<br>"+jb2.getPw()+"<br>"+jb2.getNum());
	%>
	<hr>
	아이디 : <%=jb2.getId() %> <br>
	비밀번호 : <%=jb2.getPw() %> <br>
	좋아하는 숫자 : <%=jb2.getNum() %> <br>
	<%=jb2.toString() %>
	<%=jb2 %>
	
	<hr>
	
	<!-- 액션 태그 사용 -->
 	<jsp:useBean id="bean" class="com.itwillbs.bean.Javabean2"/>
 	<!-- scope : page, request, session, application 영역에 지정해서 저장가능 
 				설정값이 없을 경우 기본 page에 저장
 	-->
 	
 	<!-- 파라미터값 저장 -->
	<jsp:setProperty property="*" name="bean"/>


	<!-- 파라미터값 출력 -->
	<jsp:getProperty property="*" name="bean"/>


</body>
</html>