<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1> WebContent/JSP1/TestPro2.jsp </h1>
	<h1> 정보 전달 받아서 출력 </h1>
	<% 
		// 파라미터 값 한글처리 (form태그-post방식 한글전달)
		request.setCharacterEncoding("UTF-8");
	
	
	   String name = request.getParameter("name");
	   int age = Integer.parseInt(request.getParameter("age"));
	   String address = request.getParameter("address");
	   
	   // 콘솔창에 출력
	   System.out.println("name : "+name);
	   System.out.println("age : "+age);
	   System.out.println("address : "+address);
	   
	   // 화면에 출력(자바코드)
	   
		out.println("name : "+name);
		out.println("age : "+age);
		out.println("address : "+address);
	 
	
	%>
	<hr>
	<!-- 표현식 -->
	이름 : <%=name %> <br>
	나이 : <%=age %> <br>
	주소 : <%=address %> <br>
	
	<!-- 전달받은 나이정보가 20살 이상인 경우
	화면에 "ㅇㅇㅇ님은 성인입니다." 출력
	나이정보가 20살 미만인 경우
	화면에 "ㅇㅇㅇ님은 미성년자 입니다."출력 -->
	
	
	<%
	if (age >=20){
		out.println(name+"님은 성인입니다.");
	}else{
	%>
		<%=name %>님은 미성년자입니다.<br>
	<%
	}
	%>
	
</body>
</html>