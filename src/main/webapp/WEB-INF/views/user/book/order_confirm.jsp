<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/user/order_confirm.css' />" rel="stylesheet" type="text/css">
</head>
<body>
<jsp:include page="../../common/commonjq.jsp" />
	<jsp:include page="../../include/header.jsp" />
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		<div class="myhanbit_wrap" style="max-width:1200px; margin:50px auto">
		
		<div class="table_area">
			<table class="tbl_type_list" border="1" cellspacing="0" summary="전체목록 리스트 테이블">
				<caption>전체목록 리스트</caption>
				<colgroup>
				<col width="160px">
				<col width="180px">
				<col width="">
				<col width="130px">
				<col width="160px">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">주문번호</th>
						<th scope="col">주문일자</th>
						<th scope="col">상품명</th>
						<th scope="col">주문금액</th>
						<th scope="col">주문상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${orderVos}">	
						<tr>
							<td>
							  <c:url value='/book/user/orderDetail' var='detail_url'>
									<c:param name='order_no' value='${item.order_no}'/>
							  </c:url>
							  <a href="${detail_url}">${item.order_no }</a>
							</td>
							<td>${item.order_date }</td>
							<td class="left">${item.bm_name } 
								<c:if test="${item.cnt > 1 }">
									<span>외 ${item.cnt-1}권</span>
								</c:if>
							</td>
							<td class="right">${item.total_price }</td>
							<td><span class="ord_state">${item.order_status}</span></td>
						</tr>
					</c:forEach>	
                </tbody>
			</table>
			
			<!-- 페이징 -->
			<div class="paginate bdr_no">
							</div>
			<!-- //페이징 -->
						
		</div>
		
		
	</div>
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
</body>
</html>