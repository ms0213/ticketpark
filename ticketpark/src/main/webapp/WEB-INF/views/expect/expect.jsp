<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">

.body-main {
	max-width: 1000px;
	margin: 0 auto;
}

.text-primary {
    color: #3E9D37!important;
 }
 
.expect-form textarea { width: 100%; height: 75px; resize: none; }

.expect-list tr:nth-child(3n+1) { border: 1px solid #ccc; background: #f8f9fa; }

.expect-list .deleteExpect, .expect-list .notifyExpect, .updateExpect, .deleteExpect { cursor: pointer; }

textarea::placeholder{
	opacity: 1;
	color: #333;
	text-align: center;
	line-height: 60px;
}
</style>

<script type="text/javascript">
function login() {
	location.href="${pageContext.request.contextPath}/member/login";	
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
	var url = "${pageContext.request.contextPath}/expect/list";
	var query = "pageNo=" + page;
	
	var fn = function(data) {
		printExpect(data);
	};
	ajaxFun(url, "get", query, "json", fn);
}

function printExpect(data) {
	var uid = "${sessionScope.member.userId}";
	var permission = "${sessionScope.member.membership > 50 ? 'true':'false'}";
	
	var dataCount = data.dataCount;
	var pageNo = data.pageNo;
	var total_page = data.total_page;
	
	$(".expect-count").attr("data-pageNo", pageNo);
	$(".expect-count").attr("data-totalPage", total_page);
	
	$("#listExpect").show();
	$(".expect-count").html("총 " + dataCount + "개의 기대평이 등록되었습니다.");
	
	$(".more-box").hide();
	if(dataCount == 0) {
		$(".expect-list-body").empty();
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
		var content = data.list[idx].content;
		var reg_date = data.list[idx].reg_date;

		out += "<tr>";
		out += "    <td width='50%'><i class='bi bi-person-circle text-muted'></i> <span>" + userName + "</span></td>";
		out += "    <td width='50%' align='right'>" + reg_date;
		if(uid === userId || permission === "true") {
			out += "   | <span class='updateExpect' data-num='" + num + "'>수정</span>";
			out += "   | <span class='deleteExpect' data-num='" + num + "'>삭제</span>";
		}
		out += "    </td>";
		out += "</tr>";
		out += "<tr>";
		out += "    <td colspan='2' valign='top'>" + content + "</td>"; 
		out += "</tr>";
		out += "<tr style='display:none;'>";
		out += "	<td colspan='2'><textarea class='form-control'>";
		out +=  content;
		out += "</textarea></td>"
		out += "</tr>";
		
	}
	
	$(".expect-list-body").append(out);

}

$(function(){
	$(".btnSend").click(function(){
		var content = $("#content").val().trim();
		if(! content) {
			$("#content").focus();
			return false;
		}
		
		var url = "${pageContext.request.contextPath}/expect/insert";
		var query = "content=" + encodeURIComponent(content);
		
		var fn = function(data) {
			$("#content").val("");
			$(".expect-list-body").empty();
			listPage(1);
		};
		
		ajaxFun(url, "post", query, "json", fn);
		
	});
});

$(function(){
	$("body").on("click", ".deleteExpect", function(){
		var $span = $(this).parent("td").find(".updateExpect");
		
		if($(this).text()==="취소") {
			$span.text("수정");
			$(this).text("삭제");
			$(this).closest("tr").next().show();
			$(this).closest("tr").next().next().hide();
			
			return false;
		}
		
		if( ! confirm('게시글을 삭제 하시겠습니까 ? ')) {
			return false;
		}
		
		var num = $(this).attr("data-num");
		var url = "${pageContext.request.contextPath}/expect/delete";
		var query = "num=" + num;
		var fn = function(data) {
			$(".expect-list-body").empty();
			listPage(1);
		};
		ajaxFun(url, "post", query, "json", fn);
		
	});
});

// 더보기
$(function(){
	$(".more-box .more").click(function(){
		var pageNo = $(".expect-count").attr("data-pageNo");
		var total_page = $(".expect-count").attr("data-totalPage");
		
		if(pageNo < total_page) {
			pageNo++;
			listPage(pageNo);
		}
	});
})

$(function(){
	$("body").on("click", ".updateExpect", function(){
		var num = $(this).attr("data-num");
		var title = $(this).text();
		var $span = $(this).parent("td").find(".deleteExpect");
		
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
			
			var url = "${pageContext.request.contextPath}/expect/update";
			var query = "num="+num+"&content="+encodeURIComponent(content);

			var fn = function(data) {
				$("#content").val("");
				$(".expect-list-body").empty();
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

<div class="container">
	<div class="body-container">	
		<div class="body-title">
			<h3>&nbsp;기대평</h3>
		</div>
		
		<div class="body-main">

			<form name="expectForm" method="post">
				<div class="expect-form border border-secondary mt-5 p-3">
					<div class="p-1">
						<span class="fw-bold">기대평 작성하기</span>
					</div>
					<div class="p-1">
						<textarea name="content" id="content" class="form-control" placeholder="${empty sessionScope.member ? '로그인 후 등록 가능합니다.':'해당 공연과 무관한 댓글, 악플은 사전통보 없이 삭제될 수 있습니다.'}"></textarea>
					</div>
					<div class="p-1 text-end">
						<button type="button" class="btnSend btn btn-outline-secondary" ${empty sessionScope.member ? "disabled='disabled'":""}> 등록하기 <i class="bi bi-check2"></i> </button>
					</div>
				</div>
			</form>

			<div id="listExpect">
				<div class='mt-4 mb-1'>
					<span class='expect-count fw-bold text-primary' data-pageNo="1" data-totalPage="1">총 0개의 기대평이 등록되었습니다.</span>
				</div>
				
				<table class="expect-list table table-borderless">
					<tbody class="expect-list-body"></tbody>
				</table>
	
				<div class='more-box mt-2 text-end'>
					<span class="more btn btn-light">&nbsp;더보기&nbsp;<i class="bi bi-chevron-down"></i>&nbsp;</span>
				</div>
			</div>

		</div>
	</div>
</div>