<%@page import="com.itwillbs.board.BoardBean"%>
<%@page import="com.itwillbs.db.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>WebContent/board/writePro.jsp</h1>
	
	<%
		// 글쓰기 처리 (입력창에서 받은 데이터를 DB로 이동 -> 글 목록)
		
		// 한글처리
		request.setCharacterEncoding("UTF-8");
		
		// 전달되는 데이터(파라미터) 저장
		
		// => 액션 태그(자바빈 객체에 저장 - BoardBean)
	%>
		<jsp:useBean id="board" class="com.itwillbs.board.BoardBean"/>
	<%
		// -> BoardBean board = new BoardBean();
	%>
		<jsp:setProperty property="*" name="board"/>
	<%
		// String name = request.getParameter("name");
		// board.setName(name);
		
		// 전달 정보 확인 출력
		System.out.println(board); // board.toString()동일 동작
		
		// IP 정보를 추가 (request)
		// System.out.println(request.getRemoteAddr());
		board.setIp(request.getRemoteAddr());
		
		// 전달 정보 확인 출력
		System.out.println(board); // ip주소 포함o
		
		///////////////////////////////////////////////////////////////////////////////////////
		
		// DB처리 작업 객체 생성 BoardDAO
		
		BoardDAO bdao = new BoardDAO();
		
		// DAO객체 안에 있는 메서드중 글쓰기 기능을 하는 메서드 호출
		// insertBoard(글정보)
		bdao.insertBoard(board);
		
		// 페이지 이동 (목록 페이지)
		response.sendRedirect("boardList.jsp");
		
	
	%>


	
	
	
</body>
</html>