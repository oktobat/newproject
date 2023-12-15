<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	.mallList { display:grid; grid-template-columns: 1fr 1fr;}
	.mallList > li { border:1px solid #000; margin:10px; 
		position:relative; }
	.mallList > li > div.originBox { display:grid; 
		grid-template-rows:110px 1fr;}
	.mallList > li > div.originBox > div { border:1px solid #000 }
	.mallList > li > div.hoverBox {
   		position:absolute; top:0; left:0; right:0; bottom:0;
   		background:red; display:none; 
   		justify-content:center;
   	    align-items:center;
   }   
   .mallList > li:hover > div.hoverBox { display:flex }
   .mallList > li > div.hoverBox a { margin:0 20px; } 
   
   
   #modalOuter { position:fixed; 
        top:0; left:0; bottom:0; right:0; 
  		background:rgba(0,0,0,0.8); 
  		z-index:9999; display:none; 
   }
  
  #modalInner { position:absolute; width:400px; height:400px;
  		left:50%; top:50%;
  		transform:translate(-50%, -50%);
  		background:#00afa0; 
  		text-align:center;
 		padding:20px; 
  }
  #modalInner .close { text-align:right; }
  #modalInner .close i { font-size:50px; color:#fff; cursor:pointer }
  
  #modalInner .infoText { font-size:18px; margin-top:20px }
  #modalInner .infoText p { color:#fff; margin:3px 0px  }
  
  #modalInner .cartIcon { font-size:80px; margin:5px 0;  }
  #modalInner .cartIcon i { color:#fff }
  
  #modalInner .moveBtn { display:flex; justify-content:center }
  #modalInner .moveBtn a { width:100px; height:100px; 
   		border-radius:50%; border:1px solid #fff; 
   		display:flex;  justify-content:center;
   		align-items:center; margin:0 10px; color:#fff; 
  }
  #modalInner .moveBtn a:hover {
  		background:#0d786d; border:1px solid #0d786d; 
  }
   
</style>

<c:set var="number" value="${pageVo.totArticles - pageVo.start}" />
<ul class="mallList">
   <c:forEach var="item" items="${mallBookListAll}">
		<li>
			<div class="originBox">
				<div class="photo">
					<img src="<c:url value='/libraryUploadImg/${item.bm_photo0}' />" alt="${item.bm_photo0 }">
				</div>
				<div class="info">
					<p>${number }</p>
				    <p>${item.bm_name }</p>
				    <p>${item.bm_publisher }</p>
				    <p>${item.bm_price}</p>
				</div>
			</div>
		    <div class="hoverBox">
			     <a href="#">상세페이지</a>
				 <a href="${item.bm_no}">장바구니</a>
				 <c:if test="${loginedUserMemberVo.u_m_id.equals('superman')}">
				    <a href="">수정</a>
				 </c:if>
			</div>
		</li>
	<c:set var="number" value="${number=number-1 }" />
	</c:forEach>
</ul>



<div id="modalOuter">
	<div id="modalInner">
	    <div class="close">
	    	<i class="fa-solid fa-xmark"></i>
	    </div>
	    <div class="infoText">
	    	<p>해당 상품을 장바구니에 담았습니다.</p>
	    	<p>장바구니로 이동하시겠습니까?</p>
	    </div>
	    <div class="cartIcon">
			<i class="fa-solid fa-cart-shopping"></i>
		</div>
		<div class="moveBtn">
		     <a href="<c:url value='/book/user/cartPage' />">장바구니<br>이동</a>
		     <a href="javascript:;">쇼핑<br>계속</a>
		</div>
	</div>
</div>

<div class="cl2" style="text-align:center; margin:30px">

    <a href="javascript:;" onclick="pageGrouping(1, 1, 0, 0)" class="firstpage  pbtn">맨처음</a>
    <c:if test="${pageVo.pgn != 1}">
        <a href="javascript:;" onclick="pageGrouping(${pageVo.pgn}, 1, 0, 0)" class="prevpage  pbtn">
            이전
        </a>
    </c:if>

	
	    <c:forEach var="i" begin="${(pageVo.pgn-1) * pageVo.pageNums + 1}" end="${(pageVo.pgn * pageVo.pageNums < pageVo.total_page) ? pageVo.pgn*pageVo.pageNums : pageVo.total_page}">
	        <c:choose>
	            <c:when test="${pageVo.page == i }">
	                <a href="javascript:;">
	                    <span class="pagenum currentpage">${i}</span>
	                </a>
	            </c:when>
	            <c:otherwise>
	                <a href="javascript:;" onclick="paging(${pageVo.pgn}, ${i})">
	                    <span class="pagenum">${i}</span>
	                </a>
	            </c:otherwise>
	        </c:choose>
	    </c:forEach>
    
    <c:if test="${pageVo.pgn != pageVo.tpgn}">
        <a href="javascript:;" onclick="pageGrouping(${pageVo.pgn}, 2, ${pageVo.tpgn}, ${pageVo.total_page})" class="nextpage  pbtn">
            다음
        </a>
    </c:if>
    <c:if test="${pageVo.page<pageVo.total_page }">
	    <a href="javascript:;" onclick="pageGrouping(${pageVo.tpgn}, 2, ${pageVo.tpgn}, ${pageVo.total_page})"  class="lastpage  pbtn">
	        맨마지막
	    </a>
    </c:if>
</div>



<script>
	
    let user_no = "${loginedUserMemberVo.u_m_no}"
	jQ(".hoverBox a:nth-child(2)").on('click', function(){
		if (!user_no) {
			user_no = 0;
		} 
		let bm_data = {
			bm_photo0 :	jQ(this).closest("li").find("img").attr("alt"),
			bm_name : jQ(this).closest("li").find(".info p:nth-child(1)").text(),
			bm_publisher : jQ(this).closest("li").find(".info p:nth-child(2)").text(),
			bm_price : jQ(this).closest("li").find(".info p:nth-child(3)").text(),
			bm_no : jQ(this).attr("href"),			
		}
		console.log(bm_data)
		jQ("#modalOuter").fadeIn(300);
		jQ.ajax({
				type :"POST",
				contentType : "application/json; charset=UTF-8",
				url : "${pageContext.request.contextPath}/book/user/cartIn/"+user_no,
				data : JSON.stringify(bm_data),
				success : function(){
				},
				error : function(error){
					console.log(error)
				}
		})
		return false
	})
	
	
	jQ("#modalOuter").on("click", ".close i, .moveBtn a:nth-child(2)", function(){
		jQ("#modalOuter").fadeOut(300);
	})
	
	
</script>