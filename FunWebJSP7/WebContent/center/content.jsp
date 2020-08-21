<%@page import="com.itwillbs.board.BoardBean"%>
<%@page import="com.itwillbs.board.ReplyBean"%>
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
<%
		// 글 번호(pk)에 해당하는 글의 정보를 가져오기
		
		// 전달된 데이터 저장(bno, pageNum)
		int bno = Integer.parseInt(request.getParameter("bno"));
		String pageNum = request.getParameter("pageNum");
	
		// BoardDAO 객체 생성
		BoardDAO bdao = new BoardDAO();
		
		// 글 조회수 정보를 1증가( updateReadCount(bno) )
		bdao.updateReadCount(bno);

		// 글 정보를 가져오는 메서드 생성( getBoard(bno) )
		BoardBean bb = bdao.getBoard(bno);
		// 화면(테이블)에 출력
	
	%>
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
			<!-- 로그인정보가 없거나, 작성자 이름과 아이디가 다른 경우
				 수정하기, 삭제하기 버튼 -> 숨김처리
				 로그인한 아이디의 정보가 작성자 이름과 같은 경우
				 수정하기, 삭제하기 버튼 -> 보여주기
			-->
			<%
				// 로그인 정보를 가져와서 판단
				// 세션값 가져오기
				String id = (String) session.getAttribute("id");
				if (id != null && id.equals(bb.getName())) {
			%>
			<li><a href="updateForm.jsp?bno=<%=bb.getBno()%>&pageNum=<%=pageNum%>">글 수정</a></li>
			<li><a href="deleteForm.jsp?bno=<%=bb.getBno()%>&pageNum=<%=pageNum%>">글 삭제</a></li>
			<%
			}
			%>
<li><a href="reWriteForm.jsp?bno=<%=bb.getBno()%>&re_ref=<%=bb.getRe_ref()%>&re_lev=<%=bb.getRe_lev()%>&re_seq=<%=bb.getRe_seq()%>">답글 쓰기</a></li>
<li><a href="notice.jsp?pageNum=<%=pageNum%>">글 목록 보기</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<article>
<h1>Board</h1>

	
	<table border="1">
		<tr>
			<td>글번호</td>
			<td><%=bb.getBno() %></td>
			<td>조회수</td>
			<td><%=bb.getReadcount() %></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><%=bb.getName() %></td>
			<td>작성일</td>
			<td><%=bb.getDate() %></td>
		</tr>
		<tr>
			<td>제목</td>
			<td colspan="3"><%=bb.getSubject() %></td>
		</tr>		
		<tr>
			<td>첨부파일</td>
			<td colspan="3">
			<a href="D:\upfile\<%=bb.getFile()%>"><%=bb.getFile() %></a>
			</td>
		</tr>
		<tr>
			<td>글 내용</td>
			<td colspan="3"><%=bb.getContent() %></td>
		</tr>
	</table>
<%-- 	<form action="replyPro.jsp?bno=<%=bb.getBno()%>" method="post">  --%>
<!-- 	<table> -->
<!-- 		<tr> -->
<!-- 		<td>작성자</td> -->
<%-- 		<td><%=bb1.getName() %></td> --%>
<!-- 		<td>내용</td> -->
<%-- 		<td><%=bb1.getContent() %></td> --%>
<!-- 		<td>시간</td> -->
<%-- 		<td><%=bb1.getDate() %></td> --%>
<!-- 		</tr> -->
<!-- 	</table> -->
<!-- 	댓글 작성<input type="text" name="reply"> <input type="submit"> -->
<!-- 	</form> -->
<div id="table_search">
<input type="text" name="search" class="input_box">
<input type="button" value="search" class="btn">
</div>
<div class="clear"></div>
<div id="page_control">
<a href="#">Prev</a>
<a href="#">1</a><a href="#">2</a><a href="#">3</a>
<a href="#">4</a><a href="#">5</a><a href="#">6</a>
<a href="#">7</a><a href="#">8</a><a href="#">9</a>
<a href="#">10</a>
<a href="#">Next</a>
</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
 	<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>