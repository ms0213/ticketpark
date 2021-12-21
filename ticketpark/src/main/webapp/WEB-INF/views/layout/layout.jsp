<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css1/bootstrap.min.css">
    <!-- animate CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css1/animate.css">
    <!-- owl carousel CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css1/owl.carousel.min.css">
    <!-- themify CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css1/themify-icons.css">
    <!-- flaticon CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css1/flaticon.css">
    <!-- fontawesome CSS 
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fontawesome/css/all.min.css">
    -->
    <!-- magnific CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css1/magnific-popup.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css1/gijgo.min.css">
    <!-- niceselect CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css1/nice-select.css">
    <!-- slick CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css1/slick.css">
    <!-- style CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css1/style.css">
    <!-- 아이콘 -->
    <link rel="stylesheet" href="/tp/resources/icons/icon/bootstrap-icons.css" type="text/css">
	<link rel="stylesheet" href="/tp/resources/icons/icofont/icofont.min.css" type="text/css">
    <!-- 우리 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css1/ticketpark.css">
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/core.css" type="text/css">
	
	<!-- jquery plugins here-->
    <script src="${pageContext.request.contextPath}/resources/js1/jquery-1.12.1.min.js"></script>

	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js1/util-jquery.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js1/menu.js"></script>
    
<title>Ticket park</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>
	<header>
	    <tiles:insertAttribute name="header"/>
	</header>
		
	<main>
	    <tiles:insertAttribute name="body"/>
	</main>
	
	<footer>
	    <tiles:insertAttribute name="footer"/>
	</footer>


    <!-- popper js -->
    <script src="${pageContext.request.contextPath}/resources/js1/popper.min.js"></script>
    <!-- bootstrap js -->
    <script src="${pageContext.request.contextPath}/resources/js1/bootstrap.min.js"></script>
    <!-- magnific js -->
    <script src="${pageContext.request.contextPath}/resources/js1/jquery.magnific-popup.js"></script>
    <!-- swiper js -->
    <script src="${pageContext.request.contextPath}/resources/js1/owl.carousel.min.js"></script>
    <!-- masonry js -->
    <script src="${pageContext.request.contextPath}/resources/js1/masonry.pkgd.js"></script>
    <!-- masonry js -->
    <script src="${pageContext.request.contextPath}/resources/js1/jquery.nice-select.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js1/gijgo.min.js"></script>
    <!-- contact js -->
    <script src="${pageContext.request.contextPath}/resources/js1/jquery.ajaxchimp.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js1/jquery.form.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js1/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js1/mail-script.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js1/contact.js"></script>
    <!-- custom js -->
    <script src="${pageContext.request.contextPath}/resources/js1/custom.js"></script>

<!-- Login Modal -->
<script type="text/javascript">
	function dialogLogin() {
	    $("form[name=modelLoginForm] input[name=userId]").val("");
	    $("form[name=modelLoginForm] input[name=userPwd]").val("");
	    
		$("#loginModal").modal("show");	
		
	    $("form[name=modelLoginForm] input[name=userId]").focus();
	}

	function sendModelLogin() {
	    var f = document.modelLoginForm;
		var str;
		
		str = f.userId.value;
	    if(!str) {
	        f.userId.focus();
	        return;
	    }
	
	    str = f.userPwd.value;
	    if(!str) {
	        f.userPwd.focus();
	        return;
	    }
	
	    f.action = "${pageContext.request.contextPath}/member/login";
	    f.submit();
	}
</script>
<div id="loginModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title text-center" style="font-family: 나눔고딕, 맑은 고딕, sans-serif;">회원 로그인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			</div>
			<div class="modal-body">
				<form name="modalLoginForm" method="post">
					<div class="form-group">
						<label for="modalUserId">아이디</label>
						<input class="form-control" id="modalUserId" name="userId" type="text" placeholder="아이디">
					</div>
					<div class="form-group">
						<label for="modalUserPwd">패스워드</label>
						<input class="form-control" id="modalUserPwd" name="userPwd" type="password" placeholder="패스워드">
					</div>
			        
					<div class="form-group">
						<button class="btn btn-lg btn-primary btn-block" type="button" onclick="modalSendLogin();">로그인 <i class="bi bi-check2"></i></button>
					</div>
                    
					<div class="text-center">
						<button type="button" class="btn btn-link" onclick="location.href='${pageContext.request.contextPath}/member/member';">회원가입</button>
						<button type="button" class="btn btn-link">아이디찾기</button>
						<button type="button" class="btn btn-link">패스워드찾기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

</body>
</html>