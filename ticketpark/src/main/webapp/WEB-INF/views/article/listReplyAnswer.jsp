<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:forEach var="vo" items="${listReplyAnswer}">
	<div class='answer-article'>
		<div class='answer-article-header'>
			<div class='answer-left'>└</div>
			<div class='answer-right'>
				<div style='float: left;'><span class='bold'>작성자 : ${vo.userName}</span></div>
				<div style='float: right;'>
					<span style="font-size: 14px; color: #a2a2a2;">${vo.reg_date}</span> |
					<c:choose>
						<c:when test="${sessionScope.member.userId==vo.userId || sessionScope.member.membership>50}">
							<span style="font-size: 14px; color: #a2a2a2;" class='deleteReplyAnswer' data-replyNum='${vo.replyNum}' data-answer='${vo.answer}'>삭제</span>
						</c:when>
						<c:otherwise>
							<span class='notifyReply'>신고</span>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
	<br>
	<div class='answer-article-body'>
		${vo.content}
	</div>
</c:forEach>
