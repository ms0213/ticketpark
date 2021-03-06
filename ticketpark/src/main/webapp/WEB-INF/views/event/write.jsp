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
.event-container {
    width: 100%;
    max-width: 1140px;
    padding-right: 15px;
    padding-left: 15px;
    margin-right: auto;
    margin-left: auto;
}

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

.couponBtn{
	background: #0075ff;
    font-size: 14px;
    line-height: 100%;
    color: white;
    vertical-align: baseline;
}

.ck.ck-editor {
	max-width: 97%;
}
.ck-editor__editable {
    min-height: 250px;
}
.ck-content .image>figcaption {
	min-height: 25px;
}
</style>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/vendor/ckeditor5/ckeditor.js"></script>

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

    str = window.editor.getData().trim();
    if(! str) {
        alert("내용을 입력하세요. ");
        window.editor.focus();
        return;
    }
	f.content.value = str;

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

<script type="text/javascript">
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
		},
		error:function(jqXHR) {
			console.log(jqXHR.responseText);
		}
	});
}

$(function() {
	$("#coupon").change(function(){
		var couponBtn = document.getElementById("couponBtn");
		
		if($("#coupon").is(":checked")){
		    couponBtn.removeAttribute("hidden");
		}else{
		    couponBtn.setAttribute("hidden", "hidden");
		}
	});
	
});

$(function() {
	$("body").on("click", ".couponBtn", function(event){
		$("#couponModal").modal("show");
		
		var url="${pageContext.request.contextPath}/event/listModal";
		
		var query = "tmp="+new Date().getTime();
		var fn = function(data){
			$(".modal-list").html(data);
		};
		ajaxFun(url, "get", null, "html", fn)
	});
	
	$(document).on("click", ".couponPick", function() {
		console.log(this.value);
		$("#modal-data").val(this.value);
		$("#couponModal").modal("hide");
	});
	
});

$(function() {
	$("#modal-data").change(function(){
		var data = document.getElementById("modal-data");
		
		if(!$("#modal-data").value){
			data.setAttribute("hidden", "hidden");
		}else{
			data.removeAttribute("hidden");
		}
	});
	
});

</script>

<div class="event-container">
	<div class="body-container">	
		<div class="body-title">
			<h3>이벤트 </h3>
		</div>
		
		<div class="body-main">
		
			<form name="eventForm" method="post" enctype="multipart/form-data">
				<table class="table write-form mt-5">
					<tr>
						<td class="table-light col-sm-2" scope="row">이벤트 이름</td>
						<td>
							<input type="text" name="eventName" class="form-control" value="${dto.eventName}">
						</td>
					</tr>

					<tr style="height: 55px;">
						<td class="table-light col-sm-2" scope="row">쿠폰여부</td>
						<td>
							<input type="checkbox" name="coupon" id="coupon" value="1"> &nbsp;&nbsp;
							<button type='button' class='btn couponBtn' id = "couponBtn" hidden="hidden">쿠폰 리스트</button>
							<input type="text" id="modal-data" name="couponNum" value="" readonly="readonly" >
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
						<td class="table-light col-sm-2" scope="row">내 용</td>
						<td>
							<div class="editor">${dto.content}</div>
							<input type="hidden" name="content">
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
								<input type="hidden" name="eventNum" value="${dto.couponNum}">
								<input type="hidden" name="page" value="${page}">
							</c:if>
						</td>
					</tr>
				</table>
			</form>
		
		</div>
	</div>
</div>



<div class="modal fade" id="couponModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"> 발급 가능 쿠폰 선택 </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table style="width: 100%; border-spacing: 1px; background: #ccc;">
	        <thead>
				<tr height="30" bgcolor="#eee" align="center">
					<th>No.</th>
					<th>쿠폰번호</th>
					<th>할인가격</th>
					<th>발급일자</th>
					<th>만료일자</th>
					<th>선택</th>
				</tr>
	        </thead>
	        <tbody class="modal-list"></tbody>
			
		</table>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
	ClassicEditor
	.create( document.querySelector( '.editor' ), {
		fontFamily: {
	        options: [
	            'default',
	            '맑은 고딕, Malgun Gothic, 돋움, sans-serif',
	            '나눔고딕, NanumGothic, Arial'
	        ]
	    },
	    fontSize: {
	        options: [
	            9, 11, 13, 'default', 17, 19, 21
	        ]
	    },
		toolbar: {
			items: [
				'heading','|',
				'fontFamily','fontSize','bold','italic','fontColor','|',
				'alignment','bulletedList','numberedList','|',
				'imageUpload','insertTable','sourceEditing','blockQuote','mediaEmbed','|',
				'undo','redo','|',
				'link','outdent','indent','|',
			]
		},
		image: {
	        toolbar: [
	            'imageStyle:full',
	            'imageStyle:side',
	            '|',
	            'imageTextAlternative'
	        ],
	
	        // The default value.
	        styles: [
	            'full',
	            'side'
	        ]
	    },
		language: 'ko',
		ckfinder: {
	        uploadUrl: '${pageContext.request.contextPath}/image/upload' // 업로드 url (post로 요청 감)
	    }
	})
	.then( editor => {
		window.editor = editor;
	})
	.catch( err => {
		console.error( err.stack );
	});
</script>