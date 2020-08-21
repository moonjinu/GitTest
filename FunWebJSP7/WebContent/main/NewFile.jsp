<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"/>
	<title>Kakao 지도 시작하기</title>
</head>
<body>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false">

   function zip_pop(a,b,c){

    //load함수를 이용하여 core스크립트의 로딩이 완료된 후, 우편번호 서비스를 실행합니다.

    daum.postcode.load(function(){

        new daum.Postcode({

            oncomplete: function(data) {

          var chkinfo = '';        

            document.getElementById(a).value = data.zonecode;

      document.getElementById(b).value= data.roadAddress;

      document.getElementById(c).focus();

            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.

         //  http://postcode.map.daum.net/guide

            // 예제를 참고하여 다양한 활용법을 확인해 보세요.

            }

        }).open();

    });

    }

</script>
<form action="main.jsp" method="post">
  <button type="button" class="addr_btn" onclick="zip_pop('zip1_1','addr_1','addr_2');return false;">주소찾기</button>

<input type="text" name="addr_1" id="addr_1" readonly="readonly"  onclick="zip_pop('zip1_1','addr_1','addr_2');return false;" class="inp w385 btn100">

<input type="text" name="addr_2" id="addr_2" class="inp w385 btn100 inp_addr2"> <br>
 
 <input type="submit">

</form>
</body>
</html>