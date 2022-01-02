<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.board-list-footer { padding-top: 7px; padding-bottom: 7px; }

.btnright {
	float: right;
}

</style>


<script type="text/javascript">
function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data){
			fn(data);
		},
		beforeSend : function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error : function(jqXHR) {
			if (jqXHR.status == 403) {
				location.href="${pageContext.request.contextPath}/admin/couponManage/list";
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패했습니다.");
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}

function detailedCoupon() {
	var dlg = $("#coupon-dialog").dialog({
		  autoOpen: false,
		  modal: true,
		  buttons: {
		       " 닫기 " : function() {
		    	   $(this).dialog("close");
		    		
		    	   location.reload();
		    	
		       }
		  },
		  height: 520,
		  width: 800,
		  title: "쿠폰상세정보",
		  close: function(event, ui) {
		  }
	});

	var url = "${pageContext.request.contextPath}/admin/couponManage/detaile";
	var query = "";
	
	var fn = function(data){
		$('#coupon-dialog').html(data);
		dlg.dialog("open");
	};
	ajaxFun(url, "post", query, "html", fn);
}


$(function() {
	$("body").on("click", ".btnDelete", function() {
		if(! confirm("해당 쿠폰을 삭제하시겠습니까?")){
			return false;
		}
		
		var couponNum = $(this).attr("data-couponNum");
		var url = "${pageContext.request.contextPath}/admin/couponManage/delete";
		var query = "couponNum="+couponNum;
		
		var fn = function(data) {
			var state = data.state;
			if(data.state==="false"){
				alert("삭제에 실패했습니다");
				return false;
			}
			url="${pageContext.request.contextPath}/admin/couponManage/detaile";
			$('#coupon-dialog').load(url);
		};
		ajaxFun(url, "post", query, "json", fn);
		
	});
});

/*
$(function() {
	$("body").on("click", ".btnModal", function() {
		$("#couponModal").modal("show");
		
		var url="${pageContext.request.contextPath}/admin/couponManage/listModal";
		
		var query = "tmp="+new Date().getTime();
		var fn = function(data){
			$(".modal-list").html(data);
		};
		ajaxFun(url, "get", null, "html", fn)
	});
	
	var myModalEl = document.getElementById('couponModal');
	
	$('#couponModal').on('hidden.bs.modal', function (e) {
		location.reload();
	});
});
*/
</script>

<div class="container">
	<div class="body-container">
		<div class="body-title">
			<h3> 쿠폰 관리 </h3>
		</div>

		<div class="body-main">
			<p>쿠폰 목록</p>

			<div class="container">
				<div class="row">
				 	<table class="table table-border table-list">
					<thead>
						<tr> 
							<th class="w-auto">쿠폰 할인가격</th>
							<th class="w-auto">쿠폰 발급날짜</th>
							<th class="w-auto">쿠폰 만료날짜</th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach var="dto" items="${list}">
						<tr> 
							<td style="text-align: center;">${dto.coupon} 원 할인쿠폰</td>
							<td style="text-align: center;">${dto.startDate}</td>
							<td style="text-align: center;">${dto.endDate}</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
		 		</div>
				
			</div>
			
			<div class="row board-list-footer mt-3 mb-3">
				<div class="col text-left">
					<button type="button" class="btn btn-light btnModal" onclick="detailedCoupon();">관리</button>
					<button type="button" class="btn btn-light btnright" onclick="location.href='${pageContext.request.contextPath}/admin/couponManage/write';" >쿠폰등록</button>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="coupon-dialog" style="display: none;">

</div>
