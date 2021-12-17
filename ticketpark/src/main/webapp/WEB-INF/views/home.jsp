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
</script>
<style>
.col-lg-6 {

	width: 100%;
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
	                            <img src="${pageContext.request.contextPath}/uploads/performance/${vo.saveFilename}" class="d-block w-100" alt="${vo.subject}" style="height: 300px; width: 200px;">
	                            <p>${vo.subject}</p>
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
                            <a class="nav-link active" id="hotel-tab" data-toggle="tab" href="#hotel" role="tab" aria-controls="hotel" aria-selected="true">뮤지컬</a>
                            </li>
                            <li class="nav-item">
                            <a class="nav-link" id="tricket-tab" data-toggle="tab" href="#tricket" role="tab" aria-controls="tricket" aria-selected="false">연극</a>
                            </li>
                            <li class="nav-item">
                            <a class="nav-link" id="place-tab" data-toggle="tab" href="#place" role="tab" aria-controls="place" aria-selected="false">콘서트</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="booking_content">
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="hotel" role="tabpanel" aria-labelledby="hotel-tab">
                                <div class="booking_form">
                                    <form action="#">
                                        <div class="form-row">
                                            <div class="form_colum">
                                                <select class="nc_select">
                                                    <option selected> 지역 </option>
                                                    <option value="1">서울</option>
                                                    <option value="2">인천</option>
                                                    <option value="3">경기</option>
                                                </select>
                                            </div>
                                            <div class="form_colum">
                                                <select class="nc_select">
                                                    <option selected> 장르 </option>
                                                    <option value="1"></option>
                                                    <option value="2"></option>
                                                    <option value="3"></option>
                                                </select>
                                            </div>
                                            <div class="form_colum">
                                                <input id="datepicker_1" placeholder="날짜">
                                            </div>
                                            <div class="form_colum">
                                                <select class="nc_select">
                                                    <option selected> 인원 수 </option>
                                                    <option value="1">1</option>
                                                    <option value="2">2</option>
                                                    <option value="3">3</option>
                                                </select>
                                            </div>
                                            
                                            <div class="form_btn">
                                                <a href="#" class="btn_1">검색하기</a>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="tricket" role="tabpanel" aria-labelledby="tricket-tab">
                                <div class="booking_form">
                                    <form action="#">
                                        <div class="form-row">
                                            <div class="form_colum">
                                                <select class="nc_select">
                                                    <option selected> 지역 </option>
                                                    <option value="1">서울</option>
                                                    <option value="2">인천</option>
                                                    <option value="3">경기</option>
                                                </select>
                                            </div>
                                            <div class="form_colum">
                                                <select class="nc_select">
                                                    <option selected> 장르 </option>
                                                    <option value="1"></option>
                                                    <option value="2"></option>
                                                    <option value="3"></option>
                                                </select>
                                            </div>
                                            <div class="form_colum">
                                                <input id="datepicker_2" placeholder="날짜">
                                            </div>
                                            <div class="form_colum">
                                                <select class="nc_select">
                                                    <option selected> 인원 수 </option>
                                                    <option value="1">1</option>
                                                    <option value="2">2</option>
                                                    <option value="3">3</option>
                                                </select>
                                            </div>
                                            
                                            <div class="form_btn">
                                                <a href="#" class="btn_1">검색하기</a>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="place" role="tabpanel" aria-labelledby="place-tab">
                                <div class="booking_form">
                                    <form action="#">
                                        <div class="form-row">
                                            <div class="form_colum">
                                                <select class="nc_select">
                                                    <option selected> 지역 </option>
                                                    <option value="1">서울</option>
                                                    <option value="2">인천</option>
                                                    <option value="3">경기</option>
                                                </select>
                                            </div>
                                            <div class="form_colum">
                                                <select class="nc_select">
                                                    <option selected> 장르 </option>
                                                    <option value="1"></option>
                                                    <option value="2"></option>
                                                    <option value="3"></option>
                                                </select>
                                            </div>
                                            <div class="form_colum">
                                                <input id="datepicker_3" placeholder="날짜">
                                            </div>
                                            <div class="form_colum">
                                                <select class="nc_select">
                                                    <option selected> 인원 수 </option>
                                                    <option value="1">1</option>
                                                    <option value="2">2</option>
                                                    <option value="3">3</option>
                                                </select>
                                            </div>
                                            
                                            <div class="form_btn">
                                                <a href="#" class="btn_1">검색하기</a>
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