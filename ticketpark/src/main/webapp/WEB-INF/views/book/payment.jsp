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
		var f = document.hiddenForm;
	    IMP.request_pay({ // param
	    pg: "html5_inicis",
	    pay_method: "card",
	    merchant_uid: "ORD20180131-0000011" + new Date().getTime(),
	    name: f.name.value + f.couponNum.value,
	    amount: 100,
	    buyer_email: f.email.value,
	    buyer_name: f.userName.value,
	    buyer_tel: f.tel.value,
	    buyer_addr: f.addr.value
	}, function (rsp) { // callback
	    console.log(rsp);
	    if (rsp.success) { // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
	    	var msg = '결제에 성공하였습니다. 예매 내역은 마이페이지를 확인해주세요.';
	    	f.action="${pageContext.request.contextPath}/book/payment";
	    	f.submit();
	    } else {
	    	var msg = '결제에 실패하였습니다.';
	    	msg += '\n실패사유 : ' + rsp.error_msg;
	    }
	    alert(msg);
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
			<form name="hiddenForm" method="post">
				<input type="hidden" value="${email}" name="email">	
				<input type="hidden" value="${userName}" name="userName">	
				<input type="hidden" value="${tel}" name="tel">	
				<input type="hidden" value="${addr}" name="addr">
				<input type="hidden" value="${amount}" name="amount">
				<input type="hidden" value="${name}" name="name">
				<input type="hidden" value="${bNum}" name="bNum">
				<input type="hidden" value="${couponNum}" name="couponNum">	
			</form>
		</div>
	        
	</div>
</div>