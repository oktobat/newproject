<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error500.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기::도서관서비스</title>

<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/admin/find_password_form.css' />" rel="stylesheet" type="text/css">

<script type="text/javascript">

	function findPassword() {
		console.log('findPassword() CALLED!!');
		
		let form = document.find_password_form;
		
		if (form.a_m_id.value == '') {
			alert('INPUT ADMIN ID.');
			form.a_m_id.focus();
			
		} else if (form.a_m_name.value == '') {
			alert('INPUT INPUT ADMIN NAME.');
			form.a_m_name.focus();
			
		} else if (form.a_m_mail.value == '') {
			alert('INPUT ADMIN MAIL.');
			form.a_m_mail.focus();
			
		} else {
			form.submit();
			
		}
		
	}

</script>

</head>
<body>
<jsp:include page="../../common/commonjq.jsp" />
	<jsp:include page="../../common/commonjq.jsp" />
	<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		
		<div id="section_wrap">
			
			<div class="word">
			
				<h3>FIND PASSWORD FORM</h3>
				<p>(We will send you a new password.)</p>
				
			</div>
			
			<div class="find_password_form">
			
				<form action="<c:url value='/admin/member/findPasswordConfirm' />" name="find_password_form" method="post">
					
					<input type="text" name="a_m_id" placeholder="INPUT ADMIN ID."> <br>
					<input type="text" name="a_m_name" placeholder="INPUT ADMIN NAME."> <br>
					<input type="text" name="a_m_mail" placeholder="INPUT ADMIN MAIL."> <br>
					<input type="button" value="find password" onclick="findPassword();"> 
					<input type="reset" value="reset">
					
				</form>
				
			</div>
			
			<div class="create_account_login">
				
				<a href="<c:url value='/admin/member/createAccountForm' />">create account</a>
				<a href="<c:url value='/admin/member/loginForm' />">login</a>
				
			</div>
		
		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	
</body>
</html>