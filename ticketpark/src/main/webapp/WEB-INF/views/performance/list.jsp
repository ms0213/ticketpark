<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">

.performance-container {
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
    width: 220px;
    height: 380px;
}

.link {
	display: block;
    position: relative;
    width: 180px;
    height: 290px;
}

.img {
	width: 180px;
    height: 260px;
    margin-bottom: 12px;
}

.box_info {
	height: 20px;
    letter-spacing: 0;
    position: relative;
}

.day {
	display: block;
    overflow: hidden;
    height: 18px;
    font-weight: normal;
    font-size: 13px;
    line-height: 18px;
    color: #666;
    text-overflow: ellipsis;
    white-space: nowrap;
    margin: 8px 5px 5px 5px;
}

.hall {
	display: block;
    overflow: hidden;
    height: 20px;
    font-weight: normal;
    font-size: 15px;
    line-height: 20px;
    color: #888;
    text-overflow: ellipsis;
    white-space: nowrap;
    margin: 3px 5px 5px 5px;
}

.page-box {
	clear: both;
	padding: 20px 0;
	text-align: center;
}

.subject {
   	display: block;
    height: auto;
    max-height: 40px;
    font-size: 16px;
    line-height: 21px;
    text-align: center;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.row-form {
	margin-left: 20px;
	margin-right: 20px;
}
</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/boot-board.css" type="text/css">
<script type="text/javascript">
function searchList() {
	var f = document.searchForm;
	f.submit();
}
</script>

<div class="performance-container">
	<div class="body-container">
		<div class="body-title">
			<h3><i class="bi bi-image"></i> 전체 </h3>
		</div>
		
		<div class="body-main">
			<div class="row board-list-footer">
				<div class="col-6 text-center">
					<form class="row row-form" name="searchForm" action="${pageContext.request.contextPath}/performance/list" method="post">
						<div class="col-auto p-1">
						<select name="condition" class="form-select">
							<option value="subject" ${condition=="subject"?"selected='selected'":""}>공연이름</option>
							<option value="date" ${condition=="date"?"selected='selected'":""}>공연 기간</option>
						</select>
						</div>
						<div class="col-auto p-1">
							<input type="text" name="keyword" value="${keyword}" class="form-control">
						</div>
						<div class="col-auto p-1">
							<button type="button" class="btn btn-light" onclick="searchList()"> <i class="bi bi-search"></i> </button>
						</div>
					</form>
				</div>
				<c:if test="${sessionScope.member.membership>50}">
					<div class="col" style="text-align: right; margin-right: 40px;" >
						<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/performance/write';">글올리기</button>
					</div>
				</c:if>
			</div>
	        
	         <div class="row">
			 	<c:forEach var="dto" items="${list}" varStatus="status">
			 		<div class="item">
			 			<a class="link" href="${articleUrl}&perfNum=${dto.perfNum}" title="${dto.subject}">
			 				<img class="img" src="${pageContext.request.contextPath}/uploads/performance/${dto.saveFilename}">
			 				<span class="subject">${dto.subject}</span>
			 			</a>
			 			<div class="box_info">
			 				<p class="day" style="text-align: center;"><span>${dto.startDate} ~ ${dto.endDate} </span> </p>
			 				<p class="hall" style="text-align: center;"><span>${dto.hallName} </span> </p>
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