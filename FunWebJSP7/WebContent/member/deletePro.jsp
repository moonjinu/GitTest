<%@page import="com.itwillbs.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="mb" class="com.itwillbs.member.MemberBean"/>
	<jsp:setProperty property="*" name="mb"/>
	<%
		// 로그인 상태 체크
	String id = (String)session.getAttribute("id");
	  if(id == null){
		  response.sendRedirect("loginForm.jsp");
	  }
	
	  // 한글처리
	  request.setCharacterEncoding("UTF-8");
	  
	  // 삭제할 비밀번호 가져오기
	  String pass = request.getParameter("pass");
	  
	  MemberDAO mdao = new MemberDAO();
	  
	  int result = mdao.deleteMember(id, pass);
	  
	  if(result ==1){
		  session.invalidate();
		  %>
		  <script type="text/javascript">
		     alert(" 삭제 완료! ");
		     location.href="main.jsp";
		  </script>		  
		  <%
		  
	  }else if(result == 0){
		  %>
		  <script type="text/javascript">
		     alert(" 비밀번호 오류 ");
		     history.back();
		  </script>		  
		  <%
	  }else{ //result == -1
		  %>
		  <script type="text/javascript">
		     alert(" 아이디 없음 오류 ");
		     history.back();
		  </script>		  
		  <%
	  }
	
	
	%>
</body>
</html>