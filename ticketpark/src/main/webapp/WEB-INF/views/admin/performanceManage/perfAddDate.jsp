<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
	margin: 0 auto 10px;
}

.input-title {
	font-size:13px;
    color: #212121;
    line-height: 180%;
}

.boxTF {
    border: 1px solid #ced4da;
    border-radius: 0.25rem;
    height: calc(1.5em + 0.75rem + 2px);
    padding: 0.375rem 0.75rem;
    background-color: #fff;
    border-radius: 4px;
    font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
    font-size: 1rem;
    font-weight: 400;
    vertical-align: baseline;
}

.btn:hover, .btn:active, .btn:focus {
	background-color: #e6e6e6;
	border-color: #adadad;
	color:#333;
}

.scheduleRemoveBtn {
    cursor: pointer;
    width: 38px;
    text-align: center;
}

input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}
</style>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/boot-board.css" type="text/css">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css1/bootstrap.min.css">


<script type="text/javascript">
function sendOk() {
    var f = document.performanceForm;
	var str;
	
    var b = true;
    $("input[name=perfsDate]").each(function(index) {
    	if(! $(this).val()) {
			b = false;
    	}
    	if(! b) return false;
    });
	
	if(! b) {
		alert("공연일정을 정확히 입력 하세요");
		return;
	}
	
    
    f.action = "${pageContext.request.contextPath}/admin/performanceManage/${mode}";
    f.submit();
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
	$("form select[name=hallNum]").change(function(){
		var hallNum = $(this).val();
		$("form select[name=theaterNum]").find('option').remove().end()
				.append("<option value=''>:: 상영관 선택 ::</option>");
		
		if(! hallNum) {
			return false;
		}
		
		var url="${pageContext.request.contextPath}/performance/theater";
		var query="hallNum=" + hallNum;
		
		var fn=function(data) {
			$.each(data.theaterList, function(index, item){
				var theaterNum = item.theaterNum;
				var theater = item.theater;
				var s = "<option value='"+theaterNum+"'>"+theater+"</option>";
				$("form select[name=theaterNum]").append(s);
			});
		};
		ajaxFun(url, "get", query, "json", fn);
	});
});



$(function(){
	$(".scheduleRemoveBtn").hide();
	
	$(".scheduleAddBtn").click(function(){
		$(".scheduleRemoveBtn").show();
		
		var p=$(this).parent().parent().find(".row:first").clone();
		$(p).find("input").each(function(){
			$(this).val("");
		});
		$(this).parent().parent().find(".schedule").append(p);
	});
	
	$("body").on("click", ".scheduleRemoveBtn", function(){
		if($(this).closest(".schedule").find(".row").length<=1) {
			return;
		}
		
		$(this).closest(".row").remove();
		
		if($(".scheduleRemoveBtn").closest(".row").length<=1) {
            $(".scheduleRemoveBtn").hide();
        }
	});
});

</script>

<div class="container">
	<div class="body-container">	
		<div class="body-title">
			<h4>[${dto.subject}] 공연 날짜 등록 </h4>
		</div>
		
		<div class="body-main">
			<form name="performanceForm" method="post" enctype="multipart/form-data">
				<table class="table write-form mt-5">
					<tr>
						<td class="table-light col-2" scope="row">공연일정</td>
						<td class="schedule">
							<div class="row" style="margin-bottom: 10px; padding-top: 4px;">
								<div class="col-6 pe-0">
									<input type="date" name="perfsDate" id="form-perfDate" class="boxTF" min="${dto.startDate}" max="${dto.endDate}" value="${dto.perfDate}">
									 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="scheduleRemoveBtn" style="float: center; line-height: 38px;"><i class="far fa-minus-square"></i></span>
								</div>
							</div>
						</td>
						<td>
                           	<button type="button" class="boxTF btn scheduleAddBtn" style="text-align: center;">추가</button>
						</td>
					</tr>
					<tr>
						<td>공연장</td>
						<td colspan="2">
							<select name="hallNum" class="selectField">
								<option value="">:: 공연장 선택 ::</option>
								<c:forEach var="vo" items="${hallList}">
									<option value="${vo.hallNum}" ${dto.hallNum==vo.hallNum?"selected='selected'":""}>${vo.hallName}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</table>
				<table class="table table-borderless">
 					<tr>
						<td class="text-center">
							<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='dateUpdate'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
							<button type="reset" class="btn btn-light">다시입력</button>
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/admin/performanceManage/perfList?page=${page}';">${mode=='dateUpdate'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
							<input type="hidden" name="perfNum" value="${perfNum}">
							<input type="hidden" name="page" value="${page}">
						</td>
					</tr>
				</table>
			</form>
		
		</div>
	</div>
</div>