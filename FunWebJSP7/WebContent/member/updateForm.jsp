<%@page import="com.itwillbs.member.MemberBean"%>
<%@page import="com.itwillbs.member.MemberDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		// 로그인 여부 체크(로그인x -> 로그인페이지 이동)
			request.setCharacterEncoding("UTF-8");
		
			String id = (String) session.getAttribute("id");
	 
			if(id == null){
				  response.sendRedirect("loginForm.jsp");
			 }
			
			MemberDAO mdao =new MemberDAO();
			MemberBean mb = mdao.getMember(id);
		
			String pass = mb.getPass();
			String name = mb.getName();
			String email = mb.getEmail();
			int birth = mb.getBirth();
			String gender = mb.getGender();
			String addr = mb.getAddr();
			String phone = mb.getPhone();
			String mobile = mb.getMobile();
					

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">Join us</a></li>
<li><a href="#">Privacy policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>회원 정보 수정</h1>
<form action="updatePro.jsp" method="post" id="join">
<fieldset>
 	
		<hr>
		<h4>수정할 정보</h4>
		<label>아이디</label>
		<input type="text" name="id" value="<%=id%>" > <br>
		<label>변경할 비밀번호</label>
		<input type="password" name="pass1" > <br>
		<label>비밀번호 확인</label>
		<input type="password" name="pass" > <br>
		<label>이름</label><input type="text" name="name" value="<%=name%>"> <br>
		<label>이메일</label>
		<input type="text" name="email" value="<%=email %>"> <br>
		<label>생년월일</label><input type="text" name="birth" value="<%=birth%>"> <br>
		<label>성별</label><input type="radio" name="gender" value="남"
			<% if(gender.equals("남")){
				%>checked
				<%} %>
		>남 
	 		 <input type="radio" name="gender" value ="여"
	 		 <% if(gender.equals("여")){
				%>checked
				<%} %>>여 
<br><br><label>주소</label>
<input type="text" name="addr" value="<%=addr%>"><br>
<label>전화번호</label>
<input type="text" name="phone" value="<%=phone%>"><br>
<label>핸드폰</label>
<input type="text" name="mobile" value="<%=mobile%>"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="회원정보 수정" class="submit">
<input type="submit" value="회원 탈퇴" class="cancel" formaction="deletePro.jsp">
</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<footer>
<hr>
<div id="copy">All contents Copyright 2011 FunWeb 2011 FunWeb 
Inc. all rights reserved<br>
Contact mail:funweb@funwebbiz.com Tel +82 64 123 4315
Fax +82 64 123 4321</div>
<div id="social"><img src="../images/facebook.gif" width="33" 
height="33" alt="Facebook">
<img src="../images/twitter.gif" width="34" height="34"
alt="Twitter"></div>
</footer>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>