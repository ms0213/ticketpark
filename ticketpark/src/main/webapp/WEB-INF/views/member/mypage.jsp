<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
#list-example {
	position: absolute;
}

.selected { 
	background: #eaefff;
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
			<h3> 마이페이지  </h3>
		</div>
		
		<div class="body-main">
			<div data-spy="scroll" data-target="#list-example" data-offset="0" class="scrollspy-example">
				<h4 id="list-item-1">예매내역</h4>
					<p>Ex consequat commodo adipisicing exercitation aute excepteur occaecat ullamco duis aliqua id magna ullamco eu. Do aute ipsum ipsum ullamco cillum consectetur ut et aute consectetur labore. Fugiat laborum incididunt tempor eu consequat enim dolore proident. Qui laborum do non excepteur nulla magna eiusmod consectetur in. Aliqua et aliqua officia quis et incididunt voluptate non anim reprehenderit adipisicing dolore ut consequat deserunt mollit dolore. Aliquip nulla enim veniam non fugiat id cupidatat nulla elit cupidatat commodo velit ut eiusmod cupidatat elit dolore.</p>
				<h4 id="list-item-2">찜목록</h4>
					<p>Quis magna Lorem anim amet ipsum do mollit sit cillum voluptate ex nulla tempor. Laborum consequat non elit enim exercitation cillum aliqua consequat id aliqua. Esse ex consectetur mollit voluptate est in duis laboris ad sit ipsum anim Lorem. Incididunt veniam velit elit elit veniam Lorem aliqua quis ullamco deserunt sit enim elit aliqua esse irure. Laborum nisi sit est tempor laborum mollit labore officia laborum excepteur commodo non commodo dolor excepteur commodo. Ipsum fugiat ex est consectetur ipsum commodo tempor sunt in proident.</p>
				<h4 id="list-item-3">나의 추천</h4>
					<p>Quis anim sit do amet fugiat dolor velit sit ea ea do reprehenderit culpa duis. Nostrud aliqua ipsum fugiat minim proident occaecat excepteur aliquip culpa aute tempor reprehenderit. Deserunt tempor mollit elit ex pariatur dolore velit fugiat mollit culpa irure ullamco est ex ullamco excepteur.</p>
				<h4 id="list-item-4">쿠폰함</h4>
					<p>Quis anim sit do amet fugiat dolor velit sit ea ea do reprehenderit culpa duis. Nostrud aliqua ipsum fugiat minim proident occaecat excepteur aliquip culpa aute tempor reprehenderit. Deserunt tempor mollit elit ex pariatur dolore velit fugiat mollit culpa irure ullamco est ex ullamco excepteur.</p>
				<h4 id="list-item-5">포인트</h4>
					<p>Quis anim sit do amet fugiat dolor velit sit ea ea do reprehenderit culpa duis. Nostrud aliqua ipsum fugiat minim proident occaecat excepteur aliquip culpa aute tempor reprehenderit. Deserunt tempor mollit elit ex pariatur dolore velit fugiat mollit culpa irure ullamco est ex ullamco excepteur.</p>
			</div>

		</div>
	</div>
</div>



