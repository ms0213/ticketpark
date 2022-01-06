<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/boot-board.css" type="text/css">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css1/bootstrap.min.css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/vendor/ckeditor5/ckeditor.js"></script>

<style type="text/css">
.selectField {
    border: 1px solid #999;
    padding: 4px 5px;
    border-radius: 4px;
    font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
    vertical-align: baseline;
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

.scheduleRemoveBtn, .actorRemoveBtn {
    cursor: pointer;
    width: 38px;
    text-align: center;
}

.actor-img, .post-img {
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
	
    str = f.categoryNum.value.trim();
    if(!str) {
        alert("카테고리를 입력하세요. ");
        f.categoryNum.focus();
        return;
    }
    
    str = f.genreNum.value.trim();
    if(!str) {
        alert("장르를 입력하세요. ");
        f.genre.focus();
        return;
    }
    
    str = f.rating.value.trim();
    if(!str) {
        alert("평점을 입력하세요. ");
        f.rating.focus();
        return;
    }
    if(str > 5 || str < 0) {
    	alert("평점은 0~5 사이로 입력해주세요 ");
    	f.rating.focus();
    	return;
    }
    
    str = f.subject.value.trim();
    if(!str) {
        alert("공연이름을 입력하세요. ");
        f.subject.focus();
        return;
    }
    
    str = f.startDate.value.trim();
    if(!str) {
        alert("공연시작날짜를 입력하세요. ");
        f.startDate.focus();
        return;
    }
    
    str = f.endDate.value.trim();
    if(!str) {
        alert("공연종료날짜를 입력하세요. ");
        f.endDate.focus();
        return;
    }
    
    if(f.startDate.value.trim() > f.endDate.value.trim()) {
    	alert("공연날짜를 정확히 입력하세요. ");
    	f.startDate.focus();
    	return;
    }
    
    str = f.showTime.value.trim();
    if(!str) {
        alert("공연관람시간을 입력하세요. ");
        f.showTime.focus();
        return;
    }
    
    str = f.rateNum.value.trim();
    if(!str) {
        alert("관람연령을 선택하세요. ");
        f.rateNum.focus();
        return;
    }
    
    str = f.rating.value.trim();
    if(!str) {
        alert("평점을 입력하세요. ");
        f.rating.focus();
        return;
    }
    
    str = f.price.value.trim();
    if(!str) {
        alert("가격을 입력하세요. ");
        f.price.focus();
        return;
    }
    
    <c:if test="${mode=='perfAdd'}">
	var b = true;
    $("input[name=actorsName]").each(function(index) {
    	if(! $(this).val()) {
			b = false;
    	}
    	if(! b) return false;
    	
    	if(! $("input[name=rolesName]").eq(index).val()) {
    		b = false;
    	}
    	if(! b) return false;
    	
    	if(! $("input[name=actorsFile]").eq(index).val()) {
    		b = false;
    	}
    	if(! b) return false;
    });
	
	if(! b) {
		alert("출연진정보를 정확히 입력 하세요");
		return;
	}
    </c:if>
    str = window.editor.getData().trim();
    if(! str) {
        alert("내용을 입력하세요. ");
        window.editor.focus();
        return;
    }
	f.content.value = str;
    
    var mode = "${mode}";
    if( (mode === "add") && (!f.postFile.value) ) {
        alert("포스터 파일을 추가 하세요. ");
        f.postFile.focus();
        return;
    }
    
    f.action = "${pageContext.request.contextPath}/admin/performanceManage/${mode}";
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
				location.href="${pageContext.request.contextPath}/member/login";
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
		
		var url="${pageContext.request.contextPath}/admin/performanceManage/genre";
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

$(function(){
	$("form select[name=hallNum]").change(function(){
		var hallNum = $(this).val();
		$("form select[name=theaterNum]").find('option').remove().end()
				.append("<option value=''>:: 상영관 선택 ::</option>");
		
		if(! hallNum) {
			return false;
		}
		
		var url="${pageContext.request.contextPath}/admin/performanceManage/theater";
		var query="hallNum=" + hallNum;
		
		var fn=function(data) {
			$.each(data.theaterList, function(index, item){
				var theaterNum = item.theaterNum;
				var theater = item.theater;
				var s = "<option value='"+theaterNum+"'>"+theater+"</option>";
				$("form select[name=theaterNum]").append(s);
			});
		};
		ajaxFun(url, "get", query, "json", fn);
	});
});

$(function() {
	var actorImg = "${dto.actorFileName}";
	
	if( actorImg ) {
		actorImg = "${pageContext.request.contextPath}/uploads/performance/" + actorImg;
		$(".write-form .actor-img").empty();
		$(".write-form .actor-img").css("background-image", "url("+actorImg+")");
	}
	
	$("body").on("click", ".write-form .actor-img", function(actor){
		$(this).next("input[name=actorsFile]").trigger("click"); 
	});
	
	$("body").on("change", "form[name=performanceForm] input[name=actorsFile]", function() {
		var $p = $(this).closest("p");
		var actorFile=this.files[0];
		if(! actorFile) {
			$p.find(".actor-img").empty();
			if( actorImg ) {
				actorImg = "${pageContext.request.contextPath}/uploads/performance/" + actorImg;
				$p.find(".actor-img").css("background-image", "url("+actorImg+")");
			} else {
				actorImg = "${pageContext.request.contextPath}/resources/images1/add_photo.png";
				$p.find(".actor-img").css("background-image", "url("+actorImg+")");
			}
			return false;
		}
		
		if(! actorFile.type.match("image.*")) {
			this.focus();
			return false;
		}
		
		var reader = new FileReader();
		reader.onload = function(e) {
			$p.find(".actor-img").empty();
			$p.find(".actor-img").css("background-image", "url("+e.target.result+")");
		}
		reader.readAsDataURL(actorFile);
	});
});

$(function(){
	$(".actorRemoveBtn").hide();
	
	if($(".actorRemoveBtn").closest("p").length > 1) {
        $(".actorRemoveBtn").show();
    }
	
	$(".actorAddBtn").click(function(){
		
		$(".actorRemoveBtn").show();
		
		var p=$(this).parent().parent().find("p:first").clone();
		$(p).find("input").each(function(){
			$(this).val("");
			$(this).attr("disabled", false);
			$(p).find(".actor-img").css("background-image", "url(/tp/resources/images1/add_photo.png)");
		});
		
		$(this).parent().parent().find(".actor").append(p);
	});
	
	$("body").on("click", ".actorRemoveBtn", function(){
		var $p = $(this).closest("p");
		
		if($(this).closest(".actor").find("p").length<=1) {
			return;
		}
		
		$p.remove();
		
		if($(".actorRemoveBtn").closest("p").length<=1) {
            $(".actorRemoveBtn").hide();
        }
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
		$("form[name=performanceForm] input[name=postFile]").trigger("click"); 
	});
	
	$("form[name=performanceForm] input[name=postFile]").change(function(){
		var postFile=this.files[0];
		if(! postFile) {
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

<c:if test="${mode=='update'}">
$(function(){
	$(".actorRemoveBtn").click(function(){
		if(! confirm("출연진을 삭제 하시겠습니까 ?")) {
			return false;
		}
		var $actor = $(this);
		var actorNum = $actor.attr("data-actorNum");
		var url="${pageContext.request.contextPath}/admin/performanceManage/deleteActor";
		$.post(url, {actorNum:actorNum}, function(data){
			$actor.remove();
		}, "json");
	});
});
</c:if>
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
								<div class="col-sm-3 pe-1">
									<select name="categoryNum" class="selectField">
										<option value="">:: 카테고리 선택 ::</option>
										<c:forEach var="vo" items="${categoryList}">
											<option value="${vo.categoryNum}" ${dto.categoryNum==vo.categoryNum? "selected='selected'":""}>${vo.category}</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-sm-3 ps-1">
									<select name="genreNum" class="selectField">
										<option value="">:: 장르 선택 ::</option>
										<c:forEach var="vo" items="${genreList}">
											<option value="${vo.genreNum}" ${dto.genreNum==vo.genreNum? "selected='selected'":""}>${vo.genre}</option>
										</c:forEach>
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
							<input type="date" name="startDate" id="startDate" class="boxTF" style="width: 35%;" value="${dto.startDate}"> ~ 
							<input type="date" name="endDate" id="endDate" class="boxTF" style="width: 35%;" value="${dto.endDate}">
							<input type="number" name="showTime" id="showTime" class="boxTF" style="width: 15%;" placeholder="관람시간" value="${dto.showTime}">
						</td>
					</tr>
					
					<tr>
						<td class="table-light col-sm-2" scope="row">공연정보</td>
						<td>
							<div class="row">
								<div class="col-sm-3 pe-1">
									<select name="rateNum" class="selectField">
										<option value="">:: 관람연령 선택 ::</option>
										<c:forEach var="vo" items="${rateList}">
											<option value="${vo.rateNum}" ${dto.rateNum==vo.rateNum? "selected='selected'":""}>${vo.rate}</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-sm-4 ps-1">
									<input type="number" name="price" id="price" class="boxTF" placeholder="가격" value="${dto.price}">
								</div>
								<div class="col-sm-4 ps-1">
									<input type="number" name="rating" id="rating" class="boxTF" placeholder="평점" value="${dto.rating}">
								</div>
							</div>
						</td>
					</tr>
				</table>
				<table class="table write-form mt-5">
					<tr>
						<td class="table-light col-sm-2" scope="row">출연진 정보</td>
						<td class="actor" style="width: 70%;">
							<c:choose>
								<c:when test="${mode == 'perfAdd'}">
									<p style="margin: 12px;">
										<input type="text" value="${dto.actorNum}" name="actorsName" class="boxTF" style="width: 25%;" placeholder="출연진 이름" value="${vo.actorName}">
										<input type="text" name="rolesName" class="boxTF" style="width: 25%;" placeholder="배역 이름" value="${vo.roleName}">
										<img class="actor-img">
										<input type="file" name="actorsFile" accept="image/*" style="display: none;" class="form-control">
										
										<span class="actorRemoveBtn" style="float: center; line-height: 38px; margin-left: 15px;"><i class="far fa-minus-square"></i></span>
									</p>
								</c:when>
								<c:when test="${mode == 'update'}">
									<c:forEach var="vo" items="${actorList}">
										<p style="margin: 12px;">
											<input type="text" name="actorsName" class="boxTF" style="width: 25%;" placeholder="출연진 이름" 
												value="${vo.actorName}" disabled="disabled">
											<input type="text" name="rolesName" class="boxTF" style="width: 25%;" placeholder="배역 이름" value="${vo.roleName}"disabled="disabled">
											
											<img class="actor-img" style="background-image: url('${pageContext.request.contextPath}/uploads/performance/${vo.actorFileName}');">
											<input type="file" name="actorsFile" accept="image/*" style="display: none;" class="form-control" disabled="disabled">
											<span class="actorRemoveBtn" data-actorNum="${vo.actorNum}" style="float: center; line-height: 38px; margin-left: 15px;"><i class="far fa-minus-square"></i></span>
										</p>
									</c:forEach>
								</c:when>
							</c:choose>
						</td>
						
						<td>
							<button type="button" class="boxTF btn actorAddBtn" style="text-align: center;">추가</button>
						</td>
					</tr>
				</table>
				
				<table class="table write-form mt-5">
					<tr>
						<td class="table-light col-sm-2" scope="row">내 용</td>
						<td>
							<div class="editor">${dto.content}</div>
							<input type="hidden" name="content">
						</td>
					</tr>
					
					<tr>
						<td class="table-light col-sm-2" scope="row">포스터</td>
						<td>
							<div class="post-img"></div>
							<input type="file" name="postFile" accept="image/*" style="display: none;" class="form-control">
						</td>
					</tr>
				</table>
				
				<table class="table table-borderless">
 					<tr>
						<td class="text-center">
							<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
							<button type="reset" class="btn btn-light">다시입력</button>
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/admin/performanceManage/perfList?page=${page}';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
							<c:if test="${mode=='update'}">
								<input type="hidden" name="perfNum" value="${dto.perfNum}">
								<input type="hidden" name="postNum" value="${dto.postNum}">
								<input type="hidden" name="postFileName" value="${dto.postFileName}">
								<input type="hidden" name="actorFileName" value="${dto.actorFileName}">
							</c:if>
						</td>
					</tr>
				</table>
			</form>
		
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