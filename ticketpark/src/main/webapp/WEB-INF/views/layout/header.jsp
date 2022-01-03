<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.frame {
  text-align: center;
}

.custom-btn {
  width: 130px;
  height: 40px;
  color: #fff;
  border-radius: 5px;
  padding: 10px 25px;
  font-family: 'Lato', sans-serif;
  font-weight: 500;
  background: transparent;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  display: inline-block;
   box-shadow:inset 2px 2px 2px 0px rgba(255,255,255,.5),
   7px 7px 20px 0px rgba(0,0,0,.1),
   4px 4px 5px 0px rgba(0,0,0,.1);
  outline: none;
}

.btn-3 {
  background: rgb(0,172,238);
  background: linear-gradient(0deg, rgb(11 121 3) 0%, rgb(60 148 54) 100%);
  width: 130px;
  height: 40px;
  line-height: 42px;
  padding: 0;
  border: none;
  
}
.btn-3 span {
	position: relative;
	display: block;
	width: 100%;
	height: 100%;
}
.btn-3:before,
.btn-3:after {
	position: absolute;
	content: "";
	right: 0;
	top: 0;
	background: rgb(44 139 37);
	transition: all 0.3s ease;
}
.btn-3:before {
	height: 0%;
	width: 2px;
}
.btn-3:after {
	width: 0%;
	height: 2px;
}
.btn-3:hover{
	background: transparent;
	box-shadow: none;
}
.btn-3:hover:before {
	height: 100%;
}
.btn-3:hover:after {
	width: 100%;
}
.btn-3 span:hover{
	color: rgb(44 139 37);
}
.btn-3 span:before,
.btn-3 span:after {
	position: absolute;
	content: "";
	left: 0;
	bottom: 0;
	background: rgb(44 139 37);
	transition: all 0.3s ease;
}
.btn-3 span:before {
	width: 2px;
	height: 0%;
}
.btn-3 span:after {
	width: 0%;
	height: 2px;
}
.btn-3 span:hover:before {
	height: 100%;
}
.btn-3 span:hover:after {
	width: 100%;
}

#contact-body ul{
	list-style: none;
	width:100%;
	margin-bottom:15px;
}
textarea{
	resize : none;
	height: 300px;
	width: 100%;
}
</style>

<script type="text/javascript">
function sendOk(){
	var f = document.contactForm;
	
	f.action = "${pageContext.request.contextPath}/admin/contactUs/write";
	f.submit();
	alert('소중한 의견 감사합니다.👻 \n 빠른 시일내에 피드백을 수용하겠습니다.');	
}
</script>

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
		                            <a href="javascript:dialogLogin();" title="로그인" style="text-decoration: none;"><i class="icofont-login"></i></a>
									
									<a href="${pageContext.request.contextPath}/member/member" style="text-decoration: none;" title="회원가입"><i class="bi bi-person-check-fill"></i></a>
	                        	</c:when>
	                        	<c:otherwise>
	                        		<a href="${pageContext.request.contextPath}/member/logout" style="text-decoration: none;" title="로그아웃"><i class="icofont-logout"></i></a>
	                        		<a href="${pageContext.request.contextPath}/member/mypage" style="text-decoration: none;" title="마이페이지"><i class="icofont-user"></i></a>
	                        		<c:if test="${sessionScope.member.membership>50}">
										<a href="${pageContext.request.contextPath}/admin" title="관리자" style="text-decoration: none;"><i class="icofont-gear"></i></a>
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
                            <a class="navbar-brand" href="${pageContext.request.contextPath}/"> <img src="${pageContext.request.contextPath}/resources/images1/logo3.png" alt="logo"> </a>
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
                                        <a class="nav-link" href="${pageContext.request.contextPath}/rank/rank">랭킹</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="${pageContext.request.contextPath}/schedule/main">공연일정</a>
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
							<div class="frame">
						    	<button class="custom-btn btn-3" type="button" data-toggle="modal" data-target="#exampleModal"><span>Contact Us</span></button>
						    </div>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!-- Header part end-->
    
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Contact Us</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<form name ="contactForm" method="post">
			<div id="contact-body">
				<div>
					<ul style="float: left; ">
						<li class="col-title">Name</li>
						<li class="col-input" >
							<input class="form-control" type="text" style="width: 90%;" name="name" id="name" required="required" placeholder="이름" style="width: 40%;">
						</li>
					</ul>
					<ul style="float: left; ">
						<li class="col-title">Title</li>
						<li class="col-input">
							<input class="form-control" type="text" style="width: 90%;" name="title" id="title" required="required" placeholder="제목" style="width:40%;">
						</li>
					</ul>
				</div>
				<ul style="float: left; ">
					<li class="col-title">Email Address *</li>
					<li class="col-input">
						<input class="form-control" type="email" name="email" id="email" placeholder="id@example.com" style="width:60%;" required="required">
					</li>
				</ul>
				<ul style="float: left; ">
					<li class="col-title">Content</li>
					<li class="col-input">
						<textarea class="form-control" name="content" placeholder="고객님의 소중한 의견을 들려주세요" required="required" style="height: 300px;" ></textarea>
					</li>
				</ul>
			</div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="reset" class="btn btn-secondary">다시쓰기</button>
        <button type="button" class="btn btn-success" onclick="sendOk();">Send</button>
      </div>
    </div>
  </div>
</div>