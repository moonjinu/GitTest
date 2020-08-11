<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>WebContent/JSP1/TestPro1.jsp</h1>
	
	<%
		// 이전페이지에서 정보를 받아오기
		System.out.println(request.getParameter("num"));
		out.println(request.getParameter("num")+100);
		
		// form 태그에서 get방식으로 정보를 전달할 때 데이터가 String타입으로 변경되서 전달된다.
		// => 숫자를 전달할 경우는 받아서 사용할 때 문자를 숫자로 변경해야한다.(형변환)
		
		// Integer.parseInt(문자열) => 문자열을 정수형(int)으로 변경

		// 데이터 타입
		// 1) 기본형 타입 - 8개
		//	- boolean (1byte)
		//  - byte , short, int, long (1,2,4,8 byte)
		//  - float, double (4,8byte)
		//  - char (2byte)
		// => 묵시적 형변환 : 메모리 공간의 크기가 작은 곳 -> 큰 곳
		// 	 => 컴파일러가 자동으로 형변환(문제가 없기 때문에)
		// => 명시적 형변환 : 메모리 공간의 크기가 큰 곳 -> 작은 곳
		// 	 => 컴파일러가 자동으로 형변환X(문제가 발생하기 때문: 메모리 공간이 큰->작) 
		//	 => 형변환 하고자하는 타입으로 (타입) 직접 지정
		//	 => 문제상황을 개발자가 인지하고, 그래도 해당타입으로 처리하겠다
		
		// 2) 참조형 타입 - 무한대
		// => 기본형 타입 8가지가 아닌 모든 데이터 타입.
		// String(참조형), int[], 
		
		int num = Integer.parseInt(request.getParameter("num"));
		
	%>
	<!-- 표현식을 사용해서 num을 출력 -->
	
	정수형 값 : <%=num %> <br>
	정수형 값  +100 : <%=num+100 %> <br>
	<%=Integer.parseInt(request.getParameter("num")) %>
	
	
	
	
</body>
</html>