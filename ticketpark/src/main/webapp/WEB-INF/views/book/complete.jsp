<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="container">
	<div class="body-container">	
	
		<div class="body-title">
			<div class="progress" style="height: 70px; font-size: 18px;">
				<div class="progress-bar bg-success" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">좌석 선택</div>
  				<div class="progress-bar bg-success" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">본인확인</div>
  				<div class="progress-bar bg-success" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">결제</div>
  				<div class="progress-bar progress-bar-striped progress-bar-animated bg-success" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">완료</div>
			</div>
		</div>

        <div class="row justify-content-md-center mt-5">
            <div class="col-md-8">
                <div class="border bg-light mt-5 p-4">
                	<h4 class="text-center fw-bold">${title}</h4>
                    <hr class="mt-4">
                       
	                <div class="d-grid p-3">
						<p class="text-center">${message}</p>
	                </div>
                       
                    <div class="d-grid">
                        <button type="button" class="btn btn-lg btn-success" onclick="location.href='${pageContext.request.contextPath}/';">메인화면 <i class="bi bi-check2"></i> </button>
                    </div>
                </div>

            </div>
        </div>
	        
	</div>
</div>