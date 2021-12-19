<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

 <!--::header part start::-->
   <header class="main_menu">
        <div class="sub_menu">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-sm-12 col-md-6">
                        
                        <div class="sub_menu_social_icon" style="float: left;">
							
							<a href="#"><i class="flaticon-facebook"></i></a>
                            <a href="#"><i class="flaticon-twitter"></i></a>
                            <a href="#"><i class="flaticon-skype"></i></a>
                            <a href="#"><i class="flaticon-instagram"></i></a>
                            <span><a><i class="flaticon-phone-call"></i>+82 4752 8700</a></span>
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-12 col-md-6">
                        <div class="sub_menu_right_content" style="float: right;">
                        	<c:choose>
	                        	<c:when test="${empty sessionScope.member}">
		                            <a href="javascript:dialogLogin();" title="로그인" style="text-decoration: none;"><i class="bi bi-door-open-fill"></i></a>
									
									<a href="${pageContext.request.contextPath}/member/member" style="text-decoration: none;" title="회원가입"><i class="bi bi-person-check-fill"></i></a>
	                        	</c:when>
	                        	<c:otherwise>
	                        		<a href="${pageContext.request.contextPath}/member/logout" style="text-decoration: none;" title="로그아웃"><i class="bi bi-door-closed-fill"></i></a>
	                        		<a href="${pageContext.request.contextPath}/member/mypage" style="text-decoration: none;" title="마이페이지"><i class="bi bi-person-lines-fill"></i></a>
	                        		<c:if test="${sessionScope.member.membership>50}">
										<a href="${pageContext.request.contextPath}/admin" title="관리자" style="text-decoration: none;"><i class="bi bi-bar-chart-line-fill"></i></a>
									</c:if>
	                        	</c:otherwise>
                        	</c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="main_menu_iner">
            <div class="container">
                <div class="row align-items-center ">
                    <div class="col-lg-12">
                        <nav class="navbar navbar-expand-lg navbar-light justify-content-between">
                            <a class="navbar-brand" href="${pageContext.request.contextPath}/"> <img src="${pageContext.request.contextPath}/resources/images1/logo.png" alt="logo"> </a>
                            <button class="navbar-toggler" type="button" data-toggle="collapse"
                                data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                                aria-expanded="false" aria-label="Toggle navigation">
                                <span class="navbar-toggler-icon"></span>
                            </button>

                            <div class="collapse navbar-collapse main-menu-item justify-content-center"
                                id="navbarSupportedContent">
                                <ul class="navbar-nav">
                                    <li class="nav-item dropdown">
                                        <a class="nav-link dropdown-toggle" href="" id="navbarDropdown"
                                            role="button" data-toggle="dropdown" aria-haspopup="true"
                                            aria-expanded="false">
                                            	카테고리
                                        </a>
                                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                        	<a class="dropdown-item" href="${pageContext.request.contextPath}/performance/list?category=all">전체</a>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/performance/list?category=musical">뮤지컬</a>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/performance/list?category=drama">연극</a>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/performance/list?category=concert">콘서트</a>
                                        </div>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="${pageContext.request.contextPath}/article/list">문화칼럼</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="${pageContext.request.contextPath}/video/list">영상클립</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="${pageContext.request.contextPath}/hall/list">공연장 정보</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="">랭킹</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="pageContext.request.contextPath}/schedule/main">공연일정</a>
                                    </li>
                                    <li class="nav-item dropdown">
                                        <a class="nav-link dropdown-toggle" href="" id="navbarDropdown"
                                            role="button" data-toggle="dropdown" aria-haspopup="true"
                                            aria-expanded="false">
                                            	고객센터
                                        </a>
                                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/faq/main">FAQ</a>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/event/list">이벤트</a>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/notice/main">공지사항</a>
                                            <a class="dropdown-item" href="">이용안내</a>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!-- Header part end-->