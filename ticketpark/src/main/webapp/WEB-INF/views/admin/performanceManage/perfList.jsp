<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-main {
	max-width: 800px;
}
.list-tr th, .list-tr td {
	text-align: center;
    overflow:hidden;
	white-space : nowrap;
	text-overflow: ellipsis;
	cursor: pointer;
}
.form-select {
    padding: 0.375rem 2.25rem 0.375rem 0.75rem;
	font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    border: 1px solid #ced4da;
    border-radius: 0.25rem;
    -webkit-appearance: none;
}

.pagination {
	margin: 10px 0 5px 0px;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css1/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/boot-board.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/icons/icon/bootstrap-icons.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/icons/icofont/icofont.min.css" type="text/css">

<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.category.value=$("#selectCategory").val();
	f.action="${pageContext.request.contextPath}/admin/performanceManage/perfList";
	f.submit();
}

function detailedPerformance(perfNum) {
	var dlg = $("#performance-dialog").dialog({
		  autoOpen: false,
		  modal: true,
		  buttons: {
		       " 수정 " : function() {
		    	   updateOk(); 
		       },
		       " 삭제 " : function() {
		    	   deleteOk(perfNum);
			   },
		       " 닫기 " : function() {
		    	   $(this).dialog("close");
		       }
		  },
		  height: 520,
		  width: 800,
		  title: "공연상세정보",
		  close: function(event, ui) {
		  }
	});

	var url = "${pageContext.request.contextPath}/admin/performanceManage/detaile";
	var query = "perfNum="+perfNum;
	
	var fn = function(data){
		$('#performance-dialog').html(data);
		dlg.dialog("open");
	};
	ajaxFun(url, "post", query, "html", fn);
}
</script>

<main>
	
	<div class="body-container">
	    <div class="body-title">
			<h2><i class="icofont-users"></i> 공연 관리 </h2>
	    </div>
	    <table class="table" style="margin-bottom: 0px;">
			<tr>
				<td align="right">
					<select id="selectCategory" class="selectField" onchange="searchList();">
						<option value="" ${category=="" ? "selected='selected'":""}>::카테고리::</option>
						<option value="musical" ${category=="musical" ? "selected='selected'":""}>뮤지컬</option>
						<option value="drama" ${category=="drama" ? "selected='selected'":""}>연극</option>
						<option value="concert" ${category=="concert" ? "selected='selected'":""}>콘서트</option>
					</select>
				</td>
			</tr>
		</table>
		
	    <div>
			<table class="table table-border table-list" style="table-layout: fixed;">
				<thead>
					<tr class="list-tr">
						<th style="width: 10%;">번호</th>
						<th style="width: 35%;">공연 제목</th>
						<th style="width: 30%;">공연기간</th>
						<th style="width: 10%;">카테고리</th>
						<th style="width: 15%;">공연장</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach var="dto" items="${list}">
						<tr class="list-tr" onclick="detailedPerformance('${dto.perfNum}')"> 
							<td>${dto.listNum}</td>
							<td>${dto.subject}</td>
							<td>${dto.startDate} ~ ${dto.endDate}</td>
							<td>${dto.category}</td>
							<td>${dto.hallName}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
						 
			<div class="page-box" style="padding: 0px;">
				${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
			</div>
			<div class="row board-list-footer">
				<div class="col-4">
					<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/admin/performanceManage/perfList';">새로고침</button>
				</div>
				<div class="col-6 text-center">
					<form class="row" name="searchForm" action="${pageContext.request.contextPath}/admin/performanceManage/perfList" method="post">
						<div class="col-auto p-1">
							<select name="condition" class="form-select">
								<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
								<option value="date" ${condition=="date"?"selected='selected'":""}>공연기간</option>
								<option value="hall" ${condition=="hall"?"selected='selected'":""}>공연장</option>
							</select>
						</div>
						<input type="hidden" name="category" value="${category}">
						<input type="hidden" name="page" value="1">
						<div class="col-auto p-1">
							<input type="text" name="keyword" value="${keyword}" class="form-control">
						</div>
						<div class="col-auto p-1">
							<button type="button" class="btn btn-light" onclick="searchList()"> <i class="bi bi-search"></i> </button>
						</div>
					</form>
				</div>
				<div class="col text-end" align="right">
					<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/admin/performanceManage/perfAdd';">공연등록</button>
				</div>
			</div>
	    </div>
	</div>
	<div id="performance-dialog" style="display: none;"></div>
</main>
