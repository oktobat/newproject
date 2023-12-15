<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/user/photo_review.css' />" rel="stylesheet" type="text/css">

</head>
<body>


	<jsp:include page="../../common/commonjq.jsp" />
    <jsp:include page="../../include/header.jsp" />
	<jsp:include page="../include/nav.jsp" />
	
	

<section>
		
		<div id="section_wrap">
		
			<div class="word">
				<h3>도서 포토후기</h3>
			</div>
		
		    <div class="photoReviewList"></div>
		
			<div class="photo_review_form">
				<form name="photo_review">
					<input type="text"		name="pr_name" 		placeholder="도서명"> <br>
					<input type="text"		name="pr_author" 	placeholder="저자"> <br>
					<input type="text"		name="pr_publisher"	placeholder="출판사"> <br>
					<input type="file" 		name="pr_photo" 	class="files"> <br>
					<input type="file" 		name="pr_photo" 	class="files"> <br>
					<input type="file" 		name="pr_photo" 	class="files"> <br>
					<input type="button"	value="전송"         onclick="photoReview()"> 
					<input type="reset"		value="취소">
				</form>
			</div>
			
			
		
		</div>
		
	</section>

	<jsp:include page="../../include/footer.jsp" />
	
	
	<script>
		let form = document.photo_review;
		let user_no = "${loginedUserMemberVo.u_m_no}";
		console.log(user_no);
		
		let pageGroup = 1;   // (1~10, 11~20)
		let pageNum = 1;	 // 최초 페이지 번호 
		
		paging(pageGroup, pageNum);
		
		function paging(pG, pN) {
			jQ.ajax({
				type :"GET",
				contentType : "application/json; charset=UTF-8",
				url : "${pageContext.request.contextPath}/book/user/photoReviewAll?pageGroup="+pG+"&pageNum="+pN,
				success : function(rdata){
					console.log(rdata)
					jQ(".photoReviewList").html(rdata)
				},
				error : function(error){
					console.log(error)
				}
			})
			
		}
		
		function pageGrouping(pGroup, direct, total_page_group_num, total_page) {
			let pNum = 0
			if (direct==1 && pGroup==1) {
		        pNum = 1
		    } else if (direct==1 && pGroup>1) {
		    	pGroup = pGroup - 1
		        pNum = pGroup*10-9
		    } else if (direct==2 && pGroup<total_page_group_num) {
		    	pGroup = pGroup + 1;
		        pNum = pGroup*10-9
		    } else if (direct==2 && pGroup==total_page_group_num) {
		        pNum = total_page
		        
		    }
		    
			console.log(pGroup, pNum)

			paging(pGroup, pNum)
		    
		}

		
		function photoReview(){
			const formData = new FormData();
			if (!user_no){
				alert("로그인을 하세요.")
				return false
			} else if (form.pr_name.value=="") {
				alert("도서명을 입력하세요.")
				return false
			} 
			let data = {
					u_m_no 		 : user_no,
					pr_name      : form.pr_name.value,
					pr_author  	 : form.pr_author.value,
					pr_publisher : form.pr_publisher.value
			}
			
			let fileInput = jQ(".files")
			for (let i=0; i<fileInput.length; i++) {
				if (fileInput[i].files.length>0) {
					for (let j=0; j<fileInput[i].files.length; j++) {
						formData.append("file", jQ('.files')[i].files[j] )
					}
				}
			}
			
			
			formData.append("key", new Blob([ JSON.stringify(data) ], {type:"application/json"}))

			form.pr_name.value = "";
			form.pr_author.value = "";
			form.pr_publisher.value = "";
			form.pr_photo[0].value = "";
			form.pr_photo[1].value = "";
			form.pr_photo[2].value = "";
			
			jQ.ajax({
				type :"POST",
				enctype : "multipart/form-data",
				url : "${pageContext.request.contextPath}/book/user/photoReviewInsert",
				data : formData,
				contentType : false,
				processData : false,
				cache : false,
				success : function(rdata){
					jQ(".photoReviewList").html(rdata)
				},
				error : function(error){
					console.log(error)
				}
			})
			
			
		}
	</script>	
	

</body>
</html>