<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
<script type="text/javascript">
	var IMP = window.IMP; // 생략 가능
	IMP.init("imp85246667");
	
window.onload =	function requestPay() {
		// IMP.request_pay(param, callback) 결제창 호출
	    IMP.request_pay({ // param
	    pg: "html5_inicis",
	    pay_method: "card",
	    merchant_uid: "ORD20180131-0000011",
	    name: "노르웨이 회전 의자",
	    amount: 64900,
	    buyer_email: "gildong@gmail.com",
	    buyer_name: "홍길동",
	    buyer_tel: "010-4242-4242",
	    buyer_addr: "서울특별시 강남구 신사동",
	    buyer_postcode: "01181"
	}, function (rsp) { // callback
	    console.log(rsp);
	    if (rsp.success) { // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
	    	// jQuery로 HTTP 요청
	    	jQuery.ajax({
	    		url: "${pageContext.request.contextPath}/book/payment", // 예: https://www.myservice.com/payments/complete
	    	    method: "POST",
	    	    headers: { "Content-Type": "application/json" },
	    	    data: {
	    	          	imp_uid: rsp.imp_uid,
	    	            merchant_uid: rsp.merchant_uid
	    	          }
	    	}).done(function (data) {
	    		// 가맹점 서버 결제 API 성공시 로직
	    	})
	    } else {
	    	alert("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
	    }
	  });
	}
</script>
<div class="container">
	<div class="body-container">
	
		<div class="body-title">
			<div class="progress" style="height: 70px; font-size: 18px;">
  				<div class="progress-bar bg-success" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">좌석 선택</div>
  				<div class="progress-bar bg-success" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">본인확인</div>
  				<div class="progress-bar bg-success progress-bar-striped progress-bar-animated" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">결제</div>
  				<div class="progress-bar bg-light" role="progressbar" style="width: 25%; color: black;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">완료</div>
			</div>
		</div>	
		
		<div class="body-main">
			
		</div>
	        
	</div>
</div>