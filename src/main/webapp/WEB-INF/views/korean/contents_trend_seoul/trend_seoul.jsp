
<%@page import="com.gorea.dto_board.Gorea_TrendSeoul_BoardTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% 
   ArrayList<Gorea_TrendSeoul_BoardTO> lists = (ArrayList)request.getAttribute("lists");
   
   int totalRecord = lists.size();
   
   StringBuilder sbHtml = new StringBuilder();
   
   for( Gorea_TrendSeoul_BoardTO to : lists) {
	      String go_seoul_seq = to.getGo_seoul_seq();
	      String go_seoul_subject = to.getGo_seoul_subject();
	      String go_seoul_subtitle = to.getGo_seoul_subtitle();
	      String filename = to.getFilename();
	      String go_seoul_loc = to.getGo_seoul_loc();
	      
	      sbHtml.append("<div class='album' data-go_seoul_seq='" + go_seoul_seq + "'>");
	      sbHtml.append("<div class='image'>");
	      sbHtml.append("<img src='../../upload/"  + filename + "'alt=''>");
	      sbHtml.append("</div>");
	      sbHtml.append("<div class='content'>");
	      sbHtml.append("<div class='content-top'>");
	      sbHtml.append("<h3 class='title'>" + go_seoul_subject + "</h3>");
	      sbHtml.append("<div class='icons' id='likeButton'>");
	      sbHtml.append("<i class='fa fa-star-o fa-2x' style='color: #94b8f4;'></i>");
	      sbHtml.append("<i class='fa fa-star fa-2x' style='color: #94b8f4;'></i>");
	      sbHtml.append("</div>");
	      sbHtml.append("</div>");
	      sbHtml.append("<div class='explain'>" + go_seoul_subtitle + "</div>");
	      sbHtml.append("</div>");
	      sbHtml.append("</div>");
	   }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Go!rea</title>
<link rel="stylesheet" type="text/css" href="/css/trendseoul/list.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"/>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
$(document).ready(function() {
   // �ٹ� Ŭ�� �̺�Ʈ ó��
   $('.album').on('click', function() {
      var go_seoul_seq = $(this).data('go_seoul_seq');
      window.location.href = './trend_view.do?go_seoul_seq=' + go_seoul_seq;
   });

});
</script>

</head>
<body>
  
  <jsp:include page="/WEB-INF/views/korean/includes/header.jsp"></jsp:include>
  
	<div class="main">
	<section class="banner">
		<article>
			<img src="/img/trendseoul/������.jpg" width="1440" height="961">
			<div class="banner-text">
					<h2 style="font-weight:bold;">Ʈ���� ����</h2>
			</div>
		</article>
	</section>
   
   <!--  
   	<div class="region-selector">
	    <button class="region-button" data-region="����">����</button>
	    <button class="region-button" data-region="��ȭ��">��ȭ��</button>
	    <button class="region-button" data-region="���빮">���빮</button>
	    <button class="region-button" data-region="��">��</button>
	    <button class="region-button" data-region="����">����</button>
	    <button class="region-button" data-region="���ǵ�">���ǵ�</button>
	    <button class="region-button" data-region="���¿�">���¿�</button>
	    <button class="region-button" data-region="���">���</button>
	    <button class="region-button" data-region="ȫ��">ȫ��</button>
	    <button class="region-button" data-region="��Ÿ">��Ÿ</button>
	</div> --> 

    <!--product section -->
    <section class="albums">
        <div class="album-container">
         
               <%=sbHtml.toString() %>
        </div>
         <div class="write-button">
            <a href="./trend_write.do">�۾���</a>
        </div>
    </section>
	</div>
</body>
</html>