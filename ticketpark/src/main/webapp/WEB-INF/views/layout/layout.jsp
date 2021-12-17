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
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/bootstrap.min.css" type="text/css">
	
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
<div class="modal fade" id="loginModal" tabindex="-1"
		data-bs-backdrop="static" data-bs-keyboard="false" 
		aria-labelledby="loginModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="loginViewerModalLabel">Login</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
                <div class="p-3">
                    <form name="modelLoginForm" action="" method="post" class="row g-3">
                    	<div class="mt-0">
                    		 <p class="form-control-plaintext">계정으로 로그인 하세요</p>
                    	</div>
                        <div class="mt-0">
                            <input type="text" name="userId" class="form-control" placeholder="아이디">
                        </div>
                        <div>
                            <input type="password" name="userPwd" class="form-control" placeholder="패스워드">
                        </div>
                        <div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="rememberMeModel">
                                <label class="form-check-label" for="rememberMeModel"> 아이디 저장</label>
                            </div>
                        </div>
                        <div>
                            <button type="button" class="btn btn-primary w-100" onclick="sendModelLogin();">Login</button>
                        </div>
                        <div>
                    		 <p class="form-control-plaintext text-center">
                    		 	<a href="${pageContext.request.contextPath}/member/pwdFind" class="text-decoration-none me-2">패스워드를 잊으셨나요 ?</a>
                    		 </p>
                    	</div>
                    </form>
                    <hr class="mt-3">
                    <div>
                        <p class="form-control-plaintext mb-0">
                        	아직 회원이 아니세요 ?
                        	<a href="${pageContext.request.contextPath}/member/member" class="text-decoration-none">회원가입</a>
                        </p>
                    </div>
                </div>
        
			</div>
		</div>
	</div>
</div>

</body>
</html>