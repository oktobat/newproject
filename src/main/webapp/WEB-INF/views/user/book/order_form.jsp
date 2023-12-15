<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/smoothness/jquery-ui.css">
<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/user/orderForm.css' />" rel="stylesheet" type="text/css">
</head>
<body>

<jsp:include page="../../common/commonjq.jsp" />
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <jsp:include page="../../include/header.jsp" />
	<jsp:include page="../include/nav.jsp" />
	<section>
		<div class="row1200">
			<div class="common_titie">
				<h2>주문/결제</h2>
			</div>
			<div id="orderList">
				<h2>주문 상품 목록</h2>
				<div class="orderFormBox"></div>
			</div>
			
		</div>
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	
	
	<script>
	    let bmNos = "${bmNos}";
	    console.log(bmNos);
		jQ.ajax({
			type :"POST",
			contentType : "application/json; charset=UTF-8",
			url : "${pageContext.request.contextPath}/book/user/orderFormList/"+bmNos,
			success : function(rdata){
				jQ(".orderFormBox").html(rdata)
			},
			error : function(error){
				console.log(error)
			}
		})
	</script>
</body>
</html>