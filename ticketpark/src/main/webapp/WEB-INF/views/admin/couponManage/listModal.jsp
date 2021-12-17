<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:forEach var="dto" items="${list}" varStatus="status">
	<tr bgcolor="#fff" align="center">
		<td>${status.index+1}</td>
		<td>${dto.coupon}원 할인쿠폰</td>
		<td>유효기간 : ${dto.exp_date} 일</td>
		<td>
			<button type="button" class="btn btn-light"
				onclick="location.href='${pageContext.request.contextPath}/admin/couponManage/update?couponNum=${dto.couponNum}'">수정</button>
			<button type="button" class="btn btn-light btnDelete"
				data-vNum='${dto.couponNum}'>삭제</button>
		</td>
	</tr>
</c:forEach>