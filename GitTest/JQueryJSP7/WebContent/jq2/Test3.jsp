<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		// textarea 글자 입력 시 마다 h2 태그에 있는 숫자를 감소
		$('textarea').keyup(function(){
			// 입력창에 입력된 글자를 전부 가져오기
			var tmp = $(this).val().length;
			// h2 값을 읽어 와서 변경
// 			$('h2').html(function(index, text){
// 				return 200-tmp;
// 			});
			$('h2').html(200-$(this).val().length);
			
			// 추가기능
			// 입력된 글자수가 200 이상 -> red, 미만 -> black
			
			var value = $(this).val().length;
			if(value >= 200 ){
				$('h2').css('color','black');
			}else{
				$('h2').css('color','red');
				
			}
		});
		

	});
</script>
</head>
<body>
	<h1>WebContent/jq2/Test3.jsp</h1>
	<div>
		<h2>200</h2>
		<textarea rows="5" cols="50"></textarea>
	</div>
</body>
</html>