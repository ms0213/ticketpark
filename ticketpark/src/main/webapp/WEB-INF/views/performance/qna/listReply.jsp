<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.reply-answer {
	display: none;
}

.num {
	color: #62C15B;
}

.listReply {
	max-width: 970px;
	margin: 0 auto;
}

.border {
    border: 1px solid #FFFFFF!important;
}

.reply .reply-info .reply-count {
	color: #000000;
}
</style>

<div class='listReply'>

<div class='reply-info' align='left'>
	<span class='reply-count' style="font-weight:bold; font-size:16px" data-pageNo='${pageNo}' data-totalPage='${total_page}' >총&nbsp;<span class="num">${replyCount}</span>개의 문의글이 있습니다.</span>

</div><br>

<table class='table table-borderless'>
	<c:forEach var="vo" items="${listReply}">
		<tr class='border bg-light'>
			<td width='50%' align='left'>
				<i class="bi bi-person-circle text-muted"></i> <span class="bold">${vo.userName}</span>
			</td>
			<td width='50%' align='right'>
				<span class="text-muted">${vo.reg_date}</span> |
				<c:choose>
					<c:when test="${sessionScope.member.userId==vo.userId || sessionScope.member.membership > 50 }">
						<span class='deleteReply' data-replyNum='${vo.replyNum}' data-pageNo='${pageNo}'>삭제</span>
					</c:when>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td align='left' colspan='2' valign='top'>${vo.content}</td>
		</tr>

		<tr>
			<td align='left'>
				<button type='button' class='btn btn-outline-secondary btnReplyAnswerLayout' data-replyNum='${vo.replyNum}'>답글 <span id="answerCount${vo.replyNum}">${vo.answerCount}</span></button>
			</td>
			<td align='right'>
				<button type='button' class='btn btn-light btnSendReplyLike' data-replyNum='${vo.replyNum}' data-replyLike='1' title="좋아요"><i class="bi bi-hand-thumbs-up"></i> <span>${vo.likeCount}</span></button>
				<button type='button' class='btn btn-light btnSendReplyLike' data-replyNum='${vo.replyNum}' data-replyLike='0' title="싫어요"><i class="bi bi-hand-thumbs-down"></i> <span>${vo.disLikeCount}</span></button>	        
			</td>
		</tr>
	
	    <tr class='reply-answer'>
	        <td colspan='2' class="px-3">
	        	<div class="p-2 border">
		            <div id='listReplyAnswer${vo.replyNum}' class='p-2'></div>
		            <div class="row px-2">
		                <div class='col'><textarea class='form-control'></textarea></div>
		            </div>
		             <div class='row p-2'>
		             	<div class="col text-end" align='right'>
		                	<button type='button' class='btn btn-light btnSendReplyAnswer' data-replyNum='${vo.replyNum}'>답글 등록</button>
		                </div>
		            </div>
				</div>
			</td>
	    </tr>
	</c:forEach>
</table>
</div>

<div class="page row justify-content-center">
<div class='qna-less-box mt-2 text-end' style="width: 30%;">
	<span class="qna-less btn btn-outline-success"> <i class="icofont-simple-left"></i>&nbsp;이전&nbsp;</span>
</div> 
<div  style="width: 30%;">
	<p>${pageNo}&nbsp;&nbsp;/&nbsp;&nbsp;${total_page}</p> 
</div>
<div class='qna-more-box mt-2 text-end' style="width: 30%;">
	<span class="qna-more btn btn-outline-success">&nbsp;다음&nbsp;<i class="icofont-simple-right"></i></span>
</div>

</div>