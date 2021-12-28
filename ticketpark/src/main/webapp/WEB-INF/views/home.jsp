<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>
$(function(){
	$(".owl-carousel").owlCarousel({
        items: 5,
        margin: 10,
        loop: true,
        nav: true,
        autoplay: false,
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
</script>
<style>
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
</style>
	<!--top place start-->
    <section class="event_part section_padding">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
	               	<ol class="carousel-indicators">
						<c:forEach var="vo" items="${listPerformance}" varStatus="status">
							<li data-target="#carouselExampleIndicators" 
								data-slide-to="${status.index}" class="${status.index ==0 ? 'active' : '' }"></li>
						</c:forEach>
					</ol>
					
					<div class="owl-carousel" >
						<c:forEach var="vo" items="${listPerformance}" varStatus="status">
							<div class="single_event_slider">
							<a class="link" href="${pageContext.request.contextPath}/performance/article?perfNum=${vo.perfNum}&page=1&category=${vo.category}" title="${vo.subject}">
	                            <img src="${pageContext.request.contextPath}/uploads/performance/${vo.postFileName}" class="d-block w-100" alt="${vo.subject}" style="height: 300px; width: 200px;">
	                            <span>${vo.subject}</span>
							</a>
	                        </div>
                        </c:forEach>
                    </div>
                    
				</div>
            </div>
        </div>
    </section>
    <!--top place end-->
    
    <!-- banner part start-->
    <section class="banner_part">
        <div class="container">
            <div class="row align-items-center justify-content-center">
                <div class="col-lg-10">
                    <div class="banner_text text-center">
                        <div class="banner_text_iner">
                            <h1> Saintmartine</h1>
                            <p>Let’s start your journey with us, your dream will come true</p>
                            <a href="#" class="btn_1">Discover Now</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- banner part start-->

    <!-- booking part start-->
    <section class="booking_part">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="booking_menu">
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item">
                            <a class="nav-link active" id="musical-tab" data-toggle="tab" href="#musical" role="tab" aria-controls="musical" aria-selected="true">뮤지컬</a>
                            </li>
                            <li class="nav-item">
                            <a class="nav-link" id="drama-tab" data-toggle="tab" href="#drama" role="tab" aria-controls="drama" aria-selected="false">연극</a>
                            </li>
                            <li class="nav-item">
                            <a class="nav-link" id="concert-tab" data-toggle="tab" href="#concert" role="tab" aria-controls="concert" aria-selected="false">콘서트</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="booking_content">
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="musical" role="tabpanel" aria-labelledby="musical-tab">
                                <div class="booking_form">
                                    <form name="musicalForm" action="${pageContext.request.contextPath}/performance/list" method="post">
                                        <div class="form-row">
                                            <div class="form_colum">
                                                <input class="form-select" type="text" name="keyAddr" value="${keyAddr}" placeholder="지역">
                                            </div>
                                            <div class="form_colum">
                                                <select name="condiGenre" id="musicalGenre">
                                                	<option value="">장르</option>
                                                </select>
                                            </div>
                                            <div class="form_colum">
                                                <input type="text" readonly="readonly" name="keyDate" value="${keyDate}" id="musicalDate" placeholder="날짜">
                                            </div>
                                            
                                            <div class="form_btn">
                                                <button type="submit" class="btn_1" style="border: none;">검색하기</button>
                                                <input type="hidden" name="category" value="musical">
												<input type="hidden" name="categoryNum" value="1">
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
                                                <select name="condiGenre" id="dramaGenre">
                                                	<option value="">장르</option>
                                                </select>
                                            </div>
											<div class="form_colum">
                                                <input type="text" readonly="readonly" name="keyDate" value="${keyDate}" id="dramaDate" placeholder="날짜">
                                            </div>
                                            
                                            <div class="form_btn">
                                                <button type="submit" class="btn_1" style="border: none;">검색하기</button>
                                                <input type="hidden" name="category" value="drama">
												<input type="hidden" name="categoryNum" value="2">
												<input type="hidden" class="dramaparam" name="keyGenre" value="">
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="concert" role="tabpanel" aria-labelledby="concert-tab">
                                <div class="booking_form">
                                    <form name="concertForm" action="${pageContext.request.contextPath}/performance/list" method="post">
                                        <div class="form-row">
                                            <div class="form_colum">
                                                <input class="form-select" type="text" name="keyAddr" value="${keyAddr}" placeholder="지역">
                                            </div>
                                           <div class="form_colum">
                                                <select name="condiGenre" id="concertGenre">
                                                	<option value="">장르</option>
                                                </select>
                                            </div>
                                            <div class="form_colum">
                                                <input type="text" readonly="readonly" name="keyDate" value="${keyDate}" id="concertDate" placeholder="날짜">
                                            </div>
                                             <div class="form_btn">
                                                <button type="submit" class="btn_1" style="border: none;">검색하기</button>
                                                <input type="hidden" name="category" value="concert">
												<input type="hidden" name="categoryNum" value="3">
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
                <div class="col-xl-6">
                    <div class="section_tittle text-center">
                        <h2>Top Places to visit</h2>
                        <p>Waters make fish every without firmament saw had. Morning air subdue. Our. Air very one. Whales grass is fish whales winged.</p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6 col-md-6">
                    <div class="single_place">
                        <img src="${pageContext.request.contextPath}/resources/images1/single_place_1.png" alt="">
                        <div class="hover_Text d-flex align-items-end justify-content-between">
                            <div class="hover_text_iner">
                                <a href="#" class="place_btn">travel</a>
                                <h3>Saintmartine Iceland</h3>
                                <p>Technaf, Bangladesh</p>
                                <div class="place_review">
                                    <a href="#"><i class="fas fa-star"></i></a>
                                    <a href="#"><i class="fas fa-star"></i></a>
                                    <a href="#"><i class="fas fa-star"></i></a>
                                    <a href="#"><i class="fas fa-star"></i></a>
                                    <a href="#"><i class="fas fa-star"></i></a>
                                    <span>(210 review)</span>
                                </div>
                            </div>
                            <div class="details_icon text-right">
                                <i class="ti-share"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="single_place">
                        <img src="${pageContext.request.contextPath}/resources/images1/single_place_2.png" alt="">
                        <div class="hover_Text d-flex align-items-end justify-content-between">
                            <div class="hover_text_iner">
                                <a href="#" class="place_btn">travel</a>
                                <h3>Saintmartine Iceland</h3>
                                <p>Technaf, Bangladesh</p>
                                <div class="place_review">
                                    <a href="#"><i class="fas fa-star"></i></a>
                                    <a href="#"><i class="fas fa-star"></i></a>
                                    <a href="#"><i class="fas fa-star"></i></a>
                                    <a href="#"><i class="fas fa-star"></i></a>
                                    <a href="#"><i class="fas fa-star"></i></a>
                                    <span>(210 review)</span>
                                </div>
                            </div>
                            <div class="details_icon text-right">
                                <i class="ti-share"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="single_place">
                        <img src="${pageContext.request.contextPath}/resources/images1/single_place_3.png" alt="">
                        <div class="hover_Text d-flex align-items-end justify-content-between">
                            <div class="hover_text_iner">
                                <a href="#" class="place_btn">travel</a>
                                <h3>Saintmartine Iceland</h3>
                                <p>Technaf, Bangladesh</p>
                                <div class="place_review">
                                    <a href="#"><i class="fas fa-star"></i></a>
                                    <a href="#"><i class="fas fa-star"></i></a>
                                    <a href="#"><i class="fas fa-star"></i></a>
                                    <a href="#"><i class="fas fa-star"></i></a>
                                    <a href="#"><i class="fas fa-star"></i></a>
                                    <span>(210 review)</span>
                                </div>
                            </div>
                            <div class="details_icon text-right">
                                <i class="ti-share"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="single_place">
                        <img src="${pageContext.request.contextPath}/resources/images1/single_place_4.png" alt="">
                        <div class="hover_Text d-flex align-items-end justify-content-between">
                            <div class="hover_text_iner">
                                <a href="#" class="place_btn">travel</a>
                                <h3>Saintmartine Iceland</h3>
                                <p>Technaf, Bangladesh</p>
                                <div class="place_review">
                                    <a href="#"><i class="fas fa-star"></i></a>
                                    <a href="#"><i class="fas fa-star"></i></a>
                                    <a href="#"><i class="fas fa-star"></i></a>
                                    <a href="#"><i class="fas fa-star"></i></a>
                                    <a href="#"><i class="fas fa-star"></i></a>
                                    <span>(210 review)</span>
                                </div>
                            </div>
                            <div class="details_icon text-right">
                                <i class="ti-share"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <a href="#" class="btn_1 text-cnter">Discover more</a>
            </div>
        </div>
    </section>
    <!--top place end-->

    

    <!--::industries start::-->
    <section class="hotel_list section_padding">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-xl-6">
                    <div class="section_tittle text-center">
                        <h2>Top Hotel & Restaurants</h2>
                        <p>Waters make fish every without firmament saw had. Morning air subdue. Our. Air very one. Whales grass is fish whales winged.</p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-sm-6">
                    <div class="single_ihotel_list">
                        <img src="${pageContext.request.contextPath}/resources/images1/ind/industries_1.png" alt="">
                        <div class="hover_text">
                            <div class="hotel_social_icon">
                                <ul>
                                    <li><a href="#"><i class="ti-facebook"></i></a></li>
                                    <li><a href="#"><i class="ti-twitter-alt"></i></a></li>
                                    <li><a href="#"><i class="ti-linkedin"></i></a></li>
                                </ul>
                            </div>
                            <div class="share_icon">
                                <i class="ti-share"></i>
                            </div>
                        </div>
                        <div class="hotel_text_iner">
                            <h3> <a href="#"> Hotel Polonia</a></h3>
                            <div class="place_review">
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <span>(210 review)</span>
                            </div>
                            <p>London, United Kingdom</p>
                            <h5>From <span>$500</span></h5>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <div class="single_ihotel_list">
                        <img src="${pageContext.request.contextPath}/resources/images1/ind/industries_2.png" alt="">
                        <div class="hover_text">
                            <div class="hotel_social_icon">
                                <ul>
                                    <li><a href="#"><i class="ti-facebook"></i></a></li>
                                    <li><a href="#"><i class="ti-twitter-alt"></i></a></li>
                                    <li><a href="#"><i class="ti-linkedin"></i></a></li>
                                </ul>
                            </div>
                            <div class="share_icon">
                                <i class="ti-share"></i>
                            </div>
                        </div>
                        <div class="hotel_text_iner">
                            <h3> <a href="#"> Hotel Polonia</a></h3>
                            <div class="place_review">
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <span>(210 review)</span>
                            </div>
                            <p>London, United Kingdom</p>
                            <h5>From <span>$500</span></h5>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <div class="single_ihotel_list">
                        <img src="${pageContext.request.contextPath}/resources/images1/ind/industries_3.png" alt="">
                        <div class="hover_text">
                            <div class="hover_text">
                                <div class="hotel_social_icon">
                                    <ul>
                                        <li><a href="#"><i class="ti-facebook"></i></a></li>
                                        <li><a href="#"><i class="ti-twitter-alt"></i></a></li>
                                        <li><a href="#"><i class="ti-linkedin"></i></a></li>
                                    </ul>
                                </div>
                                <div class="share_icon">
                                    <i class="ti-share"></i>
                                </div>
                            </div>
                        </div>
                        <div class="hotel_text_iner">
                            <h3> <a href="#"> Hotel Polonia</a></h3>
                            <div class="place_review">
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <span>(210 review)</span>
                            </div>
                            <p>London, United Kingdom</p>
                            <h5>From <span>$500</span></h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--::industries end::-->

    <!--top place start-->
    <section class="client_review section_padding">
        <div class="container">
            <div class="row ">
                <div class="col-xl-6">
                    <div class="section_tittle">
                        <h2>What they said</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="client_review_slider owl-carousel">
                        <div class="single_review_slider">
                            <div class="place_review">
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                            </div>
                            <p>Waters make fish every without firmament saw had. Morning air subdue. Our Air very one whales grass is fish whales winged night yielding land creeping that seed </p>
                            <h5> - Allen Miller</h5>
                        </div>
                        <div class="single_review_slider">
                            <div class="place_review">
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                            </div>
                            <p>Waters make fish every without firmament saw had. Morning air subdue. Our Air very one whales grass is fish whales winged night yielding land creeping that seed </p>
                            <h5> - Allen Miller</h5>
                        </div>
                        <div class="single_review_slider">
                            <div class="place_review">
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                            </div>
                            <p>Waters make fish every without firmament saw had. Morning air subdue. Our Air very one whales grass is fish whales winged night yielding land creeping that seed </p>
                            <h5> - Allen Miller</h5>
                        </div>
                        <div class="single_review_slider">
                            <div class="place_review">
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                            </div>
                            <p>Waters make fish every without firmament saw had. Morning air subdue. Our Air very one whales grass is fish whales winged night yielding land creeping that seed </p>
                            <h5> - Allen Miller</h5>
                        </div>
                        <div class="single_review_slider">
                            <div class="place_review">
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                            </div>
                            <p>Waters make fish every without firmament saw had. Morning air subdue. Our Air very one whales grass is fish whales winged night yielding land creeping that seed </p>
                            <h5> - Allen Miller</h5>
                        </div>
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