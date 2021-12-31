<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.map {
	width: 70%;
	height: 450px;
	border: 1px solid #777;
	margin: 0 auto;
}

.maker-info {
	cursor: pointer;
	font-size: 11px;
	font-weight: 600;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	line-height: 1.5;
	padding: 5px;
}

.article-table td {
	vertical-align: middle;
}

.article-table td:first-child {
	text-align: center;
	vertical-align: middle;
}

.article-content {
	width: 70%;
	margin: 0 auto;
}

.article-content p {
	color: black;
}
.hall-img{width: 300px;}
</style>

<script type="text/javascript">
function deleteOk() {

    if(confirm("공연장을 삭제하시겠습니까 ? ")) {
		var query = "hNum=${dto.hNum}&${query}";
	    var url = "${pageContext.request.contextPath}/hall/delete?" + query;
  	  location.href=url;
    }
}
</script>

<div class="container">
	<div class="body-container">
		<div class="body-title">
			<h3>${dto.hallName} 정보</h3>
		</div>

		<table class="table article-table">
			<tbody>
				<tr>
					<td rowspan="3" class="hall-img">
						<div id="carouselExampleIndicators" class="carousel slide"
							 data-ride="carousel">
							<ol class="carousel-indicators">
								<c:forEach var="dto" items="${listFile}" varStatus="status">
									<li data-target="#carouselExampleIndicators"
										data-slide-to="${status.index}"
										class="${status.index == 0 ? 'active' : ''}"></li>
								</c:forEach>

							</ol>

							<div class="carousel-inner">
								<c:forEach var="dto" items="${listFile}" varStatus="status">
									<div class="carousel-item ${status.index == 0 ? 'active' : ''}">
										<img src="${pageContext.request.contextPath}/uploads/hall/${dto.saveFilename}">
									</div>
								</c:forEach>
							</div>

							<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
								<span class="carousel-control-prev-icon" aria-hidden="true"></span>
								<span class="sr-only">Previous</span>
							</a>
							<a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
								<span class="carousel-control-next-icon" aria-hidden="true"></span>
								<span class="sr-only">Next</span>
							</a>
						</div>
					</td>
				</tr>

				<tr>
					<td class="table-light col-sm-2" scope="row">주 소</td>
					<td colspan="3">${dto.addr}</td>
				</tr>

				<tr>
					<td class="table-light col-sm-2" scope="row">전화번호</td>
					<td>${dto.tel}</td>
					<td class="table-light col-sm-2 text-center" scope="row">홈페이지</td>
					<td><a href="${dto.link}">${dto.link}</a></td>
				</tr>

			</tbody>
		</table>

		<div class="article-content">
			<p>${dto.content}</p>
		</div>

		<div id="map" class="map mb-3"></div>

		<table class="table table-borderless">
			<tr>
				<td width="50%"><c:choose>
						<c:when test="${sessionScope.member.membership>50}">
							<button type="button" class="btn btn-outline-secondary"
								onclick="location.href='${pageContext.request.contextPath}/hall/update?hNum=${dto.hNum}&page=${page}';">수정</button>
						</c:when>
						<c:otherwise>
							<button type="button" class="btn btn-outline-secondary" hidden="hidden">수정</button>
						</c:otherwise>
					</c:choose> <c:choose>
						<c:when test="${sessionScope.member.membership>50}">
							<button type="button" class="btn btn-outline-secondary" onclick="deleteOk();">삭제</button>
						</c:when>
						<c:otherwise>
							<button type="button" class="btn btn-outline-secondary" hidden="hidden">삭제</button>
						</c:otherwise>
					</c:choose></td>
				<td class="text-right">
					<button type="button" class="btn btn-outline-secondary"
						onclick="location.href='${pageContext.request.contextPath}/hall/list?${query}';">리스트</button>
				</td>
			</tr>
		</table>

	</div>
</div>

<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f6a505790b28224909b891ae566ffbb1&libraries=services"></script>
<script type="text/javascript">
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = { 
    center: new kakao.maps.LatLng(${dto.latitude}, ${dto.longitude}), // 지도의 중심좌표
    level: 3 // 지도의 확대 레벨
};

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

//마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(${dto.latitude}, ${dto.longitude}); 

//마커를 생성합니다
var marker = new kakao.maps.Marker({
position: markerPosition
});

//마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

</script>