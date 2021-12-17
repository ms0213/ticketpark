<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">

.card button {
	border: 0;
	padding: 0;
}
.card span {
	display: block;
	height: 160px;
	overflow: hidden;
}
.card iframe {
	height: 160px;
	border: none;
}
.card-body{cursor: pointer;}
.board-list-footer { padding-top: 7px; padding-bottom: 7px; }
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/boot-board.css" type="text/css">

<script type="text/javascript">
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
		},
		error:function(jqXHR) {
			console.log(jqXHR.responseText);
		}
	});
}

$(function() {
	$("body").on("click", ".btnModal", function() {
		$("#videoModal").modal("show");
		
		var url="${pageContext.request.contextPath}/video/listModal";
		
		var query = "tmp="+new Date().getTime();
		var fn = function(data){
			$(".modal-list").html(data);
		};
		ajaxFun(url, "get", null, "html", fn)
	});
	
	/*
	var myModalEl = document.getElementById('videoModal');
	myModalEl.addEventListener('show.bs.modal', function (event) {
		var url="${pageContext.request.contextPath}/video/listModal";
		$(".modal-list").load(url);
	});
	*/
	
	var myModalEl = document.getElementById('videoModal');
	
	$('#videoModal').on('hidden.bs.modal', function (e) {
		location.reload();
	});
});

$(function() {
	$("body").on("click", ".btnDelete", function() {
		if(! confirm("영상을 삭제하시겠습니까?")){
			return false;
		}
		
		var vNum = $(this).attr("data-vNum");
		var url = "${pageContext.request.contextPath}/video/delete";
		var query = "vNum="+vNum;
		
		var fn = function(data) {
			var state = data.state;
			if(data.state==="false"){
				alert("삭제에 실패했습니다");
				return false;
			}
			url="${pageContext.request.contextPath}/video/listModal?tmp="+(new Date()).getTime();
			$('.modal-list').load(url);
		};
		ajaxFun(url, "post", query, "json", fn);
		
	});
});
</script>

<div class="container">
	<div class="body-container">
		<div class="body-title">
			<h3><i class="bi bi-camera-video"></i> 비디오</h3>
		</div>

		<div class="body-main">
			<p>관련 영상을 볼 수 있음</p>
			
			<div class="row board-list-header">
	            <div class="col-auto me-auto">
	            	${dataCount}개(${page}/${total_page} 페이지)
	            </div>
	            <div class="col-auto">&nbsp;</div>
	        </div>

			<div class="container">
				<div class="row">
				 	<c:forEach var="dto" items="${list}" varStatus="status">
				 		<div class="col-md-4 col-lg-3 p-3 item">
				 			<div class="card" style="width: 18rem;">
								<iframe src="${dto.link}">지원X</iframe>
								<div class="card-body" onclick="location.href='${dto.link}'">
									<h5 class="card-title">${dto.subject}</h5>
									<p class="card-text">${dto.content}</p>
								</div>
							</div>
				 		</div>
			 		</c:forEach>
		 		</div>
				
			</div>
			
			<div class="page-box mt-3 mb-3">
				${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
			</div>
			
			<div class="row board-list-footer mt-3 mb-3">
				<div class="col text-left">
					<c:if test="${sessionScope.member.membership>50}">
						<button type="button" class="btn btn-light btnModal">관리</button>
					</c:if>
				</div>
				<div class="col text-right">
					<c:if test="${sessionScope.member.membership>50}">
						<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/video/write';">업로드</button>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" id="videoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"> 영상 관리 </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table style="width: 100%; border-spacing: 1px; background: #ccc;">
	        <thead>
				<tr height="30" bgcolor="#eee" align="center">
					<th>영상번호</th>
					<th>제목</th>
					<th>링크</th>
					<th>내용</th>
					<th>수정</th>
				</tr>
	        </thead>
	        <tbody class="modal-list"></tbody>
			
		</table>
      </div>
    </div>
  </div>
</div>
