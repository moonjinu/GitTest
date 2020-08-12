<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>WebContent/core/set1.jsp</h1>

	<%
		// 자바 코드를 사용해서 변수 2개를 선언 & 초기화
		// 두 변수의 합을 출력(화면)
		// => set1.jsp 페이지에서만 사용가능(단점)
		int a = 100;
		int b = 200;

		int sum = a + b;
	%>

	<%=sum%>

	<h2>JSTL 사용 변수 선언</h2>
	<!-- 변수 선언 -->
	<c:set var="c" value="10" />
	<c:set var="d" value="20" />
	
	<!-- 변수를 가져와서 연산을 처리할 때 el 표현식 사용 -->
	<c:set var="result" value="${c+d}" />
	
	<!-- 변수의 값을 출력할 때 el 표현식 사용 -->
	<c:out value="${result }" /> <br>

	(html) : ${c} + ${d} = ${result } <br>
	(Jstl) : <c:out value="${c }"/>+ <c:out value ="${d }"/> =<c:out value= "${result }" /> <br>
			<c:out value="${c }+${d }=${result }"/>
			
	<hr>
	
	<h2>JSTL 사용해서 변수 선언 시 특정 영역을 지정 가능</h2>
	<%-- <c:set var="name" value="홍길동" scope="page" /> --%> <!-- 기본 scope를 지정하지 않고 변수를 선언할 경우 페이지 영역에 지정(scope="page"가 생략) -->
	
	<c:set var="name" value="홍길동" scope="request" />
	
	<!-- age : 20, email : itwill@naver.com 전달  -->
	<c:set var="age" value="20" scope="request"/>
	<c:set var="email" value="itwill@naver.com" scope="request"/>
	
	<!-- 페이지 이동 시 request 영역의 값을 가지고 이동 -->
	<!-- 포워딩을 사용한 페이지 이동 시 (request, response 객체를 가지고 이동) -->
	<!-- 이동하는 페이지의 주소가 변경x(set1주소, set2 내용 -->
	<jsp:forward page="set2.jsp" />
	
</body>
</html>