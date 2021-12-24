<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-main {
	max-width: 800px;
}
</style>

<script type="text/javascript">	
<c:if test="${mode=='update'}">
$(function(){
	$(".delete-img").click(function(){
		if(! confirm("이미지를 삭제 하시겠습니까 ?")) {
			return false;
		}
		var $img = $(this);
		var fileNum = $img.attr("data-fileNum");
		var url="${pageContext.request.contextPath}/article/deleteFile";
		$.post(url, {fileNum:fileNum}, function(data){
			$img.remove();
		}, "json");
	});
});
</c:if>

function changeType() {
    var f = document.boardForm;
	    
    var str = f.selectType.value;
        f.atNum.value = str;  
}
    
    function sendOk() {
        var f = document.boardForm;
       
        var str = f.subject.value;
        if(!str) {
            alert("제목을 입력하세요. ");
            f.subject.focus();
            return;
        }

    	str = f.content.value;
        if(!str) {
            alert("내용을 입력하세요. ");
            f.content.focus();
            return;
        }
        
        str = f.selectType.value;
 		if(!str ) {
 			alert("글 유형을 선택하세요");
 			f.selectType.focus();
 			return;
 		}
        
    	f.action="${pageContext.request.contextPath}/article/${mode}";

        f.submit();
    }
    
    $(function(){
    	var sel_files = [];
    	
    	$("body").on("click", ".table-form .img-add", function(event){
    		$("form[name=boardForm] input[name=selectFile]").trigger("click"); 
    	});
    	
    	$("form[name=boardForm] input[name=selectFile]").change(function(){
    		if(! this.files) {
    			var dt = new DataTransfer();
    			for(file of sel_files) {
    				dt.items.add(file);
    			}
    			document.boardForm.selectFile.files = dt.files;
    			
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
    		document.boardForm.selectFile.files = dt.files;		
    	    
    	});
    	
    	$("body").on("click", ".table-form .img-item", function(event) {
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
    		document.boardForm.selectFile.files = dt.files;
    		
    		$(this).remove();
    	});
    });
</script>

<div class="container body-container">
	<div class="body-title">
		<h3> 게시판 </h3>
	</div>
    
	<div class="body-main mx-auto pt-15">
		<form name="boardForm" method="post" enctype="multipart/form-data">
		<input type="hidden" readonly="readonly" name="atNum" value="">
			<table class="table table-border border-top2 table-form">
				<tr> 
					<td>제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
					<td> 
						<input type="text" name="subject" maxlength="100" class="boxTF" value="${dto.subject}" style="min-width: 600px;">
					</td>
				</tr>
				
				<tr> 
					<td>작성자</td>
					<td> 
						<p class="form-control-plaintext">${sessionScope.member.userName}</p>
					</td>
				</tr>
				
				<tr> 
					<td>유&ensp;&ensp; 형</td>
					<td> 
						<select name="selectType" class="form-select" onchange="changeType();">
							<option value="">Category</option>						
							<option value="1">인터뷰</option>
							<option value="2">리뷰</option>
							<option value="3">기획</option>
							<option value="4">기사</option>
						</select>
					</td>
				</tr>
				
				<tr> 
					<td valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
					<td valign="top"> 
						<textarea name="content" class="boxTA" style="min-width: 600px; min-height: 200px;">${dto.content}</textarea>
					</td>
				</tr>
				  
				<tr>
					<td>첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
					<td >
						<div class="img-grid"><img class="item img-add"></div>
						<input type="file" name="selectFile" class="boxTF" accept="image/*" multiple="multiple" >
					</td>
				</tr>
				  
				<c:if test="${mode=='update'}">
					<tr> 
						<td>등록이미지</td>
						<td> 
							<div class="img-box">
								<c:forEach var="vo" items="${listFile}">
									<img src="${pageContext.request.contextPath}/uploads/article/${vo.saveFilename}"
										class="delete-img"
										data-fileNum="${vo.fileNum}">
								</c:forEach>
							</div>
						</td>
					</tr>
				</c:if>
	
			</table>
				
			<table class="table">
				<tr> 
					<td align="center">
						<button type="button" class="btn btn-outline-secondary fh rhclrh" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
						<button type="reset" class="btn btn-outline-secondary fh rhclrh">다시입력</button>
						<button type="button" class="btn btn-outline-secondary fh rhclrh" onclick="javascript:location.href='${pageContext.request.contextPath}/article/list';">${mode=='update'?'수정취소':'등록취소'}</button>
						<c:if test="${mode=='update'}">
							<input type="hidden" name="num" value="${dto.artiNum}">
							<input type="hidden" name="saveFilename" value="${dto.saveFilename}">
							<input type="hidden" name="page" value="${page}">
						</c:if>
					</td>
				</tr>
			</table>
		</form>
	</div>
    
</div>