<!--  2021.11.30 강보석 -->
<!-- 2022.02.08 한건희 수정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!-- pageNoMax에는 화면에 표시할 item의 최대 갯수를 대입한다. -->
<c:set var="pageNoMax" value="8" />
<!-- itemSize에는 표시할 item의 size를 대입한다. -->
<c:set var="itemSize" value="${questionList.size()}" />
<!-- itemList에는 java에서 바인딩한 Map 객체를 대입한다. -->
<c:set var="itemList" value="${questionList}" />
<c:if test='${not empty pageNo}'>
	<script>
		window
				.addEventListener(
						'load',
						function() {
							if (document.getElementById("${pageNo}")) {
								document.getElementById("${pageNo}").style.fontFamily = "kopub_bold";
								document.getElementById("${pageNo}").style.fontSize = "15px";
							}
						});
	</script>
</c:if>
<c:if test='${not empty message }'>

	<script>
		alert("${message}");
	</script>
	<%
	session.removeAttribute("message");
	%>
</c:if>



<div class="container-fluid">

	<div class="row">
		<div class="col-lg-4 offset-lg-4 text-center">
			<h1 class="page_title">마이페이지</h1>
		</div>
	</div>

	<div class="row">
		<div class="offset-lg-2 col-lg-8 text-left cs_01_subtitle">
			<h3>${userInfo.user_name}  님의 문의내역</h3>
		</div>
	</div>
	
	<div class="row">
		<div class="offset-lg-2 col-lg-1 text-center cs_01_01header">
			<span>작성일자</span>
		</div>
		<div class="col-lg-1 text-center cs_01_01header">
			<span>분류</span>
		</div>
		<div class="col-lg-1 text-center cs_01_01header">
			<span>문의 번호</span>
		</div>
		<div class="col-lg-3 text-center cs_01_01header">
			<span>문의 제목</span>
		</div>
		<div class="col-lg-2 text-center cs_01_01header">
			<span>진행 상태</span>
		</div>
	</div>

	<c:choose>
		<c:when test="${empty itemList}">
			<div class="row">
				<div class="offset-lg-2 col-lg-8 text-center cs_02_listsection">
					<span>작성된 상품 문의가 없습니다.</span>
				</div>
			</div>
		</c:when>
		<c:when test="${not empty itemList}">
			<c:forEach var="i" begin="1" end="${itemSize}">
				<c:set var="desc" value="${itemSize - i + 1}" />
				<c:set var="j" value="${(pageNoMax - pageNo * pageNoMax) + desc}" />
				<div class="row">
					<div class="offset-lg-2 col-lg-1 text-center cs_02_listsection">
						${itemList[j-1].notice_cre_date}
					</div>
					<div class="col-lg-1 text-center cs_02_listsection">
						<c:if test="${itemList[j-1].notice_category == 'PQA'}">
							<span>상품문의</span>
						</c:if>
						<c:if test="${itemList[j-1].notice_category == 'UQA'}">
							<span>1:1문의</span>
						</c:if>
					</div>
					<div class="col-lg-1 text-center cs_02_listsection">
						<span class="myQuestionListId">${itemList[j-1].notice_id.split('_')[1]}</span>
					</div>
					<div class="col-lg-3 text-center cs_02_listsection">
						<a class="myQuestionTitle" href="${contextPath}/myPage/myQuestion/QuestionDetail.do?notice_id=${itemList[j-1].notice_id}">${itemList[j-1].notice_title}</a>
					</div>
					<div class="col-lg-2 text-center cs_02_listsection">
						<span>진행 상태</span>
					</div>
				</div>
			</c:forEach>
		</c:when>
	</c:choose>

	<c:if test="${itemSize > pageNoMax}">

		<div class="row">

			<div class="col-lg-12 text-center admin_product_page_index">
				<a href="#" onclick="pageMove(this.id)" id="이전">이전</a>
				<c:if test="${itemSize > pageNoMax}">

					<c:set var="maxNo" value="${itemSize+pageNoMax-1}" />

					<c:forEach var="x" begin="1" end="${maxNo / pageNoMax}">
						<fmt:parseNumber type="number" integerOnly="true" var="noFlag"
							value="${(pageNo+pageNoMax-1) / pageNoMax}" />
						<c:if
							test="${(noFlag * pageNoMax) - (pageNoMax-1) <= x and x <= (noFlag * pageNoMax)}">
							<a href="#" onclick="pageMove(this.id)" id="${x}">${x}</a>
						</c:if>
					</c:forEach>

				</c:if>

				<a href="#" onclick="pageMove(this.id)" id="다음">다음</a>
			</div>

		</div>

	</c:if>

</div>

<script>
//페이지 이동 스크립트
function pageMove(no) {
	var getValue = 0;
	var lastPage = parseInt(${itemSize+pageNoMax-1} / ${pageNoMax});
	if(no == "이전" || no == "다음") {
		var uriValue = window.location.search;
		
		var array = uriValue.split("pageNo=");
		if(array[1] == "" || array[1] == null) {
			array[1] = 1;
		}
		getValue = array[1];
	}

	
	if(no == "이전") {
		if(getValue == 1) {
			alert("마지막 페이지 입니다.");
		}
		else {
		document.location='${contextPath}/myPage/myQuestion.do?pageNo='+(--getValue);
		}
	}
	else if (no == "다음") {
		if(getValue == lastPage) {
			alert("마지막 페이지 입니다.");
		}
		else {
		document.location='${contextPath}/myPage/myQuestion.do?pageNo='+(++getValue);
		}
	}
	else {
		document.location='${contextPath}/myPage/myQuestion.do?pageNo='+no;
	}
}
</script>

