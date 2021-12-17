<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/boot-board.css" type="text/css">

<style type="text/css">
.img-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, 65px);
	grid-gap: 5px;
}

.img-grid .item {
    object-fit: cover; /* 가로세로 비율은 유지하면서 컨테이너에 꽉 차도록 설정 */
    width: 65px;
    height: 65px;
	cursor: pointer;
}

.img-box {
	max-width: 600px;

	box-sizing: border-box;
	display: flex; /* 자손요소를 flexbox로 변경 */
	flex-direction: row; /* 정방향 수평나열 */
	flex-wrap: nowrap;
	overflow-x: auto;
}
.img-box img {
	width: 65px; height: 65px;
	margin-right: 5px;
	flex: 0 0 auto;
	cursor: pointer;
}

.body-container {
	margin: 0 auto 10px;
}
</style>

<script type="text/javascript">
function sendOk() {
    var f = document.eventForm;
	var str;
	
    str = f.eventName.value.trim();
    if(!str) {
        alert("이벤트이름을 입력하세요. ");
        f.subject.focus();
        return;
    }

    str = f.content.value.trim();
    if(!str) {
        alert("내용을 입력하세요. ");
        f.content.focus();
        return;
    }

    var mode = "${mode}";
    if( (mode === "write") && (!f.selectFile.value) ) {
        alert("이미지 파일을 추가 하세요. ");
        f.selectFile.focus();
        return;
    }
    
    f.action = "${pageContext.request.contextPath}/event/${mode}";
    f.submit();
}

<c:if test="${mode=='update'}">
$(function(){
	$(".delete-img").click(function(){
		if(! confirm("이미지를 삭제 하시겠습니까 ?")) {
			return false;
		}
		var $img = $(this);
		var fileNum = $img.attr("data-fileNum");
		var url="${pageContext.request.contextPath}/event/deleteFile";
		$.post(url, {fileNum:fileNum}, function(data){
			$img.remove();
		}, "json");
	});
});
</c:if>

$(function(){
	var sel_files = [];
	
	$("body").on("click", ".write-form .img-add", function(event){
		$("form[name=eventForm] input[name=selectFile]").trigger("click"); 
	});
	
	$("form[name=eventForm] input[name=selectFile]").change(function(){
		if(! this.files) {
			var dt = new DataTransfer();
			for(file of sel_files) {
				dt.items.add(file);
			}
			document.eventForm.selectFile.files = dt.files;
			
	    	return false;
	    }
	    
		// 유사 배열을 배열로 변환
	    const fileArr = Array.from(this.files);
	
		fileArr.forEach((file, index) => {
			sel_files.push(file);
			
			const reader = new FileReader();
			const $img = $("<img>", {class:"item img-item"});
			$img.attr("data-filename", file.name);
	        reader.onload = e => {
	        	$img.attr("src", e.target.result);
	        };
	        
	        reader.readAsDataURL(file);
	        
	        $(".img-grid").append($img);
	    });
		
		var dt = new DataTransfer();
		for(file of sel_files) {
			dt.items.add(file);
		}
		document.eventForm.selectFile.files = dt.files;		
	    
	});
	
	$("body").on("click", ".write-form .img-item", function(event) {
		if(! confirm("선택한 파일을 삭제 하시겠습니까 ?")) {
			return false;
		}
		
		var filename = $(this).attr("data-filename");
		
	    for(var i = 0; i < sel_files.length; i++) {
	    	if(filename === sel_files[i].name){
	    		sel_files.splice(i, 1);
	    		break;
			}
	    }
	    
		var dt = new DataTransfer();
		for(file of sel_files) {
			dt.items.add(file);
		}
		document.eventForm.selectFile.files = dt.files;
		
		$(this).remove();
	});
});
</script>

<div class="container">
	<div class="body-container">	
		<div class="body-title">
			<h3><i class="bi bi-images"></i> 공연장 등록 </h3>
		</div>
		
		<div class="body-main">
		
			<form name="eventForm" method="post" enctype="multipart/form-data">
				<table class="table write-form mt-5">
					<tr>
						<td class="table-light col-sm-2" scope="row">공연제목</td>
						<td>
							<input type="text" name="subject" class="form-control" value="${dto.subject}">
						</td>
					</tr>
					
					<tr>
						<td class="table-light col-sm-2" scope="row">시작날짜</td>
						<td>
							<input type="date" name="startDate" class="form-control" value="${dto.startDate}">
						</td>
					</tr>
					
					<tr>
						<td class="table-light col-sm-2" scope="row">마지막날짜</td>
						<td>
							<input type="date" name="endDate" class="form-control" value="${dto.endDate}">
						</td>
					</tr>
					
					<tr>
						<td class="table-light col-2" scope="row">시작일자</td>
						<td>
							<div class="row">
								<div class="col-5 pe-0">
									<input type="date" name="sday" id="form-sday" class="form-control" value="${dto.sday}">
								</div>
								<div class="col-3">
									<input type="time" name="stime" id="form-stime" class="form-control" value="${dto.stime}"
										style="display: ${dto.all_day == 1 ? 'none;':'inline-block;'}">
								</div>
							</div>
						</td>
					</tr>

 					<tr>
						<td class="table-light col-sm-2" scope="row">관람 시간</td>
						<td>
							<input type="text" name="time" class="form-control" value="${dto.time}">
						</td>
					</tr>
					
					<tr>
						<td class="table-light col-sm-2" scope="row">내 용</td>
						<td>
							<textarea name="content" id="content" class="form-control">${dto.content}</textarea>
						</td>
					</tr>
					
					<tr>
						<td class="table-light col-sm-2" scope="row">포스터</td>
						<td>
							<div class="img-grid"><img class="item img-add rounded" src="${pageContext.request.contextPath}/resources/images1/add_photo.png"></div>
							<input type="file" name="selectFile" accept="image/*" style="display: none;" class="form-control">
						</td>
					</tr>
					
					<tr>
						<td class="table-light col-sm-2" scope="row">출연진</td>
						<td>
							<input type="text" name="time" class="form-control" value="${dto.time}">
						</td>
					</tr>
					
					<c:if test="${mode=='update'}">
						<tr>
							<td class="table-light col-sm-2" scope="row">등록이미지</td>
							<td> 
								<div class="img-box">
									<c:forEach var="vo" items="${listFile}">
										<img src="${pageContext.request.contextPath}/uploads/event/${vo.saveFilename}"
											class="delete-img"
											data-fileNum="${vo.fileNum}">
									</c:forEach>
								</div>
							</td>
						</tr>
					</c:if>
				</table>
				
				<table class="table table-borderless">
 					<tr>
						<td class="text-center">
							<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
							<button type="reset" class="btn btn-light">다시입력</button>
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/event/list';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
							<c:if test="${mode=='update'}">
								<input type="hidden" name="eventNum" value="${dto.eventNum}">
								<input type="hidden" name="page" value="${page}">
							</c:if>
						</td>
					</tr>
				</table>
			</form>
		
		</div>
	</div>
</div>