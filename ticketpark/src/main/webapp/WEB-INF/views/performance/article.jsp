<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css2/boot-board.css"
	type="text/css">
<style type="text/css">
.table img {
	width: 100%;
}

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
.float-table {width: 50%; clear: both; float:left;}
.calendar-nav{
	width: 47%;
	float: left;
	border: 1px solid #dee2e6; 
	border-radius: 0.5rem;
	padding: 15px; 
	margin-left: 30px;}

.nav-tabs{clear: both;}
.choicetrue{color: red;}	
.cal{float: left;}
.sch-list{
	float: left;
	border: 1px solid #dee2e6;
    width: 45%;
    height: 330px;
    margin: 10px 0 10px 20px;
}
.bookdiv{clear: both;}
.perfList{margin: 10px;}

#calendarLayout {
	width: 280px;
	margin: 0 auto;
}
#calendarLayout .subject{
	height: 37px;
	line-height: 37px;
	text-align: center;
	font-weight: 600;
}

#calendarLayout table {
	width: 100%;
	border-collapse: collapse;
	border-spacing: 0;
}
#calendarLayout table tr:first-child{
	background: #f3f2f3;
}

#calendarLayout table td{
	padding: 10px;
	text-align: center;
}

#calendarLayout table td:nth-child(7n+1){
	color: #fd7e7e;

}
#calendarLayout table td:nth-child(7n){
	color: #8282ff;

}

#calendarLayout table td.gray {
	color: #ccc;
}
#calendarLayout table td.today{
	font-weight:700;
	background: #E6FFFF;
}

#calendarLayout .footer{
	height: 25px;
	line-height: 25px;
	text-align: right;
	font-size: 12px;
}
#calendarLayout .footer>span{
	background: #f3f2f3;
	border-radius: 0.25rem;
	padding: 3px 10px;
}
.subject>span, .footer>span{
	cursor: pointer;
}
.subject>span:hover, .footer>span:hover {
	color: tomato;
}
.date{cursor: pointer; color: black; opacity: 50%;}
.date:hover{background-color: #eee;}

.date-red{opacity: 100%; font-weight: 700;}

.bcd .time_btn{color: #212529;
    background-color: #e2e6ea;
    border-color: #dae0e5;}
</style>

<script type="text/javascript">
function calendar(y, m) {
	var date = new  Date(y, m-1, 1);
	y = date.getFullYear();
	m = date.getMonth()+1;
	
	var w =date.getDay(); // 요일(0~6)
	var week = ["일", "월", "화", "수", "목", "금", "토"]; // 배열
	
	// 시스템 오늘날짜
	var now = new Date();
	var ny = now.getFullYear();
	var nm = now.getMonth()+1;
	var nd = now.getDate();
	
	var out ="<div class='subject'>";
	out+="<span onclick='calendar("+y+","+(m-1)+")'><i class='icofont-rounded-left'></i></span>&nbsp;&nbsp;&nbsp;&nbsp;";
	out+="<label>"+y+"년 "+m+"월</label>";
	out+="&nbsp;&nbsp;&nbsp;&nbsp;<span onclick='calendar("+y+","+(m+1)+")'><i class='icofont-rounded-right'></i></span>";
	out+="</div>"
	
	out+="<table>";
	out+="<tr>";
	for(var i=0; i<week.length; i++) {
		out+="<td>"+week[i]+"</td>";
	}
	out+="</tr>";
	
	// 1일 앞부분 : 이전달
	var row = 1;
	var preDate = new Date(y, m-1, 0); // 이전달 마지막일자
	// var preYear = preDate.getFullYear();
	// var preMonth = preDate.getMonth() + 1;
	var preLastDay = preDate.getDate();
	var preDay = preLastDay - w + 1;
	out+="<tr>";
	for(var i=0; i<w; i++){
		out+="<td class='gray'>"+(preDay+i)+"</td>";
	}
	
	var cls;
	var lastDay = (new Date(y, m, 0)).getDate();
    
    var listperf_date = new Array();
    
    <c:forEach items="${listSchedule}" var="item1">
    listperf_date.push("${item1.perf_date}");
    </c:forEach>
	console.log(listperf_date);
    
	for(var i=1; i<=lastDay; i++) {
		
		var pickDay = new Date(y, m-1, i);
		var month = m >= 10 ? m : '0' + m;
        var day = pickDay.getDate();
        day = day >= 10 ? day : '0' + day;

	    var pickdayFormat =  y + "-" + month + "-" + day;
		var red = "";
		var ptNum = 0;
		var perf_date = "";
	    for(var j = 0; j < listperf_date.length; j++) {
			if(pickdayFormat == listperf_date[j]) {
				perf_date = listperf_date[j];
				red = "date-red";
			}

		}
	    
	    out+="<td class=' date "+red+"' data-perf_date='"+perf_date+"' >"+i+"</td>";
		if(i != lastDay && ++w%7==0) {
			row++;
			out+="</tr><tr>";
		}
	}
	
	// 마지막 날짜 뒷부분
	var nextDay=0;
	for(var i=w%7; i<6; i++) {
		out+="<td class='gray'>"+(++nextDay)+"</td>";
	}
	out+="</tr>";
	for(var r=row; r<6; r++) {
		out+="<tr>";
		for(var i=0; i<7; i++) {
			out+="<td class='gray'>"+(++nextDay)+"</td>";
		}
		out+="</tr>";
	}
	
	out+="</table>";
	
	out+="<div class='footer'><span onclick='todayDisp()'>TODAY</span></div>"
	
	document.getElementById("calendarLayout").innerHTML = out;
}

function todayDisp() {
	var now=new Date();
	var y=now.getFullYear();
	var m=now.getMonth()+1;
	calendar(y, m);
}

window.onload=function(){
	todayDisp()
};

function bookOk() {
	var url = "${pageContext.request.contextPath}/book/seatchoice";
}

</script>

<script type="text/javascript">
$(document).ready(function(){
	$('.goTop').click(function(){
        $('html').animate({scrollTop : 0}, 400);
	});
});


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
	$("body").on("click", ".choiceBtn", function() {
		var $i = $(this).find("i");
		var userChoiced = $i.hasClass("choicetrue");
		var msg = userChoiced ? "찜을 취소하시겠습니까? " : "해당 공연을 찜하시겠습니까 ? ";
		
		if(! confirm( msg )) {
			return false;
		}
		
		var url="${pageContext.request.contextPath}/member/insertChoice";
		var perfNum="${dto.perfNum}";
		var query="perfNum="+perfNum+"&userChoiced="+userChoiced;
		
		var fn = function(data){
			var state = data.state;
			if(state==="true") {
				if( userChoiced ) {
					$i.removeClass("choicetrue");
				} else {
					$i.addClass("choicetrue");
				}
				
			} else if(state==="liked") {
				alert("찜은 한번만 가능합니다.");
			} else if(state==="false") {
				alert("공연 찜 추가에 실패했습니다.");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

$(function() {
	$("body").on("click",".date-red", function() {
		var perf_date = $(this).attr("data-perf_date");
		$(".perfList").find("#selectPlz").remove();
		$(".perfList").find("div").remove().end();
		
		var url = "${pageContext.request.contextPath}/performance/listTime";
		var query = "perf_date="+perf_date;
		
		var fn = function(data) {
			$.each(data.listTime, function(index, item){
				var perfTime = item.perfTime;
				var actorName = item.actorName;
				var s = "<div class='abc mb-2'><button type='button' class='btn btn-light time_btn' style='width:240px;'>"
						+ "<span class='time'>" + perfTime + "</span>"
						+ "<p class='cast'>출연: " + actorName + "</p></button></div>";
				$(".perfList").append(s);
			});
		}
		
		ajaxFun(url, "get", query, "json", fn);
	});
});

$(function() {
	$("body").on("click",".time_btn", function() {
		$('div').removeClass('bcd');
		$(this).parent().addClass('bcd');			
	});
});
</script>




<div class="container">
	<div class="body-container">
		<div class="body-title">
			<h3>${dto.subject}</h3>
		</div>
		<div class="body-main">

		<div class="star-ratings mb-3 ml-3" style="float: left;">
			<div class="star-ratings-fill space-x-2 text-lg" style=" width: ${dto.rating*20}% ">
				<span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span>
			</div>
			<div class="star-ratings-base space-x-2 text-lg">
				<span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span><span><i class="icofont-star"></i></span>
			</div>
		</div>
		<div class="ml-3" style="float: left;">
			${dto.rating}
		</div>

			<table class="table mb-4 float-table">
				<tbody>
					<tr>
						<td rowspan="9" style="border-bottom: none; width: 300px;">
							<img src="${pageContext.request.contextPath}/uploads/performance/${dto.postFileName}">
						</td>
					</tr>
					<tr>
						<td colspan="2">공연 기간 : ${dto.startDate} ~ ${dto.endDate}</td>
					</tr>

					<tr>
						<td colspan="2">상영시간 : ${dto.showTime} 분</td>
					</tr>
					<tr>
						<td colspan="2">가격 : <fmt:formatNumber value="${dto.price}" pattern="#,###" /> 원</td>
					</tr>
					<tr>
						<td colspan="2">관람연령 : ${dto.rate}</td>
					</tr>
					<tr>
						<td colspan="2">카테고리 : ${dto.category}</td>
					</tr>
					<tr>
						<td colspan="2">장르 : ${dto.genre}</td>
					</tr>
					<tr>
						<td colspan="2">
							<button type="button" class="btn btn-outline-secondary choiceBtn"><i class="icofont-heart ${userChoiced ? 'choicetrue':''}"></i></button>
						</td>
					</tr>
				</tbody>
			</table>
			
			<div class="calendar-nav pl-3">
				<div class="cal" id="caldiv">
					<div id="calendarLayout"></div>
				</div>
				<div class="sch-list">
					<div class="text-center" style="line-height: 2rem; border-bottom: 1px solid #dee2e6;">시간 선택</div>
					<div class="perfList">
						<p id="selectPlz">선택 가능 시간 없음</p>
					</div>
				</div>
				<div class="text-right pr-4 bookdiv">
					<button type="button" class="btn btn-outline-secondary" onclick="bookOk();">예매하기</button>
				</div>
			</div>
			
			
			<ul class="nav nav-tabs" id="myTab" role="tablist">
				<li class="nav-item"><a class="nav-link active" id="home-tab"
					data-toggle="tab" href="#content" role="tab" aria-controls="home"
					aria-selected="true">상세정보</a></li>
				<li class="nav-item"><a class="nav-link" id="expect-tab"
					data-toggle="tab" href="#expect" role="tab" aria-controls="expect"
					aria-selected="false">기대평</a></li>
				<li class="nav-item"><a class="nav-link" id="review-tab"
					data-toggle="tab" href="#review" role="tab" aria-controls="review"
					aria-selected="false">후기</a></li>
				<li class="nav-item"><a class="nav-link" id="qna-tab"
					data-toggle="tab" href="#qna" role="tab" aria-controls="qna"
					aria-selected="false">QNA</a></li>
			</ul>
			<div class="tab-content mt-4 text-center" id="myTabContent">
				<div class="tab-pane fade show active" id="content" role="tabpanel"
					aria-labelledby="home-tab">${dto.content }</div>
				<div class="tab-pane fade" id="expect" role="tabpanel"
					aria-labelledby="expect-tab">기대평적는 칸</div>
				<div class="tab-pane fade" id="review" role="tabpanel"
					aria-labelledby="review-tab">후기적는 칸</div>
				<div class="tab-pane fade" id="qna" role="tabpanel"
					aria-labelledby="qna-tab">qna적는칸</div>
			</div>
			<table class="table table-borderless">
				<tr>
					<td class="text-left">
						<button type="button" class="btn btn-outline-secondary"
							onclick="location.href='${pageContext.request.contextPath}/performance/list?${query}';">리스트</button>
					</td>
					<td class="text-right">
						<button type="button" class="btn btn-outline-secondary goTop"><i class="icofont-rounded-up"></i></button>
					</td>
				</tr>
			</table>
			<form name="hiddenForm">
				<input type="hidden" value="${list}">
			</form>
		</div>
	</div>
</div>


