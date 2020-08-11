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
	<h1>WebContent/member/joinIdCheck.jsp</h1>
	
	<%
	String ID = request.getParameter("userid");
	// MemberDAO 객체 생성
	MemberDAO mdao = new MemberDAO();
	// 중복 아이디 체크하는 메서드 joinIdCheck(ID);
	int check = mdao.joinIdCheck(ID);
	
	if(check == 1 ){
		out.print("사용 가능한 아이디입니다.");
		// "아이디 선택" 버튼 추가
	%>
	<input type="button" value="아이디 사용하기" onclick="result()">
	<%
	}else if(check ==0){
		out.print("중복된 아이디입니다.");
	}else{
		out.print("에러발생");
	}
	%>
	<br> <br> <br> <br>
	<fieldset>
		<form action = "joinIdCheck.jsp" method="post" name="wfr"> <!-- action 페이지 비어있는 경우 그대로 자기페이지 이동  -->
		ID : <input type="text" name="userid" value="<%=ID %>">
		<input type="submit" value="중복 확인">
		</form>
	</fieldset>
	
	<script type="text/javascript">
	function result(){
		// ID중복 확인 창 -> 회원가입 페이지 정보전달
		
		// 새창에 있는 아이디 정보 -> 회원가입 창에 아이디 정보 전달
		// alert("새창 : "+document.wfr.userid.value);
		// alert("회원가입창 : " +opener.document.fr.id.value);
		opener.document.fr.id.value = document.wfr.userid.value
		
		// 회원가입창 제어
		// opener.document.fr.id.disabled="disabled";
		opener.document.fr.id.readOnly=true;
		// 창 닫기
		window.close();
	}
	</script>
	
	

</body>
</html>