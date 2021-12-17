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

.input-title {
	font-size:13px;
    color: #212121;
    line-height: 180%;
}

.boxTF {
    border: 1px solid #ced4da;
    border-radius: 0.25rem;
    height: calc(1.5em + 0.75rem + 2px);
    padding: 0.375rem 0.75rem;
    background-color: #fff;
    border-radius: 4px;
    font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
    font-size: 1rem;
    font-weight: 400;
    vertical-align: baseline;
}

.btn:hover, .btn:active, .btn:focus {
	background-color: #e6e6e6;
	border-color: #adadad;
	color:#333;
}
.btn[disabled], fieldset[disabled] .btn {
	pointer-events: none;
	cursor: not-allowed;
	filter: alpha(opacity=65);
	-webkit-box-shadow: none;
	box-shadow: none;
	opacity: .65;
}

.scheduleRemoveBtn, .castRemoveBtn {
    cursor: pointer;
    width: 38px;
    text-align: center;
}

.cast-img, .post-img {
    cursor: pointer;
    border: 1px solid #ccc;
    width: 45px;
    height: 45px;
    border-radius: 45px;
    background-image: url(/tp/resources/images1/add_photo.png);
    position: relative;
    background-size: cover;
    margin-left: 10px;
    padding: 20px;
}

input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}
</style>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">

<script type="text/javascript">
function sendOk() {
    var f = document.performanceForm;
	var str;
	
    str = f.subject.value.trim();
    if(!str) {
        alert("공연이름을 입력하세요. ");
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
    
    f.action = "${pageContext.request.contextPath}/performance/${mode}";
    f.submit();
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

$(function(){
	$("form select[name=categoryNum]").change(function(){
		var categoryNum = $(this).val();
		$("form select[name=genreNum]").find('option').remove().end()
				.append("<option value=''>:: 장르 선택 ::</option>");
		
		if(! categoryNum) {
			return false;
		}
		
		var url="${pageContext.request.contextPath}/performance/genre";
		var query="categoryNum=" + categoryNum;
		
		var fn=function(data) {
			$.each(data.genreList, function(index, item){
				var genreNum = item.genreNum;
				var genre = item.genre;
				var s = "<option value='"+genreNum+"'>"+genre+"</option>";
				$("form select[name=genreNum]").append(s);
			});
		};
		ajaxFun(url, "get", query, "json", fn);
	});
});

<c:if test="${mode=='update'}">
$(function(){
	$(".delete-img").click(function(){
		if(! confirm("이미지를 삭제 하시겠습니까 ?")) {
			return false;
		}
		var $img = $(this);
		var fileNum = $img.attr("data-fileNum");
		var url="${pageContext.request.contextPath}/performance/deleteFile";
		$.post(url, {fileNum:fileNum}, function(data){
			$img.remove();
		}, "json");
	});
});
</c:if>

$(function() {
	var img = "${dto.castFileName}";
	if( img ) { // 수정인 경우
		img = "${pageContext.request.contextPath}/uploads/performance/" + img;
		$(".write-form .cast-img").empty();
		$(".write-form .cast-img").css("background-image", "url("+img+")");
	}
	
	$(".write-form .cast-img").click(function(){
		$("form[name=performanceForm] input[name=castImage]").trigger("click"); 
	});
	
	$("form[name=performanceForm] input[name=castImage]").change(function(){
		var file=this.files[0];
		if(! file) {
			$(".write-form .cast-img").empty();
			if( img ) {
				img = "${pageContext.request.contextPath}/uploads/performance/" + img;
				$(".write-form .cast-img").css("background-image", "url("+img+")");
			} else {
				img = "${pageContext.request.contextPath}/resources/images1/add_photo.png";
				$(".write-form .cast-img").css("background-image", "url("+img+")");
			}
			return false;
		}
		
		if(! file.type.match("image.*")) {
			this.focus();
			return false;
		}
		
		var reader = new FileReader();
		reader.onload = function(e) {
			$(".write-form .cast-img").empty();
			$(".write-form .cast-img").css("background-image", "url("+e.target.result+")");
		}
		reader.readAsDataURL(file);
	});
});

$(function() {
	var postImg = "${dto.postFileName}";
	if( postImg ) {
		postImg = "${pageContext.request.contextPath}/uploads/performance/" + postImg;
		$(".write-form .post-img").empty();
		$(".write-form .post-img").css("background-image", "url("+postImg+")");
	}
	
	$(".write-form .post-img").click(function(){
		$("form[name=performanceForm] input[name=selectFile]").trigger("click"); 
	});
	
	$("form[name=performanceForm] input[name=selectFile]").change(function(){
		var postFile=this.files[0];
		if(! postFile) {
			$(".write-form .post-img").empty();
			if( postImg ) {
				postImg = "${pageContext.request.contextPath}/uploads/performance/" + postImg;
				$(".write-form .post-img").css("background-image", "url("+postImg+")");
			} else {
				postImg = "${pageContext.request.contextPath}/resources/images1/add_photo.png";
				$(".write-form .post-img").css("background-image", "url("+postImg+")");
			}
			return false;
		}
		
		if(! postFile.type.match("image.*")) {
			this.focus();
			return false;
		}
		
		var reader = new FileReader();
		reader.onload = function(e) {
			$(".write-form .post-img").empty();
			$(".write-form .post-img").css("background-image", "url("+e.target.result+")");
		}
		reader.readAsDataURL(postFile);
	});
});

$(function(){
	$(".scheduleRemoveBtn").hide();
	
	$(".scheduleAddBtn").click(function(){
		$(".scheduleRemoveBtn").show();
		
		var p=$(this).parent().parent().find(".row:first").clone();
		$(p).find("input").each(function(){
			$(this).val("");
		});
		$(this).parent().parent().find(".schedule").append(p);
	});
	
	$("body").on("click", ".scheduleRemoveBtn", function(){
		if($(this).closest(".schedule").find(".row").length<=1) {
			return;
		}
		
		$(this).closest(".row").remove();
		
		if($(".scheduleRemoveBtn").closest(".row").length<=1) {
            $(".scheduleRemoveBtn").hide();
        }
	});
});

$(function(){
	$(".castRemoveBtn").hide();
	
	$(".castAddBtn").click(function(){
		$(".castRemoveBtn").show();
		
		var p=$(this).parent().parent().find("p:first").clone();
		$(p).find("input").each(function(){
			$(this).val("");
		});
		
		$(p).find("input")
		
		$(this).parent().parent().find(".cast").append(p);
	});
	
	$("body").on("click", ".castRemoveBtn", function(){
		if($(this).closest(".cast").find("p").length<=1) {
			return;
		}
		
		$(this).closest("p").remove();
		
		if($(".castRemoveBtn").closest("p").length<=1) {
            $(".castRemoveBtn").hide();
        }
	});
});
</script>

<div class="container">
	<div class="body-container">	
		<div class="body-title">
			<h3> 공연 등록 </h3>
		</div>
		
		<div class="body-main">
			<form name="performanceForm" method="post" enctype="multipart/form-data">
				<table class="table write-form mt-5">
					<tr>
						<td class="table-light col-sm-2" scope="row">카테고리</td>
						<td>
							<div class="row">
								<div class="col-sm-4 pe-1">
									<select name="categoryNum" class="form-select">
										<option value="">:: 카테고리 선택 ::</option>
										<c:forEach var="vo" items="${groupList}">
											<option value="${vo.categoryNum}" ${dto.categoryNum==vo.genreNum?"selected='selected'":""}>${vo.category}</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-sm-4 ps-1">
									<select name="genreNum" class="form-select">
										<option value="">:: 장르 선택 ::</option>
									</select>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td class="table-light col-sm-2" scope="row">공연제목</td>
						<td>
							<input type="text" name="subject" class="form-control" value="${dto.subject}">
						</td>
					</tr>
					
					<tr>
						<td class="table-light col-sm-2" scope="row">공연기간</td>
						<td>
							<input type="date" name="perfDate" id="form-perfTime" class="boxTF" style="width: 35%;" value="${dto.startDate}"> ~ 
							<input type="date" name="perfTime" id="form-perfTime" class="boxTF" style="width: 35%;" value="${dto.endDate}">
							<input type="number" name="showtime" id="showtime" class="boxTF" style="width: 15%;" placeholder="관람시간" value="${dto.time}">
						</td>
					</tr>
				</table>
				
				<table class="table write-form mt-5">
					<tr>
						<td class="table-light col-2" scope="row">공연일정</td>
						<td class="schedule">
							<div class="row" style="margin-bottom: 10px; padding-top: 4px;">
								<div class="col-5 pe-0">
									<input type="date" name="perfDate" id="form-perfDate" class="form-control" value="${dto.perfDate}">
								</div>
								<div class="col-4">
									<input type="time" name="perfTime" id="form-perfTime" class="form-control" value="${dto.perfTime}">
								</div>
								<div class="col-3">
									<span class="scheduleRemoveBtn" style="float: center; line-height: 38px;"><i class="far fa-minus-square"></i></span>
								</div>
							</div>
						</td>
						<td>
                           	<button type="button" class="boxTF btn scheduleAddBtn" style="text-align: center;">추가</button>
						</td>
					</tr>
				</table>
				
				<table class="table write-form mt-5">
					<tr>
						<td class="table-light col-sm-2" scope="row">출연진 정보</td>
						<td class="cast" style="width: 70%;">
							<p style="margin: 12px;">
								<input type="text" name="castName" class="boxTF" style="width: 25%;" placeholder="출연진 이름" value="${dto.castName}">
								<input type="text" name="roleName" class="boxTF" style="width: 25%;" placeholder="배역 이름" value="${dto.roleName}">
								<img class="cast-img">
								<input type="file" name="castImage" accept="image/*" style="display: none;" class="form-control">
								
								<span class="castRemoveBtn" style="float: center; line-height: 38px; margin-left: 15px;"><i class="far fa-minus-square"></i></span>
							</p>
						</td>
						
						<td>
							<button type="button" class="boxTF btn castAddBtn" style="text-align: center;">추가</button>
						</td>
					</tr>
					
				</table>
				<table class="table write-form mt-5">
					<tr>
						<td class="table-light col-sm-2" scope="row">내 용</td>
						<td>
							<textarea name="content" id="content" class="form-control">${dto.content}</textarea>
						</td>
					</tr>
					
					<tr>
						<td class="table-light col-sm-2" scope="row">포스터</td>
						<td>
							<div class="post-img"></div>
							<input type="file" name="selectFile" accept="image/*" style="display: none;" class="form-control">
						</td>
					</tr>
				</table>
				
				<table class="table table-borderless">
 					<tr>
						<td class="text-center">
							<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
							<button type="reset" class="btn btn-light">다시입력</button>
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/performance/list';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
							<c:if test="${mode=='update'}">
								<input type="hidden" name="perfNum" value="${dto.perfNum}">
								<input type="hidden" name="postFileName" value="${dto.postFileName}">
								<input type="hidden" name="castFileName" value="${dto.castFileName}">
								<input type="hidden" name="page" value="${page}">
							</c:if>
						</td>
					</tr>
				</table>
			</form>
		
		</div>
	</div>
</div>