<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.office.library.user.member.UserMemberVo" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/user/book_detail.css' />" rel="stylesheet" type="text/css">

<style>
.modifyForm .btns { display:none }
.modifyForm .btns.on { display:block }
</style>
</head>
<body>
	<jsp:include page="../../common/commonjq.jsp" />
	<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		
		<div id="section_wrap">
		
			<div class="word">
			
				<h3>BOOK DETAIL</h3>
				
			</div>
			
			<div class="book_detail">
			
				<ul>
					<li>
						<img src="<c:url value="/libraryUploadImg/${bookVo.b_thumbnail}"/>">
					</li>
					<li>
						<table>
							<tr>
								<td>도서명</td>
								<td>${bookVo.b_name}</td>
							</tr>
							<tr>
								<td>저자</td>
								<td>${bookVo.b_author}</td>
							</tr>
							<tr>
								<td>발행처</td>
								<td>${bookVo.b_publisher}</td>
							</tr>
							<tr>
								<td>발행년도</td>
								<td>${bookVo.b_publish_year}</td>
							</tr>
							<tr>
								<td>ISBN</td>
								<td>${bookVo.b_isbn}</td>
							</tr>
							<tr>
								<td>청구기호</td>
								<td>${bookVo.b_call_number}</td>
							</tr>
							<tr>
								<td>대출가능</td>
								<td>
								<c:choose>
									<c:when test="${bookVo.b_rental_able eq '0'}"> <c:out value="X" /> </c:when>
									<c:when test="${bookVo.b_rental_able eq '1'}"> <c:out value="O" /> </c:when>
									<c:otherwise> <c:out value="X" /> </c:otherwise>
								</c:choose>
								</td>
							</tr>
							<tr>
								<td>등록일</td>
								<td>${bookVo.b_reg_date}</td>
							</tr>
							<tr>
								<td>수정일</td>
								<td>${bookVo.b_mod_date}</td>
							</tr>
						</table>
					</li>
				</ul>
				
			</div>
		
			<div class="buttons">
				<c:choose>
					<c:when test="${bookVo.b_rental_able eq 0}">
						<a href="#none">대출중</a>
					</c:when>
					<c:when test="${bookVo.b_rental_able eq 1}">
						<c:url value='/book/user/rentalBookConfirm' var='rental_url'>
							<c:param name='b_no' value='${bookVo.b_no}'/>
						</c:url>
						<a class="rental_book_button" href="${rental_url}">도서 대출</a>
					</c:when>
				</c:choose>
			</div>
			
			
			<div style="width:500px; margin:50px auto; display:flex; justify-content:center">
				<div style="margin:0 10px; font-size:20px">
					<span style="cursor:pointer" onclick="likeBtn(this)"><i class="fa-solid fa-heart"></i></span>
					<span id="likecnt"></span>
				</div>
				<div style="margin:0 10px; font-size:20px">
					<span><i class="fa-solid fa-comment"></i></span>
					<span id="revcnt">${bookVo.rev_b_no_count}</span>
				</div>
			</div>
			
			
			<!-- 도서 리뷰 등록폼(로그인한 경우에만 보임) -->
			<%
				UserMemberVo loginedUserMemberVo = (UserMemberVo) session.getAttribute("loginedUserMemberVo");
			    if (loginedUserMemberVo != null) {
			%>
				<div style="width:500px; margin:50px auto">
					<form name="add_form" style="border:1px solid #000; padding:5px 10px; border-radius:5px">
						<input type="hidden" name="b_no" value="${bookVo.b_no}" />
						<input type="hidden" name="u_m_no" value="${loginedUserMemberVo.u_m_no}" />
						<p><input disabled  style="width:100%; border:none" type="text" value="${loginedUserMemberVo.u_m_id}" /></p>
						<p><textarea style="width:100%; height:80px; padding:5px; border:none; resize:none" name="rev_content" placeholder="댓글을 남겨보세요."></textarea></p>
						<p style="text-align:right"><input style="padding:0 5px" type="button" value="등록" onclick="reviewWrite()"></p>   
					</form>
				</div>
			<% } %>
			
			<div class="review_list"></div>
			
		</div>
	</section>
	
	<jsp:include page="../../include/footer.jsp" />

	<script>
		let a_b_no = ${bookVo.b_no};
		let a_u_m_no = ${loginedUserMemberVo.u_m_no}
	 	
		reviewList(a_b_no);
		function reviewList(b_no){
			let formdata = { b_no : b_no }
			jQ.ajax({
				type :"POST",
				url : "${pageContext.request.contextPath}/book/user/bookReviewList",
				data : JSON.stringify(formdata),
				contentType : "application/json; charset=UTF-8",
				success : function(rdata){
					jQ('.review_list').html(rdata)
				},
				error : function(error){
					console.log(error)
				}
			})
		}
		
		
		function reviewWrite(){
			let form = document.add_form;
			let rev_content = form.rev_content.value;  
			                  // $('form input[name=rev_content]').val()
			let b_no = form.b_no.value;
			let u_m_no = form.u_m_no.value;                  
			if (!rev_content){
				alert("댓글을 입력하세요.")
				return false;
			}
			let formdata = { b_no:b_no, u_m_no:u_m_no, rev_content:rev_content }
			form.rev_content.value = "";
			jQ.ajax({
				type :"POST",
				url : "${pageContext.request.contextPath}/book/user/bookReviewInsert",
				data : JSON.stringify(formdata),
				contentType : "application/json; charset=UTF-8",
				success : function(rdata){
					jQ('.review_list').html(rdata)
					reviewCnt(b_no)
				},
				error : function(error){
					console.log(error)
				}
			})
			                  
		}
		
		
		function modBtn(me){
			jQ(me).parent().removeClass("on")
			jQ(me).parent().siblings().addClass("on")
			jQ(me).parent().parent().prev().find('textarea').prop('disabled', false).focus()
		}
		
		function rstBtn(me){
		   jQ(me).parent().removeClass("on")
		   jQ(me).parent().siblings().addClass("on")
		   jQ(me).closest('.modifyForm').find('textarea').prop('disabled', true)
		}
		
		function insBtn(me){
			let rev_no = jQ(me).closest('.modifyForm').find('input[name=rev_no]').val();
			let rev_content = jQ(me).closest('.modifyForm').find('textarea').val();
			let b_no = jQ(me).closest('.modifyForm').find('input[name=b_no]').val();
			let formdata = { rev_no:rev_no, rev_content:rev_content, b_no:b_no };
			jQ(me).closest('.modifyForm').find('textarea').val("");
			jQ.ajax({
				type :"POST",
				url : "${pageContext.request.contextPath}/book/user/bookReviewModify",
				data : JSON.stringify(formdata),
				contentType : "application/json; charset=UTF-8",
				success : function(rdata){
					jQ('.review_list').html(rdata)
				},
				error : function(error){
					console.log(error)
				}
			})
		}
		
		function delBtn(me){
			let rev_no = jQ(me).closest('.modifyForm').find('input[name=rev_no]').val();
			let b_no = jQ(me).closest('.modifyForm').find('input[name=b_no]').val();
			let formdata = { rev_no:rev_no, b_no:b_no };
			jQ.ajax({
				type :"POST",
				url : "${pageContext.request.contextPath}/book/user/bookReviewDelete",
				data : JSON.stringify(formdata),
				contentType : "application/json; charset=UTF-8",
				success : function(rdata){
					jQ('.review_list').html(rdata)
					reviewCnt(b_no)
				},
				error : function(error){
					console.log(error)
				}
			})
		}
		
		
		function reviewCnt(bno){
			let formdata = { b_no:bno };
			jQ.ajax({
				type :"POST",
				url : "${pageContext.request.contextPath}/book/user/bookReviewCount",
				data : JSON.stringify(formdata),
				contentType : "application/json; charset=UTF-8",
				success : function(rdata){
					jQ('#revcnt').text(rdata.revcnt)
				},
				error : function(error){
					console.log(error)
				}
			})
		}
		
		
		if (a_u_m_no) {
			userLikeStatus(a_b_no, a_u_m_no)
		} else {
			userLikeCnt(a_b_no)
		}
		
		function userLikeStatus(b_no, u_m_no){
			let formdata = { b_no:b_no, u_m_no:u_m_no };
			jQ.ajax({
				type :"POST",
				url : "${pageContext.request.contextPath}/book/user/bookLikeStatus",
				data : JSON.stringify(formdata),
				contentType : "application/json; charset=UTF-8",
				success : function(rdata){
					jQ('#likecnt').text(rdata.likecnt)
					if (rdata.status) {
						jQ('#likecnt').prev().find('i').addClass('fa-solid').removeClass('fa-regular')
					} else {
						jQ('#likecnt').prev().find('i').addClass('fa-regular').removeClass('fa-solid')
					}
				},
				error : function(error){
					console.log(error)
				}
			})
		}
		
		
		function userLikeCnt(b_no){
			let formdata = { b_no:b_no };
			jQ.ajax({
				type :"POST",
				url : "${pageContext.request.contextPath}/book/user/bookLikeCount",
				data : JSON.stringify(formdata),
				contentType : "application/json; charset=UTF-8",
				success : function(rdata){
					jQ('#likecnt').text(rdata.likecnt)
				},
				error : function(error){
					console.log(error)
				}
			})
		}
		
		
		
		function likeBtn(me){
			if (!a_u_m_no) {
				alert("로그인하 후 클릭하세요.")
				return false;
			}
			if (!jQ(me).find('i').hasClass('fa-solid')) {
				jQ(me).find('i').addClass('fa-solid').removeClass('fa-regular')
				let formdata = { b_no:a_b_no, u_m_no:a_u_m_no };
				jQ.ajax({
					type :"POST",
					url : "${pageContext.request.contextPath}/book/user/bookLikeInsert",
					data : JSON.stringify(formdata),
					contentType : "application/json; charset=UTF-8",
					success : function(rdata){
						jQ('#likecnt').text(rdata.likecnt)
					},
					error : function(error){
						console.log(error)
					}
				})
			} else {
				jQ(me).find('i').addClass('fa-regular').removeClass('fa-solid')
				let formdata = { b_no:a_b_no, u_m_no:a_u_m_no };
				jQ.ajax({
					type :"POST",
					url : "${pageContext.request.contextPath}/book/user/bookLikeDelete",
					data : JSON.stringify(formdata),
					contentType : "application/json; charset=UTF-8",
					success : function(rdata){
						jQ('#likecnt').text(rdata.likecnt)
					},
					error : function(error){
						console.log(error)
					}
				})
			}
			
		}
		
		
	</script>

</body>
</html>