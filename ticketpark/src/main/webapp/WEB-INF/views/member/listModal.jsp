<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <tr>
   		<td>Poster</td>
		<td><img src="${pageContext.request.contextPath}/uploads/performance/${dto.saveFilename}"></td>
	</tr>
	<tr>
		<td>공연장 이름</td>			
		<td>${dto.name}</td>
	</tr>
	<tr>
		<td>상영관 이름</td>
		<td>${dto.hallName}</td>	
	</tr>
	<tr>
		<td>상영관 위치</td>
		<td>${dto.location}</td>
	</tr>
	<tr>
		<td>공연 이름</td>
		<td>${dto.subject}</td>
	</tr>
	<tr>
		<td>공연 시간</td>
		<td>3시</td>
	</tr>
	<tr>
		<td>예약 좌석</td>
		<td>${dto.seat_num}</td>
	</tr>
