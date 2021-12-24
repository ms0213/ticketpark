<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
function sendOk() {
	var f = document.identificationForm;
	
	f.action = "${pageContext.request.contextPath}/book/identification";
	f.submit();
}
</script>

<div class="container">
	<div class="body-container">
	
		<div class="body-title">
			<div class="progress" style="height: 70px; font-size: 18px;">
  				<div class="progress-bar bg-success" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">좌석 선택</div>
  				<div class="progress-bar bg-success progress-bar-striped progress-bar-animated" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">본인확인</div>
  				<div class="progress-bar bg-light" role="progressbar" style="width: 25%; color: black;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">결제</div>
  				<div class="progress-bar bg-light" role="progressbar" style="width: 25%; color: black;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">완료</div>
			</div>
		</div>	
		
		<div class="body-main">
			
			<form name="identificationForm" method="post" enctype="multipart/form-data"> 
				<table class="table mt-5">
					<tr>
						<td class="table-light col-sm-2" scope="row">이름</td>
						<td>
							<p class="form-control-plaintext">${userName}</p>
						</td>
					</tr>
					
					<tr>
						<td class="table-light col-sm-2" scope="row">생년월일</td>
						<td>
							<p class="form-control-plaintext">${birth}</p>
						</td>
					</tr>
					
					<tr>
						<td class="table-light col-sm-2" scope="row">이메일</td>
						<td>
							<p class="form-control-plaintext">${email}</p>
						</td>
					</tr>
					
					<tr>
						<td class="table-light col-sm-2" scope="row">전화번호</td>
						<td>
							<p class="form-control-plaintext">${tel}</p>
						</td>
					</tr>
			
				</table>
				
				<table class="table table-borderless">
						<tr>
						<td class="text-center">
							<button type="button" class="btn btn-dark" onclick="sendOk();">결제하기&nbsp;</button>
							<button type="reset" class="btn btn-light">다시입력</button>
							<button type="button" class="btn btn-light" onclick="sendCancel();">예매취소</button>
						</td>
					</tr>
				</table>
			</form>
			
		</div>
	        
	</div>
</div>