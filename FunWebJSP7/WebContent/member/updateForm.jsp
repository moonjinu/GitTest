<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		// 로그인 여부 체크(로그인x -> 로그인페이지 이동)
		
			String id = (String) session.getAttribute("id");
	 
	 		if(id ==null){
	 		// 로그인페이지 이동
	 		response.sendRedirect("loginForm.jsp");
	 		}
		
		// DB연결 -> 로그인한 사용자의 정보 가져오기 => 화면에 출력(각각의 요소)
		// DB로 이동해서 정보를 가져오기
			request.setCharacterEncoding("UTF-8");
		
			final String DRIVER = "com.mysql.jdbc.Driver";
			final String DBURL = "jdbc:mysql://localhost:3306/jspdb";
			final String DBID = "root";
			final String DBPW = "1234";
		 	
		// 1. 드라이버 로드
			Class.forName(DRIVER);
		
			System.out.println("드라이버 로드 성공");
		
		// 2. DB연결
			Connection con = DriverManager.getConnection(DBURL, DBID, DBPW);
		
			System.out.println("DB연결 성공");
	
		// 3. SQL 구문(select) & pstmt 객체 생성
			String sql = "select * from fun_member where id = ?";
			
			PreparedStatement pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			// 4. 실행 -> 결과 저장(rs)
			ResultSet rs = pstmt.executeQuery();
			
			System.out.println("DB저장 완료");
			// 5. 검색결과 사용하기 -> 테이블 생성 후 추가
	
			String name="";
			String pass="";
			int birth=0;
			String email="";
			String addr="";
			String phone="";
			String mobile="";
			String gender="";
			Timestamp reg_date = null;
		
			if(rs.next()){
			// DB정보를 가져오기 -> 화면에 출력
			// id = rs.getString("id");
			name = rs.getString("name");
			pass = rs.getString("pass");
			email = rs.getString("email");
			birth = rs.getInt("birth");
			gender = rs.getString("gender");
			addr = rs.getString("addr");
			phone = rs.getString("phone");
			mobile = rs.getString("mobile");
			reg_date = rs.getTimestamp("reg_date");
			}
			
			if(gender == null){
				gender="남";
			}
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
<header>
<div id="login"><a href="../member/login.html">login</a> | <a href="../member/join.html">join</a></div>
<div class="clear"></div>
<!-- 로고들어가는 곳 -->
<div id="logo"><img src="../images/logo.gif" width="265" height="62" alt="Fun Web"></div>
<!-- 로고들어가는 곳 -->
<nav id="top_menu">
<ul>
	<li><a href="../index.html">HOME</a></li>
	<li><a href="../company/welcome.html">COMPANY</a></li>
	<li><a href="#">SOLUTIONS</a></li>
	<li><a href="../center/notice.html">CUSTOMER CENTER</a></li>
	<li><a href="#">CONTACT US</a></li>
</ul>
</nav>
</header>
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
<form action="" id="join">
<fieldset>
 	<form action="updatePro.jsp" method="post" name ="fr">
		<hr>
		<h4>수정할 정보</h4>
		<label>아이디</label>
		<input type="text" name="id" value="<%=id%>" readonly> <br>
		<label>변경할 비밀번호</label>
		<input type="password" name="pass" > <br>
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
	</form>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="button" value="회원정보 수정" class="submit">
<input type="button" value="회원 탈퇴" class="cancel">
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