<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.card img { width: 200px; height:150px; cursor: pointer; padding-top: 20px;}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/boot-board.css" type="text/css">

<div class="container">
	<div class="body-container">
		<div class="body-title">
			<h3>공연장 정보</h3>
		</div>

		<div class="body-main">
			<p>공연장의 정보들을 소개합니다</p>
			
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
			
		</div>
	</div>
</div>