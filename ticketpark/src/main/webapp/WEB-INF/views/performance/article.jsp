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
	var ptNum = $(".bcd").attr("data-ptNum");
	var seat_price = ${dto.price};
	var query = "?ptNum="+ptNum+"&seat_price="+ seat_price;
	var url = "${pageContext.request.contextPath}/book/seatchoice" + query;
	location.href = url;
}

</script>

<script type="text/javascript">
$(document).ready(function(){
	$('.goTop').click(function(){
        $('html').animate({scrollTop : 0}, 400);
	});
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
		},
		error:function(jqXHR) {
			console.log(jqXHR.responseText);
		}
	});
}
</script>

<script type="text/javascript">
// 찜 --------------------
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
				var ptNum = item.ptNum;
				var s = "<div class='abc mb-2' data-ptNum="+ptNum+"><button type='button' class='btn btn-light time_btn' style='width:240px;'>"
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

$(function(){
	$("body").on("click","#review-tab", function() {
        $('#review').load('${pageContext.request.contextPath}/performance/review/review?perfNum=${dto.perfNum}');
        reviewlistPage(1);
	});
});

$(function(){
	$("body").on("click","#expect-tab", function() {
        $('#expect').load('${pageContext.request.contextPath}/performance/expect/expect?perfNum=${dto.perfNum}');
        expertListPage(1);
	});
});

$(function(){
	$("body").on("click","#qna-tab", function() {
        $('#qna').load('${pageContext.request.contextPath}/performance/qna/qna?perfNum=${dto.perfNum}');
        qnaListPage(1);
      
	});
});
</script>

<!-- 기대평 -->
<script type="text/javascript">
function expertListPage(page) {
	var url = "${pageContext.request.contextPath}/performance/expect/list";
	var query = "pageNo=" + page+"&perfNum="+${dto.perfNum};
	
	var fn = function(data) {
		printExpect(data);
	};
	ajaxFun(url, "get", query, "json", fn);
}

function printExpect(data) {
	var uid = "${sessionScope.member.userId}";
	var permission = "${sessionScope.member.membership > 50 ? 'true':'false'}";
	
	var dataCount = data.dataCount;
	var pageNo = data.pageNo;
	var total_page = data.total_page;
	
	$(".expect-count").attr("data-pageNo", pageNo);
	$(".expect-count").attr("data-totalPage", total_page);
	
	$("#listExpect").show();
	$(".expect-count").html("총 " + dataCount + "개의 기대평이 등록되었습니다.");
	
	$(".expert-more-box").hide();
	if(dataCount == 0) {
		$(".expect-list-body").empty();
		return;
	}
	
	if(pageNo < total_page) {
		$(".expert-more-box").show();
	}
	
	var out = "";
	for(var idx = 0; idx < data.list.length; idx++) {
		var num = data.list[idx].num;
		var userId = data.list[idx].userId;
		var userName = data.list[idx].userName;
		var content = data.list[idx].content;
		var reg_date = data.list[idx].reg_date;

		out += "<tr>";
		out += "    <td width='50%' align='left'><i class='bi bi-person-circle text-muted'></i> <span>" + userName + "</span></td>";
		out += "    <td width='50%' align='right'>" + reg_date;
		if(uid === userId || permission === "true") {
			out += "   | <span class='updateExpect' data-num='" + num + "'>수정</span>";
			out += "   | <span class='deleteExpect' data-num='" + num + "'>삭제</span>";
		}
		out += "    </td>";
		out += "</tr>";
		out += "<tr>";
		out += "    <td colspan='2' valign='top' align='left'>" + content + "</td>"; 
		out += "</tr>";
		out += "<tr style='display:none;'>";
		out += "	<td colspan='2'><textarea class='form-control'>";
		out +=  content;
		out += "</textarea></td>"
		out += "</tr>";
		
	}

	$(".expect-list-body").append(out);
}

$(function(){
	$("body").on("click", ".expert-btnSend", function(){
		var content = $("#expectcontent").val().trim();
		if(! content) {
			$("#expectcontent").focus();
			return false;
		}
		
		var url = "${pageContext.request.contextPath}/performance/expect/insertExpect";
		var query = "content=" + encodeURIComponent(content)+"&perfNum="+${dto.perfNum};
		
		var fn = function(data) {
			$("#expectcontent").val("");
			$(".expect-list-body").empty();
			expertListPage(1);
		};
		
		ajaxFun(url, "post", query, "json", fn);
		
	});
});

$(function(){
	$("body").on("click", ".deleteExpect", function(){
		var $span = $(this).parent("td").find(".updateExpect");
		
		if($(this).text()==="취소") {
			$span.text("수정");
			$(this).text("삭제");
			$(this).closest("tr").next().show();
			$(this).closest("tr").next().next().hide();
			
			return false;
		}
		
		if( ! confirm('기대평을 삭제 하시겠습니까 ? ')) {
			return false;
		}
		
		var num = $(this).attr("data-num");
		var url = "${pageContext.request.contextPath}/performance/expect/deleteExpect";
		var query = "num=" + num+"&perfNum="+${dto.perfNum};
		var fn = function(data) {
			$(".expect-list-body").empty();
			expertListPage(1);
		};
		ajaxFun(url, "post", query, "json", fn);
		
	});
});

// 더보기
$(function(){
	$("body").on("click", ".expert-more-box .expert-more", function(){
		var pageNo = $(".expect-count").attr("data-pageNo");
		var total_page = $(".expect-count").attr("data-totalPage");
		
		if(pageNo < total_page) {
			pageNo++;
			expertListPage(pageNo);
		}
	});
});

$(function(){
	$("body").on("click", ".updateExpect", function(){
		var num = $(this).attr("data-num");
		var title = $(this).text();
		var $span = $(this).parent("td").find(".deleteExpect");
		
		if(title==="수정") {
			$(this).text("저장");
			$span.text("취소");
			$(this).closest("tr").next().show();
			$(this).closest("tr").next().next().show();
		
		} 
		else {
			var content = $(this).closest("tr").next().next().find("textarea").val().trim();
			if(! content) {
				return false;
			}
			
			var url = "${pageContext.request.contextPath}/performance/expect/updateExpect";
			var query = "num="+num+"&content="+encodeURIComponent(content);

			var fn = function(data) {
				$("#expectcontent").val("");
				$(".expect-list-body").empty();
				expertListPage(1);
			};
			
			ajaxFun(url, "post", query, "json", fn);
			
			$(this).text("수정");
			$span.text("삭제");
			$(this).closest("tr").next().show();
			$(this).closest("tr").next().next().hide();			
		}
	});
});
</script>

<!-- 리뷰 -->
<script type="text/javascript">
function reviewlistPage(page) {
	var url = "${pageContext.request.contextPath}/performance/review/list";
	//var perfNum=$("#perfNum").val();
	var query = "pageNo=" + page+"&perfNum="+${dto.perfNum};
	
	var fn = function(data) {
		printReview(data);
	};
	ajaxFun(url, "get", query, "json", fn);
}

function printReview(data) {
	var uid = "${sessionScope.member.userId}";
	var permission = "${sessionScope.member.membership > 50 ? 'true':'false'}";
	
	var dataCount = data.dataCount;
	var pageNo = data.pageNo;
	var total_page = data.total_page;
	
	$(".review-count").attr("data-pageNo", pageNo);
	$(".review-count").attr("data-totalPage", total_page);
	
	$("#listReview").show();
	$(".review-count").html("총 " + dataCount + "개의 후기가 등록되었습니다.");
	
	$(".more-box").hide();
	if(dataCount == 0) {
		$(".review-list-body").empty();
		return;
	}
	
	if(pageNo < total_page) {
		$(".more-box").show();
	}
	
	var out = "";
	for(var idx = 0; idx < data.list.length; idx++) {
		var num = data.list[idx].num;
		var userId = data.list[idx].userId;
		var userName = data.list[idx].userName;
		var userRate = data.list[idx].rate*20;
		var content = data.list[idx].content;
		var reg_date = data.list[idx].reg_date;

		out += "<tr>";
		out += "    <td width='50%' align='left'><i class='bi bi-person-circle text-muted'></i> <span>" + userName + "</span></td>";
		out += "    <td width='50%' align='right'>" + reg_date;
		if(uid === userId || permission === "true") {
			out += "   | <span class='updateReview' data-num='" + num + "'>수정</span>";
			out += "   | <span class='deleteReview' data-num='" + num + "'>삭제</span>";
		}
		out += "    </td>";
		out += "</tr>";
		out += "<tr>";
		out += "    <td valign='top' align='left'>" + content + "</td>"; 
		out += "    <td valign='top' align='right'>"; 
		out += "	<div class='star-ratings mb-3 ml-3' style='float: right;'>";
		out += "	<div class='star-ratings-fill space-x-2 text-lg' style=' width: "+userRate+"% '>";
		out += "	<span><i class='icofont-star'></i></span><span><i class='icofont-star'></i></span><span><i class='icofont-star'></i></span><span><i class='icofont-star'></i></span><span><i class='icofont-star'></i></span></div>";
		out += "	<div class='star-ratings-base space-x-2 text-lg'><span><i class='icofont-star'></i></span><span><i class='icofont-star'></i></span><span><i class='icofont-star'></i></span><span><i class='icofont-star'></i></span><span><i class='icofont-star'></i></span></div></div>";
		out += "    </td>"; 
		out += "</tr>";
		out += "<tr style='display:none;'>";
		out += "	<td colspan='2'><textarea class='form-control'>";
		out +=  content;
		out += "</textarea></td>"
		out += "</tr>";
		
	}
	
	$(".review-list-body").append(out);
}

$(function(){
	$("body").on("click", ".review-btnSend", function(){
		var content = $("#reviewcontent").val().trim();
		//var perfNum=$("#perfNum").val();
		if(! content) {
			$("#reviewcontent").focus();
			return false;
		}
		
		var url = "${pageContext.request.contextPath}/performance/review/insertReview";
		var query = "content=" + encodeURIComponent(content)+"&rate="+star+"&perfNum="+${dto.perfNum};
		
		var fn = function(data) {
			$("#reviewcontent").val("");
			$(".review-list-body").empty();
			reviewlistPage(1);
		};
		
		ajaxFun(url, "post", query, "json", fn);
		
	});
});

$(function(){
	$("body").on("click", ".deleteReview", function(){
		var $span = $(this).parent("td").find(".updateReview");
		
		if($(this).text()==="취소") {
			$span.text("수정");
			$(this).text("삭제");
			$(this).closest("tr").next().show();
			$(this).closest("tr").next().next().hide();
			
			return false;
		}
		
		if( ! confirm('리뷰를 삭제하시겠습니까 ? ')) {
			return false;
		}
		
		var num = $(this).attr("data-num");
		var url = "${pageContext.request.contextPath}/performance/review/deleteReview";
		var query = "num=" + num+"&perfNum="+${dto.perfNum};
		var fn = function(data) {
			$(".review-list-body").empty();
			reviewlistPage(1);
		};
		ajaxFun(url, "post", query, "json", fn);
		
	});
});

//더보기
$(function(){
	$("body").on("click", ".more-box .more", function(){
		var pageNo = $(".review-count").attr("data-pageNo");
		var total_page = $(".review-count").attr("data-totalPage");
		
		if(pageNo < total_page) {
			pageNo++;
			reviewlistPage(pageNo);
		}
	});
});

$(function(){
	$("body").on("click", ".updateReview", function(){
		var num = $(this).attr("data-num");
		var title = $(this).text();
		var $span = $(this).parent("td").find(".deleteReview");
		
		if(title==="수정") {
			$(this).text("저장");
			$span.text("취소");
			$(this).closest("tr").next().show();
			$(this).closest("tr").next().next().show();
		
		} 
		else {
			var content = $(this).closest("tr").next().next().find("textarea").val().trim();
			if(! content) {
				return false;
			}
			
			var url = "${pageContext.request.contextPath}/performance/review/updateReview";
			var query = "num="+num+"&content="+encodeURIComponent(content);

			var fn = function(data) {
				$("#reviewcontent").val("");
				$(".review-list-body").empty();
				reviewlistPage(1);
			};
			
			ajaxFun(url, "post", query, "json", fn);
			
			$(this).text("수정");
			$span.text("삭제");
			$(this).closest("tr").next().show();
			$(this).closest("tr").next().next().hide();			
		}
	});
});

$(function(){
	$("body").on("click", ".user-rating span", function(e){
	      $(this).parent().children('span').removeClass('on');
	      
	      $(this).addClass('on').prevAll('span').addClass('on');    
	});	
});

var star="";
function setStar(point) {
	star=point;
	console.log(star);
};
</script>

<!-- qna -->
<script type="text/javascript">
//페이징 처리






function qnaListPage(page) {
	var url = "${pageContext.request.contextPath}/performance/qna/listReply";
	var query = "perfNum=${dto.perfNum}&pageNo="+page;
	var selector = "#listReply";
	
	var fn = function(data){

		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}


// 리플 등록
$(function(){
	$("body").on("click", ".btnSendReply", function(){
		var perfNum="${dto.perfNum}";
		var $tb = $(this).closest("table");
		var content = $tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url = "${pageContext.request.contextPath}/performance/qna/insertReply";
		var query = "perfNum="+perfNum+"&content=" + content + "&answer=0";
		
		var fn = function(data){
			$tb.find("textarea").val("");
			
			var state = data.state;
			if(state === "true") {
				qnaListPage(1);
			} else if(state === "false") {
				alert("댓글을 추가 하지 못했습니다.");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

// 댓글 삭제
$(function(){
	$("body").on("click", ".deleteReply", function(){
		if(! confirm("게시물을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		var replyNum = $(this).attr("data-replyNum");
		var page = $(this).attr("data-pageNo");
		
		var url = "${pageContext.request.contextPath}/performance/qna/deleteReply";
		var query = "replyNum="+replyNum+"&mode=reply";
		
		var fn = function(data){
			
			qnaListPage(page);
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

// 댓글 좋아요 / 싫어요
$(function(){
	// 댓글 좋아요 / 싫어요 등록
	$("body").on("click", ".btnSendReplyLike", function(){
		var replyNum = $(this).attr("data-replyNum");
		var replyLike = $(this).attr("data-replyLike");
		var $btn = $(this);
		
		var msg = "게시물이 마음에 들지 않으십니까 ?";
		if(replyLike === "1") {
			msg="게시물에 공감하십니까 ?";
		}
		
		if(! confirm(msg)) {
			return false;
		}
		
		var url = "${pageContext.request.contextPath}/performance/qna/insertReplyLike";
		var query = "replyNum=" + replyNum + "&replyLike=" + replyLike;
		
		var fn = function(data){
			var state = data.state;
			if(state === "true") {
				var likeCount = data.likeCount;
				var disLikeCount = data.disLikeCount;
				
				$btn.parent("td").children().eq(0).find("span").html(likeCount);
				$btn.parent("td").children().eq(1).find("span").html(disLikeCount);
			} else if(state === "liked") {
				alert("게시물 공감 여부는 한번만 가능합니다. !!!");
			} else {
				alert("게시물 공감 여부 처리가 실패했습니다. !!!");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});



// 댓글별 답글 리스트
function listReplyAnswer(answer) {
	var url = "${pageContext.request.contextPath}/performance/qna/listReplyAnswer";
	var query = "answer=" + answer;
	var selector = "#listReplyAnswer" + answer ;
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

// 댓글별 답글 개수
function countReplyAnswer(answer) {
	var url = "${pageContext.request.contextPath}/performance/qna/countReplyAnswer";
	var query = "answer=" + answer;
	
	var fn = function(data){
		var count = data.count;
		var selector = "#answerCount"+answer;
		$(selector).html(count);
	};
	
	ajaxFun(url, "post", query, "json", fn);
}

// 답글 버튼(댓글별 답글 등록폼 및 답글리스트)
$(function(){
	$("body").on("click", ".btnReplyAnswerLayout", function(){
		var $trReplyAnswer = $(this).closest("tr").next();
	
		
		var isVisible = $trReplyAnswer.is(':visible');
		var replyNum = $(this).attr("data-replyNum");
			
		if(isVisible) {
			$trReplyAnswer.hide();
		} else {
			$trReplyAnswer.show();
            
			// 답글 리스트
			listReplyAnswer(replyNum);
			
			// 답글 개수
			countReplyAnswer(replyNum);
		}
	});
	
});

// 댓글별 답글 등록
$(function(){
	$("body").on("click", ".btnSendReplyAnswer", function(){
		var perfNum = "${dto.perfNum}";
		var replyNum = $(this).attr("data-replyNum");
		var $td = $(this).closest("td");
		
		var content = $td.find("textarea").val().trim();
		if(! content) {
			$td.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url = "${pageContext.request.contextPath}/performance/qna/insertReply";
		var query = "perfNum="+perfNum+"&content=" + content + "&answer=" + replyNum;
		
		var fn = function(data){
			$td.find("textarea").val("");
			
			var state = data.state;
			if(state === "true") {
				listReplyAnswer(replyNum);
				countReplyAnswer(replyNum);
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

// 댓글별 답글 삭제
$(function(){
	$("body").on("click", ".deleteReplyAnswer", function(){
		if(! confirm("게시물을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		var replyNum = $(this).attr("data-replyNum");
		var answer = $(this).attr("data-answer");
		
		var url = "${pageContext.request.contextPath}/performance/qna/deleteReply";
		var query = "replyNum=" + replyNum+"&mode=answer";
		
		var fn = function(data){
			listReplyAnswer(answer);
			countReplyAnswer(answer);
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

$(function(){
	$("body").on("click", ".qna-more-box .qna-more", function(){
	 	var pageNo = $(".reply-count").attr("data-pageNo");
		var total_page = $(".reply-count").attr("data-totalPage");
		
		if(pageNo < total_page) {
			
			pageNo++;
			qnaListPage(pageNo);
		}
	});
});



$(function(){
	$("body").on("click", ".qna-less-box .qna-less", function(){
	 	var pageNo = $(".reply-count").attr("data-pageNo");
		var total_page = $(".reply-count").attr("data-totalPage");
		
		if(pageNo <= total_page) {
			if(total_page <= 1) {
				qnaListPage(1);	
			} else if(pageNo <= 1) {
				qnaListPage(1);	
			}
			pageNo--;
			qnaListPage(pageNo);
		}
		
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



