<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
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
.nav-item {
	width: 120px;
	text-align: center;
}
</style>

<div class="container">
	<div class="body-container">
		<div class="body-title">
			<h3><i class="bi bi-trophy-fill"></i> 랭킹 </h3>
		</div>
		
		<div class="body-main">
            <div class="row">
                <div class="col-lg-12">
                    <div class="booking_menu">
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item">
                            <a class="nav-link active" id="book-tab" data-toggle="tab" href="#book" role="tab" aria-controls="book" aria-selected="true">예매랭킹</a>
                            </li>
                            <li class="nav-item">
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
											<td style="min-width: 300px; text-align: center;">공연명</td>
											<td style="text-align: center;">공연기간</td>
											<td style="text-align: center;">공연장</td>
											<td>평점</td>
										</tr>
										<c:forEach var="vo" items="${bookRank}">
											<tr class="click" onclick="location.href='${articleUrl}&perfNum=${vo.perfNum}&category=all'">
											<td>
											<br>
											<br>
												${vo.rnum}
											</td>
											<td>
												<img class="img" src="${pageContext.request.contextPath}/uploads/performance/${vo.postFilename}">
												&ensp;&ensp;&ensp;&ensp;
												${vo.subject}
											</td>
											<td style="text-align: center;">
											<br>
											<br>
												${vo.startDate} ~ ${vo.endDate}
											</td>
											<td style="text-align: center;">
											<br>
											<br>
												${vo.hallName}
											</td>
											<td style="text-align: center;">
											<br>
											<br>
												${vo.rating}
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
											<td style="min-width: 300px; text-align: center;">공연명</td>
											<td style="text-align: center;">공연기간</td>
											<td style="text-align: center;">공연장</td>
											<td>평점</td>
										</tr>
										<c:forEach var="vo" items="${ratingRank}">
											<tr class="click" onclick="location.href='${articleUrl}&perfNum=${vo.perfNum}&category=all'">
											<td>
											<br>
											<br>
												${vo.rnum}
											</td>
											<td>
												<img class="img" src="${pageContext.request.contextPath}/uploads/performance/${vo.postFilename}">
												&ensp;&ensp;&ensp;&ensp;
												${vo.subject}
											</td>
											<td style="text-align: center;">
											<br>
											<br>
												${vo.startDate} ~ ${vo.endDate}
											</td>
											<td style="text-align: center;">
											<br>
											<br>
												${vo.hallName}
											</td>
											<td style="text-align: center;">
											<br>
											<br>
												${vo.rating}
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