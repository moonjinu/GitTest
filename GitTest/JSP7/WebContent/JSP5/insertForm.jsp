<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>WebContent/JSP5/insertForm.jsp</h1>
	
	<!-- 
		이름, 나이, 성별(radio), 주민번호를 입력받는 페이지를 생성
		form 태그안에서 정보를 입력받아서 전달
	 -->
	<%
	String name = (String) request.getParameter("name");
	String age = request.getParameter("age");
	String gender = request.getParameter("gender");
	String jumin1 = request.getParameter("jumin1");
	String jumin2 = request.getParameter("jumin2");
	
	
	%>
 	<fieldset>
 		<legend>정보 입력</legend>
 		<form action="insertPro.jsp" method="post" name ="fr">
 			이름 : <input type="text" name="name"> <br>
 			나이 : <input type="text" name="age"> <br>
 			성별 : <input type="radio" name="gender" value="남">남 
 		 		 <input type="radio" name="gender" value ="여">여 <br>
 			주민번호 : <input type="text" name="jumin1"> -
 					<input type="text" name="jumin2"> <br> 
 				<input type="submit" value ="가입하기">
 		</form>
	 </fieldset>







</body>
</html>