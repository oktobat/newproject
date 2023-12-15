<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.office.library.user.member.UserMemberVo" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
</head>
<body>

<jsp:include page="../../common/commonjq.jsp" />
<jsp:include page="../../include/header.jsp" />
	
<jsp:include page="../include/nav.jsp" />

<section>
	${photoReviewVo.pr_no}
	${photoReviewVo.pr_name}
	
</section>

<jsp:include page="../../include/footer.jsp" />
</body>
</html>