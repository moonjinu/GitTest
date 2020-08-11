<%@page import="java.util.ArrayList"%>
<%@page import="com.itwillbs.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	BoardDAO bdao = new BoardDAO();
	
	int cnt = bdao.getBoardCount();
	// 페이지 글 개수
	int pageSize = 10;
	
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	// 현제 페이지
	int currentPage = Integer.parseInt(pageNum);
	// 시작 행 번호
	int startRow = (currentPage -1) * pageSize + 1;
	// 끝 행번호
	int endRow = currentPage * pageSize;
	
	//////////////////////////페이징처리////////////////////////////
	
	ArrayList boardList = null;
	
	if(cnt != 0){
		boardList = bdao.getBoardList(startRow, pageSize);
	}
	
	%>
	

</body>
</html>