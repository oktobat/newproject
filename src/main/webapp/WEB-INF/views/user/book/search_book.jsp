<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/user/search_book.css' />" rel="stylesheet" type="text/css">

</head>
<body>
<jsp:include page="../../common/commonjq.jsp" />
	<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		
		<div id="section_wrap">
		
			<div class="word">
			
				<h3>BOOK SEARCH RESULTS</h3>
				
			</div>
			
			<div class="book_list">
			
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
								<c:url value='/book/user/bookDetail' var='detail_url'>
									<c:param name='b_no' value='${item.b_no}'/>
								</c:url>
								<a href="${detail_url}">${item.b_name} 
								    <span style="color:red"><i style="color:red" class="fa-solid fa-comment"></i>[${item.rev_b_no_count}]</span> 
								    <span style="color:red"><i style="color:red" class="fa-solid fa-heart"></i>[${item.like_b_no_count}]</span>
								</a>
								</td>
								<td>${item.b_author}</td>
								<td>${item.b_publisher}</td>
								<td>${item.b_publish_year}</td>
								<td>${item.b_isbn}</td>
								<td>${item.b_call_number}</td>
								<td>
								<c:choose>
									<c:when test="${item.b_rental_able eq '0'}"> <c:out value="X" /> </c:when>
									<c:when test="${item.b_rental_able eq '1'}"> <c:out value="O" /> </c:when>
									<c:otherwise> <c:out value="X" /> </c:otherwise>
								</c:choose>
								</td>
							</tr>
						</c:forEach>
						
					</tbody>
					
				</table>
				
			</div>
		
		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />

</body>
</html>