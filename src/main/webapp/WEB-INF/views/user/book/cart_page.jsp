<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/user/cart_page.css' />" rel="stylesheet" type="text/css">
</head>
<body>
<jsp:include page="../../common/commonjq.jsp" />
<jsp:include page="../../include/header.jsp" />
<jsp:include page="../include/nav.jsp" />

<script>
	let user_no = "${loginedUserMemberVo.u_m_no}";
	if (!user_no){
		user_no = 0;
	}
</script>

<section>
	<div id="section_wrap">
		<div class="word">
			<h3>장바구니</h3>
		</div>
		<div class="cartBox"></div>
	</div>
</section>	

<jsp:include page="../../include/footer.jsp" />

<script>
	jQ.ajax({
		type :"GET",
		contentType : "application/json; charset=UTF-8",
		url : "${pageContext.request.contextPath}/book/user/cartList/"+user_no,
		success : function(rdata){
			jQ(".cartBox").html(rdata);
		},
		error : function(error){
			console.log(error)
		}
	})
	
</script>


</body>
</html>