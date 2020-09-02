<%@page import="java.util.ArrayList"%>
<%@page import="com.itwillbs.board.BoardBean"%>
<%@page import="java.util.List"%>
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
			 // BoardDAO 객체 생성
			 BoardDAO bdao = new BoardDAO();
			 // 테이블에 저장된 글의 개수 계산 메서드
			 // getBoardCount()
			 int count = bdao.getBoardCount();
			// ---------------------------------페이징 처리---------------------------------------------------------------
				
			// 한 페이지에서 보여줄 글의 개수 설정
			int pageSize = 10;
			// 현 페이지의 페이지값을 확인
			String pageNum = request.getParameter("pageNum");
			if(pageNum == null){ // 페이지 정보가 없을 경우 항상 1페이지
				pageNum = "1";
			}
			
			// 시작 행번호 계산 1...10, 11...20, 21...30, 31...40, ...		
			int currentPage = Integer.parseInt(pageNum);
			
			int startRow = (currentPage-1)*pageSize+1;
			
			// 끝 행번호 계산
			int endRow = currentPage * pageSize;
			
			// ---------------------------------페이징 처리---------------------------------------------------------------
			
			 
             ArrayList boardList = null;			 
			 if(count != 0){
			 // 글이 있을경우 모든 글의 정보를 가져오는 메서드
				 boardList = bdao.getBoardList(startRow, pageSize);
			 }
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
				<li><a href="writeForm.jsp">글쓰기</a></li>
				<li><a href="notice.jsp">글 목록 보기</a></li>
				<li><a href="../fileUp/up.jsp">파일업로드/다운로드</a></li>
				<li><a href="#">Service Policy</a></li>
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->

		<!-- 게시판 -->
		<article>
			<h1>
				게시판 [글 :<%=count%>개]
			</h1>
			<table id="notice">
				<tr>
					<th class="tno">No.</th>
					<th class="ttitle">Title</th>
					<th class="twrite">Writer</th>
					<th class="tdate">Date</th>
					<th class="tread">Read</th>
				</tr>

				<%
					for (int i = 0; i < boardList.size(); i++) {
						BoardBean bb = (BoardBean) boardList.get(i);
				%>
				<tr>
					<td><%=bb.getBno()%></td>
					<td class="left">
			<%
				// 답글 들여쓰기 처리
				int wid = 0;
				// 답글일때
				if(bb.getRe_lev()>0){
					wid = 10 * bb.getRe_lev();
			%>
				<img src="level.gif" width="<%=wid %>" height="15">
				<img src="re.gif">
			<% }%>
				<a href="content.jsp?bno=<%=bb.getBno()%>&pageNum=<%=pageNum%>"><%=bb.getSubject()%></a>
			</td>
					<%-- <td class="left"><%=bb.getSubject()%></td> --%>
					<td><%=bb.getName()%></td>
					<td><%=bb.getDate()%></td>
					<td><%=bb.getReadcount()%></td>
				</tr>
				<%
					}
				%>
			</table>
			<div id="table_search">
			<form action="search.jsp" method="get">
				<select name="search">
				<option value="none" id="1">전체목록</option>
				<option value="id" id="2">작성자</option>
				<option value="subject" id="3">제목</option>
				<option value="content">내용</option>
				<option value="subject+content">제목+내용</option>
				</select>
				<input type="text" class="input_box" name="word"> 
				<input type="submit" value="search" class="btn">
			</form>
			</div>
			<!-- 페이지 이동  -->
			<div class="clear"></div>
			
			<div id="page_control">
			<%
		// 다른페이지 이동버튼
		
		if(count !=0){
			// 전체 페이지수 - 글 50, 화면에 10개씩 출력 => 5페이지
			// 			- 글 56, 화면에 10개씩 출력 => 6페이지
			
			int pageCount = count/pageSize+(count % pageSize == 0? 0:1);
			
			// 한 화면에 보여줄 페이지 번호 개수
			int pageBlock = 10;
			
			// 페이지 블럭의 시작 페이지 번호
			int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
			
			// 페이지 블럭의 끝 페이지 번호
			int endPage = startPage+pageBlock-1;
			if(endPage > pageCount){
				endPage = pageCount;
			}
			// 이전
			if(currentPage !=1){
				%>
				<a href="notice.jsp?pageNum=<%=currentPage-1%>">Prev</a>
				<%
			}
			
			// 숫자(1...10, 11...20, ...)
			for(int i=startPage;i<=endPage;i++){
				%>
				<a href="notice.jsp?pageNum=<%=i%>"><%=i %></a>
				<%
				
			}
			// 다음
			if(currentPage < endPage ){
				%>
				<a href="notice.jsp?pageNum=<%=currentPage+1%>">Next</a>
				<%
			}
		}
	
	
	
	%>
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