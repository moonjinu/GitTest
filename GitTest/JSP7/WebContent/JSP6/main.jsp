<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>WebContent/JSP6/main.jsp</h1>
	
	<!-- 
		아이디, 비밀번호, 이름, 나이, 성별, 이메일 정보를 저장
		회원관리를 하는 프로그램 작성
	 -->
	 
	 <!-- 회원가입 -> 회원가입 완료 -> 로그인 -> 메인페이지  -->
	 
	 <!-- 메인 페이지는 로그인한 사람만 접근 가능 
	 	    로그인 하지않은 사람은 다시 로그인페이지로 이동
	 -->
	 
	 <!-- 로그인 아이디 : ㅇㅇㅇ님 로그인 / 환영합니다. -->
	 <%
		String id = (String) session.getAttribute("id");
	 
	 	if(id ==null){
	 		// 로그인페이지 이동
	 		response.sendRedirect("loginForm.jsp");
	 	}
	 %>
	 <h2> <%=id %> 님 환영합니다</h2>
	 
	 <input type="button" value="로그아웃" onclick="location.href='logout.jsp'">
	 
	 <hr>
	 
	 <a href="myInfo.jsp"> <h2>회원정보 보기</h2> </a> <!-- select -->
	 <a href="updateForm.jsp"> <h2>회원정보 수정</h2> </a> <!-- update -->
	 <a href="deleteForm.jsp"> <h2>회원정보 삭제</h2> </a> <!-- delete -->
	 <hr>
	 <!-- 관리자(admin)인 경우에만 정보 확인가능,
		     일반 사용자는 확인 불가능
	  -->
	  <%
	  if(id !=null){
	  	if (id.equals("admin")){
	  		%>
	  		<a href="adminSelect.jsp"> <h2>관리자 회원정보 목록</h2> </a>
	  		<%
	  	}
	  }
	  %>
	  
	 
	 
	  
	
</body>
</html>