<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-main {
	max-width: 1000px;
}
</style>

<script type="text/javascript">
<c:if test="${sessionScope.member.userId==dto.admin||sessionScope.member.membership>50}">
function deleteBoard() {
	var query = "num=${dto.artiNum}&${query}";
	var url = "${pageContext.request.contextPath}/article/delete?" + query;

	if(confirm("게시글을 삭제 하시 겠습니까 ? ")) {
		location.href=url;
	}
}
</c:if>
</script>

<script type="text/javascript">
function login() {
	location.href="${pageContext.request.contextPath}/member/login";
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
				login();
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패했습니다.");
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}
//게시글 공감 여부
$(function(){
	$(".btnSendArticleLike").click(function(){
		var $i = $(this).find("i");
		var userLiked = $i.hasClass("bi-hand-thumbs-up-fill");
		var msg = userLiked ? "게시글 공감을 취소하시겠습니까 ? " : "게시글에 공감하십니까 ? ";
		
		if(! confirm( msg )) {
			return false;
		}
		
		var url="${pageContext.request.contextPath}/article/insertArticleLike";
		var artiNum="${dto.artiNum}";
		var query="artiNum="+artiNum+"&userLiked="+userLiked;
		
		var fn = function(data){
			console.log(data);
			var state = data.state;
			if(state==="true") {
				if( userLiked ) {
					$i.removeClass("bi-hand-thumbs-up-fill").addClass("bi-hand-thumbs-up");
				} else {
					$i.removeClass("bi-hand-thumbs-up").addClass("bi-hand-thumbs-up-fill");
				}
				
				var count = data.articleLikeCount;
				$("#articleLikeCount").text(count);
			} else if(state==="liked") {
				alert("게시글 공감은 한번만 가능합니다. !!!");
			} else if(state==="false") {
				alert("게시물 공감 여부 처리가 실패했습니다. !!!");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});
// 페이징 처리
$(function(){
	listPage(1);
});

function listPage(page) {
	var url = "${pageContext.request.contextPath}/article/listReply";
	var query = "num=${dto.artiNum}&pageNo="+page;
	var selector = "#listReply";
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

// 리플 등록
$(function(){
	$(".btnSendReply").click(function(){
		var artiNum="${dto.artiNum}";
		var $tb = $(this).closest("table");
		var content=$tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="${pageContext.request.contextPath}/article/insertReply";
		var query="artiNum="+artiNum+"&content="+content+"&answer=0";
		
		var fn = function(data){
			$tb.find("textarea").val("");
			
			var state=data.state;
			if(state==="true") {
				listPage(1);
			} else if(state==="false") {
				alert("댓글을 추가 하지 못했습니다.");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});


// 댓글 삭제
$(function(){
	$("body").on("click", ".deleteReply", function(){
		if(! confirm("게시글을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		var replyNum=$(this).attr("data-replyNum");
		var page=$(this).attr("data-pageNo");
		
		var url="${pageContext.request.contextPath}/article/deleteReply";
		var query="replyNum="+replyNum+"&mode=reply";
		
		var fn = function(data){
			// var state=data.state;
			listPage(page);
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});


// 댓글별 답글 리스트
function listReplyAnswer(answer) {
	var url="${pageContext.request.contextPath}/article/listReplyAnswer";
	var query="answer="+answer;
	var selector="#listReplyAnswer"+answer;
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

// 댓글별 답글 개수
function countReplyAnswer(answer) {
	var url="${pageContext.request.contextPath}/article/countReplyAnswer";
	var query="answer="+answer;
	
	var fn = function(data){
		var count=data.count;
		var vid="#answerCount"+answer;
		$(vid).html(count);
	};
	
	ajaxFun(url, "post", query, "json", fn);
}

// 답글 버튼(댓글별 답글 등록폼 및 답글리스트)
$(function(){
	$("body").on("click", ".btnReplyAnswerLayout", function(){
		var $trReplyAnswer = $(this).closest("tr").next();
		
		var isVisible = $trReplyAnswer.is(':visible');
		var replyNum = $(this).attr("data-replyNum");
			
		if(isVisible) {
			$trReplyAnswer.hide();
			$(".reply-answer").hide();
		} else {
			$trReplyAnswer.show();
			$(".reply-answer").show();
            
			// 답글 리스트
			listReplyAnswer(replyNum);
			
			// 답글 개수
			countReplyAnswer(replyNum);
		}
	});
	
});

// 댓글별 답글 등록
$(function(){
	$("body").on("click", ".btnSendReplyAnswer", function(){
		var artiNum="${dto.artiNum}";
		var replyNum=$(this).attr("data-replyNum");
		var $td=$(this).closest("td");
		
		var content=$td.find("textarea").val().trim();
		if(! content) {
			$td.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="${pageContext.request.contextPath}/article/insertReply";
		var query="artiNum="+artiNum+"&content="+content+"&answer="+replyNum;
		
		var fn = function(data){
			$td.find("textarea").val("");
			
			var state=data.state;
			if(state==="true") {
				listReplyAnswer(replyNum);
				countReplyAnswer(replyNum);
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

// 댓글별 답글 삭제
$(function(){
	$("body").on("click", ".deleteReplyAnswer", function(){
		if(! confirm("게시글을 삭제하시겠습니까 ? ")) {
		    return;
		}
		
		var replyNum=$(this).attr("data-replyNum");
		var answer=$(this).attr("data-answer");
		
		var url="${pageContext.request.contextPath}/article/deleteReply";
		var query="replyNum="+replyNum+"&mode=answer";
		
		var fn = function(data){
			listReplyAnswer(answer);
			countReplyAnswer(answer);
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});
</script>

<div class="container body-container">
    <div class="body-title">
        <h3> ${dto.subject} </h3>
    </div>
    
    <div class="body-main pt-15 mx-auto">
		<table class="table table-border table-article">
			<thead>
			</thead>
			<tbody>
				<tr>
					<td width="50%" align="left">
						작성자 : ${dto.userName}
					</td>
					<td width="50%" align="right">
						${dto.reg_date} | 조회 ${dto.hitCount}
					</td>
				</tr>
				<tr style="border: none;">
					<c:forEach var="vo" items="${listFile}">
						<td style="border: none; size: ">
							<img src="${pageContext.request.contextPath}/uploads/article/${vo.saveFilename}">
						</td>
					</c:forEach>
					

				</tr>
				<tr style="border: none;">
					<td colspan="2" valign="top" height="200" style="border: none;">
						${dto.content}
					</td>
				</tr>
				<tr>
					<td colspan="2" class="text-center p-3">
						<button type="button" class="btn btn-outline-secondary btnSendArticleLike" title="좋아요"><i class="bi ${userArticleLiked ? 'bi-hand-thumbs-up-fill':'bi-hand-thumbs-up' }"></i>&nbsp;&nbsp;<span id="articleLikeCount">${dto.articleLikeCount}</span></button>
					</td>
				</tr>
			</tbody>
		</table>
			
		<table class="table">
			<tr>
				<td width="50%">
					<c:choose>
						<c:when test="${sessionScope.member.userId==dto.admin}">
			    			<button type="button" class="btn btn-outline-secondary fh rhclrh" onclick="javascript:location.href='${pageContext.request.contextPath}/article/update?num=${dto.artiNum}&page=${page}';">수정</button>
			    		</c:when>
			    		<c:otherwise>
			    			<button type="button" class="btn btn-outline-secondary fh rhclrh" disabled="disabled">수정</button>
			    		</c:otherwise>
			    	</c:choose>
			    	
			    	<c:choose>
			    		<c:when test="${sessionScope.member.userId==dto.admin || sessionScope.member.membership>50}">
			    			<button type="button" class="btn btn-outline-secondary fh rhclrh" onclick="deleteBoard();">삭제</button>
			    		</c:when>
			    		<c:otherwise>
			    			<button type="button" class="btn btn-outline-secondary fh rhclrh" disabled="disabled">삭제</button>
			    		</c:otherwise>
			    	</c:choose>
				</td>
			
				<td align="right">
					<button type="button" class="btn btn-outline-secondary fh rhclrh" onclick="javascript:location.href='${pageContext.request.contextPath}/article/list?${query}';">리스트</button>
				</td>
			</tr>
		</table>
		
		<div class="reply">
			<form name="replyForm" method="post">
				<div class='form-header'>
					<span class="bold">댓글쓰기</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가해 주세요.</span>
				</div>
				
				<table class="table reply-form">
					<tr>
						<td style="border-bottom: none;">
							<textarea class='form-control' name="content"></textarea>
						</td>
					</tr>
					<tr>
					   <td align='right'  style="border-top: none;">
					        <button type='button' class='btn btn-outline-secondary fh rhclrh btnSendReply'>댓글 등록</button>
					    </td>
					 </tr>
				</table>
			</form>
			
			<div id="listReply"></div>
		</div>
    </div>
    
</div>