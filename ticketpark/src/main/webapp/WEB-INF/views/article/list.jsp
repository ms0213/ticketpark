<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="container">
	<div class="body-container">	
		<div class="body-title">
			<h3> 문화 칼럼 </h3>
		</div>
		
		<div class="body-main">

	        <div class="row board-list-header">
	            <div class="col-auto me-auto">
	            	${dataCount}개(${page}/${total_page} 페이지)
	            </div>
	            <div class="col-auto">&nbsp;</div>
	        </div>				
			
				<div class="card mb-3" style="border-style: none;">
					<c:forEach var="dto" items="${list}">
						<div class="row g-0" onclick="location.href='${articleUrl}&num=${dto.artiNum}';">
							<div class="col-md-4">
								<c:forEach var="vo" items="${dto.saveFilename}" varStatus="status">
									<c:if test="${status.index==0}">
										<img src="${pageContext.request.contextPath}/uploads/article/${dto.saveFilename}"
											 class="img-fluid rounded-start" style="max-height: 450px;">									
									</c:if>
								</c:forEach>
							</div>							
							<div class="col-md-8">
								<div class="card-body">
									<h5 class="card-title">${dto.subject}</h5>
									<p class="card-text">${dto.atName}</p>
									<p class="card-text">작성자 : ${dto.userName}</p>
									<p class="card-text">게시일 : ${dto.reg_date}</p>
									<p class="card-text" style="overflow:hidden;  text-overflow:ellipsis; 
										display:-webkit-box; -webkit-line-clamp:3; -webkit-box-orient:vertical;">${dto.content}</p>

								</div>
							</div>
						</div>
						<hr>			
					</c:forEach>
				</div>
			
			<div class="page-box">
				${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
			</div>

			<div class="row board-list-footer">
				<div class="col">
					<button type="button" class="btn btn-outline-secondary fh rhclrh" onclick="location.href='${pageContext.request.contextPath}/article/list';">새로고침</button>
				</div>
				<div class="col-6 text-center">
					<form class="row" name="searchForm" action="${pageContext.request.contextPath}/article/list" method="post">
						<div class="col-auto p-1">
							<select name="condition" class="form-select">
								<option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
								<option value="userName" ${condition=="userName"?"selected='selected'":""}>작성자</option>
								<option value="reg_date" ${condition=="reg_date"?"selected='selected'":""}>등록일</option>
								<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
								<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
							</select>
						</div>
						<div class="col-auto p-1">
							<input type="text" name="keyword" value="${keyword}" class="form-control">
						</div>
						<div class="col-auto p-1">
							<button type="button" class="btn btn-outline-secondary fh rhclrh" onclick="searchList()"> <i class="bi bi-search"></i> </button>
						</div>
					</form>
				</div>
				<div class="col text-end">
				<c:if test="${sessionScope.member.userId==dto.admin}">
					<button type="button" class="btn btn-outline-secondary fh rhclrh" onclick="location.href='${pageContext.request.contextPath}/article/write';">글올리기</button>
				</c:if>
				</div>
			</div>

		</div>
	</div>
</div>