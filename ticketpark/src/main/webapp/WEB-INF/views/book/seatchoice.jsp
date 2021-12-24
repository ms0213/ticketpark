<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style type="text/css">
*{
	margin: 0; padding: 0;
	box-sizing: border-box;
}
body {
    font-size: 14px;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
}
a{
	color: #000;
	text-decoration: none;
}
a:active, a:hover {
	text-decoration: underline;
	color: tomato;
}
.btn {
    color:#333;
    font-weight:500;
    border:1px solid #ccc;
    background-color:#fff;
    text-align:center;
    cursor:pointer;
    padding:3px 10px 5px;
    border-radius:4px;
}
.btn:active, .btn:focus, .btn:hover {
	 background-color:#e6e6e6;
	 border-color: #adadad;
	 color: #333;
}
.boxTF {
    border:1px solid #999;
    padding:4px 5px 5px;
    border-radius:4px;
    background-color:#fff;
}
.selectField {
    border:1px solid #999;
    padding:2px 5px 6px;
    border-radius:4px;
    font-size: 12px;
}

.body-container {
	width: ${width}px;
	min-width: 500px;
    clear:both;
    margin: 0px auto 15px;
    min-height: ${height}px;
    padding-top: 20px;
}

.body-title {
    color: #424951;
    padding-top: 10px;
    padding-bottom: 5px;
    margin: 0 0 25px 0;
    border-bottom: 1px solid #ddd;
}
.body-title h3 {
    font-size: 23px;
    min-width: 300px;
    font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
    font-weight: bold;
    margin: 0 0 -5px 0;
    padding-bottom: 5px;
    display: inline-block;
	border-bottom: 3px solid #424951;
}

.seatSelect-header {
	width: 100%;
}

.seatSelect-header .screen {
	width: 100%;
	height: 45px;
	line-height: 45px;
	font-weight: 700;
	font-size: 17px;
	text-align:center;
	background:#e4e4e4;
	border:1px solid #ccc;
	border-radius: 3px;
	margin: 5px auto 25px;
}

.seatSelect-container {
  width: ${width}px;
  height: ${height}px;

  display: grid;
  grid-template-rows: repeat(${rows}, 1fr);
  grid-template-columns: repeat(${cols+1}, 1fr);
  grid-gap: 2px;
  align-content: center;
  justify-content : center;
}

.seatSelect-container .seat-area {
	font-weight: 600;
	font-size: 9px;
	box-sizing: border-box;
	display: flex;

	align-items: center;
	justify-content: center;
	width: 25px;
	height: 25px;
}

.seatSelect-container .seat-col-0 {
   border-bottom: 1px solid #333;
}

.seatSelect-container .seat {
	color: #fff;
	border: 1px solid #333;
	border-radius: 3px;
}

.seatSelect-container .seat-general {
	background: darkblue;
	cursor: pointer;
}
.seatSelect-container .seat-vip {
	background: yellow;
	cursor: pointer;
}
.seatSelect-container .seat-select {
	background: brown;
	cursor: pointer;
}
.seatSelect-container .seat-reserved {
	color: #fff;
	border: 1px solid #333;
	border-radius: 3px;
	background: #bbb;
}
.seatSelect-container .seat-blank {
	background: white;
	border: none;
}

.seatSelect-footer {
	width: 100%;
	clear:both;
	margin-top: 15px;
	text-align: right;
}
</style>

<script type="text/javascript">
$(function(){
	$("body").on("click", ".seat", function(){
		var selectSeatCount = $("form[name=seatSelectForm] input[name=seats]").length;
		if(selectSeatCount >= 2 && $(this).hasClass("seat-select") == false) {
			alert("좌석 선택이 완료 되었습니다.");
			return false;
		}
		
		var seatNo = $(this).attr("data-seat");  // A01-1
		if($(this).hasClass("seat-general") === true) {
			$(this).removeClass("seat-general");
			$(this).addClass("seat-select");
			
			$("form[name=seatSelectForm]").append("<input type='hidden' name='seats' value='"+seatNo+"'>");
		} else if($(this).hasClass("seat-vip") === true) {
			$(this).removeClass("seat-vip");
			$(this).addClass("seat-select");
			
			$("form[name=seatSelectForm]").append("<input type='hidden' name='seats' value='"+seatNo+"'>");
		} else if($(this).hasClass("seat-select") === true) {
			$(this).removeClass("seat-select");
			if(seatNo.substr(4, 1)=="1") {
				$(this).addClass("seat-general");
			} else if(seatNo.substr(4, 1)=="2") {
				$(this).addClass("seat-vip");
			}

			$("form[name=seatSelectForm] input[name=seats]").each(function(){
				if($(this).val() == seatNo) {
					$(this).remove();
				}
			});
		}
	});
});

function sendOk() {
	var f = document.seatSelectForm;
	
	var selectSeatCount = $("form[name=seatSelectForm] input[name=seats]").length;
	if(selectSeatCount < 1) {
		alert("좌석을 선택하세요...");
		return;
	}
	
	f.action = "${pageContext.request.contextPath}/book/seatchoice";
	f.submit();
}
</script>

<div class="container">
	<div class="body-container">
		<div class="body-title">
			<div class="progress" style="height: 70px; font-size: 18px;">
  				<div class="progress-bar progress-bar-striped progress-bar-animated bg-success" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">좌석 선택</div>
  				<div class="progress-bar bg-light" role="progressbar" style="width: 25%; color: black;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">본인확인</div>
  				<div class="progress-bar bg-light" role="progressbar" style="width: 25%; color: black;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">결제</div>
  				<div class="progress-bar bg-light" role="progressbar" style="width: 25%; color: black;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">완료</div>
			</div>
		</div>
		
		<div class="body-main">
			<div class="seatSelect-container">
			<c:set var="alph" value="ABCDEFGHIJKLMNOPQRSTUVWXYZ"/>
			<c:set var="n" value="0"/>
			<c:forEach var="seat" items="${seats}" varStatus="status">
				<c:if test="${status.index%cols==0}">
					<span class="seat-area seat-col-0">${fn:substring(alph, n, n+1)}</span>
					<c:set var="n" value="${n+1}"/>
				</c:if>
				<c:choose>
					<c:when test="${fn:substring(seat, 7, 8)==0}">
						<span class="seat-area seat-blank"></span>
					</c:when>
					<c:otherwise>
						<c:set var="reserved" value="false"/>
						<c:forEach var="rs" items="${reservedSeat}">
							<c:if test="${rs==fn:substring(seat, 3, 8)}">
								<c:set var="reserved" value="true"/>
							</c:if>
						</c:forEach>
						
						<c:choose>
							<c:when test="${reserved=='true'}">
								<span class="seat-area seat-reserved" data-seat="${fn:substring(seat, 3, 8)}">${fn:substring(seat, 3, 6)}</span>
							</c:when>
							<c:when test="${fn:substring(seat, 7, 8)==2}">
								<span class="seat-area seat seat-vip" title="vip석" data-seat="${fn:substring(seat, 3, 8)}">${fn:substring(seat, 3, 6)}</span>
							</c:when>
							<c:otherwise>
								<span class="seat-area seat seat-general" title="일반석" data-seat="${fn:substring(seat, 3, 8)}">${fn:substring(seat, 3, 6)}</span>
							</c:otherwise>
						</c:choose>
						
					</c:otherwise>
				</c:choose>

			</c:forEach>
		</div>
		
		<div class="seatSelect-footer">
			<form name="seatSelectForm" method="post">
				<button type="button" class="btn" onclick="sendOk();"> 좌석 선택 완료 </button>
				<button type="button" class="btn"> 좌석 선택 취소 </button>
				<input type="hidden" name="cinemaCode" value="${cinemaCode}">
			</form>
		</div>
	</div>
		</div>
</div>
