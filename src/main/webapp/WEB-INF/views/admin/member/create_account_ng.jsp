<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>

<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/admin/create_account_ok.css' />" rel="stylesheet" type="text/css">

</head>
<body>
<jsp:include page="../../common/commonjq.jsp" />
	<jsp:include page="../../include/header.jsp" />
	<jsp:include page="../include/nav.jsp" />
	<section>
		<div id="section_wrap">
			<div class="word row1024">
				<h3>CREATE ACCOUNT FAIL!!</h3>
			</div>
			<div class="others row1200">
				<a href="<c:url value='/admin/member/loginForm' />">login</a>
			</div>
		</div>
	</section>
	<jsp:include page="../../include/footer.jsp" />
	
</body>
</html>