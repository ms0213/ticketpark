<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/board.css" type="text/css">
<style type="text/css">
.board-list-footer { padding-top: 7px; padding-bottom: 7px; }

.btnright {
	float: right;
}
img{width: 100px;}
</style>

<script type="text/javascript">
function deleteOk(hNum) {

    if(confirm("공연장을 삭제하시겠습니까 ? ")) {
		var query = "hNum="+hNum+"&page=${page}";
	    var url = "${pageContext.request.contextPath}/admin/hallManage/delete?" + query;
  	  location.href=url;
    }
}
</script>

<div class="body-container">
	<div class="body-title">
		<h2><i class="icofont-users"></i>공연장 관리</h2>
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
				<table class="table table-border table-list">
					<thead>
						<tr>
							<th>번호</th>
							<th>공연장 이름</th>
							<th>이미지</th>
							<th>주소</th>
							<th>전화번호</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="dto" items="${list}" varStatus="status">
						<tr>
							<td>${dto.hNum}</td>
							<td>${dto.hallName}</td>
							<td><img src="${pageContext.request.contextPath}/uploads/hall/${dto.saveFilename}" class="card-img-top"></td>
							<td>${dto.addr}</td>
							<td>${dto.tel}</td>
							<td><button type="button" class="btn btn-outline-secondary"
								onclick="location.href='${pageContext.request.contextPath}/admin/hallManage/update?hNum=${dto.hNum}&page=${page}';">수정</button>
								<button type="button" class="btn btn-outline-secondary" onclick="deleteOk(${dto.hNum});">삭제</button>
								</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>


		<div class="page-box">
			${dataCount == 0 ? "등록된 공연장이 없습니다." : paging}
		</div>
		
		<div class="row board-list-footer mt-3 mb-3">
			<div class="col text-right">
				<c:if test="${sessionScope.member.membership>50}">
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/admin/hallManage/write';">등록</button>
				</c:if>
			</div>
		</div>
	</div>
</div>
