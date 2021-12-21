<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">

.body-main {
	max-width: 1000px;
	margin: 0 auto;
}

.form-control {
	text-align: center;
	
}

</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/boot-board.css" type="text/css">

<script type="text/javascript">
function login() {
	location.href="${pageContext.request.contextPath}/member/login";
}

function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
			if(jqXHR.status === 403) {
				login();
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패했습니다.");
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

$(function(){
	listPage(1);
	

	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
		listPage(1);
	})
});

// 글리스트 및 페이징 처리
function listPage(page) {
	var $tab = $("a[data-toggle='tab'].active");
	var categoryNum = $tab.attr("data-categoryNum");
	var url="${pageContext.request.contextPath}/faq/list";
	var query="pageNo="+page+"&categoryNum="+categoryNum;
	var search=$('form[name=faqSearchForm]').serialize();
	query=query+"&"+search;
	
	var selector = "#nav-Content";
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}


// 검색
function searchList() {
	var f=document.faqSearchForm;
	f.condition.value=$("#condition").val();
	f.keyword.value=$.trim($("#keyword").val());

	listPage(1);
}




// 새로고침
function reloadFaq() {
	var f=document.faqSearchForm;
	f.condition.value="all";
	f.keyword.value="";
	
	listPage(1);
}

// 글 삭제
function deleteFaq(num, page) {
	var url="${pageContext.request.contextPath}/faq/delete";
	
	var query="num="+num;
	
	if(! confirm("위 게시물을 삭제 하시 겠습니까 ? ")) {
		  return;
	}
	
	var fn = function(data){
		listPage(page);
	};
	
	ajaxFun(url, "post", query, "json", fn);
}
</script>

<div class="container">
	<div class="body-container">	
		<div class="body-title">
			<h3><i class="bi bi-question-octagon"></i> 자주하는 질문 </h3>
		</div>
		
	<br>
	<div class="body-top">
		<form class="row" name="searchForm" method="post">
			<div class="col-2">
				<select name="condition" id="condition" class="form-select" hidden="hidden">
					
				</select>
			</div>
			<div class="col-7">
				<input type="text" name="keyword" id="keyword" value="${keyword}" class="form-control" placeholder="궁금하신 내용을 입력해주세요 !">
				
	
			</div>
			<div class="col">
				<button type="button" class="btn btn-success" onclick="searchList()"><i class="bi bi-search"></i></button>
			</div>
		</form>
	</div>
	<br>
	<br>
		<div class="body-main">
			<nav>
				<div class="nav nav-tabs" id="nav-tab" role="tablist">
					<a class="nav-item nav-link active" id="tab-0" data-toggle="tab" href="#nav-Content" role="tab" aria-controls="0" aria-selected="true" data-categoryNum="0">전체</a>
					<c:forEach var="dto" items="${listCategory}" varStatus="status">
						<a class="nav-item nav-link" id="tab-${status.count}" data-toggle="tab" href="#nav-Content" role="tab" aria-controls="${status.count}" aria-selected="false" data-categoryNum="${dto.categoryNum}">${dto.category}</a>
					</c:forEach>
				</div>
			</nav>
			<div class="tab-content pt-2" id="nav-tabContent">
				<div class="tab-pane fade show active" id="nav-Content" role="tabpanel" aria-labelledby="nav-tab-content">
				</div>
			</div>
			
		</div>
	</div>
</div>

<form name="faqSearchForm" method="post">
	<input type="hidden" name="condition" value="all">
    <input type="hidden" name="keyword" value="">
</form>