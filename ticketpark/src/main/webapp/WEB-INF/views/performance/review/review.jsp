<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.text-primary {
    color: #23A41A!important;
    font-size:15px;
 
 }
.review-form textarea { width: 100%; height: 80px; resize: none; }
.review-list {width: 80%; margin: 0 auto;}

.review-list tr:nth-child(3n+1) { border: 1px solid #FFFFFF; background: #f8f9fa; }

.review-list .deleteReview, .review-list .notifyReview, .updateReview, .deleteReview { cursor: pointer; }
 
textarea::placeholder{
	opacity: 1;
	color: #333;
	text-align: center;
	line-height: 60px;
}
</style>

<style type="text/css">
.user-rating {
    float: left;
    height: 46px;
    padding: 0 10px;
	-webkit-text-fill-color: transparent;
	-webkit-text-stroke-width: 1px;
	-webkit-text-stroke-color: #2b2a29;
}
.star{font-size: 25px;}
.on{-webkit-text-fill-color: gold;}
</style>

<div class="container">
	<div class="body-container">	
		<div class="body-main">

			<form name="reviewForm" method="post">
				<div class="review-form border border-secondary p-3">
					<div class="p-1">
						<span class="fw-bold"></span>
					</div>
					<div class="p-1">
						<textarea name="reviewcontent" id="reviewcontent" class="form-control" placeholder="${empty sessionScope.member ? '로그인 후 등록 가능합니다.':'해당 공연과 무관한 댓글, 악플은 사전통보 없이 삭제될 수 있습니다.'}"></textarea>
					</div>
					<br>
					<div>
						<div style="float: left;">
							  <div class="user-rating">
							      <span class="star" onClick="setStar(1)"><i class='icofont-star'></i></span>
							      <span class="star" onClick="setStar(2)"><i class='icofont-star'></i></span>
							      <span class="star" onClick="setStar(3)"><i class='icofont-star'></i></span>
							      <span class="star" onClick="setStar(4)"><i class='icofont-star'></i></span>
							      <span class="star" onClick="setStar(5)"><i class='icofont-star'></i></span>
							  </div>
						</div>
						<div align="right">
							<button type="button" class="btnSend btn btn-outline-success" ${empty sessionScope.member ? "disabled='disabled'":""}> 등록하기 <i class="bi bi-check2"></i> </button>
						</div>
					</div>
				</div>
			</form>

			<div id="listReview">
				<div class='mt-4 mb-1'>
					<span class='review-count fw-bold text-primary' data-pageNo="1" data-totalPage="1">총 0개의 후기가 등록되었습니다.</span>
				</div>
				
				<table class="review-list table table-borderless">
					<tbody class="review-list-body"></tbody>
				</table>
	
				<div class='more-box mt-2 text-end'>
					<span class="more btn btn-outline-success">&nbsp;더보기&nbsp;<i class="bi bi-chevron-down"></i>&nbsp;</span>
				</div>
			</div>

		</div>
	</div>
</div>