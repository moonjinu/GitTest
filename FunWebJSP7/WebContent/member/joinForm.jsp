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



<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c29373c96ad3e93a2e9ef2415b158ee9&libraries=services"></script>
<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });


    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample5_address").value = addr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {

                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                       
                    }
                });
            }
        }).open();
    }
</script>
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

         //  

            // 예제를 참고하여 다양한 활용법을 확인해 보세요.

            }

        }).open();

    });

    }

</script>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
   <jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
	<nav id="sub_menu">
		<ul>
		<li><a href="joinForm.jsp">회원가입</a></li>
		<li><a href="#">Privacy policy</a></li>
		</ul>
	</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
		<article>
		<h1>회원 가입</h1>
	<form action="joinPro.jsp" name="fr" method="post" id="join" onsubmit="return check()">
		<fieldset>
		<legend>Basic Info</legend>
		<label>User ID</label>
		<input type="text" name="id" class="id">
		<input type="button" value="중복체크" class="dup" onclick="winopen();"><br>
		<label>Password</label>
		<input type="password" name="pass"><br>
		<label>Retype Password</label>
		<input type="password" name="pass2"><br>
		<label>Name</label>
		<input type="text" name="name"><br>
		<label>E-Mail</label>
		<input type="email" name="email"><br>
		<label>Birth</label>
		<input type="text" name="birth"><br>
		<label>Gender</label>
		<input type="radio" name="gender" value="남">남
		<input type="radio" name="gender" value="여">여		
		<br>
		</fieldset>
		
		<fieldset>
		<legend>Optional</legend>
		<label>Address</label>
		<input type="text" name="addr" id="sample5_address" placeholder="주소">
		<input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색"><br>
		
		<label>Phone Number</label>
		<input type="text" name="phone"><br>
		<label>Mobile Phone Number</label>
		<input type="text" name="mobile"><br>
		</fieldset>
		<div class="clear"></div>
		<div id="buttons">
		<input type="submit" value="Submit" class="submit">
		<input type="reset" value="Cancel" class="cancel">
		</div>
		
	</form>
		</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
    <jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
   <script type="text/javascript">
      /* 사용자가 회원 가입시  */
      // 데이터 빈공백 체크
      // 가입조건 만족(ex.. 아이디가 최소 5자리 이상,영문자/숫자 사용)
      // 추가 정보는 입력을 안해도 됨
      
      function check(){
    	  // alert("테스트");
    	  // 아이디가 입력이 안되있을경우 "아이디를 입력하시오!"
    	  if(document.fr.id.value.length <= 0){
    		  alert("아이디를 입력하세요");
    		  document.fr.id.focus();
    		  return false;
    	  }
      }/////////////////////////////////
      
      function winopen(){
    	  // id를 입력하는 텍스트 상자에 값이 비어있는지 없는지 판단
    	  // 값이 비어있을경우 "ID를 입력하시오", focus(), 진행 X
    	  // 값이 있을경우 진행O
    	  
    	  if(document.fr.id.value == ""){
    		  alert(" 아이디를 입력하세요 ");
    		  document.fr.id.focus();
    		  return;
    	  }
    	  // 새창을 열어서 페이지 오픈 => 회원 아이디 정보 중복체크
    	  // 페이지 이동시 입력한 ID값 가지고 이동
    	  
    	  var id = document.fr.id.value;
    	  window.open("joinIdCheck.jsp?userid="+id,"","width=400,height=200");
    	  
      }
      
      
   </script>


</body>
</html>