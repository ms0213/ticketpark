<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

	<tr bgcolor="#fff" align="center">
		<td><img src="${pageContext.request.contextPath}/uploads/performance/${dto.saveFilename}"></td>
	</tr>
	<tr bgcolor="#fff" align="center">
		<td>${dto.hallName}</td>	
	</tr>
	<tr bgcolor="#fff" align="center">
		<td>${dto.name}</td>
	</tr>
	<tr bgcolor="#fff" align="center">
		<td>${dto.location}</td>
	</tr>
	<tr bgcolor="#fff" align="center">
		<td>${dto.subject}</td>
	</tr>
	<tr bgcolor="#fff" align="center">
		<td>3시</td>
	</tr>
	<tr bgcolor="#fff" align="center">
		<td>${dto.seat_num}</td>
	</tr>
