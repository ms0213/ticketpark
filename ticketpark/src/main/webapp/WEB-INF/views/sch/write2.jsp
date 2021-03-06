<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/boot-board.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js2/dateUtil.js"></script>
<script type="text/javascript">
function sendOk() {
    var f = document.scheduleForm;
	var str;
	
	if( ! f.subject.value.trim() ) {
		f.subject.focus();
		return;
	}
	
	
	if(! f.categoryNum.value ) {
		f.categoryNum.focus();
		return;
	}
	
	
	if( ! f.sday.value ) {
		f.sday.focus();
		return;
	}
	
	if( f.eday.value ) {
		var s1 = f.sday.value.replace(/-/g, "");
		var s2 = f.eday.value.replace(/-/g, "");
		if(s1 > s2) {
			f.sday.focus();
			return;
		}
	}

	if( f.etime.value ) {
		var s1 = f.stime.value.replace(/:/g, "");
		var s2 = f.etime.value.replace(/:/g, "");
		if(s1 > s2) {
			f.stime.focus();
			return;
		}
	}
	
	if( ! f.repeat_cycle.value ) {
		f.repeat_cycle.value = "0";
	}
	
	if( f.repeat.value !=  "0" && ! /^(\d){1,2}$/g.test(f.repeat_cycle.value) ) {
		f.repeat_cycle.focus();
		return;
	}
	
	if( f.repeat.value !=  "0" && f.repeat_cycle.value < 1 ) {
		f.repeat_cycle.focus();
		return;
	}	

	
	if($("#form-eday").val() && $("#form-all_day").is(":checked")) {
		$("#form-eday").val(daysLater($("#form-eday").val(), 2));
	}
	
    f.action = "${pageContext.request.contextPath}/schedule/${mode}";
    f.submit();
}

$(function(){
	$("#form-all_day").click(function(){
		if(this.checked === true) {
			$("#form-stime").val("").hide();
			$("#form-etime").val("").hide();
		} else if(this.checked === false && $("#form-repeat").val() === "0"){
			$("#form-stime").val("00:00").show();
			$("#form-etime").val("00:00").show();
		}
	});

	$("#form-sday").change(function(){
		$("#form-eday").val($("#form-sday").val());
	});
	
	var repeat_cycle = "${dto.repeat_cycle}";
	if(repeat_cycle && repeat_cycle != "0") {
		$("#form-all_day").prop("checked", true);
		$("#form-all_day").prop("disabled", true);

		$("#form-stime").val("").hide();
		$("#form-etime").val("").hide();
		$("#form-eday").val("");
		$("#form-etime").val("");
		$("#form-eday").closest("tr").hide();
	}
	
	$("#form-repeat").change(function(){
		if($(this).val() === "0") {
			$("#form-repeat_cycle").val("0").hide();
			
			$("#form-all_day").prop("checked", true);
			$("#form-all_day").prop("disabled", false);
			
			$("#form-eday").val($("#form-sday").val());
			$("#form-eday").closest("tr").show();
		} else {
			$("#form-repeat_cycle").show();
			
			$("#form-all_day").prop("checked", true);
			$("#form-all_day").prop("disabled", true);

			$("#form-stime").val("").hide();
			$("#form-etime").val("").hide();
			$("#form-eday").val("");
			$("#form-etime").val("");
			$("#form-eday").closest("tr").hide();
		}
	});
});

$(function(){
	$("#form-color").css("background-color", $("#form-color").val());
	$("#form-color").css("color", "#fff");
	$("#form-color").change(function(){
		$(this).css("background-color", $(this).val());
	});
});
</script>

<c:if test="${sessionScope.member.membership>50}">
<div class="container">
	<div class="body-container">	
		<div class="body-title">
			<h3>???????????? </h3>
		</div>
		
		<div class="body-main">
		
			<form name="scheduleForm" method="post">
				<table class="table write-form mt-5">
					<tr>
						<td class="table-light col-2" scope="row">??? ???</td>
						<td>
							<div class="row">
								<div class="col">
									<input type="text" name="subject" id="form-subject" class="form-control" value="${dto.subject}">
								</div>
							</div>
							<small class="form-control-plaintext">* ????????? ?????? ?????????.</small>
						</td>
					</tr>

					<tr>
						<td class="table-light col-2" scope="row">????????????</td>
						<td>
							<div class="row">
								<div class="col-5">
									<select name="categoryNum" id="form-categoryNum" class="form-select">
										<!-- <option value="0">???????????? ??????</option> -->
										<c:forEach var="vo" items="${listCategory}">
											<option value="${vo.categoryNum}" ${dto.categoryNum == vo.categoryNum ? "selected='selected'":""}>${vo.category}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<small class="form-control-plaintext">* ??????????????? ?????? ?????????????????? ???????????????.</small>
						</td>
					</tr>

					<tr>
						<td class="table-light col-2" scope="row">??? ???</td>
						<td>
							<div class="row">
								<div class="col-5">
									<select name="color" id="form-color" class="form-select">
										<option value="blue" style="background:blue;" ${dto.color=="blue"?"selected='selected'":""}>??????</option>
										<option value="green" style="background:green;" ${dto.color=="green"?"selected='selected'":""}>??????</option>
										<option value="red" style="background:red;" ${dto.color=="red"?"selected='selected'":""}>??????</option>
										<option value="orange" style="background:orange;" ${dto.color=="orange"?"selected='selected'":""}>??????</option>
										<option value="tomato" style="background:tomato;" ${dto.color=="chartreuse"?"selected='selected'":""}>?????????</option>
										<option value="magenta" style="background:magenta;" ${dto.color=="cyan"?"selected='selected'":""}>?????????</option>
										<option value="purple" style="background:purple;" ${dto.color=="purple"?"selected='selected'":""}>??????</option>
										<option value="brown" style="background:brown;" ${dto.color=="brown"?"selected='selected'":""}>??????</option>
										<option value="navy" style="background:navy;" ${dto.color=="navy"?"selected='selected'":""}>??????</option>
										<option value="gray" style="background:gray;" ${dto.color=="gray"?"selected='selected'":""}>??????</option>
										<option value="black" style="background:black;" ${dto.color=="black"?"selected='selected'":""}>??????</option>
									</select>
								</div>
							</div>
						</td>
					</tr>

					<tr>
						<td class="table-light col-2" scope="row">????????????</td>
						<td class="py-3">
							<div class="row">
								<div class="col">
									<input type="checkbox" name="all_day" id="form-all_day" class="form-check-input" 
										 value="1" ${dto.all_day == 1 ? "checked='checked' ":"" } >
									<label class="form-check-label" for="form-all_day"> ????????????</label>
								</div>
							</div>
						</td>
					</tr>

 					<tr>
						<td class="table-light col-2" scope="row">????????????</td>
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
							<small class="form-control-plaintext">* ??????????????? ???????????????.</small>
						</td>
					</tr>

 					<tr>
						<td class="table-light col-2" scope="row">????????????</td>
						<td>
							<div class="row">
								<div class="col-5 pe-0">
									<input type="date" name="eday" id="form-eday" class="form-control" value="${dto.eday}">
								</div>
								<div class="col-3">
									<input type="time" name="etime" id="form-etime" class="form-control" value="${dto.etime}"
										style="display: ${dto.all_day==1 ? 'none;':'inline-block;'}">
								</div>
							</div>
							<small class="form-control-plaintext">??????????????? ??????????????????, ?????????????????? ?????? ??? ????????????.</small>
						</td>
					</tr>
					
					
					<tr>
						<td class="table-light col-2" scope="row">????????????</td>
						<td>
							<div class="row">
								<div class="col-5 pe-0">
									<select name="repeat" id="form-repeat" class="form-select">
										<option value="0" ${dto.repeat=="0"?"selected='selected'":""}>????????????</option>
										<option value="1" ${dto.repeat=="1"?"selected='selected'":""}>?????????</option>
									</select>
								</div>
								<div class="col-3">
									<input type="text" name="repeat_cycle" id="form-repeat_cycle" maxlength="2" class="form-control"
										style="display: ${dto.repeat==0 ? 'none;':'inline-block;'}"
										value="${dto.repeat_cycle}"
										placeholder="????????????">
								</div>
							</div>
						</td>
					</tr>
					

					<tr>
						<td class="table-light col-2" scope="row">??? ???</td>
						<td>
							<textarea name="memo" id="form-memo" class="form-control" style="height: 90px;">${dto.memo}</textarea>
						</td>
					</tr>
				</table>
				
				<table class="table table-borderless">
 					<tr>
						<td class="text-center">
							<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='update'?'????????????':'????????????'}&nbsp;<i class="bi bi-check2"></i></button>
							<button type="reset" class="btn btn-light">????????????</button>
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/schedule/main';">${mode=='update'?'????????????':'????????????'}&nbsp;<i class="bi bi-x"></i></button>
							<c:if test="${mode=='update'}">
								<input type="hidden" name="num" value="${dto.num}">
							</c:if>
						</td>
					</tr>
				</table>
			</form>
		
		</div>
	</div>
</div>
</c:if>