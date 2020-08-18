
<%@page import="com.itwillbs.board.BoardBean"%>
<%@page import="com.itwillbs.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  <jsp:include page="../inc/top.jsp" />
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">글쓰기</a></li>
<li><a href="notice.jsp">글 목록 보기</a></li>
<li><a href="#">파일업로드/다운로드</a></li>
<li><a href="#">Service Policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<article>
<h1> 게시판 글쓰기 </h1>

 	<%
		// 전달된 파라미터 값 저장(bno, pageNum)
		int bno = Integer.parseInt(request.getParameter("bno"));
		String pageNum = request.getParameter("pageNum");
	
		// 글 정보를 가져오기
		
		// BoardDAO 객체 생성
		BoardDAO bdao = new BoardDAO();
		
		// 글 정보 가져오는 메서드 - getBoard(bno)
		BoardBean bb = bdao.getBoard(bno);
		
		// 수정할 정보를 출력 (글쓴이, 제목, 내용)
		
	%>
	
  <fieldset>
		<form action="updatePro.jsp?pageNum=<%=pageNum %>)" method="post">
			<!-- input-type(hidden) : 화면에는 보이지 않지만, 실제 input-type처럼 데이터 저장 및 전달 가능  -->
			
			<%-- 
				폼 태그 안에는 가능하면 BoardBean형태의 데이터만 저장해서 처리할 수 있도록 해야한다.(액션태그)
				BoardBean에 포함되지 않는 데이터는 액션페이지 주소줄에 get방식으로 전달
				* 만약 전달되는 데이터가 BoardBean에는 포함되지 않고, 중요한 정보(개인정보)인 경우 1. scope에 저장 / 2. BoardBean의 구조를 바꿈(요소 추가) 
				<input type="hidden" name="bno" value="<%=bb.getBno()%>"> 
			--%>		
			
			<input type="hidden" name="bno" value="<%=bb.getBno()%>">
			글쓴이 : <input type="text" name="name" value="<%=bb.getName()%>"> <br>
			비밀번호 : <input type="password" name="pass"> <br>
			제목 : <input type="text" name="subject" value="<%=bb.getSubject()%>"> <br> 
			내용 : <br> 
			<textarea rows="10" cols="25" name="content" ><%=bb.getContent()%></textarea> <br> <br> <br>		
	
		
	<div id="table_search">
		<input type="submit" value="수정하기" class="btn">
	</div>
	<div class="clear"></div>
</form>
	</fieldset>
<div id="page_control">
</div>

</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
	<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>