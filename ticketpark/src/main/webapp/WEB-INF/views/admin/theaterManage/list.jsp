<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



	<div class="accordion" id="accordionExample"> 
		<c:forEach var="dto" items="${list}" varStatus="status">
			 <div class="card">
				<div class="card-header" id="heading${status.index}">
					<h2 class="mb-0">
						<button class="btn btn-link collapsed" type="button" data-toggle="collapse" aria-expanded="false" data-target="#collapse${status.index}" aria-controls="collapse${status.index}" style="text-decoration: none;">
          					${dto.name}
						</button>
					</h2>
				</div>

				<div id="collapse${status.index}" class="collapse" aria-labelledby="heading${status.index}" data-parent="#accordionExample">
					<div class="card-body">
						<div class="row border-bottom pb-1"> 상영관 이름 : ${dto.name}</div>
						<div class="row p-2">
      					좌석 배치도 사진 |&nbsp;보기 , ${not empty dto.saveFilename ? "삭제" : "등록"}
      					</div>

						<div class="row py-1">
							<div class="col text-end">
								<a href="#" onclick="javascript:location.href='${pageContext.request.contextPath}/admin/theaterManage/update?num=${dto.tNum}';">수정</a>&nbsp;|
								<a href="#" onclick="deleteTheater('${dto.tNum}');">삭제</a>
							</div>
						</div>
      				</div>
    			</div>
    			
  			</div>
	
		</c:forEach>
		<button type="button" class="btn btn-light" onclick="addtheater();">상영관 추가하기</button>
	</div>


<div class="row py-3">
	<div class="col">
    	
		<button type="button" class="btn btn-light" onclick="reloadTheater();">새로고침</button>
	</div>
</div>


