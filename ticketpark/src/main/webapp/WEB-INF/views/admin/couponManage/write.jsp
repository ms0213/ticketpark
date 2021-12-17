<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
function sendOk() {
	var f = document.couponForm;
	var str;
	
	str = f.coupon.value.trim();
	if(!str){
		alert("쿠폰 할인가격을 입력하세요.");
		f.subject.focus();
		return;
	}
	
	str = f.startDate.value.trim();
	if(!str){
		alert("쿠폰 발급날짜를 입력하세요.");
		f.link.focus();
		return;
	}
	
	str = f.endDate.value.trim();
	if(!str){
		alert("쿠폰 만료날짜를 입력하세요.");
		f.link.focus();
		return;
	}
	
	
	f.action = "${pageContext.request.contextPath}/admin/couponManage/${mode}";
	f.submit();
}
</script>

<div class="container">
	<div class="body-container">
		<div class="body-title">
			<h3>쿠폰 등록</h3>
		</div>
		
		<div class="body-main">
			${mode=='update'?'쿠폰을 수정합니다.':'새로운 쿠폰을 등록 합니다.'}
			<form name="couponForm" method="post">
				<table class="table write-form mt-5">
					<tr>
						<td class="table-light col-sm-2" scope="row">쿠폰 할인가격</td>
						<td>
							<input type="text" name="coupon" class="form-control" value="${dto.coupon}">
						</td>
					</tr>
					
					<tr>
						<td class="table-light col-sm-2" scope="row">쿠폰 발급날짜</td>
						<td>
							<input type="date" name="startDate" class="form-control" value="${dto.startDate}">
						</td>
					</tr>
					
					<tr>
						<td class="table-light col-sm-2" scope="row">쿠폰 만료날짜</td>
						<td>
							<input type="date" name="endDate" class="form-control" value="${dto.endDate}">
						</td>
					</tr>
					
				</table>
				
				<table class="table table-borderless">
 					<tr>
						<td class="text-center">
							<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}&nbsp;</button>
							<button type="reset" class="btn btn-light">다시입력</button>
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/admin/couponManage/list';">${mode=='update'?'수정취소':'등록취소'}&nbsp;</button>
							<c:if test="${mode=='update'}">
								<input type="hidden" name="couponNum" value="${dto.couponNum}">
							</c:if>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>