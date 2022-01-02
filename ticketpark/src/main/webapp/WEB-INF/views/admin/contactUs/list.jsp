<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/tabs.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/board.css" type="text/css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<script type="text/javascript">

function searchList() {
	var f = document.searchForm;
	f.submit();
}
function checked(cNum, chk) {
	var url = "${pageContext.request.contextPath}/admin/contactUs/updateChecked";
	var query = "cNum="+cNum+"&checked="+chk+"&page=${page}";
	location.href=url+"?"+query;
}
</script>

<style type="text/css">
.search_wrapper {
	align-items: center;
	margin:0;
	min-width : 350px;
}
svg:hover{
	cursor:pointer;
}

td {
	text-align: center;
}
</style>

<div class="body-container">
	<div class="body-title">
		<h2> Contact Us </h2>
	</div>
	
	<div class="body-main">
		<table>
			<tr>
				<td width="50%" style="text-align: left;">
					${dataCount}개(${page}/${total_page} 페이지)
				</td>
				<td width="20%" align="right">
					<!-- Search -->
					<section id="search" class="alt">
						<form method="post" class="search_wrapper" 
						name="searchForm" action="${pageContext.request.contextPath}/admin/contactUs/list">
							<select name="condition" id="condition" style="width:60%">
								<option value="all" ${condition=="all"?"selected='selected'":"" }>제목+내용</option>
								<option value="title"  ${condition=="title"?"selected='selected'":"" }>제목</option>
								<option value="content"  ${condition=="content"?"selected='selected'":"" }>내용</option>
								<option value="name"  ${condition=="name"?"selected='selected'":"" }>이름</option>
								<option value="reg_date"  ${condition=="reg_date"?"selected='selected'":"" }>등록일</option>
							</select>
							<input type="text" name="keyword" id="keyword" value="${keyword}" placeholder="Search">
								<button type="button" class="btn btn-outline-secondary" onclick="searchList()">검색</button>
						</form>		
					</section>
					<input type="hidden" name="page" value="${page}">
					<input type="hidden" name="condition" value="${condition}">
					<input type="hidden" name="keyword" value="${keyword}">
				</td>
			</tr>
		</table>
        <form name="listForm" method="post">
			<table class="table table-border table-list">
				<tr>
					<th class="num">번호</th>
					<th class="title">제목</th>
					<th class="name">작성자</th>
					<th class="email">이메일</th>
					<th class="date">작성일</th>
					<th class="check">확인</th>
				</tr>
				<c:forEach var="dto" items="${list}">
					<tr>
						<td>${dto.listNum}</td>
						<td class="left">
							<a href="${articleUrl}&cNum=${dto.cNum}">
								${dto.title}
							</a>
						</td>
						<td>${dto.name}</td>
						<td>${dto.email}</td>		
						<td>${dto.reg_date}</td>
						<td>
							<c:choose>
								<c:when test="${ dto.checked=='n'}">
									<i class="far fa-check-circle fa-lg" onclick = "checked('${dto.cNum}', 'y');"></i>										
								</c:when>
								<c:otherwise>
									<i class="fas fa-check-circle fa-lg" onclick = "checked('${dto.cNum}', 'n');"></i>																				
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
			</table>
		</form>
		
		<div class="page-box">
			${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
		</div>
	</div>
</div>
