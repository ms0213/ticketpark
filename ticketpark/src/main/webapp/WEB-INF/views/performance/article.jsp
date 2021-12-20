<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/boot-board.css" type="text/css">

<script type="text/javascript">
</script>

<div class="container">
	<div class="body-container">	
		
		<div class="body-main">

			<table class="table mb-0">				
				<tbody>
					<tr>
						<td width="50%">
							공연 이름 : ${dto.subject}							
						</td>
						<td align="right">
							공연 기간 : ${dto.startDate} ~ ${dto.endDate}
						</td>
					</tr>
					<tr>
						<td colspan="2">
							공연장 : ${dto.hallName}
						</td colspan="2">
					</tr>
					<tr>
						<td colspan="2">
							상영관 : ${dto.theater}
						</td>
					</tr>
					<tr>
						<td colspan="2">
							관람연령 : ${dto.rate}
						</td>
					</tr>
					<tr>
						<td colspan="2">
							평점 : ${dto.rating}
						</td>
					</tr>

					<tr>
						<td colspan="2" style="border-bottom: none;">
							<div class="row row-cols-6 img-box">
								<img src="${pageContext.request.contextPath}/uploads/performance/${dto.postFileName}">
							</div>
						</td>
					</tr>
											
					<tr>
						<td colspan="2">
							${dto.content}
						</td>
					</tr>
				</tbody>
			</table>
			
			<table class="table table-borderless">
				<tr>
					<td width="50%">
						<c:choose>
							<c:when test="${sessionScope.member.membership>50}">
								<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/performance/update?perfNum=${dto.perfNum}&page=${page}';">수정</button>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn btn-light" disabled="disabled">수정</button>
							</c:otherwise>
						</c:choose>
				    	
						<c:choose>
				    		<c:when test="${sessionScope.member.membership>50}">
				    			<button type="button" class="btn btn-light" onclick="deleteOk();">삭제</button>
				    		</c:when>
				    		<c:otherwise>
				    			<button type="button" class="btn btn-light" disabled="disabled">삭제</button>
				    		</c:otherwise>
				    	</c:choose>
				    	<button type="button" class="btn btn-light">예매하기</button>
					</td>
					<td class="text-end">
						<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/performance/list?${query}';">리스트</button>
					</td>
				</tr>
			</table>

		</div>
	</div>
</div>