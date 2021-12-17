<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
table {
	background: white;
}
</style>

<h3 style="font-size: 15px; padding-top: 10px;"><i class="icofont-double-right"></i> 쿠폰 정보</h3>
	<table class="table border mx-auto my-10">
		<c:forEach var="dto" items="${list}">
		<tr>
			<td class="wp-15 text-center pe-7 bg">쿠폰 할인가격</td>
			<td class="wp-35 text-center ps-5">${dto.coupon} 원 할인쿠폰</td>
		</tr>
		<tr>
			<td class="wp-15 text-center pe-7 bg">쿠폰 발급날짜</td>
			<td class="wp-35 text-center ps-5">${dto.startDate} </td>
		</tr>
		<tr>
			<td class="wp-15 text-center pe-7 bg">쿠폰 만료날짜</td>
			<td class="wp-35 text-center ps-5">${dto.endDate} </td>
		</tr>
		<tr>
			<td colspan="2" class="bg">
				<button type="button" class="btn btn-light btnUpdate" onclick="location.href='${pageContext.request.contextPath}/admin/couponManage/update?couponNum=${dto.couponNum}'">수정</button>
				<button type="button" class="btn btn-light btnDelete" data-couponNum='${dto.couponNum}'>삭제</button>
			</td>
		</tr>
		</c:forEach>
	</table>

