<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.text-primary {
    color: #23A41A!important;
    font-size:15px;
 
 }
.review-form textarea { width: 100%; height: 80px; resize: none; }
.review-list {width: 80%; margin: 0 auto;}

.review-list tr:nth-child(3n+1) { border: 1px solid #FFFFFF; background: #f8f9fa; }

.review-list .deleteReview, .review-list .notifyReview, .updateReview, .deleteReview { cursor: pointer; }
 
textarea::placeholder{
	opacity: 1;
	color: #333;
	text-align: center;
	line-height: 60px;
}
</style>

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
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
			if(jqXHR.status===403) {
				login();
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패 했습니다.");
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

$(function(){
	listPage(1);
});

function listPage(page) {
	var url = "${pageContext.request.contextPath}/performance/review/list";
	var perfNum="${dto.perfNum}";
	var query = "pageNo=" + page+"&perfNum=62";
	
	var fn = function(data) {
		printReview(data);
	};
	ajaxFun(url, "get", query, "json", fn);
}
function printReview(data) {
	var uid = "${sessionScope.member.userId}";
	var permission = "${sessionScope.member.membership > 50 ? 'true':'false'}";
	
	var dataCount = data.dataCount;
	var pageNo = data.pageNo;
	var total_page = data.total_page;
	
	$(".review-count").attr("data-pageNo", pageNo);
	$(".review-count").attr("data-totalPage", total_page);
	
	$("#listReview").show();
	$(".review-count").html("총 " + dataCount + "개의 후기가 등록되었습니다.");
	
	$(".more-box").hide();
	if(dataCount == 0) {
		$(".review-list-body").empty();
		return;
	}
	
	if(pageNo < total_page) {
		$(".more-box").show();
	}
	
	var out = "";
	for(var idx = 0; idx < data.list.length; idx++) {
		var num = data.list[idx].num;
		var userId = data.list[idx].userId;
		var userName = data.list[idx].userName;
		var userRate = data.list[idx].rate*20;
		var content = data.list[idx].content;
		var reg_date = data.list[idx].reg_date;

		out += "<tr>";
		out += "    <td width='50%' align='left'><i class='bi bi-person-circle text-muted'></i> <span>" + userName + "</span></td>";
		out += "    <td width='50%' align='right'>" + reg_date;
		if(uid === userId || permission === "true") {
			out += "   | <span class='updateReview' data-num='" + num + "'>수정</span>";
			out += "   | <span class='deleteReview' data-num='" + num + "'>삭제</span>";
		}
		out += "    </td>";
		out += "</tr>";
		out += "<tr>";
		out += "    <td valign='top' align='left'>" + content + "</td>"; 
		out += "    <td valign='top' align='right'>"; 
		out += "	<div class='star-ratings mb-3 ml-3' style='float: right;'>";
		out += "	<div class='star-ratings-fill space-x-2 text-lg' style=' width: "+userRate+"% '>";
		out += "	<span><i class='icofont-star'></i></span><span><i class='icofont-star'></i></span><span><i class='icofont-star'></i></span><span><i class='icofont-star'></i></span><span><i class='icofont-star'></i></span></div>";
		out += "	<div class='star-ratings-base space-x-2 text-lg'><span><i class='icofont-star'></i></span><span><i class='icofont-star'></i></span><span><i class='icofont-star'></i></span><span><i class='icofont-star'></i></span><span><i class='icofont-star'></i></span></div></div>";
		out += "    </td>"; 
		out += "</tr>";
		out += "<tr style='display:none;'>";
		out += "	<td colspan='2'><textarea class='form-control'>";
		out +=  content;
		out += "</textarea></td>"
		out += "</tr>";
		
	}
	
	$(".review-list-body").append(out);

}

$(function() {
	$("[type='radio']").change(function() {
		var star = $(this).attr('value');
		console.log(star);
	});
});

$(function(){
	$(".btnSend").click(function(){
		var content = $("#content").val().trim();
		if(! content) {
			$("#content").focus();
			return false;
		}
		
		var url = "${pageContext.request.contextPath}/performance/review/insertReview";
		var query = "content=" + encodeURIComponent(content);
		
		var fn = function(data) {
			$("#content").val("");
			$(".review-list-body").empty();
			listPage(1);
		};
		
		ajaxFun(url, "post", query, "json", fn);
		
	});
});

$(function(){
	$("body").on("click", ".deleteReview", function(){
		var $span = $(this).parent("td").find(".updateReview");
		
		if($(this).text()==="취소") {
			$span.text("수정");
			$(this).text("삭제");
			$(this).closest("tr").next().show();
			$(this).closest("tr").next().next().hide();
			
			return false;
		}
		
		if( ! confirm('후기를 삭제하시겠습니까 ? ')) {
			return false;
		}
		
		var num = $(this).attr("data-num");
		var url = "${pageContext.request.contextPath}/performance/review/deleteReview";
		var query = "num=" + num;
		var fn = function(data) {
			$(".review-list-body").empty();
			listPage(1);
		};
		ajaxFun(url, "post", query, "json", fn);
		
	});
});

//더보기
$(function(){
	$(".more-box .more").click(function(){
		var pageNo = $(".review-count").attr("data-pageNo");
		var total_page = $(".review-count").attr("data-totalPage");
		
		if(pageNo < total_page) {
			pageNo++;
			listPage(pageNo);
		}
	});
});

$(function(){
	$("body").on("click", ".updateReview", function(){
		var num = $(this).attr("data-num");
		var title = $(this).text();
		var $span = $(this).parent("td").find(".deleteReview");
		
		if(title==="수정") {
			$(this).text("저장");
			$span.text("취소");
			$(this).closest("tr").next().show();
			$(this).closest("tr").next().next().show();
		
		} 
		else {
			var content = $(this).closest("tr").next().next().find("textarea").val().trim();
			if(! content) {
				return false;
			}
			
			var url = "${pageContext.request.contextPath}/performance/review/updateReview";
			var query = "num="+num+"&content="+encodeURIComponent(content);

			var fn = function(data) {
				$("#content").val("");
				$(".review-list-body").empty();
				listPage(1);
			};
			
			ajaxFun(url, "post", query, "json", fn);
			
			$(this).text("수정");
			$span.text("삭제");
			$(this).closest("tr").next().show();
			$(this).closest("tr").next().next().hide();			
		}
	});
});

</script>


<style type="text/css">
.user-rating {
    float: left;
    height: 46px;
    padding: 0 10px;
	-webkit-text-fill-color: transparent;
	-webkit-text-stroke-width: 1px;
	-webkit-text-stroke-color: #2b2a29;
}
.user-rating:not(:checked) > input {
    position:absolute;
    top:-9999px;
}
.user-rating:not(:checked) > label {
    float:right;
    width:1em;
    overflow:hidden;
    white-space:nowrap;
    cursor:pointer;
    font-size:30px;
    color:#ccc;
}
.user-rating:not(:checked) > label:before {
	-webkit-text-stroke-width: 1px;
	-webkit-text-stroke-color: #2b2a29;
}
.user-rating > input:checked ~ label {
	-webkit-text-fill-color: gold;
}

</style>

<div class="container">
	<div class="body-container">	
		<div class="body-main">

			<form name="reviewForm" method="post">
				<div class="review-form border border-secondary p-3">
					<div class="p-1">
						<span class="fw-bold"></span>
					</div>
					<div class="p-1">
						<textarea name="content" id="content" class="form-control" placeholder="${empty sessionScope.member ? '로그인 후 등록 가능합니다.':'해당 공연과 무관한 댓글, 악플은 사전통보 없이 삭제될 수 있습니다.'}"></textarea>
					</div>
					<br>
					<div>
						<div style="float: left;">
							  <div class="user-rating">
							      <input type="radio" id="r5" name="rating" value="5" checked="checked"/><label for="r5"><i class='icofont-star'></i></label>
							      <input type="radio" id="r4" name="rating" value="4" /><label for="r4"><i class='icofont-star'></i></label>
							      <input type="radio" id="r3" name="rating" value="3" /><label for="r3"><i class='icofont-star'></i></label>
							      <input type="radio" id="r2" name="rating" value="2" /><label for="r2"><i class='icofont-star'></i></label>
							      <input type="radio" id="r1" name="rating" value="1" /><label for="r1"><i class='icofont-star'></i></label>
							  </div>
						</div>
						<div align="right">
							<button type="button" class="btnSend btn btn-outline-success" ${empty sessionScope.member ? "disabled='disabled'":""}> 등록하기 <i class="bi bi-check2"></i> </button>
						</div>
					</div>
				</div>
			</form>

			<div id="listReview">
				<div class='mt-4 mb-1'>
					<span class='review-count fw-bold text-primary' data-pageNo="1" data-totalPage="1">총 0개의 후기가 등록되었습니다.</span>
				</div>
				
				<table class="review-list table table-borderless">
					<tbody class="review-list-body"></tbody>
				</table>
	
				<div class='more-box mt-2 text-end'>
					<span class="more btn btn-outline-success">&nbsp;더보기&nbsp;<i class="bi bi-chevron-down"></i>&nbsp;</span>
				</div>
			</div>

		</div>
	</div>
</div>