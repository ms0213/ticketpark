<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<div class="container">
	<div class="body-container">
		<div class="body-title">
			<h3> Contact Us </h3>
		</div>
		
		<div class="body-main">
			<table class="table table-border table-article">
				<tr>
					<td width="40%">
						제목 : ${dto.title}
					</td>
					<td align="left">
						이메일 : ${dto.email}
					</td>
					<td align="right">
						작성자 : ${dto.name}
					</td>
				</tr>
				<tr>
					<td colspan="3"  height="500" style="border-top:2px solid gray;">
						${dto.content}
					</td>
				</tr>
			</table>
			
			<table class="table">
				<tr>
					<td align="right">
						<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/admin/contactUs/delete?cNum=${dto.cNum}';">삭제</button>
						<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/admin/contactUs/list?${query}';">리스트</button>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>