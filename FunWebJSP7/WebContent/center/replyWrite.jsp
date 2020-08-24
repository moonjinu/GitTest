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
      // 한글처리
      request.setCharacterEncoding("UTF-8");      
    %>
    <!-- 전달되는 정보를 BoardBean 객체에 저장(액션태그) -->
    <jsp:useBean id="bb1" class="com.itwillbs.board.ReplyBean"/>
    <jsp:setProperty property="*" name="bb1"/>
 
    <%
       BoardDAO bdao = new BoardDAO();
       bdao.insertReply(bb1);
       
       // 페이지 이동(content.jsp)
       response.sendRedirect("content.jsp");
    %>
</body>
</html>