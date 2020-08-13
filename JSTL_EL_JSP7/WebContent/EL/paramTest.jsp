<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>WebContent/EL/paramTest.jsp</h1>
	<%
		// 한글처리
		request.setCharacterEncoding("UTF-8");
		
		// 각각의 정보 저장 후 출력
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		String msg1 = request.getParameter("msg1");
		String msg2 = request.getParameter("msg2");
	%>
	
	id : <%=id %> <br>
	pass : <%=pass %> <br>
	msg1 : <%=msg1 %> <br>
	msg2 : <%=msg2 %> <br>
</body>
</html>