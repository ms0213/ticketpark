<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:forEach var="dto" items="${couponList}" varStatus="status">
	<tr bgcolor="#fff" align="center">
		<td>${status.index+1}</td>
		<td>${dto.couponNum}</td>
		<td>${dto.coupon}원 할인쿠폰</td>
		<td>${dto.startDate}</td>
		<td>${dto.endDate}</td>
		<td>
			<button type="button" class="btn btn-light couponPick" value="${dto.couponNum}">선택</button>
		</td>
	</tr>
</c:forEach>