<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach var="item" items="${reviewBookVos }">
	<div style="width:500px; margin:50px auto">
		<form class="modifyForm" name="modify_form" style="border:1px solid #000; padding:5px 10px; border-radius:5px">
			<input type="hidden" name="rev_no" value="${item.rev_no}" />
			<input type="hidden" name="b_no" value="${item.b_no}" />
			<input type="hidden" name="u_m_no" value="${item.u_m_no}" />
			<p><input disabled  style="width:100%; border:none" type="text" value="${item.u_m_id}" /></p>
			<p><textarea disabled style="width:100%; height:auto; padding:5px; border:none; resize:none" name="rev_content" placeholder="댓글을 남겨보세요.">${item.rev_content }</textarea></p>
			<c:if test="${item.u_m_no == loginedUserMemberVo.getU_m_no() }">
			  <div>
				<p style="text-align:right" class="btns on">
                	<input style="padding:0 5px" type="button" value="수정" onclick="modBtn(this);">
                	<input style="padding:0 5px" type="button" value="삭제" onclick="delBtn(this);">
                </p>
                <p style="text-align:right" class="btns">
                	<input style="padding:0 5px" type="button" value="취소" onclick="rstBtn(this);">
                	<input style="padding:0 5px" type="button" value="등록" onclick="insBtn(this);">
                </p>
              </div>
			</c:if>   
		</form>
	</div>
</c:forEach>