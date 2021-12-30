<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.btn-link {
    font-weight: 400;
    font-size: 15px;
    color: #2B2B2B;
}
 
.alert-info {
    background-color: #E4F7BA;
    border-color:  #E4F7BA;
    color: black;
    font-size: 15px;
    
}

.nav-link {
	color: #2F9D27;
}


</style>


<c:if test="${list.size() > 0}">
	<div class="accordion" id="accordionExample"> 
		<c:forEach var="dto" items="${list}" varStatus="status">
			 <div class="card">
				<div class="card-header" id="heading${status.index}">
					<h2 class="mb-0">
						<button class="btn btn-link collapsed" type="button" data-toggle="collapse" aria-expanded="false" data-target="#collapse${status.index}" aria-controls="collapse${status.index}" style= "text-decoration: none;">
          					${dto.subject}
						</button>
					</h2>
				</div>

				<div id="collapse${status.index}" class="collapse" aria-labelledby="heading${status.index}" data-parent="#accordionExample">
					<div class="card-body">
						<div class="row border-bottom pb-1"> &nbsp; [ ${dto.category} ]</div>
						<div class="row p-2">
      						${dto.content}
      					</div>
      					<c:if test="${sessionScope.member.membership>50}">
							<div class="row py-1">
								<div class="col text-end">
								<a href="#" onclick="javascript:location.href='${pageContext.request.contextPath}/faq/update?num=${dto.num}&pageNo=${pageNo}';">수정</a>&nbsp;|
								<a href="#" onclick="deleteFaq('${dto.num}', '${pageNo}');">삭제</a>
							</div>
							</div>
						</c:if>
      				</div>

    			</div>
  			</div>
	
		</c:forEach>
	</div>
</c:if>
 
<div class="page-box">
	${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
</div>

<div class="row py-3">
	<div class="col">
		<button type="button" class="btn btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/faq/main';">새로고침</button>
	</div>
	<div class="col-6 text-center">
	
			
			
	</div>
	<div class="col text-end">
		<c:if test="${sessionScope.member.membership>50}">
			<button type="button" class="btn btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/faq/write';">글올리기</button>
		</c:if>
	</div>
</div>

