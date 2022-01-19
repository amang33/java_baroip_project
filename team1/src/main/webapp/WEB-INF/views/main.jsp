<!-- 2021.11.24 윤상현 -->
<!-- 2021.12.03 한건희 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"
	import="java.net.URLEncoder, java.net.URL, 
   java.net.HttpURLConnection, java.io.BufferedReader, java.io.InputStreamReader"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!-- pageNoMax에는 화면에 표시할 item의 최대 갯수를 대입한다. -->
<c:set var="pageNoMax" value="3" />
<!-- itemList에는 표시할 item의 size를 대입한다. -->
<c:set var="itemList" value="${bestProducts.size()}" />

<%
String clientId = "metNeTJSOQeJYHhl4Gnd";//애플리케이션 클라이언트 아이디값";
String clientSecret = "3aIeVQlJZY";//애플리케이션 클라이언트 시크릿값";
String code = request.getParameter("code");
String state = request.getParameter("state");
String redirectURI = URLEncoder.encode("http://localhost:8080/baroip/main.do", "UTF-8");
String apiURL;
apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
apiURL += "client_id=" + clientId;
apiURL += "&client_secret=" + clientSecret;
apiURL += "&redirect_uri=" + redirectURI;
apiURL += "&code=" + code;
apiURL += "&state=" + state;
String access_token = "";
String refresh_token = "";
System.out.println("apiURL=" + apiURL);
try {
	URL url = new URL(apiURL);
	HttpURLConnection con = (HttpURLConnection) url.openConnection();
	con.setRequestMethod("GET");
	int responseCode = con.getResponseCode();
	BufferedReader br;
	System.out.println("responseCode=" + responseCode);
	if (responseCode == 200) { // 정상 호출
		br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	} else { // 에러 발생
		br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	}
	String inputLine;
	StringBuffer res = new StringBuffer();
	while ((inputLine = br.readLine()) != null) {
		res.append(inputLine);
	}
	br.close();
	if (responseCode == 200) {
		System.out.println(res.toString());
	}
} catch (Exception e) {
	System.out.println(e);
}
%>

<div class="main-section">
	<div class="container-fluid">
		<!--page slider -->
		<div class="post-slider">

			<div class="post-wrapper">
				<div class="post">
					<img src="${contextPath}/resources/img/common/mainImage1.jpg"
						class="slider-image" alt="메인 이미지">

				</div>
				<div class="post">
					<img src="${contextPath}/resources/img/common/mainImage2.jpg"
						class="slider-image" alt="메인 이미지">
				</div>

				<div class="post">
					<img src="${contextPath}/resources/img/common/mainImage3.jpg"
						class="slider-image" alt="메인 이미지">
				</div>

				<div class="post">
					<img src="${contextPath}/resources/img/common/mainImage4.jpg"
						class="slider-image" alt="메인 이미지">

				</div>
			</div>
		</div>
		<!--post slider-->
	</div>
</div>
<br>

<!-- product section -->

<div class="product-section">
	<div class="container-fluid">

		<div class="row">
			<div class="col-lg-4 offset-lg-1 main-section-solid">
				<hr>
			</div>

			<div class="col-lg-2 text-center">
				<div class="section-title">BEST ITEM</div>
			</div>

			<div class="col-lg-4 main-section-solid">
				<hr>
			</div>
		</div>
		<br>
	</div>
</div>
<c:if test="${empty bestProducts}">
	<br>
	<div class="col-lg-12 text-center">등록된 상품이 없습니다.</div>
</c:if>



<div class="container">
	<div class="row">
		<c:if test="${not empty bestProducts}">
			<c:forEach var="i" begin="1" end="${itemList}">
				<c:set var="key" value="product${i}" />

				<div class="col-lg-4">



					<div class="product_01_image">
						<a
							href="${contextPath}/product/productDetail.do?product_id=${bestProducts[key].product_id}">
							<img src="data:image/jpeg;base64,${bestProducts[key].image_file}"
							alt="상품 이미지">
						</a>
					</div>

					<div class="row item-format">

						<div class="col-lg-6">
							<a
								href="${contextPath}/product/productDetail.do?product_id=${bestProducts[key].product_id}">
								<span class="item-title">${bestProducts[key].product_main_title}</span>
								<br> <span class="item-comment">${bestProducts[key].product_sub_title}</span>
							</a>
						</div>

						<div class="col-lg-3 main_item_bottom_text">
							<span class="item-price"><fmt:formatNumber
									value="${bestProducts[key].product_price}" />원</span> <span
								class="item-dc"><fmt:formatNumber
									value="${bestProducts[key].product_discount}" />원</span> <br> <span
								class="item-real-price"><fmt:formatNumber
									value="${bestProducts[key].product_price-bestProducts[key].product_discount}" />원</span>
						</div>

						<div class="col-lg-3 text-right">
							<button class="main_cartImage" id="main_cartImage${i}"
								type="button" value="${bestProducts[key].product_id}">
								<img src="${contextPath}/resources/img/common/cart-put-icon.png"
									alt="카트 담기 버튼 이미지">
							</button>
							<input id="main_bestItemTitle${i}" type="hidden"
								value="${bestProducts[key].product_main_title}">
						</div>

					</div>

				</div>


			</c:forEach>
		</c:if>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$('.post-wrapper').slick({
			slidesToShow : 1,
			slidesToScroll : 1,
			autoplay : true,
			autoplaySpeed : 6000,
			nextArrow : $('.next'),
			prevArrow : $('.prev'),
		});
	});
</script>
<!-- 2022.01.10 한건희 -->
<c:if test="${not empty bestProducts}">
	<c:forEach var="i" begin="1" end="${itemList}">
		<c:set var="key" value="product${i}" />
		<script>
			$("#main_cartImage${i}").on("click", function(e) {
				let product_id = $("#main_cartImage${i}").val();
				let product_title = $("#main_bestItemTitle${i}").val();
				let userFind = "${userInfo.user_id}";
				/* 비로그인 시 팝업창 */
				if (userFind == null || userFind == "") {
					let notUser = confirm("현재 비회원 상태 입니다. 비회원으로 주문 하시겠습니까?확인(예), 취소(로그인 or 회원가입)");
					if (notUser == false) {
						location = '${contextPath}/user/login_01.do';
					} else {
						$.ajax({
							url : "${contextPath}/cart/addProductInCart.do",
							type : "GET",
							dataType : "text",
							data : {
								"product_id" : product_id,
								"cart_count" : 1
							},
							success : function(find) {
								let cartGo;
								let cartIn;
								/* 해당 상품이 장바구니에 있을 경우 수량 변경 여부 */
								if (find == "overLapProduct") {
								cartIn = confirm("장바구니에 해당 상품이 있습니다. 수량을 추가하시겠습니까?");
								if (cartIn == true) {
									$.ajax({
										url : '${contextPath}/cart/cartInProductOverLap.do',
										type : 'GET',
										dataType : 'text',
										data : {
											"product_id" : product_id,
											"cart_count" : 1,
										},success : function() {
											alert("추가 완료");
										}
									}).error(function() {
											alert('수량 변경이 실패했습니다. 잠시 후 다시 시도해 주세요.');
										});
									}
								} else {
									cartGo = confirm(product_title + "(을)를 장바구니에 추가되었습니다. 장바구니로 이동하시겠습니까?");
									if (cartGo == true) {
										location = '${contextPath}/cart/cartList.do';
									}
								}
							}
						}).error(function() {
							alert('장바구니에 담기 실패했습니다. 잠시 후 다시 시도해 주세요.');
						});
					}
				} else {
					$.ajax({
						url : "${contextPath}/cart/addProductInCart.do",
						type : "GET",
						dataType : "text",
						data : {
							"product_id" : product_id,
							"cart_count" : 1
						},success : function(find) {
							let cartGo;
							let cartIn;
							/* 해당 상품이 장바구니에 있을 경우 수량 변경 여부 */
							if (find == "overLapProduct") {
								cartIn = confirm("장바구니에 해당 상품이 있습니다. 수량을 추가하시겠습니까?");
								if (cartIn == true) {
									$.ajax({
										url : '${contextPath}/cart/cartInProductOverLap.do',
										type : 'GET',
										dataType : 'text',
										data : {
											"product_id" : product_id,
											"cart_count" : 1,
										},success : function() {
											alert("추가 완료");
											}
										}).error(function() {
											alert('수량 변경이 실패했습니다. 잠시 후 다시 시도해 주세요.');
										});
									}
								} else {
									cartGo = confirm(product_title + "(을)를 장바구니에 추가되었습니다. 장바구니로 이동하시겠습니까?");
									if (cartGo == true) {
										location = '${contextPath}/cart/cartList.do';
									}
								}
							}
						}).error(function() {
							alert('장바구니에 담기 실패했습니다. 잠시 후 다시 시도해 주세요.');
						});
					}
				});
		</script>
	</c:forEach>
</c:if>
