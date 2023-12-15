<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/admin/create_account_form.css' />" rel="stylesheet" type="text/css">


<script>
	function createAccountForm(){
		let form = document.create_account_form;
		if (form.a_m_id.value == '') {
			alert('INPUT ADMIN ID.');
			form.a_m_id.focus();
		} else if (form.a_m_pw.value == '') {
			alert('INPUT ADMIN PW.');
			form.a_m_pw.focus();
		} else if (form.a_m_pw_again.value == '') {
			alert('INPUT ADMIN PW AGAIN.');
			form.a_m_pw_again.focus();
		} else if (form.a_m_pw.value != form.a_m_pw_again.value) {
			alert('Please check your password again.');
			form.a_m_pw.focus();
		} else if (form.a_m_name.value == '') {
			alert('INPUT ADMIN NAME.');
			form.a_m_name.focus();
		} else if (form.a_m_gender.value == '') {
			alert('SELECET ADMIN GENDER.');
			form.a_m_gender.focus();
		} else if (form.a_m_part.value == '') {
			alert('INPUT ADMIN PART.');
			form.a_m_part.focus();
		} else if (form.a_m_position.value == '') {
			alert('INPUT ADMIN POSITION.');
			form.a_m_position.focus();
		} else if (form.a_m_mail.value == '') {
			alert('INPUT ADMIN MAIL.');
			form.a_m_mail.focus();
		} else if (form.a_m_phone.value == '') {
			alert('INPUT ADMIN PHONE.');
			form.a_m_phone.focus();
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
			
				<h3>CREATE ACCOUNT FORM</h3>
				
			</div>
		
			<div class="create_account_form">
			
				<form action="<c:url value='/admin/member/createAccountConfirm' />" name="create_account_form" method="post">
					
					<input type="text" name="a_m_id" placeholder="아이디다"> <br>
					<p id="idable"></p>
					<input type="password" name="a_m_pw" placeholder="비밀번호"> <br>
					<input type="password" name="a_m_pw_again" placeholder="비밀번호 확인"> <br>
					<input type="text" name="a_m_name" placeholder="관리자이름"> <br>
					<select name="a_m_gender">
						<option value="">성별</option>
						<option value="M">남자</option>
						<option value="W">여자</option>
					</select> <br>
					<input type="text" name="a_m_part" placeholder="부서"> <br>
					<input type="text" name="a_m_position" placeholder="직위"> <br>
					<input type="email" name="a_m_mail" placeholder="이메일" ><br>
					<input type="text" name="a_m_phone" placeholder="연락처"> <br>
					<input type="button" value="가입하기" onclick="createAccountForm();"> 
					<input type="reset" value="취소">
					
				</form>
				
			</div>
			
			<div class="login">
				
				<a href="<c:url value='/admin/member/loginForm' />">login</a>
				
			</div>
		
		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	
	<script>
    	jQ("input[name=a_m_id]").on("blur", function(){
			let amid = jQ(this).val();
			if (!amid) return;
			//let form = { amid : amid  }
			jQ.ajax({
				url:"${pageContext.request.contextPath}/admin/member/idCheck/"+amid,
				type : "GET",
				dataType : "json",
				contentType : 'application/json; charset=utf-8',
				success : function(rdata){	   // { result : isMember }
					console.log(rdata.result)
					let result = rdata.result;
					if (result) {
						jQ("#idable").text("중복된 아이디입니다.")
					} else {
						jQ("#idable").text("가능한 아이디입니다.")
					}
				},
				error : function(error){
					alert(error)
				}
			})
		})	
	</script>
	
</body>
</html>