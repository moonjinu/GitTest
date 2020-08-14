<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>WebContent/EL/operatro2.jsp</h1>
	
	<h2>EL표현식 사용해서 전달받은 정보 출력</h2>
		num1 : ${param.num1 } <br>
		num2 : ${param.num2 } <br>
	
	<h2>EL 표현식을 사용해서 전달받은 2개의 값의 합 출력</h2>
	<h3>EL 표현식은 전달받은 데이터 자동 캐스팅(연산 시 자동으로 숫자로 전환)</h3>
		sum : ${param.num1 + param.num2 } <br>
		
	<h2>EL 표현식을 사용해서 전달받은 2개의 값이 모두 양수인가? 판단</h2>
	${(param.num1 >= 0) && (param.num2 >= 0) }
	
	<h2>EL 표현식 사용해서 삼항조건연산 처리</h2>
	<!-- 전달한 2개의 데이터가 같으면 "같음", 다르면  "다름" 출력-->
	${param.num1==param.num2?"같음":"다름" }
	
	<h2> EL 표현식 사용(값이 null, 컬렉션의 크기가 0인 경우)</h2>
	<!-- 
		empty 값 => t/f 리턴
		operator1.jsp에서 ID값 전달, ID가 없을 경우 "guest님 환영합니다"메시지,
								 ID가 있을 경우 "ID님 환영합니다" 메시지 
	-->
	${empty param.id?"guest":param.id }님 환영합니다 <br>
	
</body>
</html>