<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/user/request_hope_book_result.css' />" rel="stylesheet" type="text/css">

<script type="text/javascript">

	function requestHopeBookForm() {
		console.log('requestHopeBookForm() CALLED!!');
		
		let form = document.request_hope_book_form;
		
		if (form.hb_name.value == '') {
			alert('INPUT HOPE BOOK NAME.');
			form.hb_name.focus();
			
		} else if (form.hb_author.value == '') {
			alert('INPUT HOPE BOOK AUTHOR.');
			form.hb_author.focus();
			
		} else {
			form.submit();
			
		}
		
	}

</script>

</head>
<body>
<jsp:include page="../../common/commonjq.jsp" />
	<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		
		<div id="section_wrap">
		
			<div class="word">
			
				<h3>REQUEST HOPE BOOK FAIL!!</h3>
				
			</div>
		
		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	
</body>
</html>