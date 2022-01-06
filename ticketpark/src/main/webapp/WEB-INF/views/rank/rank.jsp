<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
.star-ratings {
  color: #aaa9a9; 
  position: relative;
  unicode-bidi: bidi-override;
  width: max-content;
  -webkit-text-fill-color: transparent;
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

.click {
	cursor: pointer;
}
.table table-hover board-list {
	margin: 10px;
}
.img {
	max-width: 100px;
}

.nav {
	justify-content: center;
}
.table-title {
	pointer-events: none;
}
.nav-link {
	font-size: 18px;
}
.table td {
	vertical-align: middle;
	font-size: 16px;
}

</style>

<div class="container">
	<div class="body-container">
		<div class="body-title">
			<h3> 랭킹 </h3>
		</div>
		
		<div class="body-main">
            <div class="row">
                <div class="col-lg-12">
                    <div class="booking_menu">
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item" style="width: 120px; text-align: center;">
                            <a class="nav-link active" id="book-tab" data-toggle="tab" href="#book" role="tab" aria-controls="book" aria-selected="true">예매랭킹</a>
                            </li>
                            <li class="nav-item" style="width: 120px; text-align: center;">
                            <a class="nav-link" id="rating-tab" data-toggle="tab" href="#rating" role="tab" aria-controls="rating" aria-selected="false">평점랭킹</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="booking_content">
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="book" role="tabpanel" aria-labelledby="book-tab">
								<div class="bookRank">
									<table class="table table-hover board-list">
										<tr class="table-title">
											<td style="min-width: 35px;">랭킹</td>
											<td style="max-width: 300px; text-align: center;">공연명</td>
											<td style="text-align: center;">공연기간</td>
											<td style="text-align: center;">공연장</td>
											<td>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;평점</td>
											<td>&ensp;&ensp;&ensp;&ensp;&ensp;예매</td>
										</tr>
										<c:forEach var="vo" items="${bookRank}">
											<tr class="click" onclick="location.href='${articleUrl}&perfNum=${vo.perfNum}&category=all'">
											<td>
												${vo.rnum}
											</td>
											<td>
												<img class="img" src="${pageContext.request.contextPath}/uploads/performance/${vo.postFilename}">
												&ensp;&ensp;&ensp;&ensp;
												${vo.subject}
											</td>
											<td style="text-align: center;">
												${vo.startDate} ~ ${vo.endDate}
											</td>
											<td style="text-align: center;">
												${vo.hallName}
											</td>
											<td style="align-content: center;">
												<div class="star-ratings mb-3 ml-3" style="float: left; text-align: center;">
													<div class="star-ratings-fill space-x-2 text-lg" style=" width: ${vo.rating*20}% ">
														<span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span>
													</div>
													<div class="star-ratings-base space-x-2 text-lg">
														<span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span>
													</div>
												</div>
											</td>
											<td>
												<button type="button" class="btn btn-outline-secondary fh rhclrh"
													onclick="location.href='${articleUrl}&perfNum=${vo.perfNum}&category=all'">예매하기</button>
											</td>
											</tr>
										</c:forEach>
									</table>
								</div>
                            </div>
                            <div class="tab-pane fade" id="rating" role="tabpanel" aria-labelledby="rating-tab">
                               	<div class="ratingRank">
									<table class="table table-hover board-list">
										<tr class="table-title">
											<td style="min-width: 35px;">랭킹</td>
											<td style="max-width: 300px; text-align: center;">공연명</td>
											<td style="text-align: center;">공연기간</td>
											<td style="text-align: center;">공연장</td>
											<td>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;평점</td>
											<td>&ensp;&ensp;&ensp;&ensp;&ensp;예매</td>
										</tr>
										<c:forEach var="vo" items="${ratingRank}">
											<tr class="click" onclick="location.href='${articleUrl}&perfNum=${vo.perfNum}&category=all'">
											<td>
												${vo.rnum}
											</td>
											<td>
												<img class="img" src="${pageContext.request.contextPath}/uploads/performance/${vo.postFilename}">
												&ensp;&ensp;&ensp;&ensp;
												${vo.subject}
											</td>
											<td style="text-align: center;">
												${vo.startDate} ~ ${vo.endDate}
											</td>
											<td style="text-align: center;">
												${vo.hallName}
											</td>
											<td style="text-align: center;">
												<div class="star-ratings mb-3 ml-3" style="float: left;">
													<div class="star-ratings-fill space-x-2 text-lg" style=" width: ${vo.rating*20}% ">
														<span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span>
													</div>
													<div class="star-ratings-base space-x-2 text-lg">
														<span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span>
													</div>
												</div>
											</td>
											<td>
												<button type="button" class="btn btn-outline-secondary fh rhclrh"
													onclick="location.href='${articleUrl}&perfNum=${vo.perfNum}&category=all'">예매하기</button>
											</td>
											</tr>
										</c:forEach>
									</table>
								</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
		</div>
	</div>
</div>