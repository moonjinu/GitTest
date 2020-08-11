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
	<h1>WebContent/board/deletePro.jsp</h1>
	
	<%
		// 한글처리
		request.setCharacterEncoding("UTF-8");
		// 전달되는 데이터 처리 bno, passwd, pageNum
		int bno = Integer.parseInt(request.getParameter("bno"));
		String passwd = request.getParameter("passwd");
		String pageNum = request.getParameter("pageNum");
		
		// DAO 처리객체 -> deleteBoard(bno, passwd)
		// 정수형 타입 데이터로 리턴
		
		BoardDAO bdao = new BoardDAO();
		int result = bdao.deleteBoard(bno, passwd);
		
		if(result == 1){ // 정상처리
		%>
		<script type="text/javascript">
			alert("삭제되었습니다.");
			location.href="boardList.jsp?pageNum=<%=pageNum%>";
		</script>
		<%
		}else if(result == 0) { 
		%>
		<script type="text/javascript">
			alert("글 비밀번호 오류입니다.");
			history.back();
		</script>
		<%
		}else{ // result == -1
		%>
		<script type="text/javascript">
			alert("존재하지 않는 글입니다.");
			history.back();
		</script>
		<%
		}
		
		
			
	
	%>
	
	
	

</body>
</html>