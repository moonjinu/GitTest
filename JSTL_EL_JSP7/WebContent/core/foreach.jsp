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
	<h1>WebContent/core/foreach.jsp</h1>
	
	<%
		for(int i=0;i<5;i++){
			out.print("안녕하세요<br>");
		}
	%>
	
	<!-- JSTL 사용해서 반복문 처리 -->
	<c:forEach begin="1" end="5" step="2" var="i">
	<h2>${i } JSTL : 안녕하세요</h2>
	</c:forEach>
	
	<!-- 1~10까지의 수 중 홀수 출력 -->
	홀수 : <c:forEach begin="1" end="10" step="2" var="odd">
	${odd }
	</c:forEach> <br>
	<!-- 1~10까지 수 중 짝수 출력 -->
	짝수 : <c:forEach begin="2" end="10" step="2" var="even">
	${even }
	</c:forEach> <br>
	
	<!-- 1~10 수 출력 -->
	<c:forEach begin="1" end="<%=10 %>" step="1" var="num">
		${num } <br>
	</c:forEach>
	
	<!-- 
		c:forTokens 
		=> 반복문 for + StringTokenizer 클래스
	-->
	
<%-- 	<c:forTokens items="문자데이터 객체" delims="구분자" begin="시작값" end="끝" step="단계" var="결과 저장변수" varStatus="상태">
	</c:forTokens> --%>
	<c:set var="abc" value="a.b.c.d.e.f.g.hi.jkl.mno.pqrst.u"/>
	<c:forTokens items="${abc }" delims="." var="alphabet">
		${alphabet } <br>
	</c:forTokens>
	
	<!-- "안녕하세요 JSTL 문법입니다."  -->

	<c:forTokens items="안녕하세요 JSTL 문법입니다." delims=" " var="tmp">
		${tmp } <br>
	</c:forTokens>	
</body>
</html>