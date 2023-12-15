<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<table>
	<thead>
		<tr>
			<th>도서명</th>
			<th>저자</th>
			<th>발행처</th>
			<th>발행연도</th>
			<th>ISBN</th>
			<th>청구기호</th>
			<th>대출가능</th>
		</tr>
	</thead>
	
	<tbody>
		
		<c:forEach var="item" items="${bookVos}">
			<tr>
				<td>
					<c:url value='/book/admin/bookDetail' var='detail_url'>
						<c:param name='b_no' value='${item.b_no}'/>
					</c:url>
					<a href="${detail_url}">${item.b_name}</a>
				</td>
				<td>${item.b_author}</td>
				<td>${item.b_publisher}</td>
				<td>${item.b_publish_year}</td>
				<td>${item.b_isbn}</td>
				<td>${item.b_call_number}</td>
				<td>
					<c:choose>
						<c:when test="${item.b_rental_able eq 0}"> <c:out value="대출중" /> </c:when>
						<c:when test="${item.b_rental_able eq 1}"> <c:out value="대출가능" /> </c:when>
						<c:otherwise> <c:out value="X" /> </c:otherwise>
					</c:choose>
				</td>
			</tr>
		</c:forEach>
		
	</tbody>
</table>