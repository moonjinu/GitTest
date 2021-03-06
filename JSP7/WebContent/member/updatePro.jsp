<%@page import="com.itwillbs.db.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>WebContent/member/updatePro.jsp</h1>
	
	<%
		// 로그인 상태 체크
		
		String id = (String) session.getAttribute("id");
		if(id == null){
			response.sendRedirect("loginForm.jsp");
		}
		
		// 한글처리
		request.setCharacterEncoding("UTF-8");
		
		// 전달된 파라미터값 저장 -> 액션태그사용 자바빈 객체
	%>
	
		<jsp:useBean id="mb" class="com.itwillbs.member.MemberBean"/>
		<jsp:setProperty property="*" name="mb"/>
	
	<%
	
		// MemberDAO객체 생성 -> 정보 수정 메서드 호출(updateMember(수정할 객체정보))
		MemberDAO mdao = new MemberDAO();
		
		int result = mdao.updateMember(mb);
		
		// 처리결과 리턴(1- 수정완료, 0 - 비밀번호 오류, -1 - 아이디 오류)
		
		// 처리결과에 따른 페이지 이동
		if (result == 1){
			// result == 1
			response.sendRedirect("main.jsp");
			session.setAttribute("id", id);
		}else if(result == 0){
			// result == 0
			%>
			<script type="text/javascript">
			alert("비밀번호 오류");
			history.back();
			</script>
			<%
		}else{
			// result == -1		
					
			%>
			<script type="text/javascript">
			alert("아이디 오류");
			history.back();
			</script>
			<%
		}
	
	%>
	
	
</body>
</html>