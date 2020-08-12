<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	// CDATA : (UnParsed Character DATA)
	// => 코드가 태그를 포함하거나, 연산(부등호)을 포함할 때, 일반 문자로 인식하도록 처리(주로 '>' 부등호 사용 시 )
	// PCDATA : (Parsed Character DATA)
	// => 코드가 태그를 포함하거나, 연산(부등호)을 포함할 때, 코드 그대로 인식하도록 처리(실제 태그 사용 시 )

	// <![CDATA[

	// setInterval("스크립트 실행문",시간(1/1000))
	// => 일정 시간마다 코드를 실행 가능
	var i = 0;
	var s = setInterval("console.log(i++)", 1000);

	//]]>

	// clearInterval(실행중인 객체 정보)
	// => 작업 종료
	// clearInterval(s);

	$(document).ready(function() {

		// setInterval() 사용
		// 이미지 위치 변경

		// 이미지 태그의 가로길이 250 지정
		$('img').css('width', 250);

		setInterval(function() {
			$('body').append($('img').first());
		}, 1);

	});
</script>
</head>
<body>
	<!-- 	<h1>WebContent/jq/Test7.jsp</h1>
	
	<input type="button" value="정지" onclick="clearInterval(s);">
-->
	<img src="1.jpg">
	<img src="2.jpg">
	<img src="1.jpg">
	<img src="2.jpg">
	<img src="1.jpg">
	<img src="2.jpg">
	<img src="1.jpg">

</body>
</html>