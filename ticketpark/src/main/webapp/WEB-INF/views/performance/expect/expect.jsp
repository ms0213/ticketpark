<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.text-primary {
    color: #23A41A!important;
    font-size:15px;
 
 }

 
.expect-form textarea { width: 100%; height: 80px; resize: none; }
.expect-list, .mt-4 {width: 80%; margin: 0 auto;}
.expect-list tr:nth-child(3n+1) { border: 1px solid #FFFFFF; background: #f8f9fa; }

.expect-list .deleteExpect, .expect-list .notifyExpect, .updateExpect, .deleteExpect { cursor: pointer; }

textarea::placeholder{
	opacity: 1;
	color: #333;
	text-align: center;
	line-height: 60px;
}
</style>

<div class="container">
	<div class="body-container">	
		<div class="body-main">

			<form name="expectForm" method="post">
				<div class="expect-form border border-secondary mt-5 p-3">
					<div class="p-1">
						<span class="fw-bold"></span>
					</div>
					<div class="p-1">
						<textarea name="expectcontent" id="expectcontent" class="form-control" placeholder="${empty sessionScope.member ? '로그인 후 등록 가능합니다.':'해당 공연과 무관한 댓글, 악플은 사전통보 없이 삭제될 수 있습니다.'}"></textarea>
					</div>
					<br>
					<div align="right">
						<button type="button" class="expert-btnSend btn btn-outline-success" ${empty sessionScope.member ? "disabled='disabled'":""}> 등록하기 <i class="bi bi-check2"></i> </button>
					</div>
				</div>
			</form>

			<div id="listExpect">
				<div class='mt-4 mb-1' align='left' >
					<span class='expect-count fw-bold text-primary' data-pageNo="1" data-totalPage="1">총 0개의 기대평이 등록되었습니다.</span>
				</div>
				
				<table class="expect-list table table-borderless">
					<tbody class="expect-list-body"></tbody>
				</table>
	
				<div class='expert-more-box mt-2 text-end'>
					<span class="expert-more btn btn-outline-success">&nbsp;더보기&nbsp;<i class="bi bi-chevron-down"></i>&nbsp;</span>
				</div>
			</div>

		</div>
	</div>
</div>