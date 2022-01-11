<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.img {
	width: 180px;
	height: 250px;
}

ul {
	list-style: none;
	position: relative;
	margin-top: 1rem;
}

.boxTF {
	margin-bottom: 12px;
}

.addPerfDate, .addPerfTime {
	position: absolute;
    top: 16px;
    right: 25px;
    height: 18px;
    cursor: pointer;
}

.deleteTime_btn {
	min-width: 150px;
}

.date_btn, .deleteTime_btn, .deleteDate_btn, .updateDate_btn, .updateTime_btn, .updateCast_btn {
	margin-top: 1rem;
	max-width: 250px;
}

.date_choice {
	position: relative;
    float: left;
    width: 350px;
    text-align: center;
    overflow: auto;
    height: 320px;
}
.time_choice {
	position: relative;
	float: left;
    width: 350px;
    text-align: center;
    overflow: auto;
    height: 320px;
}
.schedule_box {
	margin: 10px 0 10px 0;
	height: 320px;
}

.select_date {
	padding: 15px;
	border-top: 1px solid #dee2e6;
	border-bottom: 1px solid #dee2e6;
}

.select_time {
	padding: 15px;
	border-top: 1px solid #dee2e6;
	border-bottom: 1px solid #dee2e6;
}

.time {
	font-size: 17px;
	text-align: center;
	line-height: 30px;
	display: block;
}

.cast {
	font-size: 11px;
	margin-bottom: 0px;
	display: block;
}

::-webkit-scrollbar {
    width: 16px;
    height: 10px;
    background: #e1e1e1;
}

</style>

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
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
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
			if(jqXHR.status === 403) {
				location.href="${pageContext.request.contextPath}/member/login";
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패했습니다.");
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

$(function(){
	$("button[name=perfDate]").click(function(){
		var perfDate = $(this).val();
		var perfNum = $("input[name=perfNum]").val();
		
		$(".cast_time").find("#selectPlz").remove();
		$(".cast_time").find("div").remove().end();
		
		if(! perfDate){
			return false;
		}
		
		if(! perfNum) {
			return false;
		}
		
		var url = "${pageContext.request.contextPath}/admin/performanceManage/time";
		var query = "perfDate=" + perfDate + "&perfNum=" + perfNum;
		var fn = function(data) {
			$.each(data.timeList, function(index, item){
				var perfTime = item.perfTime
				var actorName = item.actorName
				var ptNum = item.ptNum
				/*
				var s = "<div id='timeView"+ptNum+"'><button type='button' class='btn btn-light deleteTime_btn'"
						+ "data-ptNum='" + ptNum + "'>"
						+ "<span class='time'>" + perfTime + "</span>"
						+ "<p class='cast'>출연: " + actorName + "</p></button></div>";
				*/
				var s = "<div id='timeView"+ptNum+"'><button type='button' class='btn btn-light deleteTime_btn'"
						+ "data-ptNum='" + ptNum + "'>"
						+ "<span class='time'>" + perfTime + "</span>"
						+ "<p class='cast'>출연: " + actorName + "</p></button><br>"
						+ "<button type='button' class='btn btn-light updateTime_btn'"
						+ " onclick='timeUpdateView(" + ptNum + ");' style='margin-left: 10px;'>"
						+ "<span>시간수정</span></button><hr></div>";
				
				$(".cast_time").append(s);
			});
		};
		ajaxFun(url, "get", query, "json", fn);
	});
	
});
</script>
<h3 style="font-size: 15px; padding-top: 10px;"><i class="icofont-double-right"></i> 공연 정보</h3>
<table class="table border mx-auto my-10" style="table-layout: fixed;">
	<tr>
		<td rowspan="5" style="width: 23%; text-align:center;">
			<img class="img" src="${pageContext.request.contextPath}/uploads/performance/${dto.postFileName}">
		</td>
		<td class="wp-15 text-right pe-7 bg">공연제목</td>
		<td class="wp-25 ps-5" title="${dto.subject}">${dto.subject}</td>
		<td class="text-right pe-7 bg">평점</td>
		<td class="ps-5">${dto.rating}</td>
	</tr>
	<tr>
		<td class="text-right pe-7 bg">공연기간</td>
		<td class="ps-5">${dto.startDate} ~ ${dto.endDate}</td>
		<td class="text-right pe-7 bg">관람연령</td>
		<td class="ps-5">${dto.rate}</td>
	</tr>
	<tr>
		<td class="text-right pe-7 bg">카테고리</td>
		<td class="ps-5">${dto.category}</td>
		<td class="text-right pe-7 bg">장르</td>
		<td class="ps-5">${dto.genre}</td>
	</tr>
	<tr>
		<td class="text-right pe-7 bg">출연진</td>
		<td class="ps-5" colspan="3">${dto.actorName}</td>
	</tr>
	<tr>
		<td class="text-right pe-7 bg">공연일정</td>
		<td class="ps-5">
			<span class="btn btn-light" onclick="scheduleDetailView();" style="cursor: pointer;">자세히</span>
		</td>
		<td class="text-right pe-7 bg">가격</td>
		<td class="ps-5">${dto.price}</td>
	</tr>
</table>
 
<div id="scheduleDetail" style="display: none">
	<div class="schedule_box">
		<div class="date_choice border">
			<div class="select_date">
				<h5 style="margin-bottom: 0px;">공연날짜</h5>
			</div>
			<c:forEach items="${list}" var="vo">
				<div id="dateView${vo.perfDate}">
					<button name="perfDate" type="button" class="btn btn-light date_btn" value="${vo.perfDate}">
						<span class="date">${vo.perfDateDay}</span>
					</button><br>
					<button type="button" class="btn btn-light updateDate_btn" onclick="dateUpdateView('${vo.perfDate}');" style="margin-left: 10px;">
						<span>수정</span>
					</button>
					<button type="button" class="btn btn-light deleteDate_btn" data-perfDate="${vo.perfDate}" style="margin-left: 10px;">
						<span>삭제</span>
					</button>
					<hr style="margin-bottom: 0px;">
				</div>
			</c:forEach>
			<input type="hidden" name="perfNum" value="${dto.perfNum}">
		</div>
		
		<div class="time_choice border">
			<div class="select_time">
				<h5 style="margin-bottom: 0px;">공연시간</h5>
			</div>
			<div class="cast_time">
				<p id="selectPlz" style="padding-top: 100px;">날짜를 선택해주세요!</p>
			</div>
		</div>
	</div>
</div>

<div id="dateUpdate" style="display: none; padding-top: 20px; text-align: center;">
	<form name="dateUpdateForm" id="dateUpdateForm" method= "post">
		<input type="date" name="perfDate" value="" min="${dto.startDate}" max="${dto.endDate}">
		<input type="hidden" name="selectDate" value="">
		<input type="hidden" name="perfNum" value="${dto.perfNum}">
	</form>
</div>

<div id="timeUpdate" style="display: none; padding-top: 20px; text-align: center;">
	<form name="timeUpdateForm" id="timeUpdateForm" method= "post">
		<input type="time" name="perfTime" value="">
		<input type="hidden" name="ptNum" value="">
	</form>
</div>

<div id="castUpdate" style="display: none; padding-top: 20px; text-align: center;">
	<form name="castUpdateForm" id="castUpdateForm" method= "post">
		<c:forEach items="${roleList}" var="vo">
			<p>${vo.roleName} : 
				<select name="actorsNum" class="selectField">
					<option value="">:: 출연진 선택 ::</option>
					<c:forEach var="vo2" items="${actorList}">
						<option value="${vo2.actorNum}">${vo2.actorName}(${vo2.roleName})</option>
					</c:forEach>
				</select>
			</p>
		</c:forEach>
		<input type="hidden" name="ptNum" value="">
	</form>
</div>