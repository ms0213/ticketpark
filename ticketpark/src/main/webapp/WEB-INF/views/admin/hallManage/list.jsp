<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/tabs.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/board.css" type="text/css">
<style type="text/css">
.board-list-footer { padding-top: 7px; padding-bottom: 7px; }

.btnright {
	float: right;
}

</style>

<script type="text/javascript">

</script>

<div class="body-container">
	<div class="body-title">
		<h2><i class="icofont-users"></i>공연장 정보</h2>
	</div>

	<div class="body-main">
		<div class="row board-list-header">
            <div class="col-auto me-auto">
            	${dataCount}개(${page}/${total_page} 페이지)
            </div>
            <div class="col-auto">&nbsp;</div>
        </div>

		<div class="container m-3">
			<div class="row">
				<c:forEach var="dto" items="${list}" varStatus="status">
				<div class="col-md-4 col-lg-3 p-3 item">
					<div class="card text-center" style="width: 18rem;">
						<a href="${articleUrl}&hNum=${dto.hNum}">
							<img src="${pageContext.request.contextPath}/uploads/hall/${dto.saveFilename}" class="card-img-top">
						</a>
						<div class="card-body">
							<h6 class="card-title">${dto.hallName}</h6>
						</div>
					</div>
				</div>
				</c:forEach>
			</div>
		</div>


		<div class="page-box">
			${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
		</div>
		
		<div class="row board-list-footer mt-3 mb-3">
			<div class="col text-right">
				<c:if test="${sessionScope.member.membership>50}">
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/hall/write';">등록</button>
				</c:if>
			</div>
		</div>
	</div>
</div>
