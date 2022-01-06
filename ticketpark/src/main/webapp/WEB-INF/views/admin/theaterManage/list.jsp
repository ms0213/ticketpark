<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


	<div class="accordion" id="accordionExample"> 
		<c:forEach var="vo" items="${list2}">
			<img src="${pageContext.request.contextPath}/uploads/hall/${vo.hallFile}">
		</c:forEach>
		
		<table class="table table-border table-list">
			<thead>
				<tr> 
					<th class="w-auto">상영관 이름</th>
					<th class="w-auto">좌석 배치도 사진</th>
					<th class="w-auto">상영관 삭제하기</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach var="dto" items="${list}" varStatus="status">
				<tr> 
					<td style="text-align: center;">${dto.name}</td>
					<td style="text-align: center;"><button type="button" class="btn btn-light">보기</button> <button type="button" class="btn btn-light"> ${not empty dto.saveFilename ? "삭제" : "등록"} </button></td>
					<td style="text-align: center;"><button type="button" class="btn " onclick="deleteTheater('${dto.tNum}');">상영관삭제</button></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		

		
	</div>


<div class="row py-3">
	<div class="col" style="padding-top: 20px; float: right;">
    	<button type="button" class="btn btn-light" onclick="addtheater();">상영관 추가하기</button>
		<button type="button" class="btn btn-light" onclick="reloadTheater();">새로고침</button>
	</div>
</div>


