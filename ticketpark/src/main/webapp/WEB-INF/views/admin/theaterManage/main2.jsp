<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/tabs.css" type="text/css">

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
	listPage();
	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
		listPage();
	});
});

// 글리스트 및 페이징 처리
function listPage() {
	var $tab = $("a[data-toggle='tab'].active");
	var hallNo = $tab.attr("data-hallNo");
	alert(hallNo);
	var url="${pageContext.request.contextPath}/admin/theaterManage/list";
	var query="hallNo="+hallNo;
	
	var selector = "#nav-Content";
	
	var fn = function(data){
		console.log(data);
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

// 새로고침
function reloadFaq() {
	var f=document.faqSearchForm;
	f.condition.value="all";
	f.keyword.value="";
	
	listPage();
}

// 글 삭제
function deleteFaq(num) {
	var url="${pageContext.request.contextPath}/admin/theaterManage/delete";
	
	var query="tNum="+tNum;
	
	if(! confirm("위 게시물을 삭제 하시 겠습니까 ? ")) {
		  return;
	}
	
	var fn = function(data){
		
	};
	
	ajaxFun(url, "post", query, "json", fn);
}
</script>

<div class="container">
	<div class="body-container">	
		<div class="body-title">
			<h3><i class="bi bi-question-octagon"></i> 상영관 관리 </h3>
		</div>
		
	    <div class="alert alert-info" role="alert">
	        <i class="bi bi-search"></i> 공연장 아래 상영관을 등록할 수 있습니다.
	    </div>
	    		
		<div class="body-main">

		
			<nav>
				<div class="nav nav-tabs" id="nav-tab" role="tablist">

					<c:forEach var="dto" items="${listHallNo}" varStatus="status">
						<a class="nav-item nav-link ${status.index==0?'active':'' }" id="tab-${status.count}" data-toggle="tab" href="#nav-Content" role="tab" aria-controls="${status.count}" aria-selected="${status.index==0?'true':'false'}" data-hallNo="${dto.hallNo}">${dto.hallName}</a>
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
