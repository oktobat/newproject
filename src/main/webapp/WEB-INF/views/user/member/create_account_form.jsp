<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/user/create_account_form.css' />" rel="stylesheet" type="text/css">
<script type="text/javascript">

	function createAccountForm() {
		console.log('createAccountForm() CALLED!!');
		
		let form = document.create_account_form;
		
		if (form.u_m_id.value == '') {
			alert('INPUT USER ID.');
			form.u_m_id.focus();
			
		} else if (form.u_m_pw.value == '') {
			alert('INPUT USER PW.');
			form.u_m_pw.focus();
			
		} else if (form.u_m_pw_again.value == '') {
			alert('INPUT USER PW AGAIN.');
			form.u_m_pw_again.focus();
			
		} else if (form.u_m_pw.value != form.u_m_pw_again.value) {
			alert('Please check your password again.');
			form.u_m_pw.focus();
			
		} else if (form.u_m_name.value == '') {
			alert('INPUT USER NAME.');
			form.u_m_name.focus();
			
		} else if (form.u_m_gender.value == '') {
			alert('SELECET USER GENDER.');
			form.u_m_gender.focus();
			
		} else if (form.u_m_mail.value == '') {
			alert('INPUT USER MAIL.');
			form.u_m_mail.focus();
			
		} else if (form.u_m_phone.value == '') {
			alert('INPUT USER PHONE.');
			form.u_m_phone.focus();
			
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
				<form action="<c:url value='/user/member/createAccountConfirm' />" name="create_account_form" method="post">
					<input type="text" name="u_m_id" placeholder="INPUT USER ID."> <br>
					<input type="password" name="u_m_pw" placeholder="INPUT USER PW."> <br>
					<input type="password" name="u_m_pw_again" placeholder="INPUT USER PW AGAIN."> <br>
					<input type="text" name="u_m_name" placeholder="INPUT USER NAME."> <br>
					<select name="u_m_gender">
						<option value="">SELECET USER GENDER.</option>
						<option value="M">Man</option>
						<option value="W">Woman</option>
					</select> <br>
					<input type="email" name="u_m_mail"	placeholder="INPUT USER MAIL." ><br>
					<input type="text" name="u_m_phone"	placeholder="INPUT USER PHONE."> <br>
	                <input type="text" name="u_m_zipcode" id="m_zipcode" onclick="openDaumPostcode();">  
	                <input type="button" value="우편번호 검색" id="prof_zipcode" onclick="openDaumPostcode();"><br>
	                <input type="text" name="u_m_address" id="m_address">  
	                <input type="text" name="u_m_address_sub" id="m_address_sub"><br>
					<input type="button" value="회원가입" onclick="createAccountForm();"> 
					<input type="reset" value="reset">
					
				</form>
				
			</div>
			
			<div class="login">
				<a href="<c:url value='/user/member/loginForm' />">login</a>
			</div>
		
		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>  
  <script>
    function openDaumPostcode() {
      new daum.Postcode({
        oncomplete: function(data) {
          var fullAddr = ''; // 최종 주소 변수
          var extraAddr = ''; // 조합형 주소 변수
          if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
            fullAddr = data.roadAddress;
          } else { // 사용자가 지번 주소를 선택했을 경우(J)
            fullAddr = data.jibunAddress;
          }
          if(data.userSelectedType === 'R'){
            if(data.bname !== ''){
              extraAddr += data.bname;
            }
            if(data.buildingName !== ''){
              extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
          }
          document.querySelector("#m_zipcode").value = data.zonecode;
          document.querySelector("#m_address").value = fullAddr;
          document.querySelector("#m_address_sub").focus();
        }
      }).open();
    }
  </script>  
	
</body>
</html>