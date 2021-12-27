<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.img {
	width: 180px;
	height: 250px;
}

.table td {
	overflow:hidden;
	white-space : nowrap;
	text-overflow: ellipsis;
}
</style>
<h3 style="font-size: 15px; padding-top: 10px;"><i class="icofont-double-right"></i> 공연 정보</h3>
<table class="table border mx-auto my-10" style="table-layout: fixed;">
	<tr>
		<td rowspan="5" style="width: 23%; text-align:center;">
			<img class="img" src="${pageContext.request.contextPath}/uploads/performance/${dto.postFileName}">
		</td>
		<td class="wp-15 text-right pe-7 bg">공연제목</td>
		<td class="wp-25 ps-5" title="${dto.subject}">${dto.subject}</td>
		<td class="text-right pe-7 bg">평점</td>
		<td class="ps-5">${dto.rating}</td>
	</tr>
	<tr>
		<td class="text-right pe-7 bg">공연장</td>
		<td class="ps-5">${dto.hallName}</td>
		<td class="text-right pe-7 bg">상영관</td>
		<td class="ps-5">${dto.theater}</td>
	</tr>
	<tr>
		<td class="text-right pe-7 bg">공연기간</td>
		<td class="ps-5">${dto.startDate} ~ ${dto.endDate}</td>
		<td class="text-right pe-7 bg">관람연령</td>
		<td class="ps-5">${dto.rate}</td>
	</tr>
	<tr>
		<td class="text-right pe-7 bg">카테고리</td>
		<td class="ps-5">${dto.category}</td>
		<td class="text-right pe-7 bg">장르</td>
		<td class="ps-5">${dto.genre}</td>
	</tr>
	<tr>
		<td class="text-right pe-7 bg">출연진</td>
		<td class="ps-5">${dto.actorName}</td>
		<td class="text-right pe-7 bg">가격</td>
		<td class="ps-5">${dto.price}</td>
	</tr>
</table>

<h3 style="font-size: 15px; padding-top: 10px;"><i class="icofont-double-right"></i> 공연 일정</h3>
