<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
</style>

<script type="text/javascript">
function sendOk() {
	var f = document.hallForm;
	var str;
	
	str = f.hallName.value.trim();
	if(!str){
		alert("공연장 이름을 입력하세요.");
		f.hallName.focus();
		return;
	}
	
	str = f.link.value.trim();
	if(!str){
		alert("홈페이지 주소를 입력하세요.");
		f.link.focus();
		return;
	}
	
	str = f.latitude.value.trim();
	if(!str){
		alert("위도를 입력하세요.");
		f.latitude.focus();
		return;
	}
	
	str = f.longitude.value.trim();
	if(!str){
		alert("경도를 입력하세요.");
		f.longitude.focus();
		return;
	}
	
	str = f.addr.value.trim();
	if(!str){
		alert("주소를 입력하세요.");
		f.addr.focus();
		return;
	}
	
	str = f.tel.value.trim();
	if(!str){
		alert("전화번호를 입력하세요.");
		f.tel.focus();
		return;
	}
	
	var mode = "${mode}";
    if( (mode === "write") && (!f.selectFile.value) ) {
        alert("이미지 파일을 추가 하세요. ");
        f.selectFile.focus();
        return;
    }
	
	str = f.content.value.trim();
	if(!str){
		alert("내용을 입력하세요.");
		f.content.focus();
		return;
	}
	
	f.action = "${pageContext.request.contextPath}/admin/hallManage/${mode}";
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
		var url="${pageContext.request.contextPath}/admin/hallManage/deleteFile";
		$.post(url, {fileNum:fileNum}, function(data){
			$img.remove();
		}, "json");
	});
});
</c:if>

$(function(){
	var sel_files = [];
	
	$("body").on("click", ".write-form .img-add", function(event){
		$("form[name=hallForm] input[name=selectFile]").trigger("click"); 
	});
	
	$("form[name=hallForm] input[name=selectFile]").change(function(){
		if(! this.files) {
			var dt = new DataTransfer();
			for(file of sel_files) {
				dt.items.add(file);
			}
			document.hallForm.selectFile.files = dt.files;
			
	    	return false;
	    }
	    
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
		document.hallForm.selectFile.files = dt.files;		
	    
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
		document.hallForm.selectFile.files = dt.files;
		
		$(this).remove();
	});
});

</script>

<div class="container">
	<div class="body-container">
		<div class="body-title">
			<h3>공연장 등록</h3>
		</div>
		
		<div class="body-main">
			${mode=='update'?'공연장을 수정합니다.':'새로운 공연장을 등록합니다.'}
			<form name="hallForm" method="post" enctype="multipart/form-data">
				<table class="table write-form mt-5">
					<tr>
						<td class="table-light col-sm-2" scope="row">이 름</td>
						<td colspan="3">
							<input type="text" name="hallName" class="form-control" value="${dto.hallName}">
						</td>
					</tr>
					
					<tr>
						<td class="table-light col-sm-2" scope="row">주 소</td>
						<td colspan="3">
							<input type="text" name="addr" class="form-control" value="${dto.addr}">
						</td>
					</tr>
					
					<tr>
						<td class="table-light col-sm-2" scope="row">위 도</td>
						<td>
							<input type="text" name="latitude" class="form-control" value="${dto.latitude}">
						</td>
						<td class="table-light col-sm-2 text-center" scope="row">경 도</td>
						<td>
							<input type="text" name="longitude" class="form-control" value="${dto.longitude}">
						</td>
					</tr>
					
					<tr>
						<td class="table-light col-sm-2" scope="row">전화번호</td>
						<td>
							<input type="text" name="tel" class="form-control" value="${dto.tel}">
						</td>
						<td class="table-light col-sm-2 text-center" scope="row">홈페이지</td>
 						<td>
							<input type="text" name="link" class="form-control" value="${dto.link}">
						</td>
					</tr>
					
					<tr>
						<td class="table-light col-sm-2" scope="row">이미지</td>
						<td>
							<div class="img-grid"><img class="item img-add rounded" src="${pageContext.request.contextPath}/resources/images1/add_photo.png"></div>
							<input type="file" name="selectFile" accept="image/*" multiple="multiple" style="display: none;" class="form-control">
						</td>
					</tr>
					
					<c:if test="${mode=='update'}">
						<tr>
							<td class="table-light col-sm-2" scope="row">등록이미지</td>
							<td> 
								<div class="img-box">
									<c:forEach var="vo" items="${listFile}">
										<img src="${pageContext.request.contextPath}/uploads/hall/${vo.saveFilename}"
											class="delete-img"
											data-fileNum="${vo.fileNum}">
									</c:forEach>
								</div>
							</td>
						</tr>
					</c:if>

					<tr>
						<td class="table-light col-sm-2" scope="row">내 용</td>
						<td colspan="3">
							<textarea name="content" id="content" class="form-control">${dto.content}</textarea>
						</td>
					</tr>
					
				</table>
				
				<table class="table table-borderless">
 					<tr>
						<td class="text-center">
							<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
							<button type="reset" class="btn btn-light">다시입력</button>
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/admin/hallManage/list';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
							<c:if test="${mode=='update'}">
								<input type="hidden" name="hNum" value="${dto.hNum}">
								<input type="hidden" name="page" value="${page}">
							</c:if>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>