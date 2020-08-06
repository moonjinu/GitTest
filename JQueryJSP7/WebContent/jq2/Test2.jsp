<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
* {
	margin: 5px;
	padding: 5px;
	border: 3px solid black;
}
</style>
<script src="../js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		// 이미지 클릭 시 그림을 변경 =>(src 속성 값을 변경)
		// attr();
		$('img').click(function() {
			$('img').attr('src', '6.jpg');
		});

		// mouseover 6.jpg
		// 		$('img').mouseover(function(){
		// 			$(this).attr('src','6.jpg');
		// 		});
		// 		// mouseout 1.jpg
		// 		$('img').mouseout(function(){
		// 			$(this).attr('src','1.jpg');
		// 		});

		///////////////////////////////////////////////////

		// 체이닝 기법
		$('img').mouseover(function() {
			$(this).attr('src', '1.jpg');
		}).mouseout(function() {
			$(this).attr('src', '6.jpg');
		});
		
		// a 링크 클릭 시 배경색을 파랑으로 변경
		$('a').click(function(event){
			$(this).css('background-color','blue');
			
			// a링크 기본기능 - 하이퍼링크를 막음.(페이지 이동x)
			// event.preventDefault();
			
			// event.stopPropagation();
			
			// return false; -> 페이지 이동x
			// return true; / return;
		});
		
		//////////////////////////////////////////////////////
		
		// h2 태그 클릭 시 '+' 기호 추가
		
		$('h2').click(function(){
			// $(this).append("+");
			// event.preventDefault();

			$(this).html(function(index,text){
				
				return text+"@";
			});
			
			// 해당 이벤트 종료
			$(this).unbind();
			
		});
		

	});
</script>
</head>
<body>
	<h1>WebContent/jq2/Test2.jsp</h1>

	<img src="1.jpg">
	<img src="2.jpg">

	<h2>이벤트 막기</h2>
	<a href="http://www.naver.com">네이버</a>
</body>
</html>