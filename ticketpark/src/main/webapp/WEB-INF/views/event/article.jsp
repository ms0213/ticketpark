<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/boot-board.css" type="text/css">

<style type="text/css">
.coupon-div{
	text-align: center;
}
.coupon-message{
	color: blue;
}
</style>

<script type="text/javascript">
function deleteOk() {

    if(confirm("이벤트를 삭제 하시 겠습니까 ? ")) {
		var query = "eventNum=${dto.eventNum}&${query}";
	    var url = "${pageContext.request.contextPath}/event/delete?" + query;
  	  location.href=url;
    }
}
</script>

<div class="container">
	<div class="body-container">	
		<div class="body-title">
			<h3><i class="bi bi-image"></i> 이벤트 </h3>
		</div>
		
		<div class="body-main">

			<table class="table mb-0">				
				<tbody>
					<tr>
						<td width="50%">
							이벤트 이름 : ${dto.eventName}							
						</td>
						<td align="right">
							이벤트 기간 : ${dto.startDate} ~ ${dto.endDate}
						</td>
					</tr>

					<tr>
						<td colspan="2" style="border-bottom: none;">
							<div class="row row-cols-6 img-box">
								<c:forEach var="dto" items="${listFile}">
									<img src="${pageContext.request.contextPath}/uploads/event/${dto.saveFilename}">
								</c:forEach>
							</div>
						</td>
					</tr>
											
					<tr>
						<td colspan="2">
							${dto.content}
							<div class="coupon-div">
								<c:if test="${dto.coupon == 1}">
									<button type="button" class="btn btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/event/couponCheck?couponNum=${dto.couponNum}&page=${page}&eventNum=${dto.eventNum}';">쿠폰번호 [ ${dto.couponNum} ] 등록</button>
				    			</c:if>
							</div>
							<div class="coupon-message coupon-div">
								${message}
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			
			<table class="table table-borderless">
				<tr>
					<td width="50%">
						<c:choose>
							<c:when test="${sessionScope.member.membership>50}">
								<button type="button" class="btn btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/event/update?eventNum=${dto.eventNum}&page=${page}';">수정</button>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn btn-outline-secondary" disabled="disabled">수정</button>
							</c:otherwise>
						</c:choose>
				    	
						<c:choose>
				    		<c:when test="${sessionScope.member.membership>50}">
				    			<button type="button" class="btn btn-outline-secondary" onclick="deleteOk();">삭제</button>
				    		</c:when>
				    		<c:otherwise>
				    			<button type="button" class="btn btn-outline-secondary" disabled="disabled">삭제</button>
				    		</c:otherwise>
				    	</c:choose>
					</td>
					<td class="text-right">
						<button type="button" class="btn btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/event/list?${query}';">리스트</button>
					</td>
				</tr>
			</table>

		</div>
	</div>
</div>