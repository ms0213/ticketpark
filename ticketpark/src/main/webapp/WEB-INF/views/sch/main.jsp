<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">

</style>

<!-- 풀캘린더 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/fullcalendar5/lib/main.min.css">

<div class="container">
	<div class="body-container">	
		<div class="body-title">
			<h3>&nbsp;공연일정 </h3>
		</div>
		
		<div class="body-main">
			<div class="row">
				<div class="col px-2">
					<div id="calendar"></div>
				</div>
			</div>
			
			<div id='scheduleLoading' style="display: none;">loading...</div>
		</div>
	</div>
	
</div>

<!-- 일정 상세 보기 Modal -->
<div class="modal fade" id="myDialogModal" tabindex="-1" aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">일정 상세 보기</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body pt-1">
				<table class="table">
					<tr>
						<td colspan="2" class="text-center align-middle">
							<p class="form-control-plaintext view-subject"></p>
						</td>
					</tr>
					
					<tr>
						<td class="table-light col-2 align-middle">일정분류</td>
						<td>
							<p class="form-control-plaintext view-category"></p>
						</td>
					</tr>
					

					<tr>
						<td class="table-light col-2 align-middle">날 짜</td>
						<td>
							<p class="form-control-plaintext view-period"></p>
						</td>
					</tr>
					
					
					<tr>
						<td class="table-light col-2 align-middle">일정반복</td>
						<td>
							<p class="form-control-plaintext view-repeat"></p>
						</td>
					</tr>
				
					
 					<tr>
						<td class="table-light col-2 align-middle">등록일</td>
						<td>
							<p class="form-control-plaintext view-reg_date"></p>
						</td>
					</tr>

 					<tr>
						<td class="table-light col-2 align-middle">메모</td>
						<td>
							<p class="form-control-plaintext view-memo"></p>
						</td>
					</tr>
				</table>
				
				<table class="table table-borderless">
					<c:if test="${sessionScope.member.userId == 'admin'}">
						<tr>
							<td class="text-end">
								<button type="button" class="btn btn-outline-primary btnScheduleUpdate">일정 수정</button>
				    			<button type="button" class="btn btn-outline-danger btnScheduleDelete">일정 삭제</button>
							</td>
						</tr>
					</c:if>
				</table>
			</div>
		</div>
	</div>
</div>



<script type="text/javascript" src="${pageContext.request.contextPath}/resources/vendor/fullcalendar5/lib/main.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/vendor/fullcalendar5/lib/locales-all.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js2/dateUtil.js"></script>

<script type="text/javascript">
function login() {
	location.href="${pageContext.request.contextPath}/member/login";
}

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
			if(jqXHR.status===403) {
				login();
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}


var calendar = null;
document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');

	calendar = new FullCalendar.Calendar(calendarEl, {
		headerToolbar: {
			left: 'prev,next today',
			center: 'title',
			right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
		},
		initialView: 'dayGridMonth',
		locale: 'ko',
		editable: true,
		navLinks: true,
		dayMaxEvents: true,
		events: function(info, successCallback, failureCallback) {
			
			var url = "${pageContext.request.contextPath}/schedule/month";
			var startDay = info.startStr.substr(0, 10);
			var endDay = info.endStr.substr(0, 10);			
			var query = "start="+startDay+"&end="+endDay;
			
			var fn = function(data) {
				successCallback(data.list);
			};
			ajaxFun(url, "get", query, "json", fn)
		},
		selectable: true, // 셀을 선택했을 때 입력하도록
		selectMirror: true,
		select: function(info) {
			<c:if test="${sessionScope.member.userId == 'admin'}">
				// 날짜의 셀을 선택하거나 드래그하면 일정 추가 화면으로 이동
				insertSchedule(info.startStr, info.endStr, info.allDay);
				calendar.unselect(); // 선택 영역 지우기
			</c:if>
		},
		eventClick: function(info) { 
			viewSchedule(info.event);

		},
		eventDrop: function(info) {
			<c:choose>
				<c:when test="${sessionScope.member.userId == 'admin'}">
					updateDrag(info.event);
				</c:when>
				<c:otherwise>
					return false;
				</c:otherwise>
			</c:choose>
		},
		eventResize: function(info) {
			<c:choose>
				<c:when test="${sessionScope.member.userId == 'admin'}">
					updateDrag(info.event);
				</c:when>
				<c:otherwise>
					return false;
				</c:otherwise>
			</c:choose>

		},
		loading: function(bool) {
		}
	});

	calendar.render();
});

function viewSchedule(calEvent) {
	$("#myDialogModal").modal("show");

	var num = calEvent.id;
	var title = calEvent.title;
	var color = calEvent.backgroundColor;
	var start = calEvent.startStr;
	var end = calEvent.endStr;
	var allDay = calEvent.allDay;
	
	
	var categoryNum = calEvent.extendedProps.categoryNum;
	if(! categoryNum) categoryNum = 0;
	var category = calEvent.extendedProps.category;
	if(! category) category = "설정하지 않음";
	
	var sday = calEvent.extendedProps.sday;
	var eday = calEvent.extendedProps.eday;
	var stime = calEvent.extendedProps.stime;
	var etime = calEvent.extendedProps.etime;
	
	var memo = calEvent.extendedProps.memo;
	if(! memo) memo = "";
	var repeat = calEvent.extendedProps.repeat;
	var repeat_cycle = calEvent.extendedProps.repeat_cycle;
	
	var reg_date = calEvent.extendedProps.reg_date;
	
	$(".btnScheduleUpdate").attr("data-num", num);
	$(".btnScheduleDelete").attr("data-num", num);	
	
	var s;
	$(".view-subject").html(title);
	
	// s = allDay ? "종일일정" : "시간일정";
	// s = allDAy
	// $(".view-category").html(category + ", " + s);
	
	s = sday;
	if( stime ) {
		s += " " + stime;
	}
	if(eday && allDay) { 
		eday = daysLater(eday, 0);
		if(sday < eday) {
			s += " ~ " + eday;
		}
	} else if(eday) {
		s += " ~ " + eday;		
	}
	if( etime ) s += " " + etime;
	$(".view-period").html(s);
	
	$(".view-reg_date").html(reg_date);
	
	s = repeat != 0 && repeat_cycle != 0 ? "반복일정, 반복주기  " + repeat_cycle + "년" : "반복안함";
	$(".view-repeat").html(s);
	
	$(".view-memo").html(memo);
}

<c:if test="${sessionScope.member.userId == 'admin'}">
	function insertSchedule(startStr, endStr, allDay) {
		var query;
	
		if(allDay) {
			
			query = "sday="+startStr;
			if(endStr) { 
				endStr = daysLater(endStr, 0); 
											
				query += "&eday="+endStr;
			}
			query += "&all_day=1";
		} else {
			
			query = "sday="+startStr.substr(0, 10);
			query = "&eday="+endStr.substr(0, 10);		
			query = "&stime="+startStr.substr(11, 5);
			query = "&etime="+endStr.substr(11, 5);
			query = "&all_day=0";
		}
		location.href = "${pageContext.request.contextPath}/schedule/write?"+query;
	}
	
	$(function(){
		$(".btnScheduleUpdate").click(function(){
			var num = $(this).attr("data-num");
			location.href = "${pageContext.request.contextPath}/schedule/update?num="+num;
		});
		
		$(".btnScheduleDelete").click(function(){
			if(! confirm('일정을 삭제 하시겠습니까 ?')) {
				return false;
			}
			
			var fn = function(data) {
				var event = calendar.getEventById(num);
				event.remove();
				$("#myDialogModal").modal("hide");
			};
			
			var num = $(this).attr("data-num");
			var url = "${pageContext.request.contextPath}/schedule/delete";
			var query = "num="+num;
			
			ajaxFun(url, "post", query, "json", fn);
			
		});
	});
	
	function updateDrag(calEvent) {
		var num = calEvent.id;
		var title = calEvent.title;
		var color = calEvent.backgroundColor;
		var start = calEvent.startStr;
		var end = calEvent.endStr;
		var allDay = calEvent.allDay;
		
		var categoryNum = calEvent.extendedProps.categoryNum;
		if(! categoryNum) categoryNum = 0;
		
		var memo = calEvent.extendedProps.memo;
		if(! memo) memo = "";
		var repeat = calEvent.extendedProps.repeat;
		var repeat_cycle = calEvent.extendedProps.repeat_cycle;
		
		var startDate="", endDate="", startTime="", endTime="", all_day="";
		if(allDay) {
			startDate = start;
			endDate = end;
			all_day = "1";
		} else {
			startDate = start.substr(0, 10);
			endDate = end.substr(0, 10);
			startTime = start.substr(11, 5);
			endTime = end.substr(11, 5);
		}
		
		var query = "num="+num+"&subject="+title
				+ "&categoryNum="+categoryNum+"&color="+color
				+ "&all_day="+all_day
				+ "&sday="+startDate+"&eday="+endDate
				+ "&stime="+startTime+"&etime="+endTime
				+ "&repeat="+repeat+"&repeat_cycle="+repeat_cycle;
				+ "&memo="+memo
		
		var url = "${pageContext.request.contextPath}/schedule/updateDrag";
	
		var fn = function(data) {
			
			calendar.refetchEvents();
		};
		ajaxFun(url, "post", query, "json", fn);
	}
	
</c:if>
</script>

