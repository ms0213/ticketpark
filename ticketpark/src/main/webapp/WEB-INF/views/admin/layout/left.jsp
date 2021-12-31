<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="container">
	<ul id="gn-menu" class="gn-menu-main">
		<li class="gn-trigger"><a class="gn-icon gn-icon-menu"><span>Menu</span></a>
			<nav class="gn-menu-wrapper">
				<div class="gn-scroller">
					<ul class="gn-menu">
						<li><a class="gn-icon gn-icon-download" href="${pageContext.request.contextPath}/admin/memberManage/list">회원 관리</a></li>
						<li><a class="gn-icon gn-icon-download" href="${pageContext.request.contextPath}/admin/hallManage/list">공연장 관리</a></li>
						<li><a class="gn-icon gn-icon-photoshop" href="${pageContext.request.contextPath}/admin/theaterManage/main">상영관 관리</a></li>
						<li><a class="gn-icon gn-icon-help" href="${pageContext.request.contextPath}/admin/performanceManage/perfList">공연관리</a></li>
						<li><a class="gn-icon gn-icon-article" href="">매출관리</a></li>
						<li><a class="gn-icon gn-icon-pictures" href="${pageContext.request.contextPath}/admin/couponManage/list">쿠폰관리</a></li>
						<li><a class="gn-icon gn-icon-pictures" href="${pageContext.request.contextPath}/admin/contactUs/list">Contact Us</a></li>
					</ul>
				</div>
				<!-- /gn-scroller -->
			</nav></li>
		<li><a href="${pageContext.request.contextPath}/">홈 버튼</a></li>
		
	</ul>
	<header>
		<h1>
			Admin Page
		</h1>
	</header>
</div>
<!-- /container -->
