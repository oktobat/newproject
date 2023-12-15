<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>

.no-uline {
	text-decoration: none;
}

.sel-page {
	text-decoration: none;
	color: red;
}

.cls1 {
	text-decoration: none;
}

.cls2 {
	text-align: center;
	font-size: 30px;
}

.cl2 .currentpage {
	color:red; 
}

/*
   .photoList { overflow:hidden  }
   .photoList > li { width:30%; border:1px solid #000; margin:20px 0;
   			float:left; margin-right:5%;
    }
	.photoList > li:nth-child(3n) { margin-right:0 }
	
*/


/*
   .photoList { display:flex; flex-wrap:wrap;   }
   .photoList > li { width:30%; border:1px solid #000; 
                margin:20px;
    }
    .photoList > li:nth-child(3n) { margin-right:0 }
*/
	

   .photoList { display:grid; grid-template-columns: 1fr 1fr;
  }
   .photoList > li { border:1px solid #000; margin:20px; 
         display:grid; position:relative; 
   }
   .photoList > li > div.originBox {
   		display:grid; align-content:space-between;
   }
   .photoList > li > div.hoverBox {
   		position:absolute; top:0; left:0; right:0; bottom:0;
   		background:red; display:none; 
   		justify-content:center;
   	    align-items:center;
   }   
   .photoList > li:hover > div.hoverBox { display:flex }
   .photoList > li > div.hoverBox a { margin:0 20px; }
  
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

<ul class="photoList">

	<c:forEach var="item" items="${reviewListAll}">
		<li>
		   <div class="originBox">
				<p>
				   <c:choose>
				       <c:when test="${item.pr_photo0 != null }">
				         <img src="<c:url value='/libraryUploadImg/${item.pr_photo0}' />">
				       </c:when>
				       <c:otherwise>
				         <img src="<c:url value='/resources/img/user/small_banner1.png' />">
				       </c:otherwise>
				   </c:choose>
				</p>
				<div>
				    <p>${number }</p>
					<p>${item.pr_name}</p>
					<p>${item.pr_author}</p>
					<p>${item.pr_publisher}</p>
					<p>${item.pr_hit}</p>
				</div>
			</div>
			<div class="hoverBox">
			     <a href="<c:url value='/book/user/reviewDetail?pr_no=${item.pr_no}' />">상세페이지</a>
				 <a href="${item.pr_no}">장바구니</a>
			</div>
		</li>
		<c:set var="number" value="${number=number-1 }" />
	</c:forEach>
</ul>


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
		     <a href="#">장바구니<br>이동</a>
		     <a href="javascript:;">쇼핑<br>계속</a>
		</div>
	</div>
</div>



<script>
	jQ(".hoverBox a:nth-child(2)").on('click', function(){
		jQ("#modalOuter").fadeIn(300);
		return false
	})
	
	jQ("#modalOuter").on("click", ".close i, .moveBtn a:nth-child(2)", function(){
		jQ("#modalOuter").fadeOut(300);
	})
	
</script>