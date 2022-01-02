<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<style type="text/css">
.gn-menu li svg{margin: 0 30px 0 20px;}
</style>
<div class="container">
	<ul id="gn-menu" class="gn-menu-main">
		<li class="gn-trigger"><a class="gn-icon gn-icon-menu"><span>Menu</span></a>
			<nav class="gn-menu-wrapper">
				<div class="gn-scroller">
					<ul class="gn-menu">
						<li><a href="${pageContext.request.contextPath}/admin/memberManage/list"><i class="fas fa-user-alt"></i>회원 관리</a></li>
						<li><a href="${pageContext.request.contextPath}/admin/hallManage/list"><i class="fas fa-map-marker-alt"></i>공연장 관리</a></li>
						<li><a href="${pageContext.request.contextPath}/admin/theaterManage/main"><i class="fas fa-map-marker-alt"></i>상영관 관리</a></li>
						<li><a href="${pageContext.request.contextPath}/admin/performanceManage/perfList"><i class="fas fa-video"></i>공연관리</a></li>
						<li><a href="${pageContext.request.contextPath}/admin/saleManage/main"><i class="fas fa-coins"></i>매출관리</a></li>
						<li><a href="${pageContext.request.contextPath}/admin/couponManage/list"><i class="fas fa-ticket-alt"></i>쿠폰관리</a></li>
						<li><a href="${pageContext.request.contextPath}/admin/contactUs/list"><i class="fas fa-envelope"></i>Contact Us</a></li>
					</ul>
				</div>
				<!-- /gn-scroller -->
			</nav></li>
		<li><a href="${pageContext.request.contextPath}/"><i class="fas fa-home" style="font-size: 15px;"></i></a></li>
		
	</ul>
	<header>
		<h1>
			Admin Page
		</h1>
	</header>
</div>
<!-- /container -->
