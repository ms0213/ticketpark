<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.alert-info {
	max-width: 980px;
	margin: 0 auto;
	min-height: 120px;
	background-color: #f8f9fa;
	color: #000000;
	border: none;
	font-size: 16px;
} 

.form-control {
	line-height: 2;
	width: 900px;
	padding: 6px 3px;
	text-align: left;
	margin: 0 auto;
}

.deleteReply, .deleteReplyAnswer {
	cursor: pointer;
}

.btnSendReply {
	width: 75px;
	height: 77px;
	
}

.reply-form button {
	padding: 0;
} 

.reply-form textarea {
	width: 880px;
    height: 75px;
   
}

</style>


<div class="container">
		
		<div class="body-title">
		
		</div>
	<div class="body-container">	
		
		 <div class="alert alert-info" role="alert" align='left'>
	    		<br>공연에 대해서 고객간에 자유롭게 질문/답변을 하는 공간입니다.<br>
				예매, 결제, 취소 등의 정확한 답변이 필요한 문의는 티켓파크 고객센터  <strong>1234-5678</strong> 를 이용해주시기 바랍니다.<br>
	    </div>
			<div class="reply">
				<form name="replyForm" method="post">
					<div class='form-header'>
						<span class="bold"></span><span> </span>
					</div>
					
					<table class="table table-borderless reply-form">
						<tr>
							<td align='right'>
								<textarea class='form-control' name="qnacontent" id="qnacontent" placeholder=" &nbsp;게시판 운영 규정에 어긋난다고 판단되는 글은 사전 통보없이 삭제 처리될 수 있습니다."></textarea>
							</td>
						
						
						   <td align='left'>
						        <button type='button' class='btn btn-success btnSendReply'>등록</button>
						    </td>
						 </tr>
					</table>
				</form>
				
				<div id="listReply"></div>
			</div>
			
	</div>
	
</div>
