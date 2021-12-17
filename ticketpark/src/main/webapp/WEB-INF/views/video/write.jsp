<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/boot-board.css" type="text/css">

<script type="text/javascript">
function sendOk() {
	var f = document.videoForm;
	var str;
	
	str = f.subject.value.trim();
	if(!str){
		alert("제목을 입력하세요.");
		f.subject.focus();
		return;
	}
	
	str = f.link.value.trim();
	if(!str){
		alert("링크를 입력하세요.");
		f.link.focus();
		return;
	}
	
	str = f.content.value.trim();
	if(!str){
		alert("내용을 입력하세요.");
		f.content.focus();
		return;
	}
	
	f.action = "${pageContext.request.contextPath}/video/${mode}";
	f.submit();
}
</script>

<div class="container">
	<div class="body-container">
		<div class="body-title">
			<h3>영상 업로드</h3>
		</div>
		
		<div class="body-main">
			${mode=='update'?'영상을 수정합니다.':'새로운 영상을 업로드 합니다.'}
			<form name="videoForm" method="post">
				<table class="table write-form mt-5">
					<tr>
						<td class="table-light col-sm-2" scope="row">제 목</td>
						<td>
							<input type="text" name="subject" class="form-control" value="${dto.subject}">
						</td>
					</tr>
					
					<tr>
						<td class="table-light col-sm-2" scope="row">링 크</td>
						<td>
							<input type="text" name="link" class="form-control" value="${dto.link}">
						</td>
					</tr>
					
					<tr>
						<td class="table-light col-sm-2" scope="row">작성자명</td>
 						<td>
							<p class="form-control-plaintext">${sessionScope.member.userName}</p>
						</td>
					</tr>

					<tr>
						<td class="table-light col-sm-2" scope="row">내 용</td>
						<td>
							<textarea name="content" id="content" class="form-control">${dto.content}</textarea>
						</td>
					</tr>
					
				</table>
				
				<table class="table table-borderless">
 					<tr>
						<td class="text-center">
							<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
							<button type="reset" class="btn btn-light">다시입력</button>
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/video/list';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
							<c:if test="${mode=='update'}">
								<input type="hidden" name="vNum" value="${dto.vNum}">
								<input type="hidden" name="page" value="${page}">
							</c:if>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>