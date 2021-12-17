<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Menu</title>
<meta name="description"
	content="A sidebar menu as seen on the Google Nexus 7 website" />
<meta name="keywords"
	content="google nexus 7 menu, css transitions, sidebar, side menu, slide out menu" />
<meta name="author" content="Codrops" />

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css2/normalize.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css2/demo.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css2/component.css" />
<script src="${pageContext.request.contextPath}/resources/js2/modernizr.custom.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/jquery-ui.min.css" type="text/css">

	
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/main2.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/forms.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/paginate.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css2/ui-css.css" type="text/css">


<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js2/jquery.min.js"></script>
	
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js2/util-jquery.js"></script>
</head>
<body>
	<header>
	    <tiles:insertAttribute name="left"/>
	</header>
		
	<main>
	    <tiles:insertAttribute name="body"/>
	</main>
	
<div id="loadingLayout" style="display:none; position: absolute; left: 0; top:0; width: 100%; height: 100%; z-index: 9000; background: #eee;">
	<div class="loader"></div>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js2/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js2/jquery.ui.datepicker-ko.js"></script>	

<script src="${pageContext.request.contextPath}/resources/js2/classie.js"></script>
<script src="${pageContext.request.contextPath}/resources/js2/gnmenu.js"></script>
<script>
	new gnMenu(document.getElementById('gn-menu'));
</script>
</body>
</html>