<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
#list-example {
	position: absolute;
	max-height: 100%;
}

.selected { 
	background: #eaefff;
}

.scrollspy-example h4{
    line-height: 2rem;
    font-weight: 600;
    padding: 0 10px;
}

.mypage-content{
	border: 1px solid #dfdfdf;
    padding: 15px;
    border-radius: 0.25rem;
    margin: 30px 0;
}

.owl-item .card-title{
	color: white;
}
.owl-item .card-img-overlay{
	opacity: 0;
	transition: 0.5s;
}
.owl-item:hover .card-img-overlay{
	opacity: 1;
}
.owl-item:hover img{
	filter: brightness(50%);
	transition: 0.5s;
}


.mypage-content .owl-nav button {
	width:30px;
	height:30px;
	position: absolute;
	top: 45%;
	background-color: RGBA(255,255,255,0.5) !important;
	color: black !important;
	border-radius:1rem;
	margin: 0;
}
.owl-nav button.owl-prev {
  left: 0;
}
.owl-nav button.owl-next {
  right: 0;
}
</style>

<script>
function fnMove(seq){
    var offset = $("#list-item-" + seq).offset();
    $('html, body').animate({scrollTop : offset.top-150}, 400);
}

$(document).ready(function() {
	 
	// 기존 css에서 플로팅 배너 위치(top)값을 가져와 저장한다.
	var floatPosition = parseInt($("#list-example").css('top'));
	// 250px 이런식으로 가져오므로 여기서 숫자만 가져온다. parseInt( 값 );
	 
	$(window).scroll(function() {
	// 현재 스크롤 위치를 가져온다.
	var scrollTop = $(window).scrollTop();
	var newPosition = scrollTop + floatPosition + "px";
	 
	/* 애니메이션 없이 바로 따라감
	$("#list-example").css('top', newPosition);
	*/
	 
	$("#list-example").stop().animate({
	"top" : newPosition
	}, 500);
	 
	}).scroll();
	 
});

$("body").on("click", ".list-group-item-action", function(){
	 $(this).addClass("selected"); //클릭된 부분을 상단에 정의된 CCS인 selected클래스로 적용
     $(this).siblings().removeClass("selected"); //siblings:형제요소들, 
});

</script>

<script type="text/javascript">
$(document).ready(function(){
    var owl = $('.owl-carousel');
    
    owl.owlCarousel({
        items:4,                 // 한번에 보여줄 아이템 수
        loop:false,               // 반복여부
        margin:35,   			// 오른쪽 간격
        nav: true,
        navText: [
            "<i class='ti-angle-left'></i>",
            "<i class='ti-angle-right'></i>"
            ],
        autoplay:true,           // 자동재생 여부
        autoplayTimeout:1800,    // 재생간격
        autoplayHoverPause:true  //마우스오버시 멈출지 여부
    });    
    
    $('.customNextBtn').click(function() {
        owl.trigger('next.owl.carousel');
    })
    
    $('.customPrevBtn').click(function() {
        owl.trigger('prev.owl.carousel', [300]);
    })
});

function deleteZzim() {
	alert("해당 공연의 찜을 해제하시겠습니까?");ㄹ
};
</script>

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
	$("body").on("click", ".btnDelete", function() {
		if(! confirm("해당 공연의 찜을 해제하시겠습니까?")){
			return false;
		}
		var perfNum = $(this).attr("data-perfNum");
		var url = "${pageContext.request.contextPath}/member/deleteChoice";
		var query = "perfNum="+perfNum;
		
		var fn = function(data) {
			var state = data.state;
			if(data.state==="false"){
				alert("삭제에 실패했습니다.");
				return false;
			}
			url = "${pageContext.request.contextPath}/member/mypage";
			location.href = url;
		};
		ajaxFun(url,"post",query,"json",fn);
	});
});
</script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/boot-board.css" type="text/css">
<div class="container" style="display: flex; flex-direction: row;">
	<div id="list-example" class="list-group" style="min-width: 200px; margin-top: 50px;">
		<a class="list-group-item list-group-item-action" onclick="" style="text-align: center; background-color: #eaefff;">MENU</a>
		<a class="list-group-item list-group-item-action" onclick="fnMove('1')">예매내역</a>
		<a class="list-group-item list-group-item-action" onclick="fnMove('2')">찜목록</a>
		<a class="list-group-item list-group-item-action" onclick="fnMove('3')">나의 추천</a>
		<a class="list-group-item list-group-item-action" onclick="fnMove('4')">쿠폰함</a>
		<a class="list-group-item list-group-item-action" onclick="fnMove('5')">포인트</a>
		<a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath}/member/pwd">정보수정</a>
	</div>
	
	<div class="body-container" style="margin-left: 230px; max-width: 1000px;">
		<div class="body-title">
			<h3>마이페이지</h3>
		</div>
		
		<div class="body-main">
			${dto.userName}님, 반갑습니다.
			<div data-spy="scroll" data-target="#list-example" data-offset="0" class="scrollspy-example">
				<div class="mypage-content">
					<h4 id="list-item-1">예매내역</h4>
						<p>Ex consequat commodo adipisicing exercitation aute excepteur occaecat ullamco duis aliqua id magna ullamco eu. Do aute ipsum ipsum ullamco cillum consectetur ut et aute consectetur labore. Fugiat laborum incididunt tempor eu consequat enim dolore proident. Qui laborum do non excepteur nulla magna eiusmod consectetur in. Aliqua et aliqua officia quis et incididunt voluptate non anim reprehenderit adipisicing dolore ut consequat deserunt mollit dolore. Aliquip nulla enim veniam non fugiat id cupidatat nulla elit cupidatat commodo velit ut eiusmod cupidatat elit dolore.</p>
				</div>
				<div class="mypage-content">
					<h4 id="list-item-2">찜목록</h4>

					<div class="owl-carousel owl-theme owl-loaded">
						<div class="owl-stage-outer">
							<div class="owl-stage">
								<c:forEach var="dto" items="${myChoiceList}">
									<div class="owl-item">
										<img src="${pageContext.request.contextPath}/uploads/performance/${dto.saveFilename}">
										<div class="card-img-overlay">
											<h5 class="card-title">${dto.subject}</h5>
											<button class="btn btn-success" type="button" style="z-index: 2;" onclick="location.href='${pageContext.request.contextPath}/performance/article?&perfNum=${dto.perfNum}&page=1&category=${dto.category=='뮤지컬'?'musical':dto.category=='연극'?'drama':'concert'}';"><i class="icofont-ticket" style="font-size: 1.5rem"></i></button>
											<button class="btn btn-danger btnDelete" type="button" style="z-index: 2;" data-perfNum="${dto.perfNum}"><i class="icofont-trash" style="font-size: 1.5rem;"></i></button>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
					<c:if test="${empty myChoiceList}"><p class="text-center">찜한 공연이 없습니다.</p></c:if>
				</div>
				
				<div class="mypage-content">
					<h4 id="list-item-3">나의 추천</h4>
						<p>Quis anim sit do amet fugiat dolor velit sit ea ea do reprehenderit culpa duis. Nostrud aliqua ipsum fugiat minim proident occaecat excepteur aliquip culpa aute tempor reprehenderit. Deserunt tempor mollit elit ex pariatur dolore velit fugiat mollit culpa irure ullamco est ex ullamco excepteur.</p>
				</div>
				
				<div class="mypage-content">
					<h4 id="list-item-4">쿠폰함</h4>
						<table class="table table-hover board-list">
							<thead class="table-light">
								<tr>
									<th class="bw-50">쿠폰번호</th>
									<th class="bw-80">할인가격</th>
									<th class="bw-130">사용기간</th>
									<th class="bw-80">상태</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="dto" items="${myCouponList}" >
									<tr>
										<td>${dto.couponNum}</td>
										<td>${dto.coupon} 원</td>
										<td>${dto.startDate} ~ ${dto.endDate}</td>
										<td>${dto.couponState}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<c:if test="${empty myCouponList}"><p class="text-center">등록된 쿠폰이 없습니다.</p></c:if>
				</div>
				
				<div class="mypage-content">
					<h4 id="list-item-5">포인트</h4>
					<div class="row justify-content-md-center">
						<div class="col-6 text-right"><span style="vertical-align: -webkit-baseline-middle;">사용가능한 포인트</span></div>
						<div style="font-size: 20px;"><span>${dto.point}</span></div>
						<div class="col-5 text-left"><span style="vertical-align: -webkit-baseline-middle;">P</span></div>
					</div>
				</div>
			</div>

		</div>
	</div>
</div>



