<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
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
		$(this).closest("tr").remove();
		
		if($(".timeRemoveBtn").closest("tr").length<=1) {
            $(".timeRemoveBtn").hide();
        } 
	});
});

function sendOk(){
	var f = document.scheduleAddForm;
	var str;
	
	 str = f.perfDate.value.trim();
    if(!str) {
        alert("날짜를 입력하세요. ");
        f.perfDate.focus();
        return;
    }
    
    var b = true;
    $("input[name=perfsTime]").each(function(index) {
    	if(! $(this).val()) {
			b = false;
    	}
    	if(! b) return false;
    	
    });
	
	if(! b) {
		alert("시간을 선택하세요");
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
	
	 f.action = "${pageContext.request.contextPath}/admin/performanceManage/addSchedule";
	 f.submit();
}
</script>
<div class="container">
	<div class="body-container">	
		<div class="body-main">
			<form name="scheduleAddForm" method="post" enctype="multipart/form-data">
				<table class="table write-form mt-5">
					<tr>
						<td class="table-light col-2" scope="row">공연일정</td>
						<td class="schedule">
							<div class="row" style="margin-bottom: 10px; padding-top: 4px;">
								<div class="col-5 pe-0">
									<input type="date" name="perfDate" id="form-perfDate" class="form-control" value="${dto.perfDate}">
								</div>
							</div>
						</td>
					</tr>
				</table>
				<div class="timeCast">
					<table class="table write-form mt-5 timeCastTable">
						<tr>
							<td class="table-light col-sm-2" scope="row">공연시간 <br> 및 출연진</td>
							<td>
								<input type="time" name="perfsTime" id="form-perfTime" class="form-control" value="${dto.perfTime}">
							</td>
							<td class="cast" style="width: 26%;">
								<p style="margin: 12px 0 12px 0;">
									<select name="actorsNum" class="selectField">
										<option value="">:: 출연진 선택 ::</option>
										<c:forEach var="vo" items="${actorList}">
											<option value="${vo.actorNum}">${vo.actorName}</option>
										</c:forEach>
									</select>
									<span class="castRemoveBtn" style="float: center; line-height: 38px; margin-left: 15px; cursor: pointer"><i class="far fa-minus-square"></i></span>
								</p>
							</td>
							<td>
								<button type="button" class="btn timeRemoveBtn" style="text-align: center;">삭제</button>
							</td>
							<td>
								<button type="button" class="btn castAddBtn" style="text-align: center;">출연진<br>추가</button>
							</td>
							<td>
								<button type="button" class="btn" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
							</td>
						</tr>
						
						
					</table>
				</div>
				<table class="table table-borderless">
 					<tr>
						<td class="text-center">
							
							<button type="button" class="btn btn-light timeAddBtn">공연시간추가</button>
							<button type="reset" class="btn btn-light">다시입력</button>
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/admin/performanceManage/perfList';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
							<input type="hidden" name="perfNum" value="${perfNum}">
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>