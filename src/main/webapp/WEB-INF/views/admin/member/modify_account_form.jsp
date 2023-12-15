<%@page import="com.office.library.admin.member.AdminMemberVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/admin/modify_account_form.css' />" rel="stylesheet" type="text/css">

<script type="text/javascript">

	function modifyAccountForm() {
		
		let form = document.modify_account_form;
		
		if (form.a_m_name.value == '') {
			alert('INPUT ADMIN NAME.');
			form.a_m_name.focus();
			
		} else if (form.a_m_gender.value == '') {
			alert('SELECET ADMIN GENDER.');
			form.a_m_gender.focus();
			
		} else if (form.a_m_part.value == '') {
			alert('INPUT ADMIN PART.');
			form.a_m_part.focus();
			
		} else if (form.a_m_position.value == '') {
			alert('INPUT ADMIN POSITON.');
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
			
				<h3>MODIFY ACCOUNT FORM</h3>
				
			</div>
		
			<%
			AdminMemberVo loginedAdminMemberVo = (AdminMemberVo) session.getAttribute("loginedAdminMemberVo");
			%>
		
			<div class="modify_account_form">
			
				<form action="<c:url value='/admin/member/modifyAccountConfirm' />" name="modify_account_form" method="post">
					
					<input type="hidden" 	name="a_m_no"		value="${ loginedAdminMemberVo.getA_m_no() }">
					
					<input type="text"		name="a_m_id" 		value="${ loginedAdminMemberVo.getA_m_id() }" readonly disabled> <br>
					<input type="password"	name="a_m_pw" 		value="${ loginedAdminMemberVo.getA_m_pw() }" > <br>
					<input type="text"		name="a_m_name" 	value="${ loginedAdminMemberVo.getA_m_name() }" placeholder="INPUT USER NAME."> <br>
					<select name="a_m_gender">
						<option value="">SELECET USER GENDER.</option>
						<option value="M" <% if (loginedAdminMemberVo.getA_m_gender().equals("M")) {%> selected <%}%>>Man</option>
						<option value="W" <% if (loginedAdminMemberVo.getA_m_gender().equals("W")) {%> selected <%}%>>Woman</option>
					</select> <br>
					<input type="text"		name="a_m_part"		value="<%= loginedAdminMemberVo.getA_m_part() %>" placeholder="INPUT USER PART." ><br>
					<input type="text"		name="a_m_position"	value="<%= loginedAdminMemberVo.getA_m_position() %>" placeholder="INPUT USER POSITION." ><br>
					<input type="email"		name="a_m_mail"		value="<%= loginedAdminMemberVo.getA_m_mail() %>" placeholder="INPUT USER MAIL." ><br>
					<input type="text"		name="a_m_phone"	value="<%= loginedAdminMemberVo.getA_m_phone() %>" placeholder="INPUT USER PHONE."> <br>
					<input type="button"	value="정보수정" onclick="modifyAccountForm();"> 
					<input type="reset"		value="reset">
					
				</form>
				
			</div>
		
		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	
</body>
</html>