<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="paging" value="${paging}" />
<c:set var="userSeq" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>Go!rea</title>
    <link rel="stylesheet" type="text/css" href="/css/mypage/mypageHeader.css">
    <link rel="stylesheet" type="text/css" href="/css/mypage/qnaList.css">
        <script>
    	
    // ���� �������� �̵��ϴ� �Լ�
    function goToPreviousPage() {
        var currentPage = ${paging.cpage};

        // ���� �������� 1�������� ��쿡�� �������� �ʵ��� üũ
        if (currentPage > 1) {
            // �̵��� URL ����
            var url = "/${language}/qnaList.do?cpage=" + (currentPage - 1);

            // ������ ������ �̵�
            window.location.href = url;
        }
    }
    
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
   		<div class="commonBanner" id="comBanner">
      	  <img src="/img/banner/Top5Banner.jpg" alt="banner">
	        <div class="commonBanner-text">
	            <h1>����������</h1>
	        </div>
	    </div>
 	   <div class="menuContainer">
       <div class="menuinner">
           <div class="mypage-menuBtn">
               <a href="mypage.do" class="mypagebtn active userInfo">ȸ������</a>
               <a href="boardList.do?userSeq=${userSeq}" class="mypagebtn active boardList">�Խñ� ����</a>
               <a href="replyList.do?userSeq=${userSeq}" class="mypagebtn active replyList">��� ����</a>
               <a href="#" class="mypagebtn active likeList">���ã��</a>
               <a href="qnaList.do?userSeq=${userSeq }" class="mypagebtn active qna">1:1 ���ǳ���</a>
               <a href="userLeave.do?userSeq=${userSeq }" class="mypagebtn active bye">ȸ��Ż��</a>
           </div>
       </div>
   </div>
    <section class="mypage-section">
        <div class="mypage-container">
            <div class="menu-title">
                <b>��� ����</b>
            </div>

		 <div class="board-wrap">
                <table class="board-list">
                    <thead>
                        <th class="col-num">��� �Խ���</th>
                        <th class="col-title">����</th>
                        <th class="col-date">�ۼ���</th>
                    </thead>
                    <c:choose>
                        <c:when test="${not empty lists}">
                            <c:forEach var="reply" items="${lists}">
                                <tbody>
                                    <tr class="boardList">
                                        <td>${reply.boardType}</td>
                                        <td>
                                        <c:choose>
                                            <c:when test="${reply.boardType eq '������ ��õ���'}">
                                                <a href="/${language}/editRecommend_view.do?editrecoSeq=${reply.boardID}">${reply.comment}</a>
                                            </c:when>
                                             <c:when test="${reply.boardType eq '������ ����'}">
                                                <a href="/${language}/editTip_view.do?editrecoSeq=${reply.boardID}">${reply.comment}</a>
                                            </c:when>
                                            <c:when test="${reply.boardType eq 'Ʈ���� ����'}">
                                                <a href="/${language}/trend_view.do?seoulSeq=${reply.boardID}">${reply.comment}</a>
                                            </c:when>
 											<c:when test="${reply.boardType eq '�����Խ���'}">
                                                <a href="/${language}/freeboard_view.do?editrecoSeq=${reply.boardID}">${reply.comment}</a>
                                            </c:when>
                                        </c:choose>
                                        <!-- ������ ��õ, BestTop5 �κ� �߰��ؾ��� -->
                                    </td>
                                        <td>${reply.postDate}</td>
                                    </tr>
                                </tbody>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tbody>
                                <tr>
                                    <td colspan="3">��ϵ� ����� �����ϴ�.</td>
                                </tr>
                            </tbody>
                        </c:otherwise>
                    </c:choose>
                </table>
            </div>
 					<div class="bottom-container">
					    <div class="pagination-container">
					        <div class="pagination">
					        <!-- ó�� ������ ��ư -->
					        <c:if test="${paging.cpage > 1}">
					            <a href="/user/${language}/replyList.do?userSeq=${userSeq }cpage=1" class="pagination-item">&lt;&lt;</a>
					            <a href="/user/${language}/replyList.do?userSeq=${userSeq }&cpage=${paging.cpage - 1}" class="pagination-item">&lt;</a>
					        </c:if>
					        <c:if test="${paging.cpage == 1}">
					            <span class="pagination-item disabled">&lt;&lt;</span>
					            <span class="pagination-item disabled">&lt;</span>
					        </c:if>
					
					        <!-- ������ ��ȣ -->
							<c:forEach var="i" begin="${paging.firstPage}" end="${paging.lastPage}" varStatus="loop">
							    <c:choose>
							        <c:when test="${i == paging.cpage}">
							            <span class="pagination-item active">${i}</span>
							        </c:when>
							        <c:otherwise>
							            <a href="/user/${language}/replyList.do?userSeq=${userSeq}&cpage=${i}" class="pagination-item">${i}</a>
							        </c:otherwise>
							    </c:choose>
							</c:forEach>

					
					        <!-- ���� ������ ��ư -->
					        <c:if test="${paging.cpage < paging.totalPage}">
					            <a href="/user/${language}/replyList.do?userSeq=${userSeq}&cpage=${paging.cpage + 1}" class="pagination-item">&gt;</a>
					            <a href="/user/${language}/replyList.do?userSeq=${userSeq}&cpage=${paging.totalPage}" class="pagination-item">&gt;&gt;</a>
					        </c:if>
					        <c:if test="${paging.cpage == paging.totalPage}">
					            <span class="pagination-item disabled">&gt;</span>
					            <span class="pagination-item disabled">&gt;&gt;</span>
					        </c:if>
					    </div>
					    </div>
					</div>
               	</div>
                
		</div>
 	</section> 
 	
 	<jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include> 
</body>
</html>
