<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">

.event-container {
    width: 100%;
    max-width: 1140px;
    padding-right: 15px;
    padding-left: 15px;
    margin-right: auto;
    margin-left: auto;
}

.item {
	align-content: center;
	padding: 20px;
    border: 1px solid #eee;
    margin: 25px;
    width: 320px;
}

.link {
	display: block;
    position: relative;
    height: 150px;
    width: 280px;
}

.img {
	width: 100%;
    height: 120px;
    margin-bottom: 12px;
}

.box_info {
	height: 20px;
    letter-spacing: 0;
    position: relative;
}

.info {
	font-size: 12px;
}

.page-box {
	clear: both;
	padding: 20px 0;
	text-align: center;
}

.event_name {
    display: block;
    height: auto;
    max-height: 40px;
    font-size: 16px;
    line-height: 21px;
    text-align: center;
}

.row-form {
	margin-left: 20px;
	margin-right: 20px;
}
.card-img-overlay{
	height: 120px;
	background-color: RGBA(0,0,0,0.5);
	color: white;
}
.card-img-overlay span{
	font-size: 16px;
	font-weight: 600;
	line-height: 5rem;
}
</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/boot-board.css" type="text/css">
<script type="text/javascript">
function searchList() {
	var f = document.searchForm;
	f.submit();
}
</script>

<div class="event-container">
	<div class="body-container">
		<div class="body-title">
			<h3>이벤트 </h3>
		</div>
		
		<div class="body-main">
			<div class="row board-list-footer">
				<div class="col-6 text-center">
					<form class="row row-form" name="searchForm" action="${pageContext.request.contextPath}/event/list" method="post">
						<div class="col-auto p-1">
						<select name="condition" class="form-select">
							<option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
							<option value="date" ${condition=="date"?"selected='selected'":""}>이벤트 기간</option>
								<option value="eventName" ${condition=="eventName"?"selected='selected'":""}>제목</option>
								<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
						</select>
						</div>
						<div class="col-auto p-1">
							<input type="text" name="keyword" value="${keyword}" class="form-control">
						</div>
						<div class="col-auto p-1">
							<button type="button" class="btn btn-outline-secondary" onclick="searchList()"> <i class="bi bi-search"></i> </button>
						</div>
					</form>
				</div>
				<c:if test="${sessionScope.member.membership>50}">
					<div class="col" style="text-align: right; margin-right: 40px;">
						<button type="button" class="btn btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/event/write';">글올리기</button>
					</div>
				</c:if>
			</div>
	        
	         <div class="row">
	         	<c:set var="today" value="<%=new java.util.Date()%>" />
				<!-- 현재날짜 -->
				<c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd" /></c:set> 
			 	<c:forEach var="dto" items="${list}" varStatus="status">
			 		<div class="item">
			 			<a class="link" href="${articleUrl}&eventNum=${dto.eventNum}" title="${dto.eventName}">
			 				<img class="img" src="${pageContext.request.contextPath}/uploads/event/${dto.saveFilename}">
				 			<c:if test="${dto.endDate<date}">
				 				<div class="card-img-overlay text-center"><span>종료된 이벤트</span></div>
				 			</c:if>
			 				<span class="event_name">${dto.eventName}</span>
			 			</a>
			 			<div class="box_info">
			 				<p class="info" style="text-align: center;">이벤트 기간 : <span>${dto.startDate} ~ ${dto.endDate} </span> </p>
			 			</div>
					</div>
			 	</c:forEach>
			 </div>
			 
			 <div class="page-box">
				${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
			</div>
		</div>
	</div>
</div>