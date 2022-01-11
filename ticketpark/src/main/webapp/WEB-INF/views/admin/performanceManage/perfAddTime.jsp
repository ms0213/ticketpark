<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
	margin: 0 auto 10px;
}
.selectField {
    border: 1px solid #999;
    padding: 4px 5px;
    border-radius: 4px;
    font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
    vertical-align: baseline;
}
.boxTF {
	font-size: 11px;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/boot-board.css" type="text/css">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css1/bootstrap.min.css">

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">

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
	$("form select[name=perfDate]").change(function(){
		var perfDate = $(this).val();
		var perfNum = $("input[name=perfNum]").val();
		
		$("form select[name=theaterNum]").find('option').remove().end()
				.append("<option value=''>:: 상영관 선택 ::</option>");
		
		if(! perfDate) {
			return false;
		}
		
		var url="${pageContext.request.contextPath}/admin/performanceManage/theater";
		var query="perfDate=" + perfDate + "&perfNum=" + perfNum;
		
		var fn=function(data) {
			$.each(data.theaterList, function(index, item){
				var theaterNum = item.theaterNum;
				var theaterName = item.theater;
				var s = "<option value='"+theaterNum+"'>"+theaterName+"</option>";
				$("form select[name=theaterNum]").append(s);
			});
		};
		ajaxFun(url, "get", query, "json", fn);
	});
});

$(function(){
	$(".castRemoveBtn").hide();
	
	$("body").on("click", ".castAddBtn", function(){
		$(".castRemoveBtn").show();
		
		var p=$(this).parent().parent().find("p:first").clone();
		$(p).find("input").each(function(){
			$(this).val("");
		});
		
		$(this).parent().parent().find(".cast").append(p);
	});
	
	$("body").on("click", ".castRemoveBtn", function(){
		var $p = $(this).closest("p");
		
		if($(this).closest(".cast").find("p").length<=1) {
			return;
		}
		
		$p.remove();
		
		if($(".castRemoveBtn").closest("p").length<=1) {
            $(".castRemoveBtn").hide();
        }
	});
});

$(function(){
	$(".timeRemoveBtn").hide();
	
	$(".timeAddBtn").click(function(){
		$(".timeRemoveBtn").show();
		
		var p=$(this).parent().parent().parent().parent().parent().find(".timeCastTable").find("tr:first").clone();
		$(p).find("input").each(function(){
			$(this).val("");
		});
		$(this).parent().parent().parent().parent().parent().find(".timeCastTable").append(p);
	});
	
	$("body").on("click", ".timeRemoveBtn", function(){
		if($(".timeRemoveBtn").closest("tr").length<=1) {
			return;
		}
		
		if(!confirm("해당일정을 삭제하시겠습니까? ")){
			return;
		} else {
			$(this).closest("tr").remove();
		}
		
		if($(".timeRemoveBtn").closest("tr").length<=1) {
            $(".timeRemoveBtn").hide();
        } 
	});
});

function sendOk(){
	var f = document.timeAddForm;
	var str;
	
	str = f.perfDate.value.trim();
    if(!str) {
        alert("날짜를 입력하세요. ");
        f.perfDate.focus();
        return;
    }
    
    str = f.theaterNum.value.trim();
    if(!str) {
        alert("상연관을 입력하세요. ");
        f.theaterNum.focus();
        return;
    }
    
    /* 
    var b = true;
    $("input[name=perfTime]").each(function(index) {
    	if(! $(this).val()) {
			b = false;
    	}
    	if(! b) return false;
    	
    });
	
	if(! b) {
		alert("시간을 선택하세요");
		return;
	}
	*/
	
	str = $("select[name=dateNum] option:checked").text();
	
	str = f.perfsTime.value.trim();
	if(!str) {
		alert("시간을 입력하세요. ");
		f.perfsTime.focus();
		return;
	}
	
    var b = true;
    $("select[name=actorsNum]").each(function(index) {
    	if(! $(this).val()) {
			b = false;
    	}
    	if(! b) return false;
    });
	
	if(! b) {
		alert("출연진을 선택하세요");
		return;
	}
	
	 f.action = "${pageContext.request.contextPath}/admin/performanceManage/${mode}";
	 f.submit();
	 alert("시간 등록에 성공하였습니다.")
}
</script>
<div class="container">
	<div class="body-container">
	<div class="body-title">
			<h4> [${dto.subject}] 공연 시간 등록 </h4>
		</div>
		<div class="body-main">
			<iframe id="iframe1" name="iframe1" style="display:none"></iframe>
			<form name="timeAddForm" method="post" target="iframe1">
				<table class="table write-form mt-5">
					<tr>
						<td class="table-light col-2" scope="row">공연날짜</td>
						<td class="date">
							<div class="row" style="margin-bottom: 10px; padding-top: 4px;">
								<div class="col-3 pe-0">
									<select name="perfDate" class="selectField">
										<option value="">:: 날짜 선택 ::</option>
										<c:forEach var="vo" items="${dateList}">
											<option value="${vo.perfDate}">${vo.perfDate}</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-3">
									<select name="theaterNum" class="selectField">
										<option value="">:: 상영관 선택 ::</option>
										<c:forEach var="vo" items="${theaterList}">
											<option value="${vo.theaterNum}" ${dto.theaterNum==vo.theaterNum? "selected='selected'":""}>${vo.theaterName}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</td>
					</tr>
				</table>
				<div class="timeCast">
					<table class="table write-form timeCastTable" style="margin: 1.5rem 0 1.5rem 0;">
						<tr>
							<td class="table-light col-sm-2" scope="row">공연시간 <br> 및 출연진</td>
							<td style="width: 10%;">
								<input type="time" name="perfsTime" id="form-perfTime" class="form-control" value="${dto.perfTime}">
							</td>
							
							<td class="cast">
								<p style="margin: 12px 0 12px 0;">
									<select name="actorsNum" class="selectField">
										<option value="">:: 출연진 선택 ::</option>
										<c:forEach var="vo" items="${actorList}">
											<option value="${vo.actorNum}">${vo.actorName}(${vo.roleName})</option>
										</c:forEach>
									</select>
									<span class="castRemoveBtn" style="float: center; line-height: 38px; margin-left: 15px; cursor: pointer"><i class="far fa-minus-square"></i></span>
								</p>
							</td>
							<td>
								<button type="button" class="btn timeRemoveBtn" style="text-align: center;">삭제</button>
							</td>
							<td style="width: 13%;">
								<button type="button" class="btn castAddBtn" style="text-align: center;">출연진<br>추가</button>
							</td>
							<td style="width: 15%;">
								<button type="button" class="btn" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
							</td>
						</tr>
					</table>
				</div>
				<table class="table table-borderless">
					<tr>
						<td class="text-center">
							<c:if test="${mode=='update'}">
								<button type="button" class="btn btn-dark">수정완료&nbsp;<i class="bi bi-check2"></i></button>
							</c:if>
							<!-- <button type="button" class="btn btn-light timeAddBtn">공연시간추가</button> -->
							<button type="reset" class="btn btn-light">다시입력</button>
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/admin/performanceManage/perfList?page=${page}';">${mode=='update'?'수정취소':'리스트'}&nbsp;<i class="bi bi-x"></i></button>
							<input type="hidden" name="perfNum" value="${perfNum}">
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>