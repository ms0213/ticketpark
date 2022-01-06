<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>
$(function(){
	$(".owl-carousel").owlCarousel({
		center: true,
        items: 3,
        margin: 10,
        responsive:{
        	600:{
        		items:6
        	}
        },
        loop: true,
        nav: true,
        navText: [
            "<i class='ti-angle-left'></i>",
            "<i class='ti-angle-right'></i>"
            ],
        autoplay: true,
        autoplayTimeout: 3000,
        autoplayHoverPause: true
    });
});

$(function(){
	$("#musicalDate").datepicker({
		format:"yyyy-mm-dd"
	});
	
	$("#dramaDate").datepicker({
		format:"yyyy-mm-dd"
	});
	
	$("#concertDate").datepicker({
		format:"yyyy-mm-dd"
	});
});

$("body").on("change", "#musicalGenre", function(){
	var f = $(this).val();
	$(".musicalparam").val(f);
});

$("body").on("change", "#dramaGenre", function(){
	var f = $(this).val();
	$(".dramaparam").val(f);
});

$("body").on("change", "#concertGenre", function(){
	var f = $(this).val();
	$(".concertparam").val(f);
});


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
			if(jqXHR.status === 400) {
				alert("요청 처리가 실패했습니다.");
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

$(function(){
	var url = "${pageContext.request.contextPath}/listGenreMain";
	var query = "";
	
	var fn = function(data) {
		$.each(data.listGenreMain, function(index, item){
			var genreNum = item.genreNum;
			var genre = item.genre;
			var categoryNum = parseInt(item.categoryNum);
			
			if(categoryNum === 1) {
				var s = "<option value='"+genreNum+"'>"+genre+"</option>";
				$("#musicalGenre").append(s);
			}
			if(categoryNum === 2) {
				var s = "<option value='"+genreNum+"'>"+genre+"</option>";
				$("#dramaGenre").append(s);
			}
			
			if(categoryNum === 3) {
				var s = "<option value='"+genreNum+"'>"+genre+"</option>";
				$("#concertGenre").append(s);
			}
		});
		$("#musicalGenre").addClass("nc_select");
		$("#dramaGenre").addClass("nc_select");
		$("#concertGenre").addClass("nc_select");

	};
	ajaxFun(url, "get", query, "json", fn);

});

$(function(){
	$(this).find('.po-title-date').hide();
	
	$('.single_event_slider').mouseenter(function(){
	  $(this).find('.po-title-date').show();
	});
	$('.single_event_slider').mouseleave(function(){
	 $(this).find('.po-title-date').hide();
	});
});
</script>
<style>
.form-select {
	padding-left: 16px;
}

.booking_part .form-row {
	justify-content: space-evenly;
}
.form-select {
	width: 100%;
    border-color: #2493e0;
    border-radius: 0;
    color: #2493e0;
    height: 50px;
    display: flex;
    align-items: center;

}

@media (min-width: 768px)
.col-md-6 {
    flex: 0 0 auto;
    width: 100%;
}

.event_part .owl-nav button {
	width:100px;
	height:100px;
	top: 36%;
	background-color: RGBA(255,255,255,0.5) !important;
	color: black !important;
	margin: 0;
}
.event_part .owl-nav button.owl-prev {
  left: 166px;
}
.event_part .owl-nav button.owl-next {
  right: 166px;
}
.po-title {
	max-width: 100%;
	font-size: 20px;
	overflow:hidden;
	text-overflow:ellipsis;
	white-space:nowrap;
	text-align: center;
	font-family: 'tp' !important;
	color: #212529;
}
.po-title-date {
	text-align: center;
	font-family: 'tp' !important;
	color: #212529;
	font-size: 16px;
}

.container  .abc {
	box-shadow: 0px 10px 40px 0px rgb(221 221 221 / 30%);
}

.single_review_slider .hhh {
	color: #38cc2d;
}

.star-ratings {
  color: #aaa9a9; 
  position: relative;
  unicode-bidi: bidi-override;
  width: max-content;
  -webkit-text-fill-color: white;
  -webkit-text-stroke-width: 1px;
  -webkit-text-stroke-color: #2b2a29;
}
 
.star-ratings-fill {
  color: #fff58c;
  padding: 0;
  position: absolute;
  z-index: 1;
  display: flex;
  top: 0;
  left: 0;
  overflow: hidden;
  -webkit-text-fill-color: gold;
}

.star-ratings .icofont-star {font-size: 1.5rem;}

.star-ratings-base {
  z-index: 0;
  padding: 0;
}

.col-md-8 {
	cursor: pointer;
}
.col-md-4 {
	cursor: pointer;
}

.row .g-0 {


}

.click {
	cursor: pointer;
}
.table table-hover board-list {
	margin: 10px;
}
.nav-link {
	font-size: 18px;
}
.table td {
	vertical-align: middle;
}
.rightdiv { }
.videodiv { }
.articlediv { width: 60%; }
.rankdiv { }

.booking_part .nav-link.active {
    border-bottom: 3px solid rgb(60 148 54) !important;
}

input::placeholder {
  color: black !important;
}
input[name=keyAddr] {
	border-color:  rgb(60 148 54);
	border-width: 1px;
}

input[name=keyDate] {
	border-color:  rgb(60 148 54);
	border-width: 1px;
}

select[name=condiGenre] {
	border-color:  rgb(60 148 54);
	border-style: 1px;
	color: black !important;
}

.gj-icon {
    color: rgb(60 148 54) !important;
}

.ti-angle-left {
	color: rgb(60 148 54) !important;
}

.ti-angle-right {
	color: rgb(60 148 54) !important; 
}


</style>
	<!--top place start-->
    <section class="event_part" style="padding: 50px 0; min-height: 600px;">

	<div class="owl-carousel owl-theme owl-loaded">
		<c:forEach var="vo" items="${listPerformance}" varStatus="status">
			<div class="single_event_slider">
				<a class="link" href="${pageContext.request.contextPath}/performance/article?perfNum=${vo.perfNum}&page=1&category=${vo.category}" title="${vo.subject}">
				<img src="${pageContext.request.contextPath}/uploads/performance/${vo.postFileName}"
					class="d-block" alt="${vo.subject}" style="width: 244.825px; height: 326.425px; margin: 0 auto;">
				</a>
				<p class="po-title">${vo.subject}</p>
				<p class="po-title-date">${vo.hallName}</p>
				<p class="po-title-date">${vo.startDate}~${vo.endDate}</p>
			</div>
		</c:forEach>
	</div>

</section>
    <!--top place end-->
    


    <!-- booking part start-->
    <section class="booking_part">
        <div class="container">
            <div class="row abc">
                <div class="col-lg-12">
                    <div class="booking_menu">
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item">
                            <a class="nav-link active" id="musical-tab" data-toggle="tab" href="#musical" role="tab" aria-controls="musical" aria-selected="true" style="color: black;">뮤지컬</a>
                            </li>
                            <li class="nav-item">
                            <a class="nav-link" id="drama-tab" data-toggle="tab" href="#drama" role="tab" aria-controls="drama" aria-selected="false" style="color: black;">연극</a>
                            </li>
                            <li class="nav-item">
                            <a class="nav-link" id="concert-tab" data-toggle="tab" href="#concert" role="tab" aria-controls="concert" aria-selected="false" style="color: black;">콘서트</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="booking_content">
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="musical" role="tabpanel" aria-labelledby="musical-tab">
                                <div class="booking_form">
                                    <form name="musicalForm  pt-15 mx-auto" action="${pageContext.request.contextPath}/performance/list" method="post">
                                        <div class="form-row">
                                            <div class="form_colum">
                                                <input class="form-select" type="text" name="keyAddr" value="${keyAddr}" placeholder="지역" >
                                            </div>
                                            <div class="form_colum">
                                                <select class="form-select" name="condiGenre" id="musicalGenre" style="border-color: rgb(60 148 54); border-style: 1px;">
                                                	<option value="">장르</option>
                                                </select>
                                            </div>
                                            <div class="form_colum">
                                                <input type="text" readonly="readonly" name="keyDate" value="${keyDate}" id="musicalDate" placeholder="날짜" style="border-color:  rgb(60 148 54); border-style: 1px;">
                                            </div>
                                            
                                            <div class="form_btn">
                                                <button type="submit" class="btn_1" style="border: none; background-color: rgb(60 148 54);">검색하기</button>
                                                <input type="hidden" name="category" value="musical">
												
												<input type="hidden" class="musicalparam" name="keyGenre" value="">
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="drama" role="tabpanel" aria-labelledby="drama-tab">
                                <div class="booking_form">
                                    <form name="dramaForm" action="${pageContext.request.contextPath}/performance/list" method="post">
                                        <div class="form-row">
                                            <div class="form_colum">
                                                <input class="form-select" type="text" name="keyAddr" value="${keyAddr}" placeholder="지역">
                                            </div>
                                            <div class="form_colum">
                                                <select class="form-select" name="condiGenre" id="dramaGenre" style="border-color:  rgb(60 148 54); border-style: 1px;">
                                                	<option value="">장르</option>
                                                </select>
                                            </div>
											<div class="form_colum">
                                                <input type="text" readonly="readonly" name="keyDate" value="${keyDate}" id="dramaDate" placeholder="날짜" style="border-color:  rgb(60 148 54); border-style: 1px;">
                                            </div>
                                            
                                            <div class="form_btn">
                                                <button type="submit" class="btn_1" style="border: none;  background-color: rgb(60 148 54);">검색하기</button>
                                                <input type="hidden" name="category" value="drama">
												
												<input type="hidden" class="dramaparam" name="keyGenre" value="">
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="concert" role="tabpanel" aria-labelledby="concert-tab">
                                <div class="booking_form">
                                    <form name="concertForm" action="${pageContext.request.contextPath}/performance/list" method="post">
                                        <div class="form-row" >
                                            <div class="form_colum">
                                                <input class="form-select" type="text" name="keyAddr" value="${keyAddr}" placeholder="지역">
                                            </div>
                                           <div class="form_colum">
                                                <select class="form-select" name="condiGenre" id="concertGenre" style="border-color:  rgb(60 148 54); border-style: 1px;">
                                                	<option value="">장르</option>
                                                </select>
                                            </div>
                                            <div class="form_colum">
                                                <input type="text" readonly="readonly" name="keyDate" value="${keyDate}" id="concertDate" placeholder="날짜" style="border-color:  rgb(60 148 54); border-style: 1px;">
                                            </div>
                                             <div class="form_btn">
                                                <button type="submit" class="btn_1" style="border: none; background-color: rgb(60 148 54);">검색하기</button>
                                                <input type="hidden" name="category" value="concert">
												
												<input type="hidden" class="concertparam" name="keyGenre" value="">
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Header part end-->

    <!--top place start-->
    <section class="top_place section_padding">
        <div class="container">
           
            <div class="row justify-content-center">
            <div class="articlediv mr-3">
                <c:forEach var="dto" items="${listArticle}">
                	<div class="row g-0" onclick="location.href='${pageContext.request.contextPath}/article/article?page=1&num=${dto.artiNum}';">
						<div class="col-md-4 mt-4">
							<c:forEach var="vo" items="${dto.saveFilename}" varStatus="status">
								<c:if test="${status.index==0}">
									<div class="align-middle" style="height: 80%;">
									<img src="${pageContext.request.contextPath}/uploads/article/${dto.saveFilename}"
										 class="img-fluid rounded-start" style="object-fit: cover; height: 100%;">			
									</div>						
								</c:if>
							</c:forEach>
						</div>							
						<div class="col-md-8">
							<div class="card-body">
								<h5 class="card-title">${dto.subject}</h5>
								<p class="card-text">${dto.atName}</p>
								<p class="card-text">작성자 : ${dto.userName}</p>
								<p class="card-text">게시일 : ${dto.reg_date}</p>
								<p class="card-text" style="overflow:hidden;  text-overflow:ellipsis; 
									display:-webkit-box; -webkit-line-clamp:3; -webkit-box-orient:vertical;">${dto.content}</p>
							</div>
							
						</div>
					</div>
					<hr>
					</c:forEach>
					</div>
					
					<div class="rightdiv ml-5">
					<div class="rankdiv">
                    <div class="booking_menu">
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item" style="text-align: center;">
                            <a class="nav-link active" id="book-tab" data-toggle="tab" href="#book" role="tab" aria-controls="book" aria-selected="true">예매랭킹</a>
                            </li>
                            <li class="nav-item" style="text-align: center;">
                            <a class="nav-link" id="rating-tab" data-toggle="tab" href="#rating" role="tab" aria-controls="rating" aria-selected="false">평점랭킹</a>
                            </li>
                        </ul>
                    </div>

                    <div class="booking_content">
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="book" role="tabpanel" aria-labelledby="book-tab">
								<div class="bookRank">
									<table class="table table-hover board-list">
										<c:forEach var="eo" items="${bookRank}">
											<tr class="click" onclick="location.href='${pageContext.request.contextPath}/performance/article?page=1&perfNum=${eo.perfNum}&category=all'">
											<td>
												${eo.rnum}
											</td>
											<td>			
												${eo.subject}
											</td>

											<td style="align-content: center;">
												${eo.rate}
											</td>
											</tr>
										</c:forEach>
									</table>
								</div>
                            </div>
                            <div class="tab-pane fade" id="rating" role="tabpanel" aria-labelledby="rating-tab">
                               	<div class="ratingRank">
									<table class="table table-hover board-list">
										<c:forEach var="eo" items="${ratingRank}">
											<tr class="click" onclick="location.href='${pageContext.request.contextPath}/performance/article?page=1&perfNum=${eo.perfNum}&category=all'">
											<td>
												${eo.rnum}
											</td>
											<td>
												${eo.subject}
											</td>
											<td style="text-align: center;">
												<span><i class="icofont-star"></i></span>${eo.rating}
											</td>
											</tr>
										</c:forEach>
									</table>
								</div>
                            </div>
                        </div>
                    </div>
                </div>
					
					
					
		
					
					<div class="videodiv">
					<h4 style="padding-top: 70px;">영상클립<a style="float: right;" href="${pageContext.request.contextPath}/video/list">더보기</a></h4>
					<c:forEach var="xo" items="${listVideo}" varStatus="status">
				 		<div class="col-md-4 col-lg-3 p-3 item">
				 			<div class="card" style="width: 18rem;">
								<iframe src="${xo.link}">지원X</iframe>
								<div class="card-body" onclick="location.href='${xo.link}'">
									<h5 class="card-title">${xo.subject}</h5>
									<p class="card-text text-truncate">${xo.content}</p>
								</div>
							</div>
				 		</div>
			 		</c:forEach>
			 		</div>
			 		</div>
            </div>
        </div>
    </section>
    <!--top place end-->

    

   

    <!--top place start-->
    <section class="client_review section_padding">
        <div class="container">
            <div class="row ">
                <div class="col-xl-6">
                    <div class="section_tittle">
                        <h2>Best Review</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="client_review_slider owl-carousel">
                    
                    	<c:forEach var="io" items="${listReview}">
	                    	<div class="single_review_slider">
	                    		<p>${io.content}</p>
	                    		<div class="star-ratings mb-3 ml-3" style="float: right;">
									<div class="star-ratings-fill space-x-2 text-lg" style=" width: ${io.rate*20}% ">
										<span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span>
									</div>
									<div class="star-ratings-base space-x-2 text-lg">
										<span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span>
									</div>
								</div>
	                    		<h5>${io.userId}</h5>
	                    		<h6 class="hhh">(${io.subject} 예매자)</h6>
	                    	</div>
						</c:forEach>

                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--top place end-->

    <!--::industries start::-->
    <section class="best_services section_padding">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-xl-6">
                    <div class="section_tittle text-center">
                        <h2>We offered best services</h2>
                        <p>Waters make fish every without firmament saw had. Morning air subdue. Our. Air very one. Whales grass is fish whales winged.</p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-3 col-sm-6">
                    <div class="single_ihotel_list">
                        <img src="${pageContext.request.contextPath}/resources/images1/services_1.png" alt="">
                        <h3> <a href="#"> Transportation</a></h3>
                        <p>All transportation cost we bear</p>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="single_ihotel_list">
                        <img src="${pageContext.request.contextPath}/resources/images1/services_2.png" alt="">
                        <h3> <a href="#"> Guidence</a></h3>
                        <p>We offer the best guidence for you</p>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="single_ihotel_list">
                        <img src="${pageContext.request.contextPath}/resources/images1/services_3.png" alt="">
                        <h3> <a href="#"> Accomodation</a></h3>
                        <p>Luxarious and comfortable</p>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="single_ihotel_list">
                        <img src="${pageContext.request.contextPath}/resources/images1/services_4.png" alt="">
                        <h3> <a href="#"> Discover world</a></h3>
                        <p>Best tour plan for your next tour</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--::industries end::-->