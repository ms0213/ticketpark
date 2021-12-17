<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/tabs.css" type="text/css">

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
	$("ul.tabs li").click(function() {
		var hallNo = $(this).attr("data-hallNo");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
		
		$("#tab-"+hallNo).addClass("active");
		
		listPage();
	});
});

// 글리스트 및 페이징 처리
function listPage() {
	var $tab = $(".tabs .active");
	var hallNo = $tab.attr("data-hallNo");
	var url="${pageContext.request.contextPath}/admin/theaterManage/list";
	var query="hallNo="+hallNo;
	
	var selector = "#tab-content";
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

// 새로고침
function reloadTheater() {
	listPage();
}


// 글 삭제
function deleteTheater(tNum) {
	var url="${pageContext.request.contextPath}/admin/theaterManage/delete";
	
	var query="tNum="+tNum;
	
	if(! confirm("위 게시물을 삭제 하시 겠습니까 ? ")) {
		  return;
	}
	
	var fn = function(data){
		listPage();
	};
	
	ajaxFun(url, "post", query, "json", fn);
}

function addtheater(){
	var $tab = $(".tabs .active");
	var hallNo = $tab.attr("data-hallNo");
	var url = "${pageContext.request.contextPath}/admin/theaterManage/write?hallNo="+hallNo;
	location.href = url;
}
</script>

<div class="container">
	<div class="body-container">	
		<div class="body-title">
			<h2><i class="bi bi-question-octagon"></i> 상영관 관리 </h2>
		</div>
		
	    <div class="alert alert-info" role="alert">
	        <i class="bi bi-search"></i> 공연장 아래 상영관을 등록할 수 있습니다.
	    </div>
	    		
		<div class="body-main">

		<div>
			<ul class="tabs">
				<c:forEach var="dto" items="${listHallNo}" varStatus="status">
					<li id="tab-${dto.hallNo}" data-hallNo="${dto.hallNo}" class="${status.index == 0 ? 'active':''}">${dto.hallName}</li>
				</c:forEach>
			</ul>
		</div>
		<div id="tab-content" style="padding: 15px 10px 5px; clear: both;"></div>
			
		</div>
	</div>
</div>


<form name="faqSearchForm" method="post">
	<input type="hidden" name="condition" value="all">
    <input type="hidden" name="keyword" value="">
</form>
