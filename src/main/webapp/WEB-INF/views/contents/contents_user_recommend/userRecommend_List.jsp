<%@page import="com.gorea.dto_board.Gorea_Recommend_BoardTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%
	List<Gorea_Recommend_BoardTO> lists = (List)request.getAttribute( "lists" );

	StringBuilder sbHtml = new StringBuilder();
	
	for( Gorea_Recommend_BoardTO to : lists ){
		String seq = to.getUserRecomSeq();
		String deptno = to.getUserRecomboardNo();
		String title = to.getUserRecomTitle();
		String content = to.getUserRecomContent();
		String wdate = to.getUserRecompostDate();
		String comment = to.getUserRecomCmt();
		String hit = to.getUserRecomHit();
		
		String userNickname = to.getUserNickname();
		int wgap = to.getWgap();
		
		sbHtml.append( "<div>" );
		sbHtml.append( "	<div class='num'>" + seq + "</div>" );
		sbHtml.append( "	<div class='title'><a href='./userRecomView.do?seq=" + seq + "'>" + title + "</a></div>" );
		sbHtml.append( "	<div class='writer'>" + userNickname + "</div>" );
		sbHtml.append( "	<div class='date'>" + wdate + "</div>" );
		sbHtml.append( "	<div class='count'>" + hit + "</div>" );
		sbHtml.append( "</div>" );
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>유저추천</title>
    <link rel="stylesheet" type="text/css" href="/css/userRecommend/board.css">
    <style>
        * {
            margin: 0;
            padding: 0;
        }

        html {
            font-size: 10px;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: Arial, sans-serif; /* 폰트 스타일을 원하는 대로 설정할 수 있습니다 */
        }

        ul, li {
            list-style: none;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        .board_wrap {
            width: 1000px;
        }

        .board_title {
            margin-bottom: 30px;
            text-align: center;
        }

        .board_title strong {
            font-size: 3rem;
        }

        .board_title p {
            margin-top: 5px;
            font-size: 1.3rem;
        }

        .bt_wrap {
            margin-top: 30px;
            text-align: center;
            font-size: 0;
        }

        .bt_wrap a {
            display: inline-block;
            min-width: 80px;
            margin-left: 10px;
            padding: 10px;
            border: 1px solid #000;
            border-radius: 2px;
            font-size: 1.3rem;
        }

        .bt_wrap a:first-child {
            margin-left: 0;
        }

        .bt_wrap a.on {
            background: #000;
            color: #fff;
        }

        .board_list {
            width: 100%;
            border-top: 2px solid #000;
        }

        .board_list > div {
            border-bottom: 1px solid #ddd;
            font-size: 0;
        }

        .board_list > div.top {
            border-bottom: 1px solid #999;
        }

        .board_list > div:last-child {
            border-bottom: 1px solid #000;
        }

        .board_list > div > div {
            display: inline-block;
            padding: 15px 0;
            text-align: center;
            font-size: 1.3rem;
        }

        .board_list > div.top > div {
            font-weight: 600;
        }

        .board_list .num {
            width: 10%;
        }

        .board_list .title {
            width: 60%;
            text-align: left;
        }

        .board_list .top .title {
            text-align: center;
        }

        .board_list .writer {
            width: 10%;
        }

        .board_list .date {
            width: 10%;
        }

        .board_list .count {
            width: 10%;
        }

        .board_page {
            margin-top: 30px;
            text-align: center;
            font-size: 0;
        }

        .board_page a {
            display: inline-block;
            width: 32px;
            height: 32px;
            box-sizing: border-box;
            vertical-align: middle;
            border: 1px solid #ddd;
            border-left: 0;
            line-height: 100%;
        }

        .board_page a.bt {
            padding-top: 10px;
            font-size: 1.2rem;
            letter-spacing: -1px;
        }

        .board_page a.num {
            padding-top: 9px;
            font-size: 1.4rem;
        }

        .board_page a.num.on {
            border-color: #000;
            background: #000;
            color: #fff;
        }

        .board_page a:first-child {
            border-left: 1px solid #ddd;
        }

        @media (max-width: 1000px) {
            .board_wrap {
                width: 80%;
                min-width: 320px;
                padding: 0 30px;
                box-sizing: border-box;
            }

            .board_list .num,
            .board_list .writer {
                display: none;
            }

            .board_list .date {
                width: 30%;
            }

            .board_list .title {
                text-indent: 10px;
            }

            .board_list .top .title {
                text-indent: 0;
            }

            .board_page a {
                width: 26px;
                height: 26px;
            }

            .board_page a.bt {
                padding-top: 7px;
            }
            
            .board_page a.num {
                padding-top: 6px;
            }
	.board_title strong {
    	font-size: 1.8rem;
	}
        }
    </style>
</head>
<body>
    <div class="board_wrap">
        <div class="board_title">
            <strong>유저추천</strong>
        </div>
        <div class="board_list_wrap">
            <div class="board_list">
                <div class="top">
                    <div class="num">번호</div>
                    <div class="title">제목</div>
                    <div class="writer">글쓴이</div>
                    <div class="date">작성일</div>
                    <div class="count">조회</div>
                </div>
                <!-- list 부분 -->
                <%=sbHtml %>
            </div>
            <div class="board_page">
                <a href="#" class="bt first"><<</a>
                <a href="#" class="bt prev"><</a>
                <a href="#" class="num on">1</a>
                <a href="#" class="num">2</a>
                <a href="#" class="num">3</a>
                <a href="#" class="num">4</a>
                <a href="#" class="num">5</a>
                <a href="#" class="bt next">></a>
                <a href="#" class="bt last">>></a>
            </div>
        </div>
        <div class="btn_area">
         <div class="align_right">
            <input type="button" value="쓰기" class="btn_write btn_txt01" style="cursor: pointer;" onclick="location.href='./userRecomWrite.do'" />
         </div>
      </div>
    </div>
</body>
</html>
