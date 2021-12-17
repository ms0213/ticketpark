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
	width: ${width+30}px;
	min-width: 600px;
    clear:both;
    margin: 0px auto 15px;
    min-height: ${height+30}px;
    padding-top: 20px;
}

.body-title {
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

.seat-header {
	min-width: 600px;
	margin: 20px auto;
	color: black;
}
.seat-header table {
	width: 100%;
	border-collapse: collapse;
}

.seat-header .rows, .seat-header .cols {
	font-weight: 600;
}

.seat-header .btnPlus, .seat-header .btnMinus {
	cursor: pointer;
	margin-left: 5px; 
	margin-right: 5px; 
}

.seat-container {
  width: ${width+30}px;
}

.seat-container table {
	width: 100%;
	border-collapse: collapse;
}
.seat-container table tr {
	height: 30px;
}
.seat-container table td {
	width: 30px;
	text-align: center;
}

.seat-container .seat-area {
	font-weight: 600;
	box-sizing: border-box;
	display: flex;
   
	align-items: center;
	justify-content: center;
	width: 28px;
	height: 28px;
}

.seat-container .seat {
   font-size: 12px;
   color: #fff;
   border: 1px solid #333;
   border-radius: 3px;
   background: darkblue;
   cursor: pointer;
}

.seat-container .seat-col-0 {
   border-bottom: 1px solid #333;
}

.seat-container .seat-row-0 {
   font-weight: 700;
   cursor: pointer;
}

.seat-footer {
	margin: 20px auto;
	min-width: 600px;
}
.seat-footer table {
	width: 100%;
	border-collapse: collapse;
}
.seat-footer span {
	font-weight: 600;
	font-size: 12px;
}
.seat-footer .seat-info {
	display: inline-block;
	box-sizing: border-box;
	width: 25px;
	height: 25px;
	line-height: 20px;
	text-align: center;
	border: 1px solid #333;
	border-radius: 3px;
	vertical-align: middle;
}
.seat-footer label {
	font-weight: 600;
	font-size: 12px;
}
</style>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">

<script type="text/javascript">
$(function(){
	$(".seat-row-0").click(function(){
		// +, - 버튼을 클릭한 경우
		var $btn0 = $(this);
		var state=$btn0.attr("data-state");
		var cols  = $("form input[name=cols]").val();
		
		var no = $btn0.attr("data-no");
		var seatNo = $btn0.attr("data-seatNo");

		if(state==="-") {
			// 첫열 이거나 마지막 열, 왼쪽 또는 오른쪽에 모두 지워진 열이 있는지 확인한다.
			var flag=false;
			$btn0.closest("tr").find("td").each(function(idx){
				var n = $(this).find("span").attr("data-no");
				var s = $(this).find("span").attr("data-seatNo");
				if(n) {
					if( (parseInt(no) == 1) || (parseInt(no) == parseInt(cols)) || (parseInt(n)-1 == parseInt(no) && s == "00") || (parseInt(n)+1 == parseInt(no) && s == "00") ) {
						flag = true;
						return false;
					}
				}	
			});
			if(flag) return false;
			
			// 열을 모두 지운다.
			var $tds = $btn0.closest("table").find("td");
			$tds.each(function(idx){
				var n = $(this).find("span").attr("data-no");
				var s = $(this).find("span").attr("data-seatNo");
				
				if(n == undefined && seatNo === s) { // 지울 공간
					var v = $(this).find("span").next("input[name=seats]").val();
					$(this).empty().html("<input type='hidden' name='seats' value='"+v.substr(0, 4)+"00-0'>");
					
					// 전체 좌석수 감소
					var g = parseInt(v.substr(7));
					var generalSeat = $("form input[name=generalSeat]").val();
					var vipSeat = $("form input[name=vipSeat]").val();
					if(g==1){
						generalSeat--;
					} else if(g==2) {
						vipSeat--;
					}
					$("form input[name=generalSeat]").val(generalSeat);
					$("form input[name=vipSeat]").val(vipSeat);
					$(".generalSeat").html(generalSeat);
					$(".vipSeat").html(vipSeat);
					
				} else if(n == undefined && s != undefined && s > seatNo) { // // 지울 공간 우측
					s = parseInt(s)-1;
					if(s<10) s="0"+s;
					
					var v = $(this).find("span").next("input[name=seats]").val(); // 01-A01-1
					if(parseInt(v.substr(7))>0) {
						$(this).find("span").text(s);
					}
					$(this).find("span").attr("data-seatNo",s);
					if(v) {
						v = v.substr(0,4)+s+v.substr(6);
						$(this).find("span").next("input[name=seats]").val(v);
					}
				}
			});

			$btn0.attr("data-state", "+");
			$btn0.html("<i class='far fa-plus-square'></i>");
			$btn0.closest("tr").find("td").each(function(idx){
				var s = $(this).find("span").attr("data-seatNo");
				if(s && s > seatNo) {
					s = parseInt(s)-1;
					if(s<10) s="0"+s;
					$(this).find("span").attr("data-seatNo", s);
				}
			});
			$btn0.attr("data-seatNo", "00");
			
		} else {
			var setSeatNo = $btn0.parent().next("td").find("span").attr("data-seatNo");
			
			var $tds = $btn0.closest("table").find("td");
			$tds.each(function(idx){
				var n = $(this).find("span").attr("data-no");
				var s = $(this).find("span").attr("data-seatNo");
				var seats = $(this).find("input[name=seats]").val();
				
				if(n != undefined && s != undefined ) { // +, - 버튼 영역
					if(parseInt(s)>=parseInt(setSeatNo)) {
						s = parseInt(s) + 1;
						if(s<10) s = "0"+s;
						$(this).find("span").attr("data-seatNo", s);
					}
					
				} else if(n == undefined && seats != undefined ){ // 좌석 영역
					var cno = seats.substr(0, 2);
					var sno = seats.substr(4, 2);
					
					if(cno == no) { // 지원진 공간
						var v = seats.substr(0, 4)+setSeatNo+"-1";
						var h = "<span class='seat-area seat' data-seatNo='"+setSeatNo+"'>"+setSeatNo+"</span>";
						h += "<input type='hidden' name='seats' value='"+v+"'>";
						$(this).html(h);
						
						// 전체 좌석수 증가
						var generalSeat = $("form input[name=generalSeat]").val();
						generalSeat++;
						$("form input[name=generalSeat]").val(generalSeat);
						$(".generalSeat").html(generalSeat);
						
					} else if(parseInt(sno)>=parseInt(setSeatNo)) { // 지원진 공간 우측
						var a = parseInt(sno)+1;
						if(a<10) a="0"+a;
						
						$(this).find("span").attr("data-seatNo", a);
						if(parseInt(seats.substr(7))>0) {
							$(this).find("span").text(a);
						}
						
						var v = seats.substr(0, 4) + a + seats.substr(6);
						$(this).find("input[name=seats]").val(v);
					}
				}
			});
			
			$btn0.attr("data-seatNo", setSeatNo);
			$btn0.attr("data-state", "-");
			$btn0.html("<i class='far fa-minus-square'></i>");
		}
	});
	
	$("body").on("click", ".seat", function(){
		// 좌석 번호를 클릭한 경우
		var seat = $(this).next("input[name=seats]").val();
		// 01-A01-1
		
		var generalSeat = $("form input[name=generalSeat]").val();
		var vipSeat = $("form input[name=vipSeat]").val();
		
		var no = seat.substr(4, 2);
		var state = parseInt(seat.substr(seat.lastIndexOf("-")+1));
		var bg = "darkblue";
		var fg = "white";
		if(state == 0) {
			state = 2;
			bg = "#FAED7D";
			fg = "white";
			
			vipSeat = parseInt(vipSeat)+1;
			$("form input[name=vipSeat]").val(vipSeat);
			$(".vipSeat").html(vipSeat);
		} else if(state == 1) {
			state = 0;
			bg = "white";
			fg = "black";
			no = "x";
			
			generalSeat = parseInt(generalSeat)-1;
			$("form input[name=generalSeat]").val(generalSeat);
			$(".generalSeat").html(generalSeat);
		} else if(state == 2) {
			state = 1;
			bg = "darkblue";
			fg = "white";
			
			generalSeat = parseInt(generalSeat)+1;
			vipSeat = parseInt(vipSeat)-1;
			
			$("form input[name=generalSeat]").val(generalSeat);
			$("form input[name=vipSeat]").val(vipSeat);
			$(".generalSeat").html(generalSeat);
			$(".vipSeat").html(vipSeat);
		}
		seat = seat.substr(0, 7)+state;
		$(this).next("input[name=seats]").val(seat);
		$(this).html(no);
		$(this).css("background",bg);
		$(this).css("color",fg);
	});
});

function sendOk() {
	var f = document.cinemaSeatForm;
	
	f.action = "${pageContext.request.contextPath}/admin/theaterManage/${mode}";
	f.submit();
}
</script>

<div class="container">
	<div class="body-container">
		<div class="body-title">
			<h3> 좌석 배치도  </h3>
		</div>
		
		<div class="body-main">
			
	
		<form name="cinemaSeatForm" method="post">
		<div class="seat-header">
			<table border="1">
				<tr height="35">
					<td width="15%" align="center" bgcolor="#eee">상영관명</td>
					<td width="35%" style="padding-left: 10px;" bgcolor="#eee"><input type="text" name="name"></td>
					<td width="15%" align="center" bgcolor="#eee">상영관 위치</td>
					<td width="35%" style="padding-left: 10px;" bgcolor="#eee"><input type="text" name="location"></td>
				</tr>
				<tr height="35">
					<td width="15%" align="center" bgcolor="#eee">전체행수</td>
					<td width="35%" style="padding-left: 10px;" bgcolor="#eee">
						<span class="rows">${rows}</span>
					</td>
					<td width="15%" align="center" bgcolor="#eee">전체열수</td>
					<td width="35%" style="padding-left: 10px;" bgcolor="#eee">
						<span class="cols">${cols}</span>
					</td>
				</tr>
			</table>
		</div>
			<div class="seat-container">
				<c:set var="alph" value="ABCDEFGHIJKLMNOPQRSTUVWXYZ"/>
				<table>
				<c:forEach var="i" begin="0" end="${rows}">
					<tr>
					<c:forEach var="j" begin="0" end="${cols}">
						<td>
							<c:set var="seatNo" value="${j<10?'0'+=j:j}"/>
							<c:set var="no" value="${j<10?'0'+=j:j}"/>
							<c:choose>
								<c:when test="${i==0&&j==0}">
									<span class="seat-area">&nbsp;</span>
								</c:when>
								<c:when test="${i==0&&j!=0}">
									<span class="seat-area seat-row-0" data-state="-" data-no="${no}" data-seatNo="${seatNo}"><i class="far fa-minus-square"></i></span>
								</c:when>
								<c:when test="${i!=0&&j==0}">
									<span class="seat-area seat-col-0">${fn:substring(alph, i-1, i)}</span>
								</c:when>
								<c:otherwise>
									<span class="seat-area seat" data-seatNo="${seatNo}">${seatNo}</span>
									<input type="hidden" name="seats" value="${no}-${fn:substring(alph, i-1, i)}${seatNo}-1">
								</c:otherwise>
							</c:choose>
						</td>
					</c:forEach>
					</tr>
				</c:forEach>
				</table>
			</div>
			
			<div class="seat-footer">
				<table>
					<tr>
						<td width="50%" align="left" style="padding-left: 30px;">
							<label> <span class="seat-info" style="background: darkblue;"></span> 일반석[<span class="generalSeat">${generalSeat}</span>]</label>&nbsp;
							<label> <span class="seat-info" style="background: #FAED7D;"></span> VIP석[<span class="vipSeat">${vipSeat}</span>]</label>&nbsp;
							<label> <span class="seat-info" style="background: white;">x</span> 좌석없음</label>
						</td>
						<td width="50%" align="right">
							<button type="button" class="btn" onclick="sendOk();"> 등록하기 </button>
							<button type="button" class="btn"> 등록취소 </button>
						</td>
					</tr>
				</table>
				<div>
					${message}
				</div>
			</div>
			
			<input type="hidden" name="hallNo" value="${hallNo}">
			<input type="hidden" name="rows" value="${rows}">
			<input type="hidden" name="cols" value="${cols}">
			<input type="hidden" name="generalSeat" value="${generalSeat}">
			<input type="hidden" name="vipSeat" value="${vipSeat}">
		</form>
	
		</div>
	</div>
</div>