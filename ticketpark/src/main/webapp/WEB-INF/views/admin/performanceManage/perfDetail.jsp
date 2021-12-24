<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<h3 style="font-size: 15px; padding-top: 10px;"><i class="icofont-double-right"></i> 공연 정보</h3>
<table class="table border mx-auto my-10">
	<tr>
		<td class="wp-15 text-right pe-7 bg">글번호</td>
		<td class="wp-35 ps-5">${dto.listNum}</td>
		<td class="wp-15 text-right pe-7 bg">공연제목</td>
		<td class="wp-35 ps-5">${dto.subject}</td>
	</tr>
	<tr>
		<td class="text-right pe-7 bg">공연장</td>
		<td class="ps-5">${dto.hallrName}</td>
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
		<td class="text-right pe-7 bg">평점</td>
		<td class="ps-5">${dto.rating}</td>
	</tr>
	
</table>
